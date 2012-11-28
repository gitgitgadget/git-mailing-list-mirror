From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
 (summary)
Date: Wed, 28 Nov 2012 08:09:03 -0500
Message-ID: <20121128130903.GB15786@odin.tremily.us>
References: <20121128063107.GA7189@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=kORqDWCi7qDJ0mEj
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:09:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdhOJ-0003X9-9G
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 14:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab2K1NJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 08:09:10 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:44975 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2K1NJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 08:09:09 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME70044B8J3Q690@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 07:09:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 643CD6E16C1; Wed,
 28 Nov 2012 08:09:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354108143; bh=ayK8FH1+BGE0YtUQ2vhtVGoywYMV5A8A8i6CDKj+0qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XkLeCyS+e3kuDdcR+wx1+OWVhiK/Xd3ZCiDXsv0bNbXUF6skvwO2csJPrjbEJ7kz5
 ofKs6sn9R3kfN/bxaI8PG9zuW51JKp87ALficgjCDF8dz+iCYP08Re4JmYIPQZG++8
 /ErIUhvF3E8k87UT/MHpwQgax5X8Wm9H7c0XAaBQ=
Content-disposition: inline
In-reply-to: <20121128063107.GA7189@book.hvoigt.net>
 <20121128024205.GG15213@odin.tremily.us> <20121109162919.GA922@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210730>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 09:42:05PM -0500, W. Trevor King wrote:
> On Wed, Nov 28, 2012 at 12:28:58AM +0100, Heiko Voigt wrote:
> > https://github.com/hvoigt/git/commits/hv/floating_submodules_draft
>=20
> I looked over this before, but maybe not thoroughly enough ;).

Heiko pointed out that I likely hadn't looked at this branch at all,
which is true.  I'd confused it with his earlier:

On Fri, Nov 09, 2012 at 05:29:27PM +0100, Heiko Voigt wrote:
> https://github.com/hvoigt/git/commits/hv/floating_submodules

but the new floating_submodules_draft branch adds Heiko's function
reorganization and floating submodule pull (with 'update --branch') on
top of my v4 commits (instead of my branch-checkout with 'update
--branch').

> This looks fine, but my current --branch implementation (which doesn't
> pull) is only a thin branch-checkout layer on top of the standard
> `update` functionality.  I'm still unsure if built-in pulls are worth
> the configuration trouble.  I'll sleep on it.  Maybe I'll feel better
> about them tomorrow ;).

I do feel better about them today.  To get a better feel for how
people see this going forward, here is a summary of proposals to date:

v1. Record submodule.<name>.branch with 'submodule add --branch =E2=80=A6',
    leave interpretation up to the user.

    Feedback (paraphrased):
      Phil Hord: that clobbers a configure option used by Gerritt and
        possibly others, rename to --record-branch.  Maybe we should
        export submodule.<name>.* as $submodule_* in 'foreach'?
      Nahor: what about corner cases (e.g. upstream renames branches)?
      Jens Lehmann: if you record it, people will expect Git to use
        it.  What about automatic pulls & commits?

v2. Add --record instead of using --branch to address Phil's v1
    comment.

    Feedback (paraphrased):
      Jens Lehmann: this is still a tiny optimization over using 'git
        config'.  People still use this option in different ways.
      Shawn Pearce: the Gerrit use is basically the same as =C3=86var's,
        but Gerrit has special handling for '.'.
      Jeff King: if we set up submodule.<name>.branch, we should
        either use it in Git, or make it very clear that we do not use
        it.  If we use Phil's $submodule_* export, we should clear the
        variables for recursive submodules.

v3. Renamed Added $submodule_* export to v2.  Give an example of
    =C3=86var's pull workflow when explaining that Git does not use the
    value internally.

    Feedback (paraphrased):
      Heiko Voigt: what about automatic pulls & commits?  You should
        allow .git/config overrides of the .gitmodules settings.  if
        we set up submodule.<name>.branch, we should use it in Git.
        How does the submodule know which remote branch to track?
        Junio's proposed 'diff' changes may hide $sha1 information.
      Junio C Hamano: if we set up submodule.<name>.branch, we should
        use it in Git.  Use something more specific than --record.
        Update 'git diff [$path]' and friends in the superproject
        compares the HEAD of the checkout of the submodule at $path
        with the tip of the branch named by submodule.$name.branch in
        .gitmodules of the superproject, instead of the commit that is
        recorded in the index of the superproject.
      Sascha Cunz: you can use 'git shortlog $OLD_SHA1..$NEW_SHA1' for
        the automatic commit message.
      Trevor King: actually, =C3=86var's update command only specifies the
        local branch name.  The remote is recorded for that branch in
        .git/modules/<name>/config.

v4. Rename --record to --local-branch.  Remove $submodule_* export.
    Add .git/config overrides for submodule.<name>.branch.  Add
    'submodule update --branch' to check out $sha1 as
    submodule.<name>.branch.

    Feedback (paraphrased):
      Heiko Voigt: who cares about the local branch name?  You should
        be pulling origin/$branch, but still using
        .git/modules/<name>/config to record the tracked branch.  You
        should also use 'submodule add --branch[=3Dbranch]' instead of
        '--local-branch'.  You should pull the 'update --branch'
        functionality out into a sub-function like
        'handle_tracked_branch_update'.
      Jens Lehmann: .git/config overrides are nice, but they should be
        optional.
      Trevor King: floating branches are following the submodule's
        remote, while 'update --rebase/--merge' are following the
        superproject's recorded $sha1.  Bundling remote-following and
        superproject-following in the same command may be confusing.

Here's what I think we need in v5:

* Jens' optional .git/config overrides.
* Return --local-branch handling to a side effect of --branch (as in
  v1).
* A new 'submodule pull' for tracking the submodule's remote, which is
  pulling --ff-only origin/$branch into a whatever state the submodule
  is currently in.  If any changes were made to submodule $shas,
  optionally commit them with a shortlog-generated commit message.
* Remove my current 'submodule update --branch' functionality.

Thoughs?  Do we need any more information for an automatic pull, or is

  $ git pull --ff-only origin/$branch

on a headless checkout sufficient?

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtgzsAAoJEEUbTsx0l5OM7+UP/i17tYTHS5SSdgWC+PIiArxi
YuHssoBeTQ8AkYMaZqBFw8VyQ8oJpE1tARNlML3ZPAJNK2B654bLKPcm2LOUNeQ9
Yq3JYASDJJQ2dbaJDAAoyuuFyrS30HKq0ag5k81iqTFLB8vmLFH9SbRoEUazd2pv
W/zUTGSZfeaYkbixN3qwg0Ji3msPJ4FVibv9HEZjRRBQkC2BscRaKAh2YfaiSwZJ
ml/HAOiCL69EXr5fcHnFpw4XI0k/RElJYxbd7i1UvPhJBDpjlKOQvGl2WNvt+8Lg
zO9Te/UIMvamvXts6jPYWSvbwgR8qbK8qiVDTbGf8Dn5gRd+EdfHbjVC07/dBRRl
eTCkWv1lHE87MTL3NbOC3Ort2IlEYu3Svtl4+1ODWThLluIrbTxjdyvTKAIKm2cS
d2WMnWVIAVW/r2LyjgoWZvSkvwkzJhV1CeAVtC4d/yYjzBGdrlLCedQNwgpQIgW/
oKTwY9vIrXM8KEvlZmOsNqDuSrQDCy7/jNfS/aWFEKC9un2vUOSnOtf+MAYLWftG
vHnoX32GL12Wf5U+/VEn1z1os6cQHfWKFqWs4th3lEDXNdW59EBbqLFfuQSGlKB1
GAwyNeVvNGHaJEy575OBJrtsnPpyPCuPSvAm+5VbO33klQNNfhSfHkO9cBuvWctC
MmHBUtIJLgJ25SPM7kjR
=3gmp
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

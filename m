From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 17 Nov 2012 14:20:27 -0500
Message-ID: <20121117192026.GI22234@odin.tremily.us>
References: <20121117153007.GB7695@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=+PbGPm1eXpwOoWkI
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZnx4-00017b-3c
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 20:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab2KQTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 14:20:49 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:54553 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2KQTUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 14:20:48 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.214])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDN009ROCE3LBA0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 17 Nov 2012 13:20:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 25595695939; Sat,
 17 Nov 2012 14:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353180027; bh=nctJa4av/zk9UaYDh+ZWylcuO85S5dBU2ZC33Q77j1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T59GUHXGlvc80rdKmwqLG2SCgyxdtFVL4R6vRlQiDh7Mv7jf2OmJ6s0FhDdH5DRyH
 p4PwpFBUPAv8iKShq6T3WFuLhPTE4B/mjhAoc7fg9a/O1aHxWEqU7HjVndTW6yoDf/
 s0W7QQGxlrXihIiaux6Vh1PM+TpLOxjlfY4sJLEU=
Content-disposition: inline
In-reply-to: <20121117153007.GB7695@book.hvoigt.net>
 <20121117150441.GA7695@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209969>


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 17, 2012 at 04:04:42PM +0100, Heiko Voigt wrote:
> > On Sat, Nov 10, 2012 at 01:44:37PM -0500, W. Trevor King wrote:
> > >   $ git submodule pull-branch
> >=20
> > I think "floating submodules" is a misleading name for this feature
> > though, since the checkout SHA is explicitly specified.  We're just
> > making it more convenient to explicitly update the SHA.  How about
> > "tracking submodules"?
>=20
> Until now we have always called this workflow floating submodules. I
> imaging since the submodule floats to the newest revision (whatever the
> user chooses that to be) instead of staying at the recorded sha1.
>=20
> "tracking submodules" sounds strange to me since the term tracked in git
> is mainly used in combination with exact recorded history (e.g. tracking
> branch). Since it is about *not* checking out the recorded sha1 but
> something that can change I think that could cause confusion.
>=20
> I think floating is a more unambiguous term and already known on the
> list.

I had been getting the impression that floating submodules would
automatically update without explicit user intervention.  After
re-reading your initial floating submodules post, it looks like we do
match up after the mapping:

  Git        Heiko               Trevor
  ---------  -----------------   -------------
  update     update --checkout   update
             update              update --pull

So I'll go back to "floating" ;).

On Sat, Nov 17, 2012 at 04:30:07PM +0100, Heiko Voigt wrote:
> > >  (2) "git diff [$path]" and friends in the superproject compares the
> > >      HEAD of the checkout of the submodule at $path with the tip of
> > >      the branch named by submodule.$name.branch in .gitmodules of
> > >      the superproject, instead of the commit that is recorded in the
> > >      index of the superproject.
> > >=20
> >=20
> > Hmm.  ???git diff??? compares the working tree with the local HEAD (jus=
t a
> > SHA for submodules), so I don't think it should care about the status
> > of a remote branch.  This sounds like you want something like:
> >=20
> >   $ git submodule foreach 'git diff origin/$submodule_branch'
> >=20
> > Perhaps this is enough motivation for keeping $submodule_* exports?
> >=20
> > > and the option were called something like "--follow-branch=3D$branch",
> > > ???
>=20
> I am not sure if hiding changes to the recorded SHA1 from the user is
> such a useful thing. In the first step I would like it if it was kept
> simple and only the submodule update machinery learned to follow a
> branch. If that results in local changes that should be shown. The user
> is still in charge of recording the updated SHA1 in his commit.

I understand what you're warning against here, or what it has to do
with "git diff".

> From what I have heard of projects using this: They usually still have
> something that records the SHA1s on a regular basis. Thinking further,
> why not record them in git? We could add an option to update which
> creates such a commit.

I think it's best to have users craft their own commit messages
explaining why the branch was updated.  That said, an auto-generated
hint (a la "git merge") would probably be a useful extra feature.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQp+N4AAoJEEUbTsx0l5OMspQP/1v7zYdht6OUUsZIJfxcoiUO
CUNQ42hYVZjafJni+Bu4iHXOGKSd+QyLtgJmBfBxIz94qLGldEchyNfyiwmTp28y
XY2smWmqKEUkCE35FVsic9gbBMvB2+FUYQU6s4lt1KDRtWoWldaC/dhUmAXEqNEP
2jA9ez5hQEQh8Bg3mJ+pIt9KV3P7SBAug5/EQzzwPmYsq0smeTa9p7O8DsvR3MMD
wNAaRXqzO0yoj3y/7V2NQM1vwrFvdDmBErFWnGW5EpenpNgQ7fMm0awDmR+sW8Ma
q0xNHe8ICOTjeNE2zuSDVU9Q7U8fIqqgB/FPgXU1Qr62KrQhK6usttRSH+dbQx+N
UTQXMBfOJzgsN/a1T6w//2c0SMdg8mGcx26Ra6T51jZFpttsO34QRtqCJdvbdZet
od81o5Vn0muqwS23VmTdCaCdwrKLTHS59hpIRXRmkbR1mKqyenqullJJzvl4GnB8
AX5Uff8lg/HSkWcuidV4t0mpNhfY0eKo5hWQj8fKm9iiNAs07/1hG0sJvf619kt0
k5+SmBlintPVUTQSLD5hmWZLX5quVRMP9CpEFVy3sPR8MKrfuATPRxgv+KmSNZpy
7All6zOcbEMcQCw+KjzsuPScejc2YIBjMdvpf91JV5Sk1lLd350A7IHPN0J4wDja
N8fCS2ta2kl9PLKSQFC0
=VyQ6
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--

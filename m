From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 11:23:29 -0500
Message-ID: <20121123162329.GF2806@odin.tremily.us>
References: <20121123160301.GC14509@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=i3lJ51RuaGWuFYNw
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbw3B-0003j6-2I
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 17:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab2KWQYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 11:24:05 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:23466 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2KWQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 11:24:04 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.36])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDY00EIJ877LT30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 23 Nov 2012 10:23:37 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 21C046D9C06; Fri,
 23 Nov 2012 11:23:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353687810; bh=OZWcBiL2QVAxbZDAXG3rYc4MKF/RrJWbnT1SZtPw6FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ToWG2JkvSx4sci7V8/7IJNrn881VMjKqL5ijPx95S3is3Y/KtHAJJLaVBrscE/l1c
 9OIF6jOGVJzYFSa7ZnEvw/QUTIewSbTUk34MR2+RTQ6iEn/dLrNrDM0z22kU4F0Xk6
 8YAniHIsIgXv0XH11cR37d4KcqZ1aars1YsJ/4pM=
Content-disposition: inline
In-reply-to: <20121123160301.GC14509@book.hvoigt.net>
 <20121123155521.GB14509@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210264>


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 04:55:21PM +0100, Heiko Voigt wrote:
> On Tue, Nov 20, 2012 at 11:52:46AM -0800, Junio C Hamano wrote:
> > "W. Trevor King" <wking@tremily.us> writes:
> >=20
> > > The superproject gitlink should only be updated after
> > >
> > >   $ git submodule update --pull
> > >
> > > A plain
> > >
> > >   $ git submodule update
> > >
> > > would still checkout the previously-recorded SHA, not the new upstream
> > > tip.
> >=20
> > Hrm, doesn't it make the "float at the tip of a branch" mode
> > useless, though?
>=20
> How about having a branch config option and reusing our
> submodule.$name.update option for specifying whether the user wants to
> always float to the tip of the branch?

I'm adding "update --pull" as one of the update options in v4, which I
am writing up as we speak ;).

> 1. If submodule.$name.update is pull it would checkout the specified tip.

and pull from the submodule's upstream.  This doesn't need the
recorded $sha1, so I may have to rework the current

  if (clear_local_git_env; cd "$sm_path" && $command "$sha1")

> 2. If submodule.$name.update is checkout or none it would do the usual
>    thing and you need to specify --pull to get the tip.

Exactly.

> So currently I am more on the "have an automatically generated
> commit message" side. Its in a similar corner like merge commits, that
> are also generated, for me. We could have it as the default and a
> --no-commit option (like merge) for people that want to stage submodules
> individually.

This sounds reasonable, but I'd like to postpone message-generation
sugar until we get the basic functionality ironed out.

On Fri, Nov 23, 2012 at 05:03:01PM +0100, Heiko Voigt wrote:
> On Tue, Nov 20, 2012 at 07:19:12AM -0500, W. Trevor King wrote:
> > The benefit is that =C6var's
> >=20
> >   $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'
> >=20
> > becomes
> >=20
> >   $ git submodule update --pull
>=20
> There is an important question still unanswered here for me: How does
> the submodule get the configuration what the local branch tracks on the
> remote side?

A good point ;).  I'm actaully using submodule.<name>.branch to store
the submodule's local branch name.  The remote branch name for the
pull is implicit, and defaults to something setup according to
branch.autosetupmerge (I think).  If you want to get more complicated
than this, we'll probably have to add submodule.<name>.branch and
submodule.<name>.remote sections to augment the
submodule.<name>.branch setting.  I'm not sure this is worth it.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr6L/AAoJEEUbTsx0l5OMf6kP/0TGwhyjd1SbGkv538ZRmMni
891V6YfPPbrNRmSPSudo9WOkcD2UCyMNP+8AZcfJbG3tV3EN/7z9gv9Ea4MTZVy3
brlbv5xLN2rxBFLBMZ/tZz+lHkbaLmZXuIwCZUM+QbOeQaAJ1tXRwC6IT0aFstOM
2D9oG5/tJCC3C529Fj9/Z1wBWGDStB/vppPYeIiuTCRBVFsR8XrAnebJdXbswc4K
+T4eezbSfvL2/QCnsydkracGdZpMnljrD9Is23Ftsof+FIHLZOBzYxFeqIdNBXzI
N8eWf+PjZkobGvVTBLe5OLaTz+VOd6VOk84O2BbAT+8Xu+XGjxnT5imbGMMUMVek
CAGGmLCy8hfreiUEOjWAIm0MX6GerTnImHxjUX5+R/A4ZLuCL2YVgQ/1KfEnbDLc
d9gvy4KDJcAeHnmzbAPxbIZIYL2uRbmpBQ3VC0okd8PKcqBGe8DFgLDrRHKtRzKj
uCj94h2s1MGOC8Tig4bOlj/nziA5Ww/Y2/oc5hAtk/5vMVq0bLLqRHZ5bbzJMGrN
uBwka+dLaOjAs8thqVqaqeGL5ZWuG1ILFlhVc9sCd6atvps2RQB+BWJEySk5Wzr1
SmtQ5dBh2LMq2FP1AdFQiD1QgUsYOJ6Z3ogKKlBDx9lu0lz8OHdGgls6SXvXbKy7
gXg0S0oZ2rhVpopCF/7e
=B6U9
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

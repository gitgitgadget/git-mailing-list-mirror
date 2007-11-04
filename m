From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 9/5] Migrate git-checkout.sh to use git-rev-parse --parseopt --keep-dashdash
Date: Sun, 04 Nov 2007 10:03:35 +0100
Message-ID: <20071104090335.GB26269@artemis.corp>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org> <1194112219-19968-1-git-send-email-madcoder@debian.org> <1194112219-19968-2-git-send-email-madcoder@debian.org> <1194112219-19968-3-git-send-email-madcoder@debian.org> <1194112219-19968-4-git-send-email-madcoder@debian.org> <7v7ikytpz0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eAbsdosE1cNLO4uF";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IobOe-0001Hs-Bd
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbXKDJDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXKDJDl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:03:41 -0500
Received: from pan.madism.org ([88.191.52.104]:33561 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbXKDJDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:03:39 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4130528494;
	Sun,  4 Nov 2007 10:03:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 27C171E45C; Sun,  4 Nov 2007 10:03:35 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ikytpz0.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63364>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 07:44:03AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Also fix some space versus tabs issues.
> > ---
> >  git-checkout.sh |   99 +++++++++++++++++++++++++++--------------------=
--------
> >  1 files changed, 49 insertions(+), 50 deletions(-)
> >
> > diff --git a/git-checkout.sh b/git-checkout.sh
> > index 8993920..5424745 100755
> > --- a/git-checkout.sh
> > +++ b/git-checkout.sh
> > @@ -1,6 +1,16 @@
> >  #!/bin/sh
> > =20
> > -USAGE=3D'[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
> > +PARSEOPT_OPTS=3D--keep-dashdash
> > +OPTIONS_SPEC=3D"\
> > +git-branch [options] [<branch>] [<paths>...]
> > +--
> > +b=3D          create a new branch started at <branch>
> > +l           create the new branchs reflog
> > +track       tells if the new branch should track the remote branch
> > +f           proceed even if the index or working tree is not HEAD
> > +m           performa  three-way merge on local modifications if needed
> > +q,quiet     be quiet
> > +"
>=20
> Ok, so this is how PARSEOPT_OPTS gets used.  It is a way for the
> command that sources git-sh-setup to tell the parseopt code what
> to do.  I can agree with this, but then all the other commands
> that do not set PARSEOPT_OPTS before sourcing git-sh-setup
> should set it to empty string.  Otherwise the users can screw
> you with their environment variables.

  yes it's the why, and it's also the why this variable isn't quoted
because it is meant to get options to pass to git-rev-parse --parseopt
In fact it's only used in git-checkout right now. I believe the proper
way to do that is that git-sh-setup does a PARSEOPT_OPTS=3D and that
git-checkout.sh its sole user overrides it once git-sh-setup is sourced.
I'll send the two updated patches for that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLYrnvGr7W6HudhwRAizeAKCkQiAOmYd2huLY+qZNrWRzN9z2bwCdHCBo
k/sd8AxMLYx4Eg1+QyVjjP4=
=axb0
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

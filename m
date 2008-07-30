From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 16:05:23 +0200
Message-ID: <20080730140523.GC31392@artemis.madism.org>
References: <20080730141656.41ce02ec@pc09.procura.nl> <20080730123713.GA31392@artemis.madism.org> <20080730144452.797d8686@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="B4IIlcmfBL/1gGOG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCK3-0000wd-BW
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbYG3OF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYG3OF0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:05:26 -0400
Received: from pan.madism.org ([88.191.52.104]:44145 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbYG3OF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:05:26 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BD6CA3C37B;
	Wed, 30 Jul 2008 16:05:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7DE682BD7E5; Wed, 30 Jul 2008 16:05:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080730144452.797d8686@pc09.procura.nl>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90791>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2008 at 12:44:52PM +0000, H.Merijn Brand wrote:
> On Wed, 30 Jul 2008 14:37:13 +0200, Pierre Habouzit
> <madcoder@debian.org> wrote:
>=20
> > On Wed, Jul 30, 2008 at 12:16:56PM +0000, H.Merijn Brand wrote:
> > > git-1.5.6.4 - HP-UX 11.23 64bit compile
> > >=20
> > > * expecting success:
> > >         test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> out=
put.err &&
> > >         test_cmp expect output &&
> > >         test ! -s output.err
> > >=20
> > > --- expect      2008-07-30 11:52:05 +0000
> > > +++ output      2008-07-30 11:52:05 +0000
> > > @@ -1,5 +1,5 @@
> > >  boolean: 2
> > > -integer: 1729
> > > +integer: 7425998454784
> > >  string: 123
> > >  abbrev: 7
> > >  verbose: 2
> > > * FAIL 2: short options
> > >=20
> > > I'm sure you can come up with a more sensible change, but the current
> > > code is definitely wrong
> > >=20
> > >=20
> > > --8<---
> > > --- test-parse-options.c.org    2008-07-30 11:57:16 +0000
> > > +++ test-parse-options.c        2008-07-30 12:08:56 +0000
> > > @@ -2,6 +2,7 @@
> > >  #include "parse-options.h"
> > >=20
> > >  static int boolean =3D 0;
> > > +static unsigned int int_integer =3D 0;
> > >  static unsigned long integer =3D 0;
> >=20
> >   long is wrong in the first place, parse-opt only uses ints.
>=20
> If I change it to int, the date parsing goes bogus.

That is because OPT_DATE indeed expect a long (why not a time_t I don't
know btw... but time_t is a long on linux so it doesn't change things a
lot).

The proper fix is to let integer be an *INT* (long integer is bogus
anyways) and to put the date in a long using static unsigned long date,
and make OPT_DATE use this long.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiQdSMACgkQvGr7W6HudhyILQCfcUlhoqdi5aNWNJqCxR68snKn
kMcAnir9NoCq/C29Ll9xhN9Q4rhRTMow
=uP6D
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fixup GECOS handling
Date: Sun, 24 Apr 2005 01:49:16 +0200
Message-ID: <1114300156.27940.22.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
	 <20050422171818.GE7173@pasky.ji.cz>
	 <1114192702.31076.428.camel@axer.marchex.com>
	 <1114196803.29271.52.camel@nosferatu.lan>
	 <20050423233821.GN13222@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-54lFU/cEXzwkQEPlSlpA"
Content-Transfer-Encoding: 8bit
Cc: kyle@marchex.com, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:41:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUF3-0005Bk-Sn
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVDWXpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVDWXpg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:45:36 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:63458 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262181AbVDWXpY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 19:45:24 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 516332577;
	Sun, 24 Apr 2005 01:45:18 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id B7B503A2430;
	Sun, 24 Apr 2005 01:51:42 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03145-12; Sun, 24 Apr 2005 01:51:37 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id A40C93A241A;
	Sun, 24 Apr 2005 01:51:37 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423233821.GN13222@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-54lFU/cEXzwkQEPlSlpA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-04-24 at 01:38 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 09:06:43PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > @@ -311,6 +296,17 @@
> >         if (!pw)
> >                 die("You don't exist. Go away!");
> >         realgecos =3D pw->pw_gecos;
> > +       /*
> > +        * The GECOS fields are seperated via ',' on Linux, FreeBSD, et=
c,
> > +        * and ';' on AIX.
> > +        */
> > +#if defined(__aix__)
> > +       if (strchr(realgecos, ';'))
> > +               *strchr(realgecos, ';') =3D 0;
> > +#else
> > +       if (strchr(realgecos, ','))
> > +               *strchr(realgecos, ',') =3D 0;
> > +#endif
> >         len =3D strlen(pw->pw_name);
> >         memcpy(realemail, pw->pw_name, len);
> >         realemail[len] =3D '@';
>=20
> I'm confused, what does this has to do with AIX? Do we even have / can
> expect to have any major AIX users?
>=20

Given.

> I'm not too happy with this, I have to say. It seems it won't do always
> the right thing anyway. I would still favour the approach when you cut
> off everything after ';', and everything after ',' if no ';' is found.
> Seems simplest, safest, etc.
>=20
> Tell me about anyone who has a semicolon in his realname.
>=20

Point I guess is still that the only valid delimiter on linux is ',',
and the only reason for the ';' was because of some aix/whatever user
saying that is a delimiter as well. But like I said: cat $this
> /dev/null ... This is basically the same type of discussion as the
hash collision one, and I'm sure we all have better things to do.


Thanks,

--=20
Martin Schlemmer


--=-54lFU/cEXzwkQEPlSlpA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCat78qburzKaJYLYRAkyRAJsG+OQas0cqVPJtj1xy/psCkZfWdACfdX36
996+HvSqJ9pdHYBQW3ag+u4=
=hx74
-----END PGP SIGNATURE-----

--=-54lFU/cEXzwkQEPlSlpA--


From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 18:58:25 +0200
Message-ID: <1114189105.29271.36.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xj2B1S1GQ4l9oHmT7o2e"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 18:50:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP1Lr-0008GO-2N
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVDVQyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVDVQyf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:54:35 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:11196 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S262066AbVDVQya
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 12:54:30 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id E1EBA51C0;
	Fri, 22 Apr 2005 18:54:26 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 7D7F73A2430;
	Fri, 22 Apr 2005 19:00:48 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09580-14; Fri, 22 Apr 2005 19:00:44 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id A7F783A241A;
	Fri, 22 Apr 2005 19:00:44 +0200 (SAST)
To: kyle@marchex.com
In-Reply-To: <1114186599.31076.409.camel@axer.marchex.com>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Xj2B1S1GQ4l9oHmT7o2e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 09:16 -0700, Kyle Hayes wrote:
> On Fri, 2005-04-22 at 16:23 +0200, Martin Schlemmer wrote:
> > Hi,
> >=20
> > This still applies - any reason for not doing this?
>=20
> Seems like this will break on certain kinds of data.  See below.
>=20
> >         if (!pw)
> >                 die("You don't exist. Go away!");
> >         realgecos =3D pw->pw_gecos;
> > +       /* The name is seperated from the room no., tel no, etc via [,;=
] */
> > +       if (strchr(realgecos, ','))
> > +               *strchr(realgecos, ',') =3D 0;
> > +       else if (strchr(realgecos, ';'))
> > +               *strchr(realgecos, ';') =3D 0;
> >         len =3D strlen(pw->pw_name);
> >         memcpy(realemail, pw->pw_name, len);
> >         realemail[len] =3D '@';
>=20
> Suppose that the GECOS field is:
>=20
> Hayes, Kyle; Room 42; 424-424-4242; foo bar baz...
>=20
> You'll search for the first comma, find it, truncate my name to "Hayes",
> and continue.
>=20
> I have seen this kind of GECOS in larger environments where the
> individual users are not the ones that administrate their machines.
> Using the LastName, FirstName style of name is not rare.=20
>=20

What OS?  With Linux at least, this is what chfn's manpage say:

----
       The only restriction placed on the contents of the fields is that no=
 control characters may  be  present,
       nor  any  of  comma, colon, or equal sign. The other field does not =
have this restriction, and is used to
       store accounting information used by other applications.
----

Meaning, if they use a ',' in one of the fields (and it is a linux
system with the chfn most probably from the shadow package), then they
are looking for trouble.  The only reason I added the ';' was because
somebody said whatever OS used it instead of a ','.


Thanks,

--=20
Martin Schlemmer


--=-Xj2B1S1GQ4l9oHmT7o2e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaS0xqburzKaJYLYRAmjdAJ99sRYOA/JuP/qPiRvj39HGDcOD6QCeJ9bj
q3AFur8m9s+x/v4eXuMmW/U=
=2Dts
-----END PGP SIGNATURE-----

--=-Xj2B1S1GQ4l9oHmT7o2e--


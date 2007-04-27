From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Fri, 27 Apr 2007 10:59:51 +0200
Message-ID: <20070427085951.GC4690@ferdyx.org>
References: <20070426192439.GA6976@ferdyx.org> <7vd51qp57k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMbY-0005rS-9k
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 11:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbXD0JSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 05:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXD0JSs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 05:18:48 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:49925
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbXD0JSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 05:18:47 -0400
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2007 05:18:47 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id E4E788D315;
	Fri, 27 Apr 2007 10:37:37 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16220-05; Fri, 27 Apr 2007 10:37:32 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 5B7288D305;
	Fri, 27 Apr 2007 10:37:31 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Fri, 27 Apr 2007 10:59:52 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd51qp57k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45709>


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2007 at 01:54:55AM -0700, Junio C Hamano wrote:
> "Fernando J. Pereda" <ferdy@gentoo.org> writes:
>=20
> > +int split_maildir(const char *maildir, const char *dir, int nr_prec, i=
nt skip)
> >  {
> > ...
> > +	while ((maildent =3D readdir(mddir)) !=3D NULL) {
> > +		FILE *f;
> > +
> > +		snprintf(file, sizeof(file), "%s/%s",
> > +				curdir, maildent->d_name);
> > +
> > +		if (maildent->d_name[0] =3D=3D '.')
> > +			continue;
> >  ...
> > +		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
> > +		split_one(f, name, 1);
> > +
> > +		fclose(f);
> > +	}
> > +
> > +	closedir(mddir);
> > +
> > +	ret =3D skip;
> > +out:
> > +	return ret;
> > +}
>=20
> I do not personally deal with maildir so I do not know for sure,
> but this feels very wrong.
>=20
> What order are you emitting the output?
>=20
> split_mbox() is designed to number the messages the same order
> as they are found in the mailbox, but the above loop relies on
> readdir() to give them in a reasonable order to you, which does
> not seem a right assumption to me (otherwise "/bin/ls" and
> friends would not sort what they read from the filesystem would
> they?).

It is indeed very wrong. You can't sort them without opening and parsing
the headers. Please drop this patch.

Sorry for the noise.

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGMbuHCkhbDGC9KNQRAp68AJ49/JiyB+mNgC6+42p++LHnZXHHBgCdHJzp
3idSAHsKsVyuwSjuXkfVtAc=
=8tds
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

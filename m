From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 9 Jul 2009 13:24:14 +0200
Message-ID: <200907091324.17643.trast@student.ethz.ch>
References: <20090709075728.137880@gmx.net> <200907091031.43494.trast@student.ethz.ch> <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart415724185.OZBB8UJyOJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Martin Ettl <ettl.martin@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 09 13:24:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOrjr-0000p0-Ic
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 13:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZGILY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 07:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbZGILYZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 07:24:25 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:46120 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbZGILYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 07:24:24 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Jul 2009 13:24:22 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Jul 2009 13:24:22 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.95; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302>
X-OriginalArrivalTime: 09 Jul 2009 11:24:22.0502 (UTC) FILETIME=[CEE29060:01CA0087]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122967>

--nextPart415724185.OZBB8UJyOJ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Thu, 9 Jul 2009, Thomas Rast wrote:
>=20
> > Martin Ettl wrote:
> > > -	if (ferror(f) || fclose(f))
> > > +	if (ferror(f))
> > >  		error("Unable to write marks file %s.", file);
> > > +  	fclose(f);
> >=20
> > You no longer check the error returned by fclose().  This is
> > important, because the FILE* API may buffer writes, and a write error
> > may only become apparent when fclose() flushes the file.
>=20
> Indeed.  A better fix would be to replace the || by a |, but this must be=
=20
> accompanied by a comment so it does not get removed due to overzealous=20
> compiler warnings.

Are you allowed to do that?  IIRC using | no longer guarantees that
ferror() is called before fclose(), and my local 'man 3p fclose' says
that

       After the call to fclose(), any use of stream results in
       undefined behavior.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart415724185.OZBB8UJyOJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkpV02EACgkQqUud07tmzP3UOACdF+2NkDslR150qYfKAw93NiKO
K5YAnjRofltt7N1KIaa2XWxMESTugj+n
=51HY
-----END PGP SIGNATURE-----

--nextPart415724185.OZBB8UJyOJ--

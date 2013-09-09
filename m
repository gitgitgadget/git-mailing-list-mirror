From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] send-email: don't call methods on undefined values
Date: Mon, 9 Sep 2013 22:49:50 +0000
Message-ID: <20130909224950.GA101065@vauxhall.crustytoothpaste.net>
References: <1378673674-97212-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqli363pwp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: git@vger.kernel.org, artagnon@gmail.com, mst@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAHQ-0004jj-QW
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab3IIWt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:49:56 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60189 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755807Ab3IIWt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 18:49:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91FF928074;
	Mon,  9 Sep 2013 22:49:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqli363pwp.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234389>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 09:45:10AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1234,7 +1234,7 @@ X-Mailer: git-send-email $gitversion
> >  				if ($smtp->code =3D=3D 220) {
> >  					$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
> >  									  ssl_verify_params())
> > -						or die "STARTTLS failed! ".$smtp->message;
> > +						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
>=20
> I agree that $smtp->message may be bogus at this point, but could
> "require IO::Socket::SSL" have failed on us in ssl_verify_params?
> In that degraded mode, we do not do SSL peer verification, but
> otherwise we would still attempt to talk with the peer, and in such
> a case, IO::Socket::SSL would not be available to us at this point,
> no?

Since Net::SMTP::SSL uses IO::Socket::SSL (in fact, it is an
IO::Socket::SSL), we can be guaranteed that it is, in fact, available at
this point.  I guess strictly we don't need that require in
IO::Socket::SSL since we'll already be guaranteed that it exists by the
require of Net::SMTP::SSL.

I tried using Net::SMTP::SSL::errstr() instead, but that didn't seem to
produce useful output.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSLlCOAAoJEL9TXYEfUvaLy88P/jge3GopoVI6VTHJbfwP538B
/RzXqcLpdN1D3Ft6lNthi/LFAZeTCCtu3unqd+Vf1XZsJ1S6cTz5AmfShQ6kWD8W
Y7U8G3WijaKRAvZHiYH0zHDId//5JSGrKuPTCYb7vb2v9LAjp6kE1aFISPkxXtxK
6tN95H86lgd2ekk0lQv+qBZRrV6iONBzACGFhDUy4M4qfMuXrFBfr8ZcH88aatp8
R1r+0rdoM7KKeRat/92yfDRA0Bx/s4ZeTBYUgHFPb7yQQj1YUBSI8ckUJXlW9lO/
bYA6/5DpnLVtctlPhF5AdM6y6edoV7FkGzoTxj6OH6+WhJgXHS4ixQPOtNkBwrQd
PaqZKcoKmCIOn+PMOxGWhunOv35NY5sElJMEsO8n3glkuXbUwBGhCgS+ImgbpBgP
Pmtb8AuGDl7ATiNeLxpkNjEdQOOPU4g7Eo0SD8h5DZNqIkHqX9xBYGN4q1eIY94L
TddhrvZxq9szHGfwCgo7EOHLUsRifbMfN10wyqG4QrcPZcuhizBehtzy7azCU8eS
iX2pS3FdbZA58eqjn0EfwGwQ7JUeJb/jWWFIPgU2ogL9llHAvX/0Xtlc6QlDKiNf
9eTYfvqNt2tRKILWd9TgmSsbwvsGSZN69N8pAXk3CBZlktyeHl+f70ozF8Z7p72g
1vsJmMmrF02vZ3iRyOeQ
=H63L
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

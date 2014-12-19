From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-http-backend auth via Kerberos
Date: Fri, 19 Dec 2014 20:16:33 +0000
Message-ID: <20141219201633.GA88110@vauxhall.crustytoothpaste.net>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
 <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
 <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 21:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23yf-000785-TA
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 21:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaLSUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 15:16:42 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55634 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbaLSUQl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 15:16:41 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2E0762808F;
	Fri, 19 Dec 2014 20:16:37 +0000 (UTC)
Mail-Followup-To: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261594>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 03:07:20PM +0000, Dan Langille (dalangil) wrote:
> Correct, we are trying to avoid that.  In addition, there is only https, =
no http.

I don't think HTTPS versus HTTP matters.  I use Kerberos over HTTPS only
and it works fine.

> To be clear, for the following tests, there is no Kerberos ticket.
>=20
> I tried that URL using three different browsers.  Each time I am prompted=
 for
> a username & password.  After entering valid credentials, I get:
>=20
> Chrome: No data received. Unable to load the webpage because the server
> sent no data. Error code: ERR_EMPTY_RESPONSE
>=20
> With Firefox: The connection was reset
>=20
> Safari: Safari Can=E2=80=99t Open The Page
>=20
> However, I did stumble across something which seems promising.
>=20
> After the above failures, if I then browse to /gitweb/
> (where I see expected results) and then go to the info/refs URL you suppl=
ied,
> I see data such as this:
>=20
>    fe068a8ae55cea4bb90e2cc714107f4c5389d516	refs/heads/0.96.x
>    d384a963980e9b40e34dea80eac280cf2d4b7c73	refs/heads/0.97.x
>=20
> Conclusion: there is something in the /gitweb auth which is succeeding an=
d then
> allowing /git to work

That could possibly be due to KrbSaveCredentials.

> For the record, this is the gitweb auth:
>=20
> <Location /gitweb>
>   SSLOptions +StdenvVars
>   Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
>=20
>   AuthType           Kerberos
>   AuthName           =E2=80=9Cus.example.com"
>   KrbAuthRealms      us.example.com
>   KrbServiceName     HTTP/us.example.com
>   Krb5Keytab         /usr/local/etc/apache22/repo-test.keytab
>   KrbMethodNegotiate on
>   KrbMethodk5Passwd  on

Does it work if you set this value (KrbMethodK5Passwd on) explicitly in
the other configuration?  That might be sufficient.

>=20
> That attempt is shown here: http://dpaste.com/04RG37E.txt
>=20
> > You'll obviously
> > want to see if the server offers Basic auth as well as Negotiate.
>=20
> I=E2=80=99m not up on my knowledge here.  You mean the Kerberos server?

No, I meant the HTTP server, which it looks like from your attempt it
does.  I'm not really sure what the issue is after looking at that,
although it looks like Git isn't sending the username and password.
I'll try to look at this a little more this weekend.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUlIehAAoJEL9TXYEfUvaLIgIP/15gXt9+IBUyRQXemppG2C0u
MS+A+DbP2qv3IihYgU4nJDLD+1E7raQfCZjIwwRybCwOUS7iyCFhC6IHtx3L1gsT
2SRcEY0G0MQyStokWOGuua5oklqk/AiUeV9xPtXIMXWZwiSWCF2YuluD2RxWioAv
mGq/fdIFtvWIrqwmtWQEMF5UwkxrreTfUYStUCnOZ+6uXXA7HGNxaf6n93MHh4Ri
lMgbF3Ea/pLTviM1IVTT/438S/q7sWyZX5NP1HZlXM7hxgsEvWSH7JApsFVQKg6t
QZOPIwIC2n3KhVhykEpsKICKd613DO8amuCGdn5azh0gEQQllIFv/I7CWenp6yUv
S7Qb2TcaJqclXbAOP8jTYvvza/OTGU3X/2ou1ef6Ir9Z6dqt2Y/TYMK0/KpcqO97
ugoj/iDOK8mJGyvl1hxk//LNuPO012Com2BthtwhH28jOra8O2NqrIaS62ShDqP2
6T2lIaJ0V4mL5FwoRxAM3jrT9eDP4DF+o+DfPDYlAXQ9kzN9eQLaGkK9Sb0UIQlb
7ND+tmzDdCp5DDwnHqT2oQMCpI04AbF1gga6fpKqqD7e3HVPNuX3SK70OflpzGfD
elxYZ+RENPqu8gkXcCZDCAOk+Y0q+Nw3QDbIZA1NoGh5nkuYEEbc1U+YYXo4r3OY
LDb9ttK0aVmJ2Y8PL8D/
=Ez7j
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

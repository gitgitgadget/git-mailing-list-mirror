From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: forcing a user@ into the URL if not present
Date: Thu, 30 Apr 2015 20:23:42 +0000
Message-ID: <20150430202342.GC5015@vauxhall.crustytoothpaste.net>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
 <CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Cc: git@vger.kernel.org
To: Dan Langille <dlangille@sourcefire.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynuzx-0000eQ-92
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbbD3UXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 16:23:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:53152 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752803AbbD3UXs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 16:23:48 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d8d7:1ec4:dcc9:52a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 464602808D;
	Thu, 30 Apr 2015 20:23:46 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dan Langille <dlangille@sourcefire.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268106>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 04:14:12PM -0400, Dan Langille wrote:
> Would this question be better suited for another list?

Nope, this is the place to go.

> On Wed, Apr 22, 2015 at 4:06 PM, Dan Langille <dlangille@sourcefire.com> =
wrote:
> > Hello,
> >
> > I'm using git 2.3.2 with Kerberos for authentication and gito-lite for
> > authorization.
> >
> > This works:
> >
> > $ git clone https://dvl@ repo.example.org/git/testing
> > Cloning into 'testing'...
> > warning: You appear to have cloned an empty repository.
> > Checking connectivity... done.
> >
> > My goal: have it work without supplying dvl@ as shown here:
> >
> > $ git clone https://repo.example.org/git/testing
> > Cloning into 'testing'...
> > Username for 'https://repo.example.org':
> >
> > I don't want to be prompted for a password.  I want Kerberos to kick in.
> >
> > Following http://git-scm.com/docs/gitcredentials, the following seems to
> > have nil effect.  Anyone used this feature already?
> >
> >   git config --global credential.https://repo.example.org.username dvl
> >
> > $ cat ~/.gitconfig
> > [credential "https://repo.example.org"]
> > username =3D dvl
> > [http]
> > sslCAInfo =3D /usr/local/etc/trusted-certificates.pem
> >
> > With the above, I still get prompted for a password
> >
> > Given my use of Kerberos for authorization, is this option feasible?

Not at the present time.  The only time that the credential API is
invoked is if it prompts for a password, and by that point you've fallen
back to Basic authentication.

> > Should I be taking a different approach?

If you want it to work only with Kerberos, then any username in the URL
is fine, as libcurl doesn't care.

One thing you could try is to make your URL https://git@repo.example.org
and then use

  git config --global credential.https://git@repo.example.org.username dvl

and see if it does the right thing for both Kerberos and Basic auth.  It
would be sort of a hack, but it might work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQo9OAAoJEL9TXYEfUvaLu9UQALjw1aFR4H81hDUgqci2+ooJ
mFTTdk0I5m2P+03Sn8KhpnXTnbyozXI9BYGX/lwnIhwIjmkxTYr4iMuzEodm9YRO
Y0LdLPl/sRw9dglbzGolHRZUU2RdERbDOCQKsbiqrWIShXDC5prsc2sfdRaIKx89
mSPK2tsClaknvyD/bbpoGwEi3Y33+2PLZYkAiNop8YxnrhzpJc9yD7vM2HntdF4e
Q/3/I5GqZNRi5kUAKCCqkp15o2ui1fVE9b4FDViolofKEwuH7TofTjbE85/PokAE
ZUXnEoBdp30oz+40Hbtdpe6s8CNSyubxb9oYYuYhPlO83dBaa0ChW7SGhaUsaIUz
AvzszBwYl/U43Vi+XhRT44+gIA8G9URnCctn5/6O312VWG2WQ/JPcINm14B5w26Q
2i4psUjhO2rjgQCnqZICMrt38B33gg5KiuhvNPBmgfot0tobArLUXXH6kxxC5DoU
bqo10Mdrj92rmy6HUSizvw+TSGRhsPgHHLtQSQ5uTZ+bVsYorqQBkkR/kC11ZEYd
29aqpRmjY+vjlsD9TWLOfNGF1ETKAswKWGCow7PyLnocurz0co7GnPW7pANbVIsI
33DLKQpfJ5tg6zhprK1K8YfAb1J4ErsmrTua4sm5NttXVBJ/qDIjmchPfapgkzTy
Vr7SMOzHUR5bvHE0o7nS
=F71l
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

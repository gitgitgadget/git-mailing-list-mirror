From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Fix t9101 test failure caused by Subversion "auto-props"
Date: Fri, 16 Nov 2007 18:56:17 +0100
Message-ID: <75D25F7C-EAB4-49ED-80FF-2BC535915585@lrde.epita.fr>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr> <73246E38-9C22-4279-A53E-678434238E5C@wincent.com> <20071116124850.GA14473@atjola.homenet> <2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-41-32728788"
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>,
	Junio Hamano <junkio@cox.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It5RO-00011F-2x
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 18:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708AbXKPR4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 12:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762123AbXKPR4k
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 12:56:40 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50170 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933708AbXKPR4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 12:56:38 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1It5Qb-00053m-KX; Fri, 16 Nov 2007 18:56:29 +0100
In-Reply-To: <2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65234>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-41-32728788
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Nov 16, 2007, at 2:25 PM, Wincent Colaiuta wrote:

> If a user has an "auto-prop" in his/her ~/.subversion/config file for
> automatically setting the svn:keyword Id property on all ".c" files
> (a reasonably common configuration in the Subversion world) then one
> of the "svn propset" operations in the very first test would become a
> no-op, which in turn would make the next commit a no-op.
>
> This then caused the 25th test ('test propget') to fail because it
> expects a certain number of commits to have taken place but the actual
> number of commits was off by one.
>
> Bj=F6rn Steinbrink identified the "auto-prop" feature as the cause
> of the failure. This patch avoids it by passing the "--no-auto-prop"
> flag to "svn import" when setting up the test repository, thus =20
> ensuring
> that the "svn propset" operation is no longer a no-op, regardless =20
> of the
> users' settings in their config.
>
> Signed-off-by: Wincent Colaiuta <win@wincent.com>
> ---
>  t/t9101-git-svn-props.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
> index 3c83127..d7a7047 100755
> --- a/t/t9101-git-svn-props.sh
> +++ b/t/t9101-git-svn-props.sh
> @@ -48,7 +48,7 @@ EOF
>         printf "\r\n" > empty_crlf
>         a_empty_crlf=3D`git-hash-object -w empty_crlf`
>
> -       svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
> +       svn import --no-auto-props -m 'import for git-svn' . =20
> "$svnrepo" >/dev/null
>  cd ..
>
>  rm -rf import

Great, thank you for tackling this issue.  It wasn't easy to find.

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-41-32728788
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPdnBwwE67wC8PUkRAtLfAJ93HvmqKimUFqrtBQJuwmg11XJSrwCdFFo5
dNafDxyJVyLHawEng2Ya8ok=
=Heqy
-----END PGP SIGNATURE-----

--Apple-Mail-41-32728788--

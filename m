From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] tg-remote: don't add push specs but warn about
	existing ones.
Date: Wed, 13 May 2009 13:42:07 +0200
Organization: The Debian project
Message-ID: <20090513114207.GB11669@piper.oerlikon.madduck.net>
References: <20090512090201.GA10150@pengutronix.de> <1242209046-9416-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Marc Weber <marco-oweber@gmx.de>, 528442@bugs.debian.org
X-From: git-owner@vger.kernel.org Wed May 13 13:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4CrP-0000xg-I5
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 13:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207AbZEMLm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758079AbZEMLmZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 07:42:25 -0400
Received: from clegg.madduck.net ([193.242.105.96]:55842 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbZEMLmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 07:42:23 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 253501D409C;
	Wed, 13 May 2009 13:42:07 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 2C22544BB; Wed, 13 May 2009 13:42:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242209046-9416-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.30-rc4-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9356/Wed May 13 01:38:29 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119036>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.05.13=
=2E1204 +0200]:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Marc Weber <marco-oweber@gmx.de>
> Cc: martin f. krafft <madduck@debian.org>

Signed-off-by: martin f. krafft <madduck@debian.org>

> diff --git a/tg-remote.sh b/tg-remote.sh
> index 3a40081..86dcd9a 100644
> --- a/tg-remote.sh
> +++ b/tg-remote.sh
> @@ -28,8 +28,13 @@ git config "remote.$name.url" >/dev/null || die "unkno=
wn remote '$name'"
>  ## Configure the remote
> =20
>  git config --replace-all "remote.$name.fetch" "+refs/top-bases/*:refs/re=
motes/$name/top-bases/*" "\\+refs/top-bases/\\*:refs/remotes/$name/top-base=
s/\\*"
> -git config --replace-all "remote.$name.push" "+refs/top-bases/*:refs/top=
-bases/*" "\\+refs/top-bases/\\*:refs/top-bases/\\*"
> -git config --replace-all "remote.$name.push" "+refs/heads/*:refs/heads/*=
" "\\+refs/heads/\\*:refs/heads/\\*"
> +
> +if git config --get-all "remote.$name.push" "\\+refs/top-bases/\\*:refs/=
top-bases/\\*" >/dev/null && test "xtrue" !=3D "x$(git config --bool --get =
topgit.dontwarnonoldpushspecs)"; then
> +	info "Probably you want to remove the push specs introduced by an old v=
ersion of topgit:"
> +	info '       git config --unset-all "remote.'$name'.push" "\\+refs/top-=
bases/\\*:refs/top-bases/\\*"'
> +	info '       git config --unset-all "remote.'$name'.push" "\\+refs/head=
s/\\*:refs/heads/\\*"'
> +	info '(or use git config --bool --add topgit.dontwarnonoldpushspecs tru=
e to get rid of this warning)'
> +fi
> =20
>  info "Remote $name can now follow TopGit topic branches."
>  if [ -z "$populate" ]; then

Thanks,

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"the mind of the thoroughly well-informed man is a dreadful thing.
 it is like a bric-=E0-brac shop, all monsters and dust,
 with everything priced above its proper value."
                                                        -- oscar wilde

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkoKsg4ACgkQIgvIgzMMSnUA6wCfRZNp3PIXRJyxhzxrKfz+XIu9
qcsAoNMLuncME+xT2rRuS0qM4r4Lqs47
=JYIX
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

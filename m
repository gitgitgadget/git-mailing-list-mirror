From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Git svn migration does not work because fatal git checkout
 updating paths is incompatible with switching branches
Date: Wed, 25 Jan 2012 20:09:23 +0100
Message-ID: <1327518563.31804.82.camel@centaur.lab.cmartin.tk>
References: <4F20442A.1080005@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wk7ydCVlRiTtSpVa6S43"
Cc: git@vger.kernel.org
To: Christine Bauers <c.bauers@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 25 20:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq8Dp-0006we-GM
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 20:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab2AYTJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 14:09:25 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:58213 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2AYTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 14:09:24 -0500
Received: from [192.168.1.17] (brln-4dbc4241.pool.mediaWays.net [77.188.66.65])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 31F2946092;
	Wed, 25 Jan 2012 20:09:19 +0100 (CET)
In-Reply-To: <4F20442A.1080005@gmx.de>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189120>


--=-wk7ydCVlRiTtSpVa6S43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-25 at 19:04 +0100, Christine Bauers wrote:
> Hi there,
>=20
> I=C2=B4m trying to migrate a repository from svn to git which branches an=
d=20
> tags with the following migration script:
>=20
> git svn clone --no-metadata --stdlayout --A ../users.txt=20
> svn://host/svn/project/subproject subproject
>=20
> cd subproject
> git config svn.authorsfile ../../users.txt
> git svn fetch
>=20
> git checkout -b branch1 remotes/branch1
> git checkout -b branch2 remotes/branch2
> git checkout -b branch3 remotes/branch3
>=20
> git checkout -b src_v1 remotes/tags/src
> git checkout master
> git tag src src_v1
> git branch -D src_v1
>=20
> git checkout -b WebContent_v1 remotes/tags/WebContent
> git checkout master
> git tag WebContent WebContent_v1
> git branch -D WebContent_v1
>=20
> and get the follwoing errors:
>=20
> W: Ignoring error from SVN, path probably does not exist: (160013):=20
> Filesystem has no item: Datei nicht gefunden: Revision 8966, Pfad=20
> =C3=82=C2=BBsubproject=C2=AB
> W: Do not be alarmed at the above message git-svn is just searching=20
> aggressively for old history.
> This may take a while on large repositories
> fatal: git checkout: updating paths is incompatible with switching branch=
es.
> Did you intend to checkout 'remotes/branch1' which can not be resolved=
=20
> as commit?
> fatal: git checkout: updating paths is incompatible with switching branch=
es.
> Did you intend to checkout 'remotes/branch2 which can not be resolved as=
=20
> commit?
> fatal: git checkout: updating paths is incompatible with switching branch=
es.
> Did you intend to checkout 'remotes/branch3' which can not be resolved=
=20
> as commit?
> fatal: git checkout: updating paths is incompatible with switching branch=
es.
> Did you intend to checkout 'remotes/tags/src' which can not be resolved=
=20
> as commit?
> error: pathspec 'master' did not match any file(s) known to git.
> fatal: Failed to resolve 'src_v1' as a valid ref.
> error: branch 'src_v1' not found.
> fatal: git checkout: updating paths is incompatible with switching branch=
es.
> Did you intend to checkout 'remotes/tags/WebContent' which can not be=20
> resolved as commit?
> error: pathspec 'master' did not match any file(s) known to git.
> fatal: Failed to resolve 'WebContent_v1' as a valid ref.
> error: branch 'WebContent_v1' not found.
>=20
> How do I solve this problem?

First try to figure out where the problem happens. It could be that
git-svn isn't recognising the branches properly, or that the layout
isn't what it expects or any number of things.

What layout does the repo have? Does it correspond to what git-svn is
expecting? All those error messages come from the fact that you're
telling git some starting points that it can't find. Make sure those
exist and they have the name you're giving. What does `git branch -a`
say? You're presumably not giving us the real names, so we can't tell if
there are problems there.

If you're looking to migrate completely, something like
svn-dump-fast-export ( https://github.com/barrbrain/svn-dump-fast-export
) might get you there better.

   cmn



--=-wk7ydCVlRiTtSpVa6S43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPIFNjAAoJEHKRP1jG7ZzTGv4H/io7in3W+qUpxOvEkcvStJBW
fPm7eSJ9ixaaqMQrWOzynFuukA+e6N2Tapdr7PTcHMPblSilxQgvPU/3lsZMh4Qz
vY7ilDN3GTD4yXJ0PvaeWoFm4g9pMnlmc+S0oq10CBCYY64WvbO7qmKCF693r+42
YX/HyYQpPt49FXnks2j6azP35/Zi0YGGFZPSnVtdhoylAzazLQQwrq3dAfXdqiEV
ae3gUbUhnKd4UFm5rhgAzQL9y9iBpvPTgZBQUDuBGBB50EJN7JSMq4rJwl3ZNmIP
QjHhFW3I4MTUnhiFVI+nuYpF4pFgIyNoI83ZfrO46w33fH43QSLRrYwyfP33lEI=
=xqka
-----END PGP SIGNATURE-----

--=-wk7ydCVlRiTtSpVa6S43--

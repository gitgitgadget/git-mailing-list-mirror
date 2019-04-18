Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6F320248
	for <e@80x24.org>; Thu, 18 Apr 2019 06:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfDRG63 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 02:58:29 -0400
Received: from mail1.fsfe.org ([217.69.89.151]:57360 "EHLO mail1.fsfe.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfDRG63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 02:58:29 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 02:58:28 EDT
Message-ID: <f5a8939f2efddb194dadb59c946522a75c5bda53.camel@fsfe.org>
Subject: Bug report: `git-ls-files --exclude-standard --ignored --others
 --directory` gives incomplete output
From:   Carmen Bianca Bakker <carmenbianca@fsfe.org>
To:     git@vger.kernel.org
Date:   Thu, 18 Apr 2019 08:49:56 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-M4NCWj5JmQY+aPUB52kV"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-M4NCWj5JmQY+aPUB52kV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi git developers,

Apologies in advance if my mailing list etiquette isn't 100% perfect. I
don't use mailing lists all that often. Please CC me in replies, because
I am not subscribed.

I use `git-ls-files` in a project[1] to get a list of ignored
files/directories, and to ignore them in my project.  I found that using
`--directory` speeds things up by a lot, so I can ignore entire
directories.

However, I get inconsistent results between using the --directory flag
and not.  To demonstrate this, I created a super tiny repository[2].=20
The repository ignores all `*.mo` files.

I then do:

$ mkdir po/subdir
$ touch eo.mo po/eo.mo po/subdir/eo.mo

When I run `git ls-files --exclude-standard --ignored --others`, my
output is:

eo.mo
po/eo.mo
po/subdir/eo.mo

But when I run `git ls-files --exclude-standard --ignored --others=20
--directory`, my output is:

eo.mo
po/eo.mo

Rather strangely, when I alter the command to `git ls-files --exclude-
standard --ignored --others --directory --no-empty-directory`, I get:

eo.mo
po/eo.mo
po/subdir/

This seems very counter-intuitive to me, because po/subdir/ is an empty
directory in the sense that it contains no files tracked by git.

Is this a bug, or is this a miscomprehension on my part about how `git-
ls-files` is supposed to function?

With kindness,
Carmen


[1]: <
https://github.com/fsfe/reuse-tool/blob/75c8c1ba0b7fcefc3ab4e132b539f506e18=
f721c/src/reuse/_util.py#L115
>
[2]: <https://github.com/carmenbianca/git-ls-files>

--=-M4NCWj5JmQY+aPUB52kV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEaOz9p2Grh2PLV5z6duum9rbqLskFAly4HhQACgkQduum9rbq
LskVRw//UGFqEKjgRQuxGMAgLIO9uDs2ANQCHIBcUqd7xxyMu0LKzEWSTVt/2Ul0
OtJA4l2lJgtR9AsMdxg5WEVVX1dA88TpLIPDdNlwnLzUIklkuo2DeVa6GTVmpPa+
78H7rVb5AQUbW0BY1dhdOknWbZaDwmr8rlV2DKUDucpg+nbobTyjkC2ktBKtmdUT
U+4WD5VAHuvT7gPUZRAfvAgPEGUtZ8nC2/DOD3anbpK+8scFNuGGhmR0I2rhEwjF
QtyBmmB+WzfMkhEwB8vW4cEPHPu+xSuIAU/Cl8XL01pr+mHrlId4ZIJ5GTP//g4K
Oo2lsUxCozyyd4LC97tmPdAHSbDmDPBQAkLlecLaGHkkjBGij+dSiColvSCCugFx
lYbafshNFt2YDVEUSmRjf56tYDAdMhl38cEs0S93nSCZw09U2FL2U5ycAb6fsU7/
U0QMv7r6NnWkQNo0UqFCImKxAro77YNHq7zTt4D85JpvpThrc3yLhzY0S9ZWh/wB
8RiYeUj3U6Hphn55qBFQfLGyzAnp/rpIunj37iUWMN4ZVXxRMvnLA4cu4t13DY1b
nqEnzEupLQfizyeoI7AgFD88FbrmFYnkyG77N1TKykot92yTtpguCWldsvU/XnLp
AJHHRppdPJ1JW0vxw20cMhjsrYdpiMTbrjQWoQyL3IB+y6hp+M0=
=bFGq
-----END PGP SIGNATURE-----

--=-M4NCWj5JmQY+aPUB52kV--


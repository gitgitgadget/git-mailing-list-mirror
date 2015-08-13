From: Johannes Schauer <josch@debian.org>
Subject: Re: bug: git-archive does not use the zip64 extension for archives with more
 than 16k entries
Date: Thu, 13 Aug 2015 04:25:45 +0200
Message-ID: <20150813022545.30116.44787@localhost>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha256"; boundary="===============2421754159873201725=="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 04:25:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPiDJ-0000Z0-1X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 04:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbbHMCZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 22:25:48 -0400
Received: from fulda116.server4you.de ([62.75.219.19]:43236 "EHLO
	fulda116.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbHMCZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 22:25:47 -0400
Received: from localhost (ip5f5addcd.dynamic.kabel-deutschland.de [95.90.221.205])
	by mister-muffin.de (Postfix) with ESMTPSA id D6E12802F6
	for <git@vger.kernel.org>; Thu, 13 Aug 2015 04:25:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: alot/0.3.6
In-Reply-To: <55CBA140.7050301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275832>

--===============2421754159873201725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Quoting Ren=C3=A9 Scharfe (2015-08-12 21:40:48)
> Am 11.08.2015 um 12:40 schrieb Johannes Schauer:
> > for repositories with more than 16k files and folders, git-archive will=
 create
> > zip files which store the wrong number of entries. That is, it stores t=
he
> > number of entries modulo 16k. This will break unpackers that do not inc=
lude
> > code to support this brokenness.
> =

> The limit is rather 65535 entries, isn't it?  The entries field has two =

> bytes, and they are used fully.

seems to be 65535 indeed.

I just forwarded the number Dieter Baron (libzip contributor) told me when =
they
replied (off list) to my bug report against libzip:
http://nih.at/listarchive/libzip-discuss/msg00554.html

But reading https://en.wikipedia.org/wiki/Zip_(file_format)#ZIP64 the limit
indeed seems to be 65535.

> Which programs are affected? InfoZIP Zip 3.0 and 7-Zip 9.20 seem to handl=
e an
> archive with more entries just fine.  The built-in functionality of Windo=
ws
> 10 doesn't.

In my case I discovered this because libzip http://nih.at/libzip does not
implement reading an archive with more than 65535 entries without zip64.

> Besides, 64K entries should be enough for anybody. ;-)

:P

> Seriously, though: What kind of repository has that many files and uses t=
he
> ZIP format to distribute snapshots?  Just curious.

I have not searched for any.

In my case I was using git to keep track of the modifications our tools do =
to a
directory of files to detect regressions. These tools are also able to read
data from zip archives instead from a directory. I created the zip archive
using git-archive because the files already were in git so that seemed most
convenient to me. That's when I discovered the problem because our tools use
libzip. The easy workaround was to use another packager instead of git-arch=
ive.
We use the zip format because Windows has support for it.

> > Instead, git-archive should use the zip64 extension to handle more than=
 16k
> > files and folders correctly.
> =

> That seems to be what InfoZIP does and Windows 10 handles it just fine. If
> lower Windows versions and other popular extractors can unzip such archiv=
es
> as well then this might indeed be the way to go.

The wikipedia page above claims that windows versions starting with vista h=
ave
support for zip64. It also lists some other software with support for it.

Thanks!

cheers, josch

--===============2421754159873201725==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVzAApAAoJEPLLpcePvYPhLUEP/i3r+wbhhHBrapMjLLeIupJy
4I7fItTXxzSWyX8g8MH1RLdd/ckKJ0zsMQZTMtSbKwjEatE56ChvEvm2PIadX8Qg
DDn51mTFABDpPaItl8IxSmMVDzHePnkzTnFRbZzFC/jaCgm2Rb4AGCr9GTTvvlNi
37XQ/YyE2af2WiGtn2TLGO8ZamHaxoov4n9DYBEcgi9yUVg3CUvL5+Reb7spf0sI
PEOMkeuLmaBKDQsb4N4IPz6c0vTGgvfe9rmD4dtUKuB0R/7S2Tz366IM1zuypW3y
Q3hg53Pq2OaXtB5ukYYQ3mi5/jEyUIciF8mklbXfTx+vaaPoFXUwEgjJde+49WOl
lHfIpqk1w2WqYyzgwgf328of7lUeEh3ABhFdpAdNPOYf2amSUAy+xl614cu4Y/ld
wcoKn28H2pspfiux/SPljVbo9xhQbkd2Po8p0J2lLVhwXqjJv5MLBITPUSH0sZRL
MuI+1wNpOiQaIZsaxyiSmNUpMVdmeb2ZHUw38jkKCcpvYhtfE3ItCDs8R28s6bP8
yUEWXVrZk1hKmID1plLkCPAc5sHSZJdA7n66xv8ZdTyWHbykto45FPY6Kt0Lc6/q
B+riiP6rEuX6TeUnOvHc3lQ49lwGXfBrRFJbYvY/XQs99izD/Xp9o0SnJ3p9InC4
xPYEMc1IsRSxfssr0wNa
=6mn4
-----END PGP SIGNATURE-----

--===============2421754159873201725==--

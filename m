From: =?UTF-8?Q?=22Ren=C3=A9_Scharfe=22?= <l.s.r@web.de>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Sun, 23 Aug 2015 11:29:11 +0200
Message-ID: <trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
 <20150813022545.30116.44787@localhost> <55D8C824.6000704@web.de>,
 <CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schauer" <josch@debian.org>,
	"Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 11:29:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTRas-0007aj-Tp
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbbHWJ3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 05:29:18 -0400
Received: from mout.web.de ([212.227.15.3]:59964 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbbHWJ3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 05:29:17 -0400
Received: from [79.253.147.160] by 3capp-webde-bs47.server.lan (via HTTP);
 Sun, 23 Aug 2015 11:29:11 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:m79tkELO3kN9OSCOPuNADjSzGGRBADr7JTBI621gMIy
 sb9WLD74BaK5i+z7QwgW0nobht9ehO22/Y5RDB6T3w+EPF155V
 bsIXErkGxAY0tl1LIEZCFdAsfXSomQHfxxjeBzLJw/0aNmDqM8
 aMUUFn7ViL+VhIBbCgWCVsjbcaD3b9mqmTgVt9ppeCidyIbPWD
 WR4UYbVrgU+sDh7IFg9lJNzjF4XT9+N8pHKEVhGT+N/lJybFam
 nfTDuPA7zqQy2xiCkDsfRPAj94Wz0hpAyG+u6nTCVXMJd3+/xR 2+mI4I=
X-UI-Out-Filterresults: notjunk:1;V01:K0:E7sXvwippT4=:ZZOxDJABpRXdjcEuj1MLQR
 52ludJ+Ro4DtywCHGEdBPwa5Uhu5d1Fy3uHruoIxYr/T4CBWqoNvSiVc+24C5guCBzpQHhoW5
 xQZ4kF+fCQWpr22GSXFpiTg2euFKooe/45xfMdzFN1oLH0+vnUdc0eSETHHRGBx9kGGWaUKbH
 JLFXrtaV/NfNcyR06cFuTslH4h3CInf8xg3dxnxEFg/WapZWeDJura6efO/p+UUFlwRgdk5JS
 0Ewi/XZu9ad1c34Dd5Vf2QSFSAzIMPpw2AEtBHbBVMVEIZiXubXbxHexw9bgGRJyM+Y0NwWMP
 w8Z9/7DjdqjGFA6zXC5nLZ2kuw/mj00ColM5DG3Kn/P9lnLW6P5SHHvx6VB6orQimOgfE6gTX
 g0iPppetDyMYXq3QBrKJIdb2h85Hgz1OsRENx+UKU5BQsTzfdsWh72/3DQpoFIfE1gUxwk+Wj
 f4vFU16xDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276402>

Am 23.08.2015 um 07:54 schrieb Eric Sunshine:
> On Sat, Aug 22, 2015 at 3:06 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corne=
r-cases.sh
>> index 654adda..c6bd729 100755
>> --- a/t/t5004-archive-corner-cases.sh
>> +++ b/t/t5004-archive-corner-cases.sh
>> @@ -115,4 +115,44 @@ test_expect_success 'archive empty subtree by d=
irect pathspec' '
>>          check_dir extract sub
>>   '
>>
>> +ZIPINFO=3Dzipinfo
>> +
>> +test_lazy_prereq ZIPINFO '
>> +       n=3D$("$ZIPINFO" "$TEST_DIRECTORY"/t5004/empty.zip | sed -n =
"2s/.* //p")
>> +       test "x$n" =3D "x0"
>> +'
>=20
> Unfortunately, this sed expression isn't portable due to dissimilar
> output of various zipinfo implementations. On Linux, the output of
> zipinfo is:
>=20
>      $ zipinfo t/t5004/empty.zip
>      Archive:  t/t5004/empty.zip
>      Zip file size: 62 bytes, number of entries: 0
>      Empty zipfile.
>      $
>=20
> however, on Mac OS X:
>=20
>      $ zipinfo t/t5004/empty.zip
>      Archive:  t/t5004/empty.zip   62 bytes   0 files
>      Empty zipfile.
>      $
>=20
> and on FreeBSD, the zipinfo command seems to have been removed
> altogether in favor of "unzip -Z" (emulate zipinfo).

Thanks for your thorough checks!

I suspected that zipinfo's output might be formatted differently on
different platforms and tried to guard against it by checking for the
number zero there. Git's ZIP file creation is platform independent
(modulo bugs), so having a test run at least somewhere should
suffice. In theory.

We could add support for the one-line-summary variant on OS X easily,
though.

> One might hope that "unzip -Z" would be a reasonable replacement for
> zipinfo, however, it is apparently only partially implemented on
> FreeBSD, and requires that -1 be passed, as well. Even with "unzip -Z
> -1", there are issues. The output on Linux and Mac OS X is:
>=20
>      $ unzip -Z -1 t/t5004/empty.zip
>      Empty zipfile.
>      $
>=20
> but FreeBSD differs:
>=20
>      $ unzip -Z -1 t/t5004/empty.zip
>      $
>=20
> With a non-empty zip file, the output is identical on all platforms:
>=20
>      $ unzip -Z -1 twofiles.zip
>      file1
>      file2
>      $
>=20
> So, if you combine that with "wc -l" or test_line_count, you may have
> a portable and reliable entry counter.

Counting all entries is slow, and more importantly it's not what we
want. In this test we need the number of entries recorded in the ZIP
directory, not the actual number of entries found by scanning the
archive, or the directory.

On Linux "unzip -Z -1 many.zip | wc -l" reports 65792 even before
adding ZIP64 support; only without -1 we get the interesting numbers
(specifically with "unzip -Z many.zip | sed -n '2p;$p'"):

    Zip file size: 6841366 bytes, number of entries: 256
    65792 files, 0 bytes uncompressed, 0 bytes compressed: 0.0%

> With these three patches applied, Mac OS X has trouble with 'many.zip=
':
>=20
>      $ unzip -Z -1 many.zip
>      warning [many.zip]:  76 extra bytes at beginning or within zipfi=
le
>        (attempting to process anyway)
>      error [many.zip]:  reported length of central directory is
>        -76 bytes too long (Atari STZip zipfile?  J.H.Holm ZIPSPLIT 1.=
1
>        zipfile?).  Compensating...
>      00/
>      00/00
>      ...
>      ff/ff
>      error: expected central file header signature not found (file
>        #65793). (please check that you have transferred or created th=
e
>        zipfile in the appropriate BINARY mode and that you have compi=
led
>        UnZip properly)
>=20
> And FreeBSD doesn't like it either:
>=20
>      $ unzip -Z -1 many.zip
>      unzip: Invalid central directory signature
>      $
>=20

Looks like they don't support ZIP64. Or I got some of the fields wrong
after all.

https://en.wikipedia.org/wiki/Zip_%28file_format%29#ZIP64 says: "OS X
Yosemite does support the creation of ZIP64 archives, but does not
support unzipping these archives using the shipped unzip command-line
utility or graphical Archive Utility.[citation needed]".

How does unzip react to a ZIP file with more than 65535 entries that
was created natively on these platforms? And what does zipinfo (a real
one, without -1) report at the top for such files?

Thanks,
Ren=C3=A9

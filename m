From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Failing tests in t0027-autocrlf.sh under msysgit/git-win-sdk
Date: Thu, 02 Oct 2014 16:14:21 +0200
Message-ID: <542D5DBD.9090506@virtuell-zuhause.de>
References: <542D4769.60503@virtuell-zuhause.de> <542D563A.8070306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-win-sdk@googlegroups.com
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZh9N-0001RB-VH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 16:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaJBOOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2014 10:14:30 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:42703 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbaJBOO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2014 10:14:29 -0400
Received: from p5ddc25b7.dip0.t-ipconnect.de ([93.220.37.183] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XZh9H-0006lk-L5; Thu, 02 Oct 2014 16:14:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <542D563A.8070306@web.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412259269;5ba6a8c1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257808>

Am 02.10.2014 um 15:42 schrieb Torsten B=C3=B6gershausen:
> On 2014-10-02 14.39, Thomas Braun wrote:
>> Hi,
>>
>> I've enabled EXPENSIVE and ran the git test suite under msysgit/git-=
win-sdk with
>> git version 2.1.0.9753.g360f311.dirty.
>>
>> Now I have some failing tests in t0027-autocrlf.sh in the MINGW only=
 section which puzzle me.
>>
>> The offending test sets are
>>
>> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
>> index 72dd3e8..90c4cd1 100755
>> --- a/t/t0027-auto-crlf.sh
>> +++ b/t/t0027-auto-crlf.sh
>> @@ -245,18 +245,18 @@ if test_have_prereq MINGW
>>  then
>>  check_files_in_ws ""      false ""        LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>>  check_files_in_ws ""      true  ""        CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> -check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> +# check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF=
  LF_mix_CR    CRLF_nul # first broken
>=20
>>  check_files_in_ws ""      true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
>> -check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> +# check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF=
  LF_mix_CR    CRLF_nul # broken
>>  check_files_in_ws ""      true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
>>  check_files_in_ws ""      false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>>  check_files_in_ws ""      true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> =20
>>  check_files_in_ws native  false ""        LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>>  check_files_in_ws native  true  ""        CRLF  CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> -check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> +# check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF=
  LF_mix_CR    CRLF_nul # broken
>>  check_files_in_ws native  true  "auto"    CRLF  CRLF  CRLF         =
LF_mix_CR    CRLF_nul
>> -check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>> +# check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF=
  LF_mix_CR    CRLF_nul # broken
>>  check_files_in_ws native  true  "text"    CRLF  CRLF  CRLF         =
CRLF_mix_CR  CRLF_nul
>>  check_files_in_ws native  false "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>>  check_files_in_ws native  true  "-text"   LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
>>
>> I tried with NATIVE_CRLF =3D YesPlease but 117 failed too.
>>
>> First question, under what MINGW system do these tests pass?
>> Second question any hints how to tackle this?
>=20
>>
>> The first failing test is
>> not ok 117 - checkout core.eol=3D core.autocrlf=3Dfalse gitattribute=
s=3Dauto file=3DLF
>> #
>> #                       compare_ws_file eol__crlf_false_attr_auto_ L=
=46    crlf_false_attr__LF.txt
>> #
>>
>>
>> where I have in the trash directory
>>
>> $ diff -Nur *expect* *actual*
>> --- LF.expect   2014-10-02 12:15:17 +0000
>> +++ eol__crlf_false_attr_auto_.actual.crlf_false_attr__LF.txt   2014=
-10-02 12:15
>=20
> First things first:
> We have a file with LF in the repo, and check it out.
>=20
> Read it like this:
> "eol__crlf_false_attr_auto_.actual"
>                  ^ *.txt auto in .gitconfig  =20
>       ^
>       core.autocrlf is false=20
>   ^
>   core.eol is unset

Thanks for the explanation.

> The file is expected to have LF in the working tree, but has CRLF
>=20
>> :17 +0000
>> @@ -1,3 +1,3 @@
>> -0000000   l   i   n   e   1  \n   l   i   n   e   2  \n   l   i   n=
   e
>> -0000020   3
>> -0000021
>> +0000000   l   i   n   e   1  \r  \n   l   i   n   e   2  \r  \n   l=
   i
>> +0000020   n   e   3
>> +0000023
>>
>> Reading convert.h tells me that for undefined NATIVE_CRLF the native=
 EOL is LF.
>> Which looks like the test is correct.
>>
>> Thomas
>>
> Which version of t0027 do you have:
> The latest version in git.git is this one,
> and "should pass" (but I may have missed something)
>=20
> commit f6975a6b119128de1c5a89e6cd64f75ed1de2177
> Author: Torsten B=C3=B6gershausen <tboegi@web.de>
> Date:   Sat Aug 16 22:16:58 2014 +0200
>=20
>     t0027: Tests for core.eol=3Dnative, eol=3Dlf, eol=3Dcrlf
>    =20
>     Add test cases for core.eol "native" and "" (unset).
>     (MINGW uses CRLF, all other systems LF as native line endings)
>    =20
>     Add test cases for the attributes "eol=3Dlf" and "eol=3Dcrlf"
>    =20
>     Other minor changes:
>     - Use the more portable 'tr' instead of 'od -c' to convert '\n' i=
nto 'Q'
>       and '\0' into 'N'
>     - Style fixes for shell functions according to the coding guide l=
ines
>     - Replace "txtbin" with "attr"
>    =20
>     Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Correct guess! I've been testing the original version 343151dc (t0027:
combinations of core.autocrlf, core.eol and text, 2014-07-08).
f6975a6 of t0027-autocrlf.sh passes now completely.

Thanks for the quick reply.

Thomas

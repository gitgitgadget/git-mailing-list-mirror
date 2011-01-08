From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-archive and core.eol
Date: Sat, 8 Jan 2011 18:28:35 +0100
Message-ID: <AANLkTi==eqwrwq-P6czDvOH5GDEi6WgvRUuZ2dMoiK7e@mail.gmail.com>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com> <4D28683B.4020400@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 08 18:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbcbB-0000fT-RC
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 18:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1AHR3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jan 2011 12:29:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62118 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1AHR27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 12:28:59 -0500
Received: by fxm20 with SMTP id 20so17781589fxm.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=uZcN8ZTC/HrEggUYqQwDApQ5nLna2TsKvhtlLnUFuG4=;
        b=x2xygNybgLhhrZFGZbtn0oIxW0tBfHbBkNovQe2dAK784/0i3grNmL578SMzzIdnAY
         hIoESKt/EUfvlrVf5MxPZErwmnDO5CiLwr09zDp7RQBrIqisxpkgDppsWW5xNTCO2QfR
         4hN2FHlSqlXPSlFVDGAwyyGy4NcGjBv1jmIaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=TNdPsUck7Dq711oA68jDIVzPE5lgKlZvi3AWLjQTXrloc3AtwmEK841ZeOGnKx5KHQ
         5+f75fpmoieLKpfF3vsOKFaB3M+tEg2adnkCliWgYUv/KomIh8zMobAgTzw3uf+lFmJa
         +uefZKd/7fFSjrC4TpyU6Jev8wJJZGtZ+AsLo=
Received: by 10.223.112.1 with SMTP id u1mr3440235fap.109.1294507735790; Sat,
 08 Jan 2011 09:28:55 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Sat, 8 Jan 2011 09:28:35 -0800 (PST)
In-Reply-To: <4D28683B.4020400@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164834>

On Sat, Jan 8, 2011 at 2:35 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 15.12.2010 23:32, schrieb Erik Faye-Lund:
>> I recently tried the following on Windows:
>>
>> $ git init
>> Initialized empty Git repository in c:/Users/kusma/test/.git/
>> $ echo "foo
>> bar" > test.txt
>> $ git -c core.autocrlf=3Dtrue add test.txt
>> warning: LF will be replaced by CRLF in test.txt.
>> The file will have its original line endings in your working directo=
ry.
>> $ git commit -m.
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>> =A0create mode 100644 test.txt
>> $ git -c core.autocrlf=3Dtrue -c core.eol=3Dlf archive --format=3Dta=
r HEAD > test.tar
>> $ tar xvf test.tar
>> $ od -c test.txt
>> 0000000 =A0 f =A0 o =A0 o =A0\r =A0\n =A0 b =A0 a =A0 r =A0\r =A0\n
>> 0000012
>>
>> Just to be sure, I checked this:
>>
>> $ git show HEAD:test.txt | od -c
>> 0000000 =A0 f =A0 o =A0 o =A0\n =A0 b =A0 a =A0 r =A0\n
>> 0000010
>>
>> Yep, the file has LF in the repo, as expected... the warning from
>> git-add is a bit confusing, but OK.
>>
>> Hmm, so git-archive writes CRLF even if I said I wanted LF. But then=
 I
>> tried this on Linux:
>>
>> $ git init
>> Initialized empty Git repository in /home/kusma/src/test/.git/
>> $ echo "foo
>> bar" > test.txt
>> $ git add test.txt
>> $ git commit -m.
>> [master (root-commit) c6f195e] .
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>> =A0create mode 100644 test.txt
>> $ git -c core.autocrlf=3Dtrue -c core.eol=3Dcrlf archive --format=3D=
tar HEAD
>>> test.tar
>> $ tar xvf test.tar
>> test.txt
>> $ od -c test.txt
>> 0000000 =A0 f =A0 o =A0 o =A0\r =A0\n =A0 b =A0 a =A0 r =A0\r =A0\n
>> 0000012
>>
>> This leaves me a bit puzzled. On Linux, I can override the default
>> new-line style CRLF for git-archive, but I can't override it to LF o=
n
>> Windows?
>>
>> I expected it to work because sha1_file_to_archive calls
>> convert_to_working_tree. I've tried stepping through the code, but I
>> don't quite understand where it goes wrong. Or even how the code is
>> supposed to work :P
>>
>> Does anyone have any clue what's going on? I'm running with the
>> current master, git version 1.7.3.3.585.g74f6e.
>
> I can't seem to replicate this (1.7.4-rc1); see below for the test sc=
ript
> I tried to come up with. =A0It should test all combinations of the re=
levant
> config variables and the text attribute. =A0I cheated by simply setti=
ng the
> expectations to match the results on Linux; I didn't check if these a=
re
> indeed the correct results. =A0The test passes for me on MinGW, too, =
though.
>
> Did I miss a variable or are some of the expectations wrong?
>
> Thanks,
> Ren=E9
>


Really? I haven't looked through what the test actually does (I'm out
sick right now, and don't have many working brain-cells), but every
single test fails for me:

not ok - 1 setup
#=09
#		printf "1\\n2\\n" >lf &&
#		printf "1\\r\\n2\\r\\n" >crlf &&
#=09
#		echo "*.txt text" >.gitattributes &&
#		git add .gitattributes &&
#=09
#		mkdir autocrlf_false &&
#		cp lf crlf autocrlf_false/ &&
#		cp lf autocrlf_false/lf.txt &&
#		cp crlf autocrlf_false/crlf.txt &&
#		git -c core.autocrlf=3Dfalse add autocrlf_false/ &&
#=09
#		mkdir autocrlf_true &&
#		cp lf crlf autocrlf_true/ &&
#		cp lf autocrlf_true/lf.txt &&
#		cp crlf autocrlf_true/crlf.txt &&
#		git -c core.autocrlf=3Dtrue add autocrlf_true/ &&
#=09
#		git commit -m.
#=09
not ok - 2 archive with autocrlf=3Dfalse eol=3Dcrlf
#=09
#			git -c core.autocrlf=3Dfalse -c core.eol=3Dcrlf archive HEAD
>autocrlf_false-eol_crlf.tar &&
#			(mkdir autocrlf_false-eol_crlf.d && cd autocrlf_false-eol_crlf.d
&& "tar" xf -) <autocrlf_false-eol_crlf.tar
#	=09
not ok - 3 archive with autocrlf=3Dtrue eol=3Dcrlf
#=09
#			git -c core.autocrlf=3Dtrue -c core.eol=3Dcrlf archive HEAD
>autocrlf_true-eol_crlf.tar &&
#			(mkdir autocrlf_true-eol_crlf.d && cd autocrlf_true-eol_crlf.d &&
"tar" xf -) <autocrlf_true-eol_crlf.tar
#	=09
not ok - 4 archive with autocrlf=3Dfalse eol=3Dlf
#=09
#			git -c core.autocrlf=3Dfalse -c core.eol=3Dlf archive HEAD
>autocrlf_false-eol_lf.tar &&
#			(mkdir autocrlf_false-eol_lf.d && cd autocrlf_false-eol_lf.d &&
"tar" xf -) <autocrlf_false-eol_lf.tar
#	=09
not ok - 5 archive with autocrlf=3Dtrue eol=3Dlf
#=09
#			git -c core.autocrlf=3Dtrue -c core.eol=3Dlf archive HEAD
>autocrlf_true-eol_lf.tar &&
#			(mkdir autocrlf_true-eol_lf.d && cd autocrlf_true-eol_lf.d &&
"tar" xf -) <autocrlf_true-eol_lf.tar
#	=09
not ok - 6 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dcrlf: c=
rlf =3D> crlf
#	test_cmp crlf autocrlf_false-eol_crlf.d/autocrlf_false/crlf
not ok - 7 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dcrlf: l=
f =3D> lf
#	test_cmp lf autocrlf_false-eol_crlf.d/autocrlf_false/lf
not ok - 8 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dlf: crl=
f =3D> crlf
#	test_cmp crlf autocrlf_false-eol_lf.d/autocrlf_false/crlf
not ok - 9 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dlf: lf =
=3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_false/lf
not ok - 10 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dcrlf: c=
rlf =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_false/crlf
not ok - 11 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dcrlf: l=
f =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_false/lf
not ok - 12 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dlf: crl=
f =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_false/crlf
not ok - 13 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dlf: lf =
=3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_false/lf
not ok - 14 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dcrlf: c=
rlf =3D> lf
#	test_cmp lf autocrlf_false-eol_crlf.d/autocrlf_true/crlf
not ok - 15 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dcrlf: l=
f =3D> lf
#	test_cmp lf autocrlf_false-eol_crlf.d/autocrlf_true/lf
not ok - 16 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dlf: crl=
f =3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_true/crlf
not ok - 17 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dlf: lf =
=3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_true/lf
not ok - 18 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dcrlf: cr=
lf =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_true/crlf
not ok - 19 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dcrlf: lf=
 =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_true/lf
not ok - 20 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dlf: crlf=
 =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_true/crlf
not ok - 21 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dlf: lf =3D=
> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_true/lf
not ok - 22 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dcrlf:
crlf.txt =3D> crlf
#	test_cmp crlf autocrlf_false-eol_crlf.d/autocrlf_false/crlf.txt
not ok - 23 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dcrlf: =
lf.txt =3D> crlf
#	test_cmp crlf autocrlf_false-eol_crlf.d/autocrlf_false/lf.txt
not ok - 24 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dlf: cr=
lf.txt =3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_false/crlf.txt
not ok - 25 add autocrlf=3Dfalse, archive autocrlf=3Dfalse eol=3Dlf: lf=
=2Etxt =3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_false/lf.txt
not ok - 26 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dcrlf: c=
rlf.txt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_false/crlf.txt
not ok - 27 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dcrlf: l=
f.txt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_false/lf.txt
not ok - 28 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dlf: crl=
f.txt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_false/crlf.txt
not ok - 29 add autocrlf=3Dfalse, archive autocrlf=3Dtrue eol=3Dlf: lf.=
txt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_false/lf.txt
not ok - 30 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dcrlf: c=
rlf.txt =3D> crlf
#	test_cmp crlf autocrlf_false-eol_crlf.d/autocrlf_true/crlf.txt
not ok - 31 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dcrlf: l=
f.txt =3D> crlf
#	test_cmp crlf autocrlf_false-eol_crlf.d/autocrlf_true/lf.txt
not ok - 32 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dlf: crl=
f.txt =3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_true/crlf.txt
not ok - 33 add autocrlf=3Dtrue, archive autocrlf=3Dfalse eol=3Dlf: lf.=
txt =3D> lf
#	test_cmp lf autocrlf_false-eol_lf.d/autocrlf_true/lf.txt
not ok - 34 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dcrlf: cr=
lf.txt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_true/crlf.txt
not ok - 35 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dcrlf: lf=
=2Etxt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_crlf.d/autocrlf_true/lf.txt
not ok - 36 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dlf: crlf=
=2Etxt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_true/crlf.txt
not ok - 37 add autocrlf=3Dtrue, archive autocrlf=3Dtrue eol=3Dlf: lf.t=
xt =3D> crlf
#	test_cmp crlf autocrlf_true-eol_lf.d/autocrlf_true/lf.txt
# failed 37 among 37 test(s)
1..37

$ git --version
git version 1.7.4.rc1.3196.gfd693

(This is the current 'devel'-branch from
git://repo.or.cz/git/mingw/4msysgit.git)

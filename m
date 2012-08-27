From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Tue, 28 Aug 2012 05:25:53 +0800
Message-ID: <CANYiYbGudJ56j=o5SDJur2dv2=icCe2FYad88dV_5tBzLAbZnA@mail.gmail.com>
References: <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
	<08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
	<7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
	<d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
	<a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com>
	<1345523464-14586-1-git-send-email-pclouds@gmail.com>
	<cover.1346045253.git.worldhello.net@gmail.com>
	<f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com>
	<7v4nnoti3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T66os-0006SD-Ku
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab2H0VZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 17:25:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53793 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab2H0VZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 17:25:54 -0400
Received: by ialo24 with SMTP id o24so9170159ial.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DJ6hD+kNIL2iagetWQz5alet1M28krBAtMmBBlMwdCY=;
        b=luLrqLnQcO5u/vrgU5FgXdVq0TW+EESLCpjG5asr2VNiSagdkBMwf6qrFDTuI0kBjR
         GdLXKNfIlOWd1fMxRlliSny2ELPMt+6a2mps+z1HgKbdelvf4ZV1o+XCBfBZIOeLAOwz
         974eCyz7UhAIs1xaEx0Es5UgjlgUdFUXkylx1iUPY1Vrb8h5t8BHxUOUy0tJFPrcON1t
         ftzBmXPm0BltCzKphMFJiZt0TIzAJsLquKDArIBf4X3GRurXUIL31mpgLsrSKiS8TxOl
         xr4F848hgo3RwQCQon3V4jZBmhTqHfrXXFGvn1dZXRhC6jWqRqSCGLfQwuGftQuC/TNL
         FPKw==
Received: by 10.50.45.162 with SMTP id o2mr11698649igm.0.1346102753962; Mon,
 27 Aug 2012 14:25:53 -0700 (PDT)
Received: by 10.50.17.104 with HTTP; Mon, 27 Aug 2012 14:25:53 -0700 (PDT)
In-Reply-To: <7v4nnoti3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204372>

2012/8/28 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Use i18n-specific test functions in test scripts for git-remote.
>> This issue was was introduced in v1.7.10-233-gbb16d5:
>>
>>     bb16d5 i18n: remote: mark strings for translation
>>
>> and been broken under GETTEXT_POISON=3DYesPlease since.
>>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> ...
>> @@ -77,6 +75,14 @@ test_expect_success 'add another remote' '
>>  )
>>  '
>>
>> +test_expect_success C_LOCALE_OUTPUT 'add another remote' '
>> +(
>> +     cd test &&
>> +     check_remote_track origin master side &&
>> +     check_remote_track second master side another &&
>> +)
>> +'
>
> This couldn't have possibly passed with the trailing &&, or am I
> missing something?  There is already "add another remote" before
> this test that adds "second" remote.  Is this test about "add
> yet another remote", or is it checking the result of adding "second"
> that was done in the previous step?

The trailing "&&=E2=80=9C is a copy & paste error. I only run my fixup =
in
GIT_GETTEXT_POISON mode in a harry, not noticed the bypassed
testcase has this serious bug.

I split the original "add another remote" into two blocks. One is a
normal testcase, and another has a C_LOCALE_OUTPUT prereq
flag. This is because other testcases depend on the operations in
"add another remote" testcase ('git remote add -f second ../two'),
and these testcases would fail if add C_LOCALE_OUTPUT
prereq to the whole "add another remote" testcase.

>
> Will queue with an obvious fix-up with retitle, 'check tracking', or
> something.
>
> Thanks.



--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 010-51262007, 18601196889

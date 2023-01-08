Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2ACC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjAHKLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 05:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHKLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 05:11:08 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451CC741
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 02:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673172660; bh=/jv4k6rwh6ez7wlhL/qzSoNnDfVptdsFrHOQpqZyIss=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WSvlShCHe5gN3oPZ8F4HdNVPZKZPkcdFkax7pJswKWc8uBOFUX1DFY1hSEnBSeMq0
         QrZ2nfhHmsuuXjsAjmHbseAfwPNVEsVqMjpVdYCLTut0M7J62GaPcYebxqPA3z1OKR
         3N+blhTgkVJ3kwUDNFiv9EP1sXuYtZ/iYI5wK0pXN2p5caIAzbSXcHsKipM1WasNST
         qGNodBWmjrQN3sqdYDXzI4untaK2zVHhQh8nYFO2zdLAYSBVCpzPHa6dv1jAq9gCji
         cnRmkUoAtZ2JnTkxLuT7LJ0Jj0Ac/xJBPC99sv8vHY5eupb9SEDrQjgYQ4TSZsDciY
         L1C6brgcnpF8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([79.203.21.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqPN-1oSDe11ZoH-00mZd7; Sun, 08
 Jan 2023 11:11:00 +0100
Message-ID: <3e04e283-cad0-7be4-d85c-65d0a52289e2@web.de>
Date:   Sun, 8 Jan 2023 11:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/4] do full type check in BARF_UNLESS_COPYABLE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
 <4f161041-b299-f79a-e01b-cc00e2880850@web.de> <xmqqy1qdxz67.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqy1qdxz67.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2lRRLsQTmYJXegiH+XZVcdrw7TN2wV6t1pcdteY/PbJWBCPaAe6
 YYLscY164GBPofIDghF8N/boMY/rmL4RZrZBt7LfAQG63OOPRg7bcdJHF+ET2L98bs5QC5P
 SW08ma2jiDoxHLI3qKpSxR7VbjW7HS+0kwlcsG3jUv218QPMGmdBOSrRK1lX/YJM2Ei0X4C
 WDQRwG3Szllh4hMHIGogQ==
UI-OutboundReport: notjunk:1;M01:P0:6EQ+MbeYaDU=;T5ZSGtS5kmFkL900+DUQjMw+Iuw
 Z9OwMb0GuittNtt7/H/Ac4VZBxK05u01luPbt0RmMRJNxu5Q/IxIFM3cvoDU9iO6icOMT8SlQ
 zq6mRQtaS9lDskaBjzl+PhF2sWDWz+0qyv8PxY1kKGfkIUP6cXQJZXaw6dUkz4bvl3MFg+GwM
 2qvjIKE+HReeWjCCW/KTVtHu5oEj2QptvwUHqKzQrR6UcK8QGZHVcM2jUNBzKFuUD5ADqCek9
 xjue+I9D7PanfNvUWYm1vW+CzUzhTzs2zV9BIZJeiOEIGh5w2XKHOkVfKeGKvF5JXFHNp1y7l
 nlCmiwRwcE4w8wi0Ux37bbbjA06De8si62RvrjrS8NAfaW9ed964Km2rd0Log4xFvhGiZcB9Q
 zrMsQP4Xg/p0mSHmskgUDBmQ1/yay5BSYzQuen3HMnpXYhedgCfGWsn6+bI68ggfOD85WW1if
 7ymeVETOf2YL8ekcI4Z9/fh3kM5u+bJPwGMGAaurVfg5ykNPNt6OP6vjDhCz4fueOCU1ktXZS
 n/jfOANsALaukJGcw2UxnWcPpbITPbxh256FkBR7RHMV/97NEuJ8o7kfkZR/s3JT9D0E5VBD0
 mUTLkvttRIT7pF/vDHmPMXiBUPDrGh7gR5New0OmKF8PDkeFBw2v5toISoby+05jEx8TP4xoq
 JFihpatF9ZUU+9KKuTNI8F/bkgIYoYiNBWWvF9NaJml9P1EzarWOyppHleNSv6YuvgkIpTD7J
 gE1P80FfJVW25mkG2/mTcpu1HrIREmoMcKEh6AH8diLUY0RNJm28uxsPMxNR+EIDFNG2d1hyd
 O6GhjPaV0QNWIg5DEMkNB03V3kDG75vmafLIza704LlLHgBT1mFRlC1IrOkdalfYsErbM5cWS
 eRD9KFx4Loh74leO240NHJGXe4EeWY8FrTbtZTblzj2JVYqG4TBFUc0XfQ9f4VIfLcszcRp74
 vMT4Bw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.01.2023 um 08:28 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Use __builtin_types_compatible_p to perform a full type check if
>> possible.  Otherwise fall back to the old size comparison, but add a
>> non-evaluated assignment to catch more type mismatches.  It doesn't fla=
g
>> copies between arrays with different signedness, but that's as close to
>> a full type check as it gets without the builtin, as far as I can see.
>
> This seems to unfortunately break builds for compat/mingw.c
>
> cf. https://github.com/git/git/actions/runs/3865788736/jobs/6589504628#s=
tep:4:374
>
>    1848 |                 COPY_ARRAY(&argv2[1], &argv[1], argc);
>
> where the two arrays are "char *const *argv" in the parameter list, and
> a local variable
>
> #ifndef _MSC_VER
> 		const
> #endif
> 		char **argv2;
>
> It seems that (const char **) and (char **) are compatible but the
> pointers themselves being const breaks the type compatibility?
> Perhaps the latter should be "(optionally const) char *const *argv2"?

We compare the types of the elements, so effectively we do this:

   __builtin_types_compatible_p(__typeof__(const char *),  __typeof__(char=
 *))

... which returns 0.

We can remove the const like we already do for Visual Studio.  But
then we have to add two casts when passing on argv2, like in
mingw_execv(), because adding a const to a pointer of a pointer
must be done explicitly in C (even though Visual Studio seems to
do it implicitly without complaining).  Feels a bit silly. :-|

=2D-- >8 ---
Subject: [PATCH 1.5/4] mingw: make argv2 in try_shell_exec() non-const

Prepare for a stricter type check in COPY_ARRAY by removing the const
qualifier of argv2, like we already do to placate Visual Studio.  We
have to add it back using explicit casts when actually using the
variable, unfortunately, because GCC (rightly) refuses to add it
implicitly.  Similar casts are already used in mingw_execv().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d614f156df..e131eb9b07 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1839,16 +1839,13 @@ static int try_shell_exec(const char *cmd, char *c=
onst *argv)
 	if (prog) {
 		int exec_id;
 		int argc =3D 0;
-#ifndef _MSC_VER
-		const
-#endif
 		char **argv2;
 		while (argv[argc]) argc++;
 		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] =3D (char *)cmd;	/* full path to the script file */
 		COPY_ARRAY(&argv2[1], &argv[1], argc);
-		exec_id =3D trace2_exec(prog, argv2);
-		pid =3D mingw_spawnv(prog, argv2, 1);
+		exec_id =3D trace2_exec(prog, (const char **)argv2);
+		pid =3D mingw_spawnv(prog, (const char **)argv2, 1);
 		if (pid >=3D 0) {
 			int status;
 			if (waitpid(pid, &status, 0) < 0)
=2D-
2.38.1.windows.1

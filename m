Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E9C4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiJFVJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJFVJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:09:19 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BAC2C9D
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665090553; bh=p24uiJAPBbfE+YAT3Y4sb1H56+cvgt/T2ZJpqH1SM7w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sfW8ZytWjKGEe5Av0cSq3ZMsKKs1/Rp5au7Y5ZMq6FNOlxgdkOS6acAaSQALtU9ny
         vgBlTsum1lj5GgOH8ukNSsJyaKr400+QxJ+4Q5UI7TqMeM1vWuiK3A4x29+R1KiS9k
         cTYDH/ZHoEOdlQKhmqmQHvJW0gNiOPLx3UeiKr6C/B052T1w8clbucaKXU8HaEYXmc
         CTab+SOn6VPdvo5q15r0N1JWrIhGzAcUp0cO7dSgHir+/XXHkmF/YbBIuSQU/8MWuy
         d4qINMAlYpid2kn8XrOU29B+N6CaD3lUCRwOyeOL1An9yTSYtFLB0KO9P2J+aSaTJ+
         CJz9MyHUgN80Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1pEEhz26dC-00b9y6; Thu, 06
 Oct 2022 23:09:13 +0200
Message-ID: <36cd156b-edb2-062c-9422-bf39aad39a6d@web.de>
Date:   Thu, 6 Oct 2022 23:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] builtin/merge-file: fix compiler error on MacOS with
 clang 11.0.0
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <7cee38788a7a3c2c09a238e01c5bd825445f999d.1665085395.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7cee38788a7a3c2c09a238e01c5bd825445f999d.1665085395.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DLbBr4tKTR/fXo10SNFkXDwk89MQ5uTZydptrKbTQp5O6fH8fKD
 k10OND7/sKI5XvMzgY2qmBTP2xrKzWYA7cAKqfL34jF4CB5CGFHtgni0Waz7hmvdhlmwt0q
 k9gJAJjYV6NAuUQYEz/any0Sr8Vu/M0uWI/422P0xNbVutKgozSc2ASEBzJYYgJEsVNqLo6
 uVQhJFaoTYfKLySX7wekQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nxOhKnEbHU=:iYkbukke1cOI0yQBwR/BlN
 Y9wZodJh62CmEEszHPMb7fGxLW1Vu8nGO0Y2pM+L5P+DzT3cKbR/y4NWg1+TsDLBb4qHszi1B
 bA41At+5cCPzyKuJREoyuxwriDyNvU3vh4pSLfrKzI4TLIK2Xe2o/BJHkpNKX9383KgT1FEQ2
 j8b+s4rWFdiz//tzdoVSdYi9mkiACs8t+vAUPXxfRbNFMT8XMNzwMfyUzWTc3xu9noy4sIDMn
 PivwwHkXfbUDRhWG5c/iXf8Jp1yo0eu9R+FraUg6UIk6UpaG/E2qfyqZWtXUC9vowH2G1XMVN
 0HIDIi4usgqVzeGeCcOeiHmZuJ62diVpZ+iQuhP8tMQgj4Y1lVLCgqUyLRTs2A6KhMKnsF6R5
 MrUG9hk9FqM6h6Dk0t3e5b1IvJBjv0Clu7M/an1Oop0NmeDym7Ytc/hYo4c1tDRuZIo3NriPE
 re/DWCp3bs5Zovu2QV4ADJmRtWkhiagpRpX4P4ghVMxrEd/BmL25NxnJYVw17NLa+ClFHua+3
 tXJCRTjoZzHzxgOKRofICw+gh+jA4aXJ0EPlK80sySJ9yBg7m2mlLZOdx4P8FrZfBzLcumeZt
 OoFiKWcmGYeZ86ujccagnfkS4zdmrrYh7sJnvEXKuWn1wxM61AUMOnARNFzUV9H5WuMfcFqDj
 HrdPMLd2Ts9mRP6askhDL8/2I7jGfFumBzM/Mu4zJYB9wpolfsozjBbasZum4wpXmBhTPXxHg
 SWX50/hsa0AV1c0Fd2NSIkBEFu2j/rQ7f267SyEHKIpXeTMnj/1ym3kf87/tEMzRGljCz/FLs
 PzH1zIwfC/E4rhL71IqX3yzKzHOeDZVLUTRZmrJ0sfza6TmhR3/JZ1uxTxTBv4Mw/wsAtU4uU
 a5NMp+R1AXlvced9hHANjqLl+UInF3yMi7+xxn+TYmleBdDxivu4qQOcEMk+2/xdYVK/0sh0u
 Qw5qH/KFQdDMksRPcG0uVVpXSrU3cfyNbBQ+vlJ7SYjWuNGCPUVHirQD6FnL28O5+IbxXNDfb
 Z9aeCKytbSrVhJBbper81vKcQfFZJLnNOqz7n2LnpNwGRLP8yiB5pMVUazs+YBG+rk1wFw5xE
 YLswbu/Zf8KyG1oQ4C1H9ZtJqQ+JoTCemdgfvKQGvF9uqL19PCUF1/EF0OEGjSvfZebZRPLJs
 fAkbaPqLumbP7ny0MMwq53PloPlk2yh/dGfFLKNi24DOwmSsHSgIt/BPcXPucOCqXkMZr14Hd
 74lM4RnHIwqK5taY6eG+BWDDwKdGmfH+SL+Sfr8uUHuXsX3PL6yGWOlFdDxEL3fmiqzGjbHBA
 qrGy6op/LiwYOXTLNZiGo/fHOq642O9WCI4TH3a8FpViQpxJbNlm03agsCCnoUoawH//BkE12
 f0XrAWyK8zNd3SxgMAXXmRcsNE+9IXXHCBwwv/gOMAazMTYX6zlykxi6OVXPLc4bmcdJkI3if
 UIc/5Qz8kMXAbskr9jv7x7Hj1HOXoLJGb3rNs7ONfmyPoyPsQEzR4CH6ve+inBF/3HXczVTCE
 gJggnj+HGB9TDInKgqHSCtQHhm1bxV3KBFtKNPwYDsGIG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.22 um 21:43 schrieb Jeff Hostetler via GitGitGadget:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add extra set of braces around zero initialization of two array/structur=
e
> variables to resolve compiler errors/warnings from clang 11.0.0 on MacOS=
.
> This is not needed on clang 14.0.

Not sure how the Apple version numbers map to LLVM versions.  I can
reproduce it with Godbolt's Compiler Explorer with clang 8, but not
with clang 9 or higher: https://godbolt.org/z/f7f7s9xxz

Funny that type of the "inner" member seems to affect the warning.

>
> $ uname -a
> Darwin jeffhost-mbp.local 19.6.0 Darwin Kernel Version 19.6.0: \
>        Mon Apr 18 21:50:40 PDT 2022; \
>        root:xnu-6153.141.62~1/RELEASE_X86_64 x86_64
> $ clang -v
> Apple clang version 11.0.0 (clang-1100.0.33.17)
> Target: x86_64-apple-darwin19.6.0
> [...]
>
> $ make builtin/merge-file.o
>     CC builtin/merge-file.o
> builtin/merge-file.c:29:23: error: suggest braces around initialization =
\
> 			    of subobject [-Werror,-Wmissing-braces]
>         mmfile_t mmfs[3] =3D { 0 };
>                              ^
>                              {}

{0} is an idiom to zero-initialize any struct, no matter how deeply
nested.  It's valid C and the compiler warning about it is not helpful.
Shouldn't we rather silence it with -Wno-missing-braces?

On the other hand: Uglifying just three initializations in total isn't
that bad.  The issue may reappear, though, because most people use
compilers that don't issue that spurious warning, I imagine.

> builtin/merge-file.c:31:20: error: suggest braces around initialization =
\
> 			    of subobject [-Werror,-Wmissing-braces]
>         xmparam_t xmp =3D { 0 };
>                           ^
>                           {}
> 2 errors generated.
> make: *** [builtin/merge-file.o] Error 1
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/merge-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index c923bbf2abb..607c3d3f9e1 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -26,9 +26,9 @@ static int label_cb(const struct option *opt, const ch=
ar *arg, int unset)
>  int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  {
>  	const char *names[3] =3D { 0 };
> -	mmfile_t mmfs[3] =3D { 0 };
> +	mmfile_t mmfs[3] =3D { { 0 } };
>  	mmbuffer_t result =3D { 0 };
> -	xmparam_t xmp =3D { 0 };
> +	xmparam_t xmp =3D { { 0 } };
>  	int ret =3D 0, i =3D 0, to_stdout =3D 0;
>  	int quiet =3D 0;
>  	struct option options[] =3D {


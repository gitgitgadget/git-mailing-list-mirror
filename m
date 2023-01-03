Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3FC3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 16:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjACQ35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjACQ3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 11:29:55 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2765FCF
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672763391; bh=UMujoyPEb0gGXhABmfhvQxG1RFzOitbSxNpZEFBDXvw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=cSEm1i8reUjMM61gG9vNpOjT3ZDxFEVJiN8TOUCbeiU6OmEYQI1AKDHjniHMFIlXa
         rDAa90tm/wgTzvDVzptRjtNeaBjZF3N1IRdC7NlVyzIM8+881fXQLKoH/smWQeX8ob
         HhmvhhF97jo45dyd5UNi1lboMWhF9QQjHChK5lObk04C2G1nfvw64UmUFrrqur6poS
         TZBeBEArTmzv0dqUrwXnoL9vmUSC8CMfGtetKc/HBxhfxusYGoaUlb8aoGsrwBZTNy
         tin1zPTIQOTMAir8VzjcwM8paVX/lAVMUJdzZrs72ciezDEplMjiBrejh0c5vTctvq
         fQtTKfwCYhl2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1pWTwd2Xqy-00Juv1; Tue, 03
 Jan 2023 17:29:51 +0100
Message-ID: <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
Date:   Tue, 3 Jan 2023 17:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
To:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l6Ff5g5MDfY0yiaO0gX663fSv4Iwatip6X2zyT/RVprmJVMxILb
 o2qCI5RwiTaNUowKCp8xEOio4RiRtiyW/c1y8dOZ6DVNa5DaKR5oaq3s7B5KoBeNSDo5cbd
 fI/rfXBZkxz0owvnzQkrOthbtQqPyM4RMwYmrZPeC/9yFIdaUSgdVbrbDSsjBjZ1+kIZizS
 CW3TuQt/P/HauLM3nsLqg==
UI-OutboundReport: notjunk:1;M01:P0:nwr+YHd/ywo=;Zga7evnzI2X8lY/acS90uNc6mPR
 jtYANHvtcU1FNBoimIlhBiz5x4Ago2GNFA/4UfkFODrpPwVZVBJsETIm83CQSQQHnWUHbPiFd
 FrgcKCKL/rOl9+D5o77X5Whjk8CpcwPYCelh2NMkLVmEAtjoUL+/5/+jLOaOm//L6rhimNJon
 lYh9b4KQFfzzmRzDZsLR4j7Wlmzb336f+RaWKTDWqjLKR7dQoy3K1N21a/UrtojFu4rf6dFpi
 ujspzdbos949VWW5HM+ePB3vLS9DqCNuOv+pldy3/SzZ15jmQYzZ+UNePilC3Uk7CeP/H0zDK
 34bF3fVtnFn+zhPFrlYxEUeiqpEy5vRyhKdtexCSYZVO1T5r0IZYOSYktXXGbd+CxbCmkkWJy
 JvD6GNrJrSg385V6PR71nEzQH3pdK5GgoxA2S0R5TnMR1WhOIbXcRgi/h5aqKQ2ox8uXzMKDk
 oTXxdGhyZIMSlmhjxNprW6fXT9qveJlBSlAbY3NRveiHZ56cR//mu5cUp/v2kaYdT4NKpQv9e
 7yyn/4QdSlX58hBA4cUIKKwtQxzfLB/m53adT2T/CWLAih/P2aGGUnyVKCcNQLsfQGmMiZdV/
 ZrMohV+AbPRwdtug6EeV9okWEuon7X/cOWVRHVJ33bTF45MAa/5Hu7BGppkVnI/nMN4NCbCIQ
 xo/qViTOr9Lp+1OvsK2GmmNK3xIoFJMwUjHbZMixfLmIHmKD/sb0S9yprkMGvEYtMIBfuSVJ0
 cfMDF+tUvw+dwD6E4NKLvxXIZ+0p+qKOY+LZo35p3dyi75p2k6o+o62W87OJ7I2VjCPNT7Ntg
 MyUxbLVAH9ssux9NSfCwPo08i8Fy2JjrRigenCDtBqVoLM6Mf+0fyfmIX0vi3HBsQwveife3Y
 9zMMbTaohUQwEVgAhTQkGXY84dNM/QcTV+uqDcDb1bhiIhvVfedw9srykPVMIeelrRPNiCGn9
 3hel0g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.23 um 10:53 schrieb Marco Nenciarini:
> I've installed latest git from brew and suddenly git grep started behavi=
ng oddly when using alternatives.
>
> ```
> $ echo abd > test.file
> $ git grep --untracked 'a\(b\|c\)d' test.file
> $ git grep --untracked 'a\(b\)d' test.file
> test.file:abd
> ```
>
> It should have matched in both cases.
>
>
> If I switch to exented pattern it starts working again
>
> ```
> $ git grep --untracked -E 'a(b|c)d' test.file
> test.file:abd
> ```

This is expected: Basic regular expressions don't support alternation.

Under which circumstances did it work for you without -E or -P?

>
> [System Info]
> git version:
> git version 2.39.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:08:47 P=
ST 2022; root:xnu-8792.61.2~4/RELEASE_X86_64 x86_64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/bash
>
>


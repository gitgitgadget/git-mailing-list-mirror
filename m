Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314FECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJ1OXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJ1OXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:23:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32E7E02C
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666967016; bh=dt2z8Du7H//Tt8VSIAtSD7AI5s10cof5LcWQaPrN5YQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L7PTKA8I6w6oY2ur1hEUx9mUmFihHRzqcB1dE6gjc426aHosCXRe34RV4c1yav2wx
         HFWeRsKgpkHkKpDoaaM1WVP+Aw3XYpCCevWb+XonvXSUXlegrVctLL4m5l2qTj9Lys
         oo42Uh07hKQBBBq1dXXJXoNTANz5z5zBtOaPagFrg5eUyA2vDK4dMj+Ua6Dd68ShW5
         b5baKpDOTB8cdQp8D70KjkRFLbQ4YdiS7tRbBXzrVep2HxqRZHHvT0PME6FVW5C2Sd
         qtPe1vDEWc/G8xuONUtxSQzuQ3YSOEIqDT7Gj8MBs9DMu+Rz6GnzVgbl+AE/FXsYIU
         3Vh7aSJBBfSdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1p2WmS1P64-00wVru; Fri, 28
 Oct 2022 16:23:36 +0200
Message-ID: <943608ab-340d-8cd3-8812-c0f65909000a@web.de>
Date:   Fri, 28 Oct 2022 16:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <Y1rl9arDRGay0CHm@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y1rl9arDRGay0CHm@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bVSKroow3VYL3x41iQLocX3tAIo1fj02CfrTaAf1t1t9SGZoBOV
 ZX6g7xy/iDhwRbwJ01/wdD/avCD7hCdBPf4S0vbM2DiRkrYHEap66QWXoMot+47hHcJRl6v
 A2aQc4u+HHx8zwX7y9bsO2i0aKw/dFoYRWFWZ7+9fhL4OV44c0n5ehZCNBLBh1pXXV77ODK
 kYXKPSnfEydm8PBhYYWMg==
UI-OutboundReport: notjunk:1;M01:P0:8wIjkAz+b4s=;Tb5eKuTh3/sHCL6eby+378AnLOA
 H+eCqmPrNdy+P68pNGrMxPx7LITOzecE3j2XsKhKG1cYq3GzqolpKgFUQXjVZW4s7ij/apf0u
 DlAfaehK6tFtNsNj76GuYl+GRthw6MSSR5ND5+1A4wtAKlQ1dZU4O6rdIco3FPaSPUYgLHCK2
 rpzceuWvoSzyhdd30kb5Ns6QqgSpqyfDeapmvUq7zpnRtc+JgBXWO4/7toKvrgPy3TWoCOlys
 rtudoHsZUaLoNpoIB8EwVWNfqsgQCF/TtqhUV+qHTJqT1cSTmkoEodX5K8CKAgAYyptF2fd6e
 /OL8cy7jbvypClYbRzlAyvOjP4Ko+aYoBI3v4HsnBVHb6iOgSV3ptbbbTMWwtJxbKfcEZGBOw
 KutwAx9PjmGInMnH5VzYQYXx+zgEOLqHbbikpA/SOhqtlqVjrVupcV+xzZLLSzbZagcmlh3fh
 rGS9IX7EZuT9jdjNZHBtspyRIOKA66OxvAyWtHWyEcHMIsXsaO22TnrigMtdvCThPFX7peCT3
 HtVPK0Xcjn3s/Y1YdMrGL2pHatXFIVcwTJBTbyE0M3ckYdbWz8WM/o2ISdSGPsYzbdm1RVPAu
 oqJb5kWuwYgVelJZ2uuwesdb+7GFly+oHkZ0Q1pB7TXFFdb/Z88jseKLZ5QB3PPJXeowU97sB
 U94+LprrMHZ70UPrgnAMtwhyDXj1V91/ijaM6BNrNmTy6KqL6R8MhpHEl+/USmh0Nx2H50Pbx
 UoD6BNAKSCuZ5/zJEk6PLP6+WOKppp491AgAdfOSSNMmExRCporQV3L5lWKqPMZKUQhKlFRx+
 BPjqMJJJZ2F92BEjszyx93zeE0I+S90WQVSxa93em6NV+n3bUEl+X8pE7RcAxmbQ95L8LczBO
 rRv9AAFkyQluymt9mFrjEUy3Kl29OHSr0YqgZMult4X0h5mN6bna/P7S//TvhB3ZQEP40ullt
 ZXmmQHRv8oA1qiYXkgRFGxhrwGI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.22 um 22:11 schrieb Jeff King:
> On Thu, Oct 27, 2022 at 06:30:36PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Replace the convenience functions run_command_v_opt() et. al. and use
>> struct child_process and run_command() directly instead, for an overall
>> code reduction and a simpler and more flexible API that allows creating
>> argument lists without magic numbers and reduced risk of memory leaks.
>>
>> This is a broken-out and polished version of the original scratch at
>> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de=
/
>
> I read through this and it all looks fine to me. I was a bit puzzled at
> the layout of your series at first. In particular, the difference
> between cases in patch 4 versus the later ones.
>
> I think it is that in patch 4, these are all unambiguously positive
> because we are getting rid of magic numbers (or magically-sized arrays).
> Whereas in patches 5-8, there's nothing inherently wrong with the
> call-sites; but as we get rid of the API wrappers, we convert them. So
> they are collateral damage, so to speak, from the simplification of the
> API.
>
> That makes sense to me, though I could point out that most of the sites
> cleaned up in patch 4 _could_ be converted to look like the ones that
> are converted in 5-8. Obviously that doesn't make sense to do, knowing
> that 5-8 are coming. But if the point in splitting it this way is to
> show that we could stop at patch 4, cleaning up call sites but not
> shrinking the run-command API, then I just want to point out that there
> is another way to do those cleanups. :)

Yes, almost, except that I think 5-7 are doing necessary pruning and 8
requires a small leap of faith in the value of simplicity.  And I wanted
to shrink down and simplify that last patch.

Ren=C3=A9

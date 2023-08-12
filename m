Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D9C0015E
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHLFLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHLFLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:11:20 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29575BE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691817064; x=1692421864; i=l.s.r@web.de;
 bh=7B/ef4VKe0qjeIIc2RIMcHS1Mb86MIaGuQBEdQ82v8Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=msoGMww0SIdUA0Pbm61QnaQ/ysodMgB7TzpNU2Pz5qIC6YXdeLjZ3SDb7JrS3UuMJQN1dDA
 c7vTQuZ2m1T2NaFku5KcBNrp/WUJSiBNdVjJNQ168felB5wIFpPqXt2cowVannQRU82h7AmSM
 69Ffs5vx4pemWZK00uvmPXMU5OVyzixJBE8qs5miODO7voC8J+rwcYDG4AvGu8HtBD8wbCvAL
 LioC8eHcp6Yje3hHihosQ2cYvyYq91EE7jF5pgs5DyBDT1oNX2nnfLBngCHzuAPz+v5Z2IS8h
 pYJubJH9ZR3y8ypjnOJDk5jgU2Y1wt21nJAERm2nBlfEM2PCMm9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1qOcdK2NNu-006Oil; Sat, 12
 Aug 2023 07:11:04 +0200
Message-ID: <6e05309d-c2be-c949-ae83-c4dd3247e790@web.de>
Date:   Sat, 12 Aug 2023 07:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
 <20230811151102.GE2303200@coredump.intra.peff.net>
 <fbeadf7d-c16f-0612-6256-fc4355e89638@web.de>
 <20230811182415.GC2816191@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230811182415.GC2816191@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XD28+Hp5HL9VOUf5ih0skQT1DQCetCE/S9b5jwCV2ddle3SGmrB
 gOCa5UcSYJBkEKnhUYWamBz71RDj+SALJVQNJF9Ndhe+tkmgbWnV30vnndu6z+LPVm4laq4
 Oa/nfoqNITGT2h+Kp0ju1X08fcEfHwKZE2h6266Z7gAvA6KYpx4QCnWpI041GUfSD9ctlSv
 MAnlLmlnDHBo2xrsdzQ7Q==
UI-OutboundReport: notjunk:1;M01:P0:zrm9+bo+olA=;mZf+oy+J31KsnEh/xu2cNVpWj5x
 /B8+h7g1PtB9dRnP3arm+yYHoIdU3LKthrIJWIULzuAeiy9D7fhZcuRFd6eO0N/ASMPNHNLP8
 Z9FdcLqikLi/eKher25jp7lC/sjQ+6Sg48AeVvqofkNZXZVkEUTSWxpSCQCFEqLF0f+4GNgcO
 R2k01mLUUmZp8YCtlbXbHGaHkD3AKmcihnKfKs2tjG5zpgi9b+wwxMeXXZ1y2Ha3sdYwB1+z3
 zYwgjtLAGwyUFkzf5PXdW+U3tWupNAZV8Qr8lAs7Zcjysp86bzIl4qHW66SY87+xOzyIdYk/b
 GFn6P0HAPZWiAjF/Yz2m6G8wpfozZZ/rL3oYO2oDY7jju2/pj24RzCJo9eqKQPTGdlMchxHn4
 s4LZVimW18KSIQNiNfe2EB8/LxWE/s8ysmMEa1bwPHUyx4kCO+05yzpCuZFH8uaw5VdKKyIEP
 87ulGsxBEi/DR3fzQc81FGyUkiq9Wmd2pSwrONqUCt55+isyznyGJlI+6i5ObqOZnRamvPcjS
 yjkaonpQJvnxcpNju/WsGAvrK5I3ZRuDeg1ZmGn69fqaUAaTEInIVgMIFB0UkvdYY0q0NjHN2
 YQ+9+EXZa0EB6FHRpv1vViHB3U4Kp6aj0JIKxyZWPld8WuqLu/Fo1uDZB9PvoYR/7IhrPGEOk
 SzbnZZg4/Mf46KNNcOPVoNzwiLwUGErODwCzaJhw405NTr1lJnttc8yiJLR6yrMuUSrs8VhuC
 FJ3wA9aVp+nKpMQgVr+UCz+iFB1aKAKW6BysqwzF3VOp8hEzY//DcRkXdqXBqCpvoWg6T4qH2
 U70GUYgr0HrFfMzOV6ZkUdQgrAFFnMrp08uXElAlXdHrfe7f47+7uzEQowdRA/fmTXcxCY8Mm
 eI14VMZ0vxe4VXDvCMi9Max/Aqo/XipnBv8WdgFxbF8tVBzl7bR2tUHFQC9KP1nQEIpGJ5ipe
 ZJSa0iIzBnJjJBuYPdobYPPF3w0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.23 um 20:24 schrieb Jeff King:
> On Fri, Aug 11, 2023 at 07:59:12PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> we are defining an inline function with the explicit goal of passing i=
t
>>> as a function pointer. I don't remember all of the standard's rules
>>> here. Are we guaranteed that it will create a linkable version if
>>> necessary?
>>
>> I don't see on which basis the compiler could refuse.  We can't expect
>> the function address to be the same across compilation units, but we
>> don't need that.  If there's a compiler that won't do it or a standards
>> verse that makes this dubious then I'd like to know very much.
>
> I seem to recall some quirks where an inline function that is not called
> directly is not required to be compiled at all, and the compiler can
> assume that there is a definition available in another translation unit.

C99 says in 6.7.4 Function specifiers: "It is unspecified whether a call
to the function uses the inline definition or the external definition.",
referring to functions with both types of definition.  So a compiler
could ignore the inline version for those.

> But I think that only applies when no storage-class specifier is
> provided. In this case, you said "static", so I think it's OK?

That's how I understand it as well -- there is no external version to
choose and the compiler is not free to ignore the inline one.

> It's possible I'm mis-remembering the issues, too. One problem is that
> pre-C99, you might end up with the opposite problem (a compiled function
> with visible linkage that conflicts with other translation units at link
> time). E.g. here:
>
>   https://stackoverflow.com/questions/51533082/clarification-over-intern=
al-linkage-of-inline-functions-in-c/51533367#51533367
>
> But I think with "static" we should always be OK.

*nod*

> Don't get me wrong, I like type checking. It's just that doing weird
> things with the language and pre-processor also carries a cost,
> especially in an open source project where new folks may show up and say
> "what the hell is this macro doing?". That's a friction for new
> developers, even if they're comfortable with idiomatic C.

Sure, but that ship has sailed in this specific case.  Standard option
parsing would use getopt or getopt_long, neither of which has void
pointers.  We already carry the cost of our OPT_ macros.  Let's ease it.

> That said...
>
>> A good example in parseopt: The patch below adds type checking to the
>> int options and yields 79 warning about incompatible pointers, because
>> enum pointers were used in integer option definitions.  The storage siz=
e
>> of enums depends on the member values and the compiler; an enum could b=
e
>> char-sized.  When we access such a thing with an int pointer we write u=
p
>> to seven bytes of garbage ... somewhere.  We better fix that.
>
> ...I do find this evidence compelling.

It's 3 instead of 7 bytes of garbage, but the point still stands..

Ren=C3=A9

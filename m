Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749BAC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJTSe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTSe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:34:27 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FA6254
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666290851; bh=TNZ3Pd7XqTmVtjNuEfWr0Z2YG0wEGJeGswLkbau7wmM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Nyxcsan0oI0h6xytn30V43UxUNlkARh6a1yVpP4UApIomsNR+39VV7iIQWZjlniQj
         06/PLFdgG3lefZw3cZxpU/E7mmW6tyaYxYrwFaddcKBseotQWc4Ne6dWn9/4cSGeEv
         yQBvmA+3vNmvAZIpvhtY+qyh6ngbBqsoHxhsqUtxSAExwDDSgglCp99yVa5a9t3/Tw
         f9+14H8JrZQxi9MfWq4y3EUhisvtRfJDFLrLjvxRm2mPhjaD/fMsVuD8IlBcyuawrH
         trJsNYsu2X818iIafXQXBEPVuC0gnj2Fw4hxjvYdX5YWVpQGFmQGu6fGwnbZ0V4KvE
         JPPb2zbHwBMEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1pEi413P6g-012rrB; Thu, 20
 Oct 2022 20:34:11 +0200
Message-ID: <84971a3a-4c5c-5b79-582e-88b3bd8c624f@web.de>
Date:   Thu, 20 Oct 2022 20:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
 <xmqq4jw1wl6z.fsf@gitster.g> <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
 <Y08P0G1Be+5hCVML@coredump.intra.peff.net> <xmqq7d0vu8cw.fsf@gitster.g>
 <Y1AujKKPUJFepph5@coredump.intra.peff.net> <xmqq7d0vsngp.fsf@gitster.g>
 <Y1BIfEN5ds2kKjjk@coredump.intra.peff.net> <xmqq5ygfr48b.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5ygfr48b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:28RmNjLK7kmWWAD68gWpQt1QVEb023v237fy5yH9DFV8bgeZgjp
 5V82p5IYAAliJ2w72MA0LbdUa46AZLamQte+ZCRf8/vX3vagVpzNVFwg2NM1irjib8Nk0Hm
 tL8gxiJ+el+bFPWhdCL94pF6Yz5j9jLxmKDzP6lCniLMUn0RDABueYKhS4FNQox/5QfndgH
 HsSIi29QOAmEzYR/oAchw==
UI-OutboundReport: notjunk:1;M01:P0:koFhuhJWNKM=;6rIcL5aXgjcrel+c6iGV5/lMvMU
 aXeTkfl0x+8Z/BmFzaUrPFo+kXif9+AcDkFFYnGjBhBJ417iJxRjDu0FkwyLwLVXHTM8fBkoI
 aX+tYG5HW1WVcs+7EGn8ZqhzxagRApL9FjQOxtfiko63aktGPWVB2D9jBjn/XpjMFhXA25Zqf
 r+FdewbKvPyXIHA3765BilJLf2DjnSO0mHDcpqCfAIV6gfAnuwhgk0/DqxhPRy5AysYv4FOrC
 ZIJ9MXILEpTgn3A8DV2Up19tzyc1oJKrD7XFEWoPit2Pgj1I8EZR+sPvUmEv2RylV8xgoTwb5
 uXUazEhh5YsUmcl0VnPynIUofLfl3XUr8kdbsczie7RhmeS+sWng7muJBC0NMi44hj4EBJaYl
 c2XmHpXR+u9CBEiU06aInvjxhRG8w76bIADXaev/QpQqKDByezgX8FVKG/QMl0wJqj5fZGAAz
 kEy3d0QQ488ku9H7mKtCIzZtEFLIUGD+r4nIdCrGt1n8LYKj7rQ3YzQHwlkf7hw9EU6GHWrk8
 nQVcub1MXOGQ1yDShBsVEGodmj6qdkU8WDX0yJW9rWWlU5VbEzEeKPP7knXJrg/2GOpKVPu8s
 ea2YGgqZdLteCvP4arbhA9jONxAV30em9LwQMWWbHFbxmfnFe+TUnC83OSb2btx5+bUE+z+w1
 fOgH+2qG0rpdp+ivPWn+cszWgEnlakcAtKO97p8bH3f2ONYxdNNlGJ0PAy/YBWAqsZrB1OYDW
 NlJSvn4M9G4KwZfbUzdesQBDioFX2z/IS79Xv317ymHmUCcVLssxoYW7RJbNKIq8Eik5/NiPy
 xJm9n+KkcOEuIjYMMTNXc7ye6Mmz7XaO76YpYnbzdXFDxKR1HC7/ow9Qj+gsA4hPocOu4K2Bj
 H68YDNcauEWF7gRmV8bMtPfZ4Jn8WVF0UFE/RVJYd0aU0F9m672RAQrf6BhEq0byyvvnFwT1R
 cvhTQALVhPWQd6YLEaVkXDaOF74=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.10.22 um 21:41 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> That said, I am not too sad to have both. I would not have bothered to
>> do the work to remove the _v() versions with flags. But since Ren=C3=A9
>> already did so...
>
> It makes two of us ;-)

I wrote that patch out of curiosity and was pleased by the total line
count reduction, getting rid of the on-stack array construction sites
with their magic numbers, not having to manage strvecs explicitly
anymore and the callers staying readable.

One weak spot is the new helper builtin/gc.c::run_git_or_die() that I
added because it was easier than replacing all those strvecs that are
prepared before deciding whether their commands are even needed.

Stripping down the central API to a single shared object (a struct and
functions that get it passed) simplifies it for programmers.  It takes
the idea of d3b2159712 (run-command API: remove "argv" member, always
use "args", 2021-11-25) and c7c4bdeccf (run-command API: remove "env"
member, always use "env_array", 2021-11-25) to its logical conclusion
of going fully dynamic and using standard strvec functions everywhere.
Local shortcuts like builtin/gc.c::run_git_or_die() may still be
defensible.

But still: Is all of that code churn worth it?  Not sure.

Ren=C3=A9

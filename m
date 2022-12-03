Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F0C4332F
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 08:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLCInb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLCIna (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 03:43:30 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D8186E3
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670056999; bh=r+6umoMXaTRm9LH8HZDrhAqRQAbtSWot6kqz6LzXA0Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=wl5nRQbQbF1o00ZPw85yDvSWatZs9RUaKEgbqWXLsLbPMJqjA7GFLYfSXB/5viEd6
         r18xXTUljWBbu9fhZIQ1jsi3CbAB508zHA0JbkicImQ009PfKVdG3Te9/6WijgAek3
         E/gExNMon8Fn0WJRgyQK2+U3vNvdkRKmNdk9HDE1gya1Vrf1bMmRVDWJBtJvQ2fgjW
         eMl1LxgDjBSvyRxPhl8KxrtzsHpi0IDpz6y4GnnRXD3+LIKsFWPPt5HOrf71483OdB
         gHMuU0seqb36EVwluTVZTXxjvv6oR/OfcJ+rjM6UfMPgHK6yZnjXbztLvgz4/HzQ2r
         fmp4LD07WcHKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4bUq-1p1w4v3Oa6-00246a; Sat, 03
 Dec 2022 09:43:19 +0100
Message-ID: <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de>
Date:   Sat, 3 Dec 2022 09:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
 <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ERWpryMmKIVbI5AoHu0m9AMeQjBZ0yfkBZgcVJ5kn9Jw3zYeqnv
 siYM4/jVMX7++8z+UEIDfPuq5D/8c8oinvC+QVu/29i+Mmf3vyDRQO+cdCuHnK1AAdS9i6e
 Z/cdKW/jXUs/Ogan4Q9yAzv2HACqbJQJbm4lfgxOalpI2aeMzj0D4w/JdhQ10BD77tHR2Zk
 VFgW6EItu3btZ6FxB0JPw==
UI-OutboundReport: notjunk:1;M01:P0:ypzzy6ua870=;osyqVKNLNVeWq0jS6Klcz8kszjT
 YMdygbp7StQUnC2fw5H1u1xfWfUhLiu0ILk0a35mWb0BOLDiIjrg5Tx6DmbLnZKP5T4+tIv3G
 eCX0ZseCgtf5+RflZvukUXUsM8ZG/YWuCjPHFe+y85azhkeGXkaq7U0O0vXUt4xgmMU/ltzFW
 m7vO8gEMzZiuv12p8GO8x4aTP4Zp9HWq9B2a86x3NdinHcnr3ifgULtoKd5j/SowHU1TbA4dJ
 2KXfDAeTOXa4gjgJqb+eSvIYglykxqyEErOn7MXGywZVcLTH2K11xwHzDlwqnBkpLZAxhD0O/
 gKbQkezLPsQA1kCdwDSDuANrnx8KLM4P8PVHxgY4XqtWVsfNOFxlgA91QSRYDI9D/yi52zcx/
 8zfrEiOTNOKB42UKatTaKDhiaCj2+UsyEWx66NGu2XzgKTMoRLKKz4R8Pjnfxu18mCV2T3jiu
 q9qNm+Z4Dkgu3MT2JfOCOi6vN+lN6LZanQeknPF45M1b6o7g3SwvTtEVAwbfL9bNS2Wxp1VUm
 ZzV3rwDTvlBfAZCCmoqSMc4gxFQQk87IbckxF1hPE4ax5PRgXoswiV8mdV+LTckbwY6cXYXJa
 m3HcIDwBO46xsZLkMKUeW5sn9dgbck5kV5jrJpOuD//lyDfWWP1Gd8qgpDWa2BwiMdBeePhh7
 LYyI4CB1DoX6rGOwXT0+XM74IWG3XMupn7lWctn6vYXzNHPVb7xT2N+Rh8+Y7J6mR9oBQ991C
 lNCCb5Lf6e58ldw/JszpL6SMdvCARMeYm67Dclbc6LNW2IjD65AG3XuBWY8Fr1sisAdL8d3j7
 LvAbHWcNP/FmGHPPgFvASxfp/u0E+/3TMN5Qd1Rfa8khs6+ffbjhvBwg755BEnalyqMwxdOwc
 Wxi3IO7qnf9tNDjt/vXB7PsXEyzQqQoT53VZQtkEn6m7f7O2bkjK0eWocP9ulX+tOXfCAF49+
 1VwGPnObaEM35DROr1SkuBqxzWI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.22 um 06:09 schrieb Eric Sunshine:
> On Fri, Dec 2, 2022 at 11:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Use tee(1) to replace two calls of cat(1) for writing files with
>> different line endings.  That's shorter and spawns less processes.
>> [...]
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>> @@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=3D""
>>  create_crlf_ref () {
>> -       cat >.crlf-orig-$branch.txt &&
>> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.t=
xt &&
>> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.t=
xt &&
>
> This feels slightly magical and more difficult to reason about than
> using simple redirection to eliminate the second `cat`. Wouldn't this
> work just as well?
>
>     cat >.crlf-orig-$branch.txt &&
>     append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&

It would work, of course, but this is the exact use case for tee(1).  No
repetition, no extra redirection symbols, just an nicely fitting piece
of pipework.  Don't fear the tee! ;-)

(I'm delighted to learn from https://en.wikipedia.org/wiki/Tee_(command)
that PowerShell has a tee command as well.)

> (Plus, this avoids introducing `tee` into the test suite, more or
> less. The few existing instances are all from the same test author and
> don't seem particularly legitimate -- they appear to be aids the
> author used while developing the test to be able to watch its output
> as it ran.)

I agree that the tee calls in t1001 and t5523 are unnecessary.

Ren=C3=A9

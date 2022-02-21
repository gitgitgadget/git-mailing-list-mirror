Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED5C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiBUIQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242471AbiBUIQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:16:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566313CC3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:16:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u18so27616208edt.6
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JNyQXEriKTl1Nhfzsd9GSXFm0EGUG6Q4l25WZZrCbAU=;
        b=QqtAQML2MqCgJP3oGsC0R445nfU1n+zQuwRjrjhAx28poQ9D0LRt7v9Cjxms2n94pz
         GLQgB+iHLwGGXJ7Rc23E5nEgaXunCPA3IzSUC1rNWid5g2evy1KKBhAvP8FxJJs4h7oA
         u++knr2sZa4CE2hET4lOPQncBlAF36pm634R4Exyj62uJOjniQrS425IOJRYfo0RYOoU
         6P1OUHy7GiMMF5RZEt8P+bJHTEmSBx61fuPZ9GfqA5XpkWC7470tUcySkD7O2CSzvsmi
         j0+F4QuinJtztOT01/4fpvDeDeWI8tYsQp004EXWrqse6xLPF2uIxNVIdITwAT1eG9OC
         Rjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JNyQXEriKTl1Nhfzsd9GSXFm0EGUG6Q4l25WZZrCbAU=;
        b=CfjZLTC93zguja4ZuFqzRaAn8cuIXpklQyaGgD/X4hF2a6tX8j2koUHGWa2xhccWPY
         QPzbUChfPaI7b1xNxWc9JaGmjRsiOgA3z+ORRi9Gjvn9sDeQ9HelukcgNKAGmX4kl8tF
         l7XhzXN06LV5PhRxTcuBOMU55CWGcve6R3n88J0KkBLPGjAnD8917K2Qlaw6Cx7Y3q0S
         qheKYLdQ1RqWv4IOSWs+Kn88WEuFWS8ONwU956NlsdYBEW4uHyEkruHoqaeIJ0/8DeAR
         gZzCPTnp6U3ZZGE7CUX9D1RD2aeFMBgZ4p65Y19h++A0NS3aZTxsSkIh+hZsHJFMiINd
         7jww==
X-Gm-Message-State: AOAM533Cl/SRUrwe4E0BUmUK5uBqJimnhbbLO6S70wPNyIw/UaNpski4
        19qMB1A2OlIpOiFLD7WuRCc=
X-Google-Smtp-Source: ABdhPJwDN+8+zo5UePP6z/ksUYTvaA2tYGdY+N5VkSMOL2ylKNfgU3NvyXTKoK50dVWfRciuubuDDQ==
X-Received: by 2002:a50:f144:0:b0:40f:29ce:c68e with SMTP id z4-20020a50f144000000b0040f29cec68emr20045443edl.307.1645431378407;
        Mon, 21 Feb 2022 00:16:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h19sm8476828edt.6.2022.02.21.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:16:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nM3rl-005NmH-CZ;
        Mon, 21 Feb 2022 09:16:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Mon, 21 Feb 2022 09:09:54 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <xmqqtucuw93i.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202201623500.26495@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202201623500.26495@tvgsbejvaqbjf.bet>
Message-ID: <220221.867d9od48e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Sat, 19 Feb 2022, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > I notice that you did not take this into `seen` yet. I find that a little
>> > sad because it would potentially have helped others to figure out the
>> > failure in the latest `seen`:
>> > https://github.com/git/git/runs/5255378056?check_suite_focus=true#step:5:162
>> >
>> > Essentially, a recent patch introduces hard-coded SHA-1 hashes in t3007.3.
>>
>> I saw the thread, I saw a few patches were commented on, and a few
>> were left unanswered, but one was replied by the original submitter
>> with a "Good catch!", making me expect the topic to be discussed or
>> rerolled to become ready relatively soon.
>
> Yes, I have local changes, but I had really hoped that this patch series
> would get a chance to prove its point by example, i.e. by offering the
> improved output for the failures in `seen`. I hoped that because I think
> that those improvements speak for themselves when you see them.

I think it's a good idea to get wider expose in "seen", "next" etc. for
topics where the bottleneck is lack of feedback due to lack of wider
exposure.

But in this case I've pointed out both direction & UX issues to you that
you haven't addressed. Both what I sent a reminder of yesterday in [1],
and more relevant to what you're discussing here a reply [2] where I
looked & tested your new output v.s. the old, and found that on test
failures it:

 * Replaced summary output with a much more verbose version.

 * Turned the GitHub UI from usable (but sometimes hard to find the needle in
   the haystack) to *extremely slow*. Seemingly because the browser was asked to
   make sense of~30k lines of output, with some of it hidden dynamically by JavaScript.

1. https://lore.kernel.org/git/220220.86bkz1d7hm.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.com/

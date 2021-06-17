Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD68C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB254613D5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFQVC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:02:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E506C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:00:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id he7so12181141ejc.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2BKDM8EwBtAAQjfv9qOMGpFG7IGihwCLtrj+HgD18pI=;
        b=BEl4B/UusH931Amp2RRAx1X7R17p1P22L/0akzxqgUJlHFuL0JNdJNl0McUKr7libK
         EbJlIoYWr1KRYS4iJPCkHFl8r6Wgoivb3xemL355uyGM1ko1BqmBFB2gnFw0qBZv656Y
         TWuY8BHbY0Hn7kNQ0gJImtV7BvwoRC/iv8Ku7JL0Y+009QraQoZo8XwMg0tIkQnNH8az
         bRMEimndNLCuRG/1azwXTl9PnVaBFXFGbnbm1HK7Tuo7OZqA6HyeMryBDnma056IeioQ
         D3BUbSOUtvwCYmVTwK1DQL4s8FpsOsnCbfwA9dR966MkDSf54gPROE5FMfruwYsxoN00
         znsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2BKDM8EwBtAAQjfv9qOMGpFG7IGihwCLtrj+HgD18pI=;
        b=Mby5nAb8gWxucQiMtWjhhR8x1CYnx+3rH/hx787WZE0MRbZzzf4oi0B4UsIYYwSt5k
         aYbGtcTtL765itJP0U52TaxZHtpSL/vM4H6Xvh1mSm8dBCHbnLCLYv8QOG9rcY8WGppK
         +car3z7yU5NUAyf0H+u7U/4rstejekFUY9KlXpVGnKwipLPDtODqDgIRgRYvIN10Y3hC
         BoCZ+rWYTvdKJ2oKkXdhiD2xETwfNj6y/Wf0e9H2yiDeokA3Jj8hm4Z0O+DuoXz5pYGI
         pjioQMika0fXlEw3S7NYyeGY0xyutqCaJ2Ec4lDz7mUUEL7UC0r7QtIHGxp2hLP3Ln5e
         tvsA==
X-Gm-Message-State: AOAM530wyxQ7sKmyD8ckOxUbegKVO7MNFeeANJJppgIN6i5/VnUxdzaI
        9wyh0se4MHR67lAyzQYq+vE=
X-Google-Smtp-Source: ABdhPJxpevu+A0SgEpeg6V/Wan7EVLmgocgwJOjU1iXTGUrZxML392QygSIklZHvt60V+i9LL99CrQ==
X-Received: by 2002:a17:907:9854:: with SMTP id jj20mr4307505ejc.365.1623963645538;
        Thu, 17 Jun 2021 14:00:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n10sm2891354edw.70.2021.06.17.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:00:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Makefile: stop hardcoding {command,config}-list.h
Date:   Thu, 17 Jun 2021 22:58:59 +0200
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
 <60cbad11b13f5_9bf20896@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60cbad11b13f5_9bf20896@natae.notmuch>
Message-ID: <87zgvo435v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change various places that hardcode the names of these two files to
>> refer to either $(GENERATED_H), or to a new generated-hdrs
>> target.
>
> Avoiding hard-coded things is generally a good idea, and I can smell
> there's an advantage nearby, but it's not stated.
>
> Can you spell out what you are trying to achieve?

It's hinted at in the CL, but this is series 1/3 of a re-roll of the
base topic for config-based hooks, real use of this is made in step 2/3,
3/3 has a better overview:
http://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avarab@g=
mail.com

>> Hardcoding command-list.h there seems to have been a case of
>> copy/paste programming in dce7d29551 (msvc: support building Git using
>> MS Visual C++, 2019-06-25).
>
> Actually that's not the commit, it's this one:
>
> 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
> Studio solution, 2019-07-29)

Thanks, I had both in my buffers somewhere and copied over the wrong
one. Will correct pending further feedback...

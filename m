Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00BDEB8FAF
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbjIFGkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjIFGkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 02:40:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868DCF4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 23:40:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so5555315e87.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693982414; x=1694587214; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrtQPjzUTZ3CZTHsS+wY5/VRtNLQ1gM+Ucoo4Hjb7Y0=;
        b=nFsGsNaBDFnC2kWbR4fLvMDP4pESuFSG7CNScqdLmRr//Uexy50FyCVRR0SS/2Ji8/
         /cgwMEACOn+Sx6+86Mt7mjwknsJHMeSwKygD4qetnMe1h7o/WrEd1byd9advUNXe90m9
         9BhiKB7MgGe4K5uBPch++LRRwBpnppwbCOMlbzPD8a8PR/xH5trCRvPalX01K2xvSNj4
         FiBV2B9QGnneY1WMLiJMaxDtbqIrJbwQLwFgwrHPp1wFshiNP+k00m1bEHvIf3d3UEKQ
         CHveOtAPT0HpVIUhNVzgyWexwDsUqzA/2s59qTE1bmRRu3p2rirQAtDwCklIqMKuWbT/
         dmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982414; x=1694587214;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrtQPjzUTZ3CZTHsS+wY5/VRtNLQ1gM+Ucoo4Hjb7Y0=;
        b=GwPx1QBc3eM+X4K2Dk0Lbk6umzDKezuLYWaehtknAB1Um6+kN+1AVFuoUtUiQfTWrR
         csE0byPumaXUczEXqWNaVpc5AXPSfSMebyJpwqBFz30QwgBWx8jNBKXfN9SXAJslA1Ry
         Hj91o4+PpKfiHrscV0H9YbG4M+xq4dmG9f/K8w6nnWeHfiw1UqPk+KT1rSfYYeMTQrbW
         55gWr57BSycFP3VkwKHrFrHWf3wiIv6gHC/Qxi9wv2x9ckt1M8vu60h9fUGJ7Pfmo7qM
         rbKPyhEuwO6U24WaQw3w71ILWviSh+ndMBDU6R0TFyDnyvRg9NLIQTRD+/1h/++G5QGY
         X/dQ==
X-Gm-Message-State: AOJu0Yxf0a6NmfpsLwcVb9Oga7z2KIvIalploB2KvGk4Osxg+4ZrYVxB
        puuLeoLU0dY5L1oUfH9NphQ=
X-Google-Smtp-Source: AGHT+IEJT5CtGi3FVp/qGepcWCDKAz6hyagzea5jNHmnvwe0eRXJzGLxQsyb3P5i8WJw1YfuPDsQWA==
X-Received: by 2002:a2e:8804:0:b0:2bc:bc7e:e2df with SMTP id x4-20020a2e8804000000b002bcbc7ee2dfmr1461375ljh.33.1693982413973;
        Tue, 05 Sep 2023 23:40:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e878f000000b002b6eb5db863sm3299972lji.43.2023.09.05.23.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 23:40:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/1] doc/diff-options: fix link to generating patch section
References: <87zg20qzhg.fsf@osv.gnss.ru> <xmqq34zsqlr3.fsf@gitster.g>
Date:   Wed, 06 Sep 2023 09:40:12 +0300
In-Reply-To: <xmqq34zsqlr3.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        05 Sep 2023 15:49:04 -0700")
Message-ID: <87zg1zpzxv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> First, there is no need for conditional referencing, as all the files
>> that include "diff-options.txt" eventually include
>> "diff-generate-patch.txt" as well.
>
> Except for git-format-patch.txt which includes the former but not
> the latter.  But this is inside ifndef::git-format-patch[], so the
> above description being a bit imprecise does not cause any actual
> damage.

Ah, nice catch!

>
>     Documentation for all commands that want to describe the `-p`
>     option by including the "diff-options.txt" file also include the
>     "diff-generate-patch.txt" file, so an internal link would work
>     for all of them.

Sounds fine. Would you re-phrase it yourself, or should I rather
re-roll?


Thanks,
-- Sergey Organov

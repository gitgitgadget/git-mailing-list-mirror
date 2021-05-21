Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA293C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE38E61353
	for <git@archiver.kernel.org>; Fri, 21 May 2021 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhEURpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhEURpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 13:45:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881DC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 10:43:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y76so11110690oia.6
        for <git@vger.kernel.org>; Fri, 21 May 2021 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6XXzXpbaTwbK67CUrI4gMK59fMhyUJwfYYhQQBB8dJs=;
        b=fr+rHDTgfEs85kRWxtMior/lc1bwankb8Bqf065ilHO+B39veZ4DtQS15wLhAcw1/L
         HlnJi2eh81VTnsvmB4jEdT3naUU821w4DK9X+7PaYQgF6cPbbW1iMwLGd+43BVGOjIjV
         HgC/mflCCcXCx741CdflTe24BlKB2UWFTuKQPuKogFkt5oALXvNOT8vUfASU29YHyKrn
         QpA+MqwL7p0V+YTcdSQSuSB6sQXN7MbxLV+h8CrQ860cmdgZnSB38Y9p7a1HFP7U3qLQ
         UKvN40cARWLyBji2X2jAeyiEfR3jYjOLW+k8btgEsrPGlQ8wlKsSLJifwneEnTYDHBrN
         bvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6XXzXpbaTwbK67CUrI4gMK59fMhyUJwfYYhQQBB8dJs=;
        b=hs9trZG+oXs5Ms10hUTwex3qabgFOlyrLSBu/79CbcqZHdjVZRYllH+SsuXSPHNPM7
         af/Gia2Q7BglwSn1MW7SxMFJp3hfpGKlw1ffVBOudSFXpPnR8UjaP0yeS0YvFYllyeMc
         hbD/uVYvn51cq6n4iKRTe0nb8t8HQxKen/u5lQUgvI/dMw1mJAgcLJ9vYeAwGsmq/VjY
         2qXJFT5NIrEG4f6DX+MCPlN8AFlfnh0wPM2o8NBoloQscGyGbPDhmGXQm1JiDFXGb6vq
         jDiNvsVBEtkIizLjV/IqW0Nzkiu79S6fZBe8ervCtezBjYhMiyzD3tIjTdrBlCRJ8k5M
         de7g==
X-Gm-Message-State: AOAM530jpV2UNycE0pRtE5Dmv9mzTdjJnUPI3xU7XBNjeKvc66fc/PwG
        CA9ZOAXRW3/R/wwotBhkxpc=
X-Google-Smtp-Source: ABdhPJzgj7txEFNykpjtdOihZlWgA0Y0BcDl51mGMT5qJ9jd3JzShc/bMzSY53qQSVMmYU+VTr+MWg==
X-Received: by 2002:a54:4011:: with SMTP id x17mr2920266oie.112.1621619020506;
        Fri, 21 May 2021 10:43:40 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v19sm1424750otq.35.2021.05.21.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:43:39 -0700 (PDT)
Date:   Fri, 21 May 2021 12:43:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Message-ID: <60a7f14a4f0ee_5503920867@natae.notmuch>
In-Reply-To: <6dc0fcee-3415-e6f9-df30-c97de4385f56@gmail.com>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <60a66b11d6ffd_2448320885@natae.notmuch>
 <b58cbdcc-abd3-ec82-7d8d-771f47c484ff@gmail.com>
 <60a6877fa8389_2747c20842@natae.notmuch>
 <6dc0fcee-3415-e6f9-df30-c97de4385f56@gmail.com>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 20/05/2021 16:59, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> On 20/05/2021 14:58, Felipe Contreras wrote:

> >>> That is true. We could add a check for that:
> >>>
> >>>     if (getenv("LESS_TERMCAP_md"))
> >>>             return;
> >>>
> >>> However, it may not be necessary since many of the tips online set these
> >>> variables inside a function.
> >>
> >> The only person who has tested this patch has reported a problem with
> >> it, it seems unlikely that no other users will have similar issues.
> > 
> > The check above will fix your problem, will it not?
> 
> Yes it will if it is implemented which was not clear as your message 
> suggested it may not be necessary.

It was a maybe.

> I think it would be safer to check LESS_TERMCAP_{md,us,so} and not set
> LESS if any of them are set as it is possible a user may only override
> some of them.

Sure, if we could set 6 variables before, we can check for 3 afterwards.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E50C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA83361375
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFBHPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFBHPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 03:15:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E2CC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 00:13:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u9so559630plr.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+xO62QbArKQc6s9LnYjmAaPnqsHtwKZJQvpEwA6r5QE=;
        b=TPxMy4nygoLcUq/f/nHE/sebJY6fob9bD+nj9AEyNOm8u+ZRWfQgRitUqeqFsGTSkb
         BPstiJ2gx9t5RKf1DA3Gh0TydoKm6aB0LDqKTHuCj30fcJ8enrmQbWcbLEm928YPGhwP
         jTdKH6/j7PtXBvtwudqc6Wg4ajqCIgsCXbe1kSvPymK2hxfiA2RnsrV+PAGWC/B3eIG7
         A/SbMWNmKYlAcQT15595zwR3emUOX8jK0h4r1ubd84YJMAlQWhF1YjgXZ1368xRwNgnq
         3ckxI+QWUWv6BDWC2IllHKFn/xijn4Ty6PpHCWXqjRGv5qvXWKWLgWUTMEb5liJtYuR4
         DnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+xO62QbArKQc6s9LnYjmAaPnqsHtwKZJQvpEwA6r5QE=;
        b=ok+HO0K33tC6SBuYOJm4pAsVmxhSRXe34In2HUe8pPgbYvPD7mTP89xfcPockH5nmn
         8AwxeRN2rd0mI7OAPF4DClbnFfA13KyqZVX4fATf++gwRySQ1NSc6KLrJDkVpsuz2rY+
         0nCsRajUs/443Dtww7/4WD0rd/rKm6Y9DuKoFP/X6pXuDyZucpepyaR0TvknMCCcxC9W
         Kfu+BBefpMPdzfg2vaTyTDPJaDEwRn2ZquA9M6HOVSMhh1DcGLkdMD2XQMXFO4JMVvG+
         6kzCf/n9a9MItPjYV8JLMUq8Wlo0PmOjgkQ3c9F7eOctFxBlWRHugIlbH2jH3qEDZOoP
         gSpg==
X-Gm-Message-State: AOAM530Urg5sOui2nBKdaR1PmeIq80NWDuu1dV7ua8+buvl/x5BfqGjn
        jrlyiaYg8dKicrrynaXH4Rk=
X-Google-Smtp-Source: ABdhPJzDuB+pGiXs1/eSR9oSUu6k9j03e68cdE13I2rESATM5CZHPFMs7v0Ly6tVvgudks+K1xeikg==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr20280297pji.29.1622618012951;
        Wed, 02 Jun 2021 00:13:32 -0700 (PDT)
Received: from generichostname ([172.92.1.94])
        by smtp.gmail.com with ESMTPSA id m5sm16334861pgl.75.2021.06.02.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 00:13:32 -0700 (PDT)
Date:   Wed, 2 Jun 2021 00:13:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] contrib/completion: fix zsh completion regression
 from 59d85a2a05
Message-ID: <YLcvmrwT/ZuMts2C@generichostname>
References: <20210601205229.46974-1-davvid@gmail.com>
 <60b6c57c3cac1_4044208f@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b6c57c3cac1_4044208f@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 06:40:44PM -0500, Felipe Contreras wrote:
> I have not tested this particular version, but I have tested similar
> changes, and this should work:
> 
> Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

FWIW, since I was the one who introduced the bug,

Acked-by: Denton Liu <liu.denton@gmail.com>

Thanks for your help, David and Felipe.

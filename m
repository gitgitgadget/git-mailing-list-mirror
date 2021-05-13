Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F9C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3D361285
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEMHFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEMHFX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:05:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7747C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:04:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z3so23314348oib.5
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qlypTpjJE0Uau4Jfutab4Vr4xvWcN9PvP7Fw0oKZC7c=;
        b=RB4h4rV6hPRhX7own2H1tKc2rwZWX2WdpDyfoZUoe1xefZBwZxwZtMPq1foUHwtmR5
         dhyV4LdMW6yISklypeigUTUpX/jeVLd6UvFYvuuiBoe3TWEpswLNYWeoka5Lq3/T4jk+
         fzGtblNYWEADre5EpVzOGH3aN93vTUuTpmmwWUqU/7hxdNz6Y745LfFxnwkin4K6Usbj
         L0qRumx3qrK36hasE4oyqoDSwKuk2dz4ETjDNB0hVu3bU2zBiI6pvAtCf5L+vKESDaPJ
         eHygQ2B9G72UzkvDS50Q5CJqHC7RdTH9oPsVDPHKMm/8bbVFuzO6/GSqehghwdtNBgjP
         BeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qlypTpjJE0Uau4Jfutab4Vr4xvWcN9PvP7Fw0oKZC7c=;
        b=VwLnFnAiyR7gWAHF0IVYjXho5/qQbhU6/pPxK9WlIeNrf3WHijh23w1mAg7m05/dSk
         GhV5I2f5Ed1cMluEFCfjXlzJmpvHbzU6h0LVndz5cXC8YM8SPO8IDDDq/ZVtzLNGpHkd
         er04C/e4+ZSPdouGLDGSh2ggbrXlcQ2UocJy9vFvbj8yQSS9tt5b03E0Mgx/OZ4ieYrS
         wPQj6JmQ+S9W9ege1eqrCvfzAi5okZCoIhHDBOCYSR3xtVriK9JsnZW88NS0OUAH1MXV
         A25Ku3/szhuFEoz13UUs9CjcdePvkyQg5q9gopI3YqBtNs+yrb3MOj8ClBaovOuXm7hn
         CRhA==
X-Gm-Message-State: AOAM533nGk9Jzquh3xXFiSSsczDd2SHHs3XIDhizC+r70H8wEEzTd/dt
        zwF9UvqdaYLy0D/q3T91Nfo=
X-Google-Smtp-Source: ABdhPJy1DOgyepwUgyNPHELHrmI4qtpQDx8FKvBk5wGq5RBgSeBLyi2bb0TsWtGMuN5NDXC13MxZMQ==
X-Received: by 2002:aca:4c58:: with SMTP id z85mr29584512oia.46.1620889453214;
        Thu, 13 May 2021 00:04:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w20sm390830otk.33.2021.05.13.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:04:12 -0700 (PDT)
Date:   Thu, 13 May 2021 02:04:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <609ccf688a4e7_329320879@natae.notmuch>
In-Reply-To: <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
 <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> It is a bit unfortunate to have to go through these contortions, but
> this is definitely the best we can do for now. I think in the long run
> it would be nice to have a "--stdin" mode for git-config, where we could
> do something like:
> 
>   git config --stdin <<\EOF
>   key=foo.bar
>   type=bool
>   default=false
> 
>   key=another.key
>   type=color
>   default=red
>   EOF

Why do we even have to specify the type? Shouldn't there be a registry
of configurations (a schema), so that all users don't have to do this?

-- 
Felipe Contreras

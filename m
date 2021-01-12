Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967AC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BC322EBE
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405185AbhALQgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbhALQgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:36:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9FC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:35:38 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f26so2395118qka.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZiuGN9B+8lkjWewpBcGVZpniN+kVNKN24osYb66eTZI=;
        b=Aeg9MqCQTpxexovxTRfMzj1W1GG+4EuQxlq7X7jnMkUI7FuG2HBNerkRILlEzvjRfm
         SFI6t3nxdAoYrsHSQp58q+etOFxoz9qooCC6VAUoNvYNvuNaidNPmL6Crr8efVDS83SU
         yqbgbXUtRFqgObtrc4DaetrapuU5kFclgXnu04Ff4vwKoaHtX2rNRzDMaeoH+JLxglQf
         jhGlb0sruit/J1L4MSSRO9m3b0iOllYYoevTCgfiwAoMvTCmeeoPOBU5xUZUCRAqbJzB
         m17EBnjRjKxO2BA1402NvMQRom1ijZ/DMh4NvEajGmKfkIFAWbgXXIJqm640WQRIwvpw
         czhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiuGN9B+8lkjWewpBcGVZpniN+kVNKN24osYb66eTZI=;
        b=Smaf4bdPjybNkzAx5ljytGr2qYvwyX0EKNthCX0Sox868Sov5NNfL+b68y0ngYDpH/
         d4Jlm7y8AEap3/SAE0VN/ZTrBCw9zOH0PxzcBFgYZOY1Ji8BTsKGoBpbrAnm9r1vJo7+
         xyrrdzMZxjYEI4uV8YWn7+6q47yoPIfkpJtIR7ufTD9YVM+zZYmjsdS4+O0HHeDEYWE/
         asEJ5orBfztq2bY6b4WGSd6waMPVZ3oiONVOBgvhKw8XIrfkr0GsFKZ1RiAZrACworZe
         R/FKhF6ZwmHoX2NHTX8OzOmLB9fnMZbJuDyRi/VHMnC85J65GLK4emsHJVmlh87qXr68
         YWBA==
X-Gm-Message-State: AOAM533sQ83ApfRm+9mh97fmT6HLpmf3usprx3SVm6XwVbHZ8sC6yzgN
        buPDTVy8ceLiumDbSuXLf06ANQ==
X-Google-Smtp-Source: ABdhPJwiIn2+XzLbD+UhxsAB5P4YwPMAruxwLWA9GcXPcXtDK+KReh6aL0enlhTteD8pYgPwSL3fcw==
X-Received: by 2002:a37:79c1:: with SMTP id u184mr88352qkc.313.1610469337343;
        Tue, 12 Jan 2021 08:35:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id j56sm1360712qtc.58.2021.01.12.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:35:36 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:35:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 07/20] show_objects_for_type(): convert to new revindex
 API
Message-ID: <X/3P1eM+VDyNWRSY@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <bc67bb462ae0c87b34e46568d54b170a8aec870b.1610129796.git.me@ttaylorr.com>
 <X/1klwe44go+A+Xi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1klwe44go+A+Xi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:57:59AM -0500, Jeff King wrote:
> A minor nit, but "n" isn't very descriptive. It's not in scope for very
> long, so that's not too bad, but there are two positions at work in this
> function: the pos/offset bit position, and the index position. Maybe
> "index_pos" would be better than "n" to keep the two clear?

Much clearer, thank you.

> -Peff

Thanks,
Taylor

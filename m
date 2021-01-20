Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FFBC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8D423356
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390694AbhATOfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbhATOes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:34:48 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FADC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:34:06 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id bd6so10946303qvb.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G45yHoajcie2LIastK4XguJ+tYBGghQMCuY0+KVa5NU=;
        b=A6UhN1oixY4iBDkb2XdkJ/7CaUjg5tW5+wg4bRGsRsM0EcFnOacnBud78fbJMhcche
         l+NizkAJs6StYUgyfJpbPl5EEeTYbXew+7v+5D5JgRkdqcMAkNj5CftlSMwgXy80xEfo
         plQXGJn52xRyqZeXD3UqS61WaPW1rqw+1fxbB13zPQjg/1NOWpzidZpKD3/HlTUkcGLU
         eRtxT7+hyU1PRYLoZ7WIfxtgJp7XEH3GmXXfD+ghd8IWilGdhJ3bACrx3bWG4mxMfGZg
         7gpsuojt8snxX1slhVF3hlO8PVO6LiZpmstAQsxb8KTC7yBjl+1hkFoyXvKZxUThXrS3
         GEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G45yHoajcie2LIastK4XguJ+tYBGghQMCuY0+KVa5NU=;
        b=UPP/qzCvjHimaIuH6jGi5p981UxOCI6Phh9XuTZXU+pXgwYtxK9gVjEw2b/yr5uya+
         J+ETFTg6koZvjJQeW4/ABWwxz/yvfGTBPFI9LYpTZfoz9d2uALGrbvdfZoQb6VxfsLOv
         nfotfaItYA+xog9QcWNMoUdBzZJHQBKeqsxE2CGP9WVc5tU+tbyUg1awnYbVlzyXc+Ib
         wsNa/bkM8h5eYsJF3qFFmyJxM5MauWTswgfvfIG5o8l9zizaakzeUBaCnJTEcJRo9rhd
         XtVv7Ql8t0kXHi9B7nJtqIsRG1QUhYITQWJ7o6b5/xHnhdp8T9nVMdwHie2e6EkhAUUP
         ssvA==
X-Gm-Message-State: AOAM531F7IArXO23F/pENQJkXd6cDvbbOJ/EjVGDAJJ062b6okLTV6Ob
        /4zVaDLgXYTkS6Q3Lv3+XMSkfw==
X-Google-Smtp-Source: ABdhPJywE2v0RzYJkXB9PZ5eFgQ2hXw+avG4VHabJ4g6auKG9c+9FrRYPKlAI/OFec8wsdMxEHFA5Q==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr9839600qvi.9.1611153244716;
        Wed, 20 Jan 2021 06:34:04 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id e185sm598110qkb.127.2021.01.20.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:34:04 -0800 (PST)
Date:   Wed, 20 Jan 2021 09:34:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 09/10] builtin/repack.c: extract loose object handling
Message-ID: <YAg/WU01bvfsMxgX@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
 <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 08:59:48AM -0500, Derrick Stolee wrote:
> On 1/19/2021 6:24 PM, Taylor Blau wrote:
> > 'git repack -g' will have to learn about unreachable loose objects that
>
> This reference to the '-g' option is one patch too early. Perhaps
> say
>
>   An upcoming patch will introduce geometric repacking. This will
>   require removing unreachable loose objects in a separate path
>   from the existing checks.
>
> or similar?

Mmm. I had imagined that this would be read either in the context of
this series, or by someone in the future long after 'git repack -g' had
been introduced.

I could see that it's confusing, though, and I do agree your wording
makes clearer that the option doesn't exist yet.

I'm happy to send a replacement or reroll if you feel strongly, but in
either case I'll wait for a little more review first.

Thanks,
Taylor

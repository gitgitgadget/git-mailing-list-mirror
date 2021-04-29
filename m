Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1953C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E9A613E1
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhD2Oz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhD2OzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 10:55:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A35C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:54:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a18so25541632qtj.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N74NfuCubevHWXvNJKHqoXm79KBWxPoFChbEnk3CZ3M=;
        b=axZsHDpUrQ32PoLd8VB6eYhU5QEXn8cdl24EUFdW0aJWbPLKhhM8oH9y8M5WPXmtX4
         32sZX7CDodSfaB6H9rhy+aMP9ICGo8HJyUgtH8LKsLe/nF82EDvVv4yCrP5mYUFs4PnP
         wwjeHaVqamdP3BPd4hHl8qMcUHAdx9wzKcf3bSrjTPjN0G+UxK9h2MX74qiGkFTJb928
         0d80DzqJ5JMIRb3iJnNJdBna/Bq8HeTmTtCppWKSS12sMaBgpx9UCtvbYXiM/ZpUW6Z6
         2f4oZ5MgTjHP1S0yysfJuh+F4OSaZlshlkaut5uJv23BNefbXuoigFsYs6P9mSNPoDkW
         6vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N74NfuCubevHWXvNJKHqoXm79KBWxPoFChbEnk3CZ3M=;
        b=lG9uZeR6xHvJxFmbzP/p/LkUzJ2Y7WWSIaM23qXgt5TqNiKRQHkv8YHEqnWH5Hn4YT
         ThB6pBDpmyR93cIile6T6gSm9I4k6xgFUdndOXWp6RzKTnGondMjqmIDtzJwNEWiQLcK
         XdrXNdBGNkwaIRVM0XhIOlTuakc89BI2Hq2oQpuGKnP0cEUVFXPuwHq2fnbJ/AoYtXyj
         c5TcJ+IAOZrtuajbR8wNS0tuB4JePT66lHELUaAIJLRmu7UfVH3iSaUrtMRrCsrN/Jdq
         dH/kIuEcnJUJhPqWM28wswlsqArlQPivT7zf4BB0RuaZ0jDrZj+OtavtqYXHhHvMChkl
         nrrA==
X-Gm-Message-State: AOAM531+gW21ozNQudpO26tN6F5GvtLXHmf7vdPM7cPLdECCMiWWFcLQ
        hCUhJnbPhq5+9eivvIaE50CVHQ==
X-Google-Smtp-Source: ABdhPJz0rLMA6L6b8EEKOR3+tk9pe5N8BODhXGmRyALdoQ33ciDuhsD+u8XjM/KCC2bCctrbZ315hA==
X-Received: by 2002:ac8:7381:: with SMTP id t1mr32509951qtp.3.1619708076045;
        Thu, 29 Apr 2021 07:54:36 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id v10sm73626qtf.39.2021.04.29.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:54:31 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     yguoaz@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: A possible divide by zero problem in read-cache.c
Date:   Thu, 29 Apr 2021 11:54:24 -0300
Message-Id: <20210429145424.515208-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <CAM7=BFooqCo3vn+yy6uM26szZDAcbx8M=sZS1znucJvHRbtxHg@mail.gmail.com>
References: <CAM7=BFooqCo3vn+yy6uM26szZDAcbx8M=sZS1znucJvHRbtxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 11:33 AM Yiyuan guo <yguoaz@gmail.com> wrote:
>
> Hello, git developers.
> I have found a possible divide by zero problem in read-cache.c. Here
> is the trace (with links to code location) for triggering the bug:
>
> Step 0: (In function do_read_index) [ link:
> https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2216
> ]
>       nr_threads = istate->cache_nr / THREAD_COST;
> If istate->cache_nr == 0, nr_threads will also obtain 0 value.
>
> Step 1: (calling another function load_cache_entries_threaded with
> nr_threads as an argument )  [ link:
> https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2247
> ]
>       src_offset += load_cache_entries_threaded(istate, mmap,
> mmap_size, nr_threads, ieot);

Hmm, this function call is guarded by an `if (ieot)` block:

	if (ieot) {
		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
		free(ieot);
	} else {
		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
	}


And `ieot` will only get a non-NULL value if this previous assignment was
executed:

	if (extension_offset && nr_threads > 1)
		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);

So it seems to me that we only call `load_cache_entries_threaded()` when
`nr_threads > 1`.

> Step 2:  (use nr_threads as divisor, leading to possible divide by
> zero in function load_cache_entries_threaded) [ link:
> https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2103
> ]
>       ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);

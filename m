Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482CC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D59F64DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBOVCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBOVCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:02:25 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3BC061786
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:45 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q8so3732225qvx.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=VkhaewwxHW70dWgR5AFLHGIxe1Xo5ZJsunF42B9+G19lW/wVmzeNxYzmq5WmE9jJwI
         xjYKvbA504TdulHjs91C5U2LFIJvDEl8vEoeL+qIBwgzsrAFBuXk5tU6bBk7LIjspgNl
         Nyh6jvbbx4twxX0mIACZQmF9opklidha482A+T5oqdZBHMzEbsNf782jGR5N3b5xuzPv
         9A4JK/a0ThEs5zT4Bm4puNwQSQd3L64l99+WNbWDEexnMG+xAdYE+FzicsiKQaF/7u7X
         ZX4HRdt86kTeyW/pNsTkrgGd8NvPs/iIyktBjHWVLNerBywFDA5c1LYTMleSsVNylmOr
         wIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=pvxKerD9MgTUaDVCyyLQ4niMQAsSE6frEyK435//4en0zhMYOr0SWHU89kIFMyNrPV
         Psa1Cld+cuIi5Z8RSezhd9TLouOy6mw5VYIRKBPt2LwTjVdg6FTsZsntQbVEZ0fh+OuK
         3bA7gtIYSbCCGkcV+k/uelXgxS+5tH0agySsnBXSS9qCm/S56FY1KsFhHqtvT8rArSU6
         0B+97fXmUV1A/5h6uHVbc9kq+gF1QdugWotl5qy0ifoDcaBucfzWVrhee8XEKhrlgWoA
         +VjxaABtOy1HJqrqUzc3zImwh+T0MRsWJq+5NXYMpYKzaAL3lBf/KMKMoaq20rUqf6Ik
         NrxQ==
X-Gm-Message-State: AOAM531nhCUlNn7GMOAjIfXJF23pzftPrwsgEZcw3Yf4tcPri29T5Bsf
        /Bi8ve8HdDI01Dxm7tTuPm3+v4NSPP1M6J4Z
X-Google-Smtp-Source: ABdhPJxyaMTnUW42DGWW1XMZu41vjz0iPP3SgwAGdD9BUfCWIvQC3wIwMkZLJ5ES7fhq8NxczOU2uA==
X-Received: by 2002:a0c:f1c2:: with SMTP id u2mr16790749qvl.34.1613422904477;
        Mon, 15 Feb 2021 13:01:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id j124sm12751544qkf.113.2021.02.15.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:01:44 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:01:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: [PATCH v2 2/4] builtin/multi-pack-index.c: don't handle 'progress'
 separately
Message-ID: <abcc7fb7312b349562fe6d13e2250496e107c9ed.1613422804.git.me@ttaylorr.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613422804.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there is a shared 'flags' member in the options structure,
there is no need to keep track of whether to force progress or not,
since ultimately the decision of whether or not to show a progress meter
is controlled by a bit in the flags member.

Manipulate that bit directly, and drop the now-unnecessary 'progress'
field while we're at it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4a0ddb06c4..c70f020d8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,7 +13,6 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
-	int progress;
 	unsigned flags;
 } opts;
 
@@ -23,7 +22,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
+		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
@@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	opts.progress = isatty(2);
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage, 0);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
-	if (opts.progress)
-		opts.flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
-- 
2.30.0.667.g81c0cbc6fd


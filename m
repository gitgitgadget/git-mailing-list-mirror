Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D400AC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962542076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Cbjc4S2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHKUvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC80C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r19so23718qvw.11
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQ0YqZZa9lODCoFb9xpqUaBGz+eMOXt0L0kMZRhg/Ic=;
        b=Cbjc4S2rukJm6KsQz1M/zTF0MUOITgoNiDRLcaLJnJu6W6CsE5EZexQjcwxDR9mO6T
         V3j0BIQ9xLGS4ubrm52CCG2N08RUcamFPW+fVwQy3FKqU2/E3ZDMCCJBfpjMmPh3wCuF
         Eni3pP3+MoPEVtvrc53L2FZmMw7RD4FNn+F7qqERi4UenkuBJmhOnGFjBkuicUNDH1Vd
         +My/6BR70SNkhdXnw9hmNh4xpK049X9Pyxth/DBEG7R76OnQzNV9ey+yvpyKWOcEwc/o
         JExKf1mi6mY+cIdPsRg//h0D0HQvE/B7ofp55Mcq2ElAdwOV+bchwnBiYYUTShaH20nY
         mEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQ0YqZZa9lODCoFb9xpqUaBGz+eMOXt0L0kMZRhg/Ic=;
        b=I1/WuS+nbyO/FlMRsKCnbAiJLK+RtjSAodCgj1kv/T5dFOWzLvqcn2OfxLuZKRHpj/
         l2J/GS/O1eoYWFhl6PP3AizWjUCIbPqE8Y7ebSnO0djHNvYRo7FRmDMHjVlnzOarhQXx
         ejW0/uAgBpDXE05bhveoKacZ6dbLGwg+cNoDqUkmZa7D5ZOcVsRdVQd4xEXgzWhgdUKF
         TARna8VqRYhpXnDeZLWZ42fYnHvPQXmc/chc5IYKpaXQ4I8wsUZ8DwOP/zXZxKeyI6LF
         4x6r+er7f3L2OzrorDnloYuLXCcoSZkaXI9RIQrKRPRdl60FNd5ZcO+4g/XlXOT5JMDf
         xgUg==
X-Gm-Message-State: AOAM532OIM0R372dExx/AS6Ybq35Bnh5pfrr1qWXdZAp1hFLnRQwSR8X
        ZMD0GvCZUk0Y73+FIXc+L0T/Wd3xQQk7y1A2
X-Google-Smtp-Source: ABdhPJw8PWpJXMa/Ghx9FXftDjASUcJdiAX4GqMq7fcXj+udcnJeH0Qmx3XgGZpw5jck/V2bpwv21g==
X-Received: by 2002:ad4:444e:: with SMTP id l14mr3160668qvt.111.1597179111461;
        Tue, 11 Aug 2020 13:51:51 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id s5sm18559863qke.120.2020.08.11.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:50 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 11/14] csum-file.h: introduce 'hashwrite_be64()'
Message-ID: <4800cd373eefb8d71094254d90fd0304067e464f.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small handful of writers who wish to encode 64-bit values in network
order have worked around the lack of such a helper by calling the 32-bit
variant twice.

The subsequent commit will add another caller who wants to write a
64-bit value. To ease their (and the existing caller's) pain, introduce
a helper to do just that, and convert existing call-sites.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 8 ++------
 csum-file.h    | 6 ++++++
 midx.c         | 3 +--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0d70545149..8964453433 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1784,12 +1784,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunks[i].id);
-		chunk_write[1] = htonl(chunk_offset >> 32);
-		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
+		hashwrite_be32(f, chunks[i].id);
+		hashwrite_be64(f, chunk_offset);
 
 		chunk_offset += chunks[i].size;
 	}
diff --git a/csum-file.h b/csum-file.h
index f9cbd317fb..b026ec7766 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -62,4 +62,10 @@ static inline void hashwrite_be32(struct hashfile *f, uint32_t data)
 	hashwrite(f, &data, sizeof(data));
 }
 
+static inline void hashwrite_be64(struct hashfile *f, uint64_t data)
+{
+	hashwrite_be32(f, data >> 32);
+	hashwrite_be32(f, data & 0xffffffffUL);
+}
+
 #endif
diff --git a/midx.c b/midx.c
index a5fb797ede..51ca27cf34 100644
--- a/midx.c
+++ b/midx.c
@@ -775,8 +775,7 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 		if (!(offset >> 31))
 			continue;
 
-		hashwrite_be32(f, offset >> 32);
-		hashwrite_be32(f, offset & 0xffffffffUL);
+		hashwrite_be64(f, offset);
 		written += 2 * sizeof(uint32_t);
 
 		nr_large_offset--;
-- 
2.28.0.rc1.13.ge78abce653


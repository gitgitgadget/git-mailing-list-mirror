Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E013C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E184611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFWSl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:41:26 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:09 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i12so3533252ila.13
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfAo+rT3P5nq/oinR4C7ueRvMZ2QOd4p5/w5J2qPgxU=;
        b=JWdFhlx6PHXe1mVBR1TN29XPZTOLQTXYKQU4l9aljiZvUm9VCazQa6wpWcuyNRm4Wj
         YlhHnkhR3lLNK4V+p9cs/XqCTpI9EmMf9TRrN1GImC/oArkF41bMMo4Z5dTxJK2PUg0r
         fmO0E8b63dvI6n7wfIQcLhSaWqMliX6eq+tzXjwx+xj9ckxAmR3pWMnwpP3ebxQZ7dks
         jZIy05/xniCFT2fYhmeWwL5ZEdFoXkIUygDxTrDGN4il3boQ+wWnxjvjxePXwXpDrYgn
         nJ8gBuw4YUrkyH8ctZx/fiMK5iAgdPtxX5SSJPr/p8tSfPXl98vBg/kIQIrkE7Piojbu
         koPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfAo+rT3P5nq/oinR4C7ueRvMZ2QOd4p5/w5J2qPgxU=;
        b=nsXEi/hVCx0eh+2z/SYK3iADQMWYRHJcWtFayhrUv454Xl5GL9/v6qfuZOb+bNa00a
         rafNXDf6W8uwQxQF/G2t5ts1DFLtDvkbFXpJyqrG9J+WmqKRaVCsWG4FiKXuom4tLXWX
         mhWX6kciVJ11ksuYiovtnWpwqlwTKEs56phReFHSVxbHn/0eLV2w3MiqFOW/9Iza7gxR
         ld2z+yrvl+6Xg3xwnW3jwPmENBdKlvrc7nMgEbbCyp1twIK0Ek230ErOzyGGpXD64qkV
         9eptVZ4VANHrhKSR44sNSg7Y9vWafVkJgs0AXNi5tpSiCI2kEpxH1mjwBqXsXWa3gXFy
         2eAA==
X-Gm-Message-State: AOAM531zAsWMQuplkiEUz510C/kSze/XRcpw4iFe2bN8U9QioUBc9/jk
        qqJIZqAzqSfgr1eK21vr8CKnnFZcwhGoaLXm
X-Google-Smtp-Source: ABdhPJynByj/3LycrvFCIgL9jgGJwegyrXtNW1uwg9DGcziQwp5b9vU8qNzyZcNW4eGr117aPQ4Y5w==
X-Received: by 2002:a92:d9d2:: with SMTP id n18mr611676ilq.118.1624473548281;
        Wed, 23 Jun 2021 11:39:08 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id s5sm383418ilh.19.2021.06.23.11.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:39:07 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:39:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 1/4] csum-file: introduce checksum_valid()
Message-ID: <3f1fcf348473d7320d46e3df6fe97c482b9888f2.1624473543.git.me@ttaylorr.com>
References: <cover.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new function which checks the validity of a file's trailing
checksum. This is similar to hashfd_check(), but different since it is
intended to be used by callers who aren't writing the same data (like
`git index-pack --verify`), but who instead want to validate the
integrity of data that they are reading.

Rewrite the first of two callers which could benefit from this new
function in pack-check.c. Subsequent callers will be added in the
following patches.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c  | 16 ++++++++++++++++
 csum-file.h  |  3 +++
 pack-check.c | 11 +----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 3487d28ed7..c951cf8277 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -217,3 +217,19 @@ uint32_t crc32_end(struct hashfile *f)
 	f->do_crc = 0;
 	return f->crc32;
 }
+
+int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
+{
+	unsigned char got[GIT_MAX_RAWSZ];
+	git_hash_ctx ctx;
+	size_t data_len = total_len - the_hash_algo->rawsz;
+
+	if (total_len < the_hash_algo->rawsz)
+		return 0; /* say "too short"? */
+
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, data, data_len);
+	the_hash_algo->final_fn(got, &ctx);
+
+	return hasheq(got, data + data_len);
+}
diff --git a/csum-file.h b/csum-file.h
index 3044bd19ab..291215b34e 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -44,6 +44,9 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/* Verify checksum validity while reading. Returns non-zero on success. */
+int hashfile_checksum_valid(const unsigned char *data, size_t len);
+
 /*
  * Returns the total number of bytes fed to the hashfile so far (including ones
  * that have not been written out to the descriptor yet).
diff --git a/pack-check.c b/pack-check.c
index 4b089fe8ec..c8e560d71a 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -164,22 +164,13 @@ static int verify_packfile(struct repository *r,
 
 int verify_pack_index(struct packed_git *p)
 {
-	size_t len;
-	const unsigned char *index_base;
-	git_hash_ctx ctx;
-	unsigned char hash[GIT_MAX_RAWSZ];
 	int err = 0;
 
 	if (open_pack_index(p))
 		return error("packfile %s index not opened", p->pack_name);
-	index_base = p->index_data;
-	len = p->index_size - the_hash_algo->rawsz;
 
 	/* Verify SHA1 sum of the index file */
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, index_base, len);
-	the_hash_algo->final_fn(hash, &ctx);
-	if (!hasheq(hash, index_base + len))
+	if (!hashfile_checksum_valid(p->index_data, p->index_size))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;
-- 
2.31.1.163.ga65ce7f831


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AEAC6379D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDC6241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PwWO4DV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKQVqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgKQVqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF7C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:43 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f93so17077814qtb.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4d20uyG9cZ5B5GqRS0mcoB4LsZ3zxHoVoqqlcKj8nJw=;
        b=PwWO4DV3oppq+sjcVRaPn+hk7WMsOg7a04C2ZACrd8PeEuhrxsHCDUhkn5PuqQHgkw
         rLZc53DEeXudjsEo8AjUQcLGObenBmPwQD0WNqyzUZ2A2s2WAYRGubFyojK3hq2+6QUM
         X2Cw+ggiEARfAh5DySlaGUQQFIogfSIQHoAlZnb3/KpstoTziCLQSB9qFlpTAvNXlz6M
         XOyJqbmk0DS9gK+bcLpqvos1Kl6WrB+2t4mQ55HmlNbNLtXLk9XSza3fBvILfVWMXvIS
         SACPUUm6X/NelpzEJfESWclnuJxONmWUPoIOvb4WhNRIMZAIo7IIJDLvE6Aw1+RppsH0
         yFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4d20uyG9cZ5B5GqRS0mcoB4LsZ3zxHoVoqqlcKj8nJw=;
        b=EEm/cyEysfCSues2d1jIX9LMcRGIEJRYRnXjWb7/Gdy4/DkiDecXNXNl2p1f/CghPL
         w2PJFJ6YG7pHTiQ+IZz/wtepAFNq5fn4U3uyGrXjP7uAw4aRlPc/+62trgdBOmBh+5VT
         GBweD9Mr5Gl42s+4G9/PGnhEXvVlhts76sI10aHgjMzEwW9/1s6b77y2mUoS/yoLj0Ld
         RsLIzutJcX60LnyYfusRfSE1goxRrpgwWHU1CKZPREzPrmzHL9+agw9Goo0EocQtVOwk
         QbvbW6kXJ00ceiSj2sF9zz+Dim6oGLqHgsoyf8QKMKA9sBK8az+hlrVUMYIxRtDBenaq
         nISQ==
X-Gm-Message-State: AOAM531gHtHDgHkkIKoFNfvmvQlo+yEv7orgqwA0sPwXteDkHEIJEUjT
        KsBNfOweNWHw8cmK1+IOnQaCr7P4xqahU71J
X-Google-Smtp-Source: ABdhPJyENf8MX9syLITDvXVTLxs38jR1CSZx39qYt9EgI/Ijep6dUMIB0fsWawj0vm1iAuuOwTzgSQ==
X-Received: by 2002:ac8:5c94:: with SMTP id r20mr1839630qta.158.1605649602060;
        Tue, 17 Nov 2020 13:46:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id n125sm11491325qkd.85.2020.11.17.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:41 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 03/24] pack-bitmap: bounds-check size of cache extension
Message-ID: <db11116dac1bda88d8b80fbb8197c92d9ff4369c.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

A .bitmap file may have a "name hash cache" extension, which puts a
sequence of uint32_t values (one per object) at the end of the file.
When we see a flag indicating this extension, we blindly subtract the
appropriate number of bytes from our available length. However, if the
.bitmap file is too short, we'll underflow our length variable and wrap
around, thinking we have a very large length. This can lead to reading
out-of-bounds bytes while loading individual ewah bitmaps.

We can fix this by checking the number of available bytes when we parse
the header. The existing "truncated bitmap" test is now split into two
tests: one where we don't have this extension at all (and hence actually
do try to read a truncated ewah bitmap) and one where we realize
up-front that we can't even fit in the cache structure. We'll check
stderr in each case to make sure we hit the error we're expecting.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c           |  8 ++++++--
 t/t5310-pack-bitmaps.sh | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fe5647e72e..074d9ac8f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -153,14 +153,18 @@ static int load_bitmap_header(struct bitmap_index *index)
 	/* Parse known bitmap format options */
 	{
 		uint32_t flags = ntohs(header->options);
+		size_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
+		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
 			return error("Unsupported options for bitmap index file "
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
-			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
+			if (cache_size > index_end - index->map - header_size)
+				return error("corrupted bitmap index file (too short to fit hash cache)");
+			index->hashes = (void *)(index_end - cache_size);
+			index_end -= cache_size;
 		}
 	}
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 8318781d2b..e2c3907a68 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -343,7 +343,8 @@ test_expect_success 'pack reuse respects --incremental' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'truncated bitmap fails gracefully' '
+test_expect_success 'truncated bitmap fails gracefully (ewah)' '
+	test_config pack.writebitmaphashcache false &&
 	git repack -ad &&
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
@@ -352,7 +353,19 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-	test_i18ngrep corrupt stderr
+	test_i18ngrep corrupt.ewah.bitmap stderr
+'
+
+test_expect_success 'truncated bitmap fails gracefully (cache)' '
+	git repack -ad &&
+	git rev-list --use-bitmap-index --count --all >expect &&
+	bitmap=$(ls .git/objects/pack/*.bitmap) &&
+	test_when_finished "rm -f $bitmap" &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	mv -f $bitmap.tmp $bitmap &&
+	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_i18ngrep corrupted.bitmap.index stderr
 '
 
 # have_delta <obj> <expected_base>
-- 
2.29.2.312.gabc4d358d8


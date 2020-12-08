Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D66C0018C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F16823A22
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgLHAFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:32 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209FC0611C5
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:46 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id x13so6789356oto.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKUdskbrHTgE2dMosZfIVMUOZBpta233l6JHsaPug8M=;
        b=KC4jZaKhX9ET7KbtFO6OzTIJPzXJQ0tbORMU7vLSLyOAUWVY1gOGGJvNbhccfShU9P
         6ETyA3jGaYFGMDMFH7xbt+1gWLlCqqwlN7mOcF0lyNtvp2bErf/ev2VZ4FQh4MFf7Ki4
         iEm6oryNfmubeughJic+PiCE/Uusynu9vHa1b5tMUqSje27vCf9CLUU8sYD90nfiQHQ4
         KeHkp4A8XpXV/9z29ZqDMS+tPJt2dypHFdBWJ65GmEl/djwghT55KbrAyr2ZnW0drfpu
         xqCiP1l9OexGmkaUmCDRhiAUyWwTpO7tNObOE/i0rVNCZaxx3pYISmL1WryChrJprFsj
         6oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKUdskbrHTgE2dMosZfIVMUOZBpta233l6JHsaPug8M=;
        b=cfYWMIhIGyyLtCW2WdlTG64S7dRiE+t1BP8T/j6laBaMZpVF94fxHJaTrWfRXeCCLm
         s2Xt64ILdMApCXLLyCxdx2OCAs0ZDBm18rqx0Dzh40+ChGzaTIgYiUEX5BdbcgLnzt9x
         OYRXTfVOPpQ4pUw2AtSmZMtqRUkhanZ5wIe6cnZl3HqROM4eEwE1DSFoW09MqQ8TcBqK
         cGSgFejWCBlV9f4NWJeOvW3jL2Io/bmrlqiWXIf6t3P8qYk4VeAoIJGJeFkN1aIGjMXj
         bUAD9V/taVwErLJGaBhPLlI9r+rvFqluczQpmgiuTDNIMgTQqM0Xbds5WetGSvW4w3It
         kS2w==
X-Gm-Message-State: AOAM532FmuVYN7QCSW74Dzqefk/vn0ZazHfWemDxGHG/Fc2N3bvB/6n+
        2XTNqHizWaqZFngevUPHQ9rVcaQWaJiFUhqM
X-Google-Smtp-Source: ABdhPJyLQnrmks6+EhwYSG9RtiYquBEZTg750qeeaF2ebhXWCVwS8IdI00thS7x47L9ri7VfHsLDvQ==
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr11471305ott.257.1607385885386;
        Mon, 07 Dec 2020 16:04:45 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n190sm2969199oob.11.2020.12.07.16.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:44 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 07/24] ewah: make bitmap growth less aggressive
Message-ID: <4b56f12932c0fd9e47a82a1adbeb4080a894013f.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

If you ask to set a bit in the Nth word and we haven't yet allocated
that many slots in our array, we'll increase the bitmap size to 2*N.
This means we might frequently end up with bitmaps that are twice the
necessary size (as soon as you ask for the biggest bit, we'll size up to
twice that).

But if we just allocate as many words as were asked for, we may not grow
fast enough. The worst case there is setting bit 0, then 1, etc. Each
time we grow we'd just extend by one more word, giving us linear
reallocations (and quadratic memory copies).

A middle ground is relying on alloc_nr(), which causes us to grow by a
factor of roughly 3/2 instead of 2. That's less aggressive than
doubling, and it may help avoid fragmenting memory. (If we start with N,
then grow twice, our total is N*(3/2)^2 = 9N/4. After growing twice,
that array of size 9N/4 can fit into the space vacated by the original
array and first growth, N+3N/2 = 10N/4 > 9N/4, leading to less
fragmentation in memory).

Our worst case is still 3/2N wasted bits (you set bit N-1, then setting
bit N causes us to grow by 3/2), but our average should be much better.

This isn't usually that big a deal, but it will matter as we shift the
reachability bitmap generation code to store more bitmaps in memory.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7c1ecfa6fd..6f9e5c529b 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -37,13 +37,10 @@ struct bitmap *bitmap_new(void)
 
 static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
-	if (word_alloc > self->word_alloc) {
-		size_t old_size = self->word_alloc;
-		self->word_alloc = word_alloc * 2;
-		REALLOC_ARRAY(self->words, self->word_alloc);
-		memset(self->words + old_size, 0x0,
-			(self->word_alloc - old_size) * sizeof(eword_t));
-	}
+	size_t old_size = self->word_alloc;
+	ALLOC_GROW(self->words, word_alloc, self->word_alloc);
+	memset(self->words + old_size, 0x0,
+	       (self->word_alloc - old_size) * sizeof(eword_t));
 }
 
 void bitmap_set(struct bitmap *self, size_t pos)
-- 
2.29.2.533.g07db1f5344


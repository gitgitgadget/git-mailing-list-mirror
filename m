Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC4C197BF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D0123A22
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgLHAFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgLHAFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:07 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F3C06179C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:21 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v85so6968793oia.6
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0biD3z7zmbAd3yPu0/4ZJpBDWIf7gZwf31aSZXDeAwY=;
        b=BsFstG/chYQOyqJYvyeGq4IcYqyKHxA+N2e9TqzgH6pAOpReFMqCbrwInrmZ1fMSFe
         cemZVcHUGXKUCPGyDrKX25Ej/54C+6bh7t06u2Qt53wkFvibZYAWCoD5gj9psZ/gMJLS
         qPKunGY94e9OFHIkqOhpuJ31uSPy7D3sho7KKUrKzgdTp1MPaIkccI9AjnANAjqzNcfM
         iPX1WmzJYC/okMZZvFVsR+gvAxy9BDtyyBFRwmcWKQtvoif3WqSkNi/rjfkcyBxKl2T4
         0etgcjDOJ4ESEtZUakGJczfSxtjIHtBPDPbRtzZEd8B66+NCh8a/yuI/VI67peHHD+6R
         tg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0biD3z7zmbAd3yPu0/4ZJpBDWIf7gZwf31aSZXDeAwY=;
        b=bfcTpSnXzz8YVzzyj8drHCXsHWcdn1H0AV17DUBm8SDGV9sEgcBDR8mCkmrjqD+iVs
         2nTAOH/pTachiQeffCwvuqhjgWpLahVQGEH+AT2QWlxX3hrK8sVdwtRpExE79NSscB1w
         ekHr2myNMua5xZbqoUXghmYoGWVmqxrFbEqo1N2HyAJ4ykGr0AoOmpq+HA4C9S8PFCOd
         DMRwPwFlZbCJn3YFZqYHhrHVcthoxV1vu9u+iwbnrbNK3Mr9phVTNTSoxLeRJ27d81AX
         sZu1fAD5SwwqCCbksiq8nsFdyo7d4+DuRqI3tT7vOuWiegEazXcCVVQy1GK3IZFy3quu
         Yavg==
X-Gm-Message-State: AOAM531sAfGc6aV5TDG7p1xfMXyrajwuhjj9yuR6Ma9+vDIEb0QmaEIF
        xWQg3CfMN3aUHDauE2wD4fpGtMhXXjugc9iO
X-Google-Smtp-Source: ABdhPJzXO3IkJnY+scjzi+JeQN6vkwHz97+Dmk5lIBqc4NAnS2BCc1Xtb3zFd7uiFqL1x6o1GMhDMQ==
X-Received: by 2002:aca:ef44:: with SMTP id n65mr1012874oih.90.1607385860707;
        Mon, 07 Dec 2020 16:04:20 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t12sm1976021oot.21.2020.12.07.16.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:20 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 02/24] pack-bitmap: fix header size check
Message-ID: <b455b248e4e12d50a7fd1ef2cac34af7f6c53bed.1607385833.git.me@ttaylorr.com>
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

When we parse a .bitmap header, we first check that we have enough bytes
to make a valid header. We do that based on sizeof(struct
bitmap_disk_header). However, as of 0f4d6cada8 (pack-bitmap: make bitmap
header handling hash agnostic, 2019-02-19), that struct oversizes its
checksum member to GIT_MAX_RAWSZ. That means we need to adjust for the
difference between that constant and the size of the actual hash we're
using. That commit adjusted the code which moves our pointer forward,
but forgot to update the size check.

This meant we were overly strict about the header size (requiring room
for a 32-byte worst-case hash, when sha1 is only 20 bytes). But in
practice it didn't matter because bitmap files tend to have at least 12
bytes of actual data anyway, so it was unlikely for a valid file to be
caught by this.

Let's fix it by pulling the header size into a separate variable and
using it in both spots. That fixes the bug and simplifies the code to make
it harder to have a mismatch like this in the future. It will also come
in handy in the next patch for more bounds checking.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4077e731e8..fe5647e72e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,9 +138,10 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
+	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
-	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
-		return error("Corrupted bitmap index (missing header data)");
+	if (index->map_size < header_size + the_hash_algo->rawsz)
+		return error("Corrupted bitmap index (too small)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
 		return error("Corrupted bitmap index file (wrong header)");
@@ -164,7 +165,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-	index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	index->map_pos += header_size;
 	return 0;
 }
 
-- 
2.29.2.533.g07db1f5344


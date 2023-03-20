Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F04C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCTUDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCTUDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB04ED0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:46 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r4so7086107ilt.8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M0RUwC8NqbI54+W2PYI1fm4kPL+s41dBwUnD+TCbZU=;
        b=ncdBLtbwIZLJhbQGuSszUG+tK9QV9ZMyHy6FnMujlhRljhlIL8jOeWY999OyeED5oC
         e26+WhSHl7T17Q1qhaBzMcQrQANXJh10G3cM0aD4do63GPR9d8Te20B5Tk6rqhHVLYXp
         2QGSDBGBcWW23QNEU85qJtPo3RDjVDZ5P8+AlcTGFgMcAZvWOcsLKQjOiuA8QrlFbTiD
         zcmDXl5a1WEcyGVNdvJj8kfCxqLM1ugHHScSzu5bP2fQWiyxtYte7D6LObCcybxy9mkD
         j5nZq3KqmpABU1ZJrsLasoUl9Aye4kFYroZuWJazNPJW+DfeK4HQ1rvW3D2wqLkiQ0tc
         OpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M0RUwC8NqbI54+W2PYI1fm4kPL+s41dBwUnD+TCbZU=;
        b=wgxtcakMz4+fMOBbWsi9f3zn9AdZKnGU0SF7taDrvdoICvJxZNSrnkd2oRulUe7DPo
         5oJomXv1xt3GoSagD5P7kex+1qz86BF+xogLB7XU5qj8gS/nSZAbrZe611dQKAYL7pBB
         TjAoBDfyDyPlGYQDuCle3icz8/02Zci3K5yLcC+xu45PmRNO9vKz+GBS24nPNl+X3Gs8
         56rDe6ad6TpbdCPKQghFPNYCBxIkvOyZd9BWERgo2EABzFFKJbnjif7VRA01Tgr+EVJv
         OhdiWXuVd6+NO7s//piF6r3tfjzO7pUDqeYvrvhaNmUZoq2EIQYojriUKSwmDlgVQ0HQ
         sQKg==
X-Gm-Message-State: AO0yUKUql+elESldXpjy3JyBQ3GB0Nnr3Tf4FAl3DWOYpQ386hBlvS7E
        d7nBnoyxZGaV5CfZC+I7lK1K5QUugn9G3Xdi9CA3JQ==
X-Google-Smtp-Source: AK7set9n8rZ2B6Qx+KIvUdRtqW6tdwEm+fd9IcR8AY8vJ1lmEp+zASuQqsro/xb8BM9mh/uiBJOftA==
X-Received: by 2002:a92:dcca:0:b0:314:20e6:133c with SMTP id b10-20020a92dcca000000b0031420e6133cmr509858ilr.3.1679342564755;
        Mon, 20 Mar 2023 13:02:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r14-20020a92760e000000b00304ad1e7d21sm3040101ilc.28.2023.03.20.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:44 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/6] pack-bitmap.c: hide bitmap internals in `read_be32()`
Message-ID: <4914c5b72c3aab9f59589daf8daff5e2271c52fb.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar fashion as the previous commit, update `read_be32()` to
take a `struct bitmap_index *` instead of copies of and pointers to
variables within that structure.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d8ba252ba1..794aaf5b02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -244,10 +244,10 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	return stored;
 }
 
-static inline uint32_t read_be32(const unsigned char *buffer, size_t *pos)
+static inline uint32_t read_be32(struct bitmap_index *bitmap_git)
 {
-	uint32_t result = get_be32(buffer + *pos);
-	(*pos) += sizeof(result);
+	uint32_t result = get_be32(bitmap_git->map + bitmap_git->map_pos);
+	bitmap_git->map_pos += sizeof(result);
 	return result;
 }
 
@@ -282,7 +282,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		if (index->map_size - index->map_pos < 6)
 			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
 
-		commit_idx_pos = read_be32(index->map, &index->map_pos);
+		commit_idx_pos = read_be32(index);
 		xor_offset = read_u8(index);
 		flags = read_u8(index);
 
-- 
2.40.0.77.gd564125b3f


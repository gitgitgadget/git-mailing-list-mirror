Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806FC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E85E23A6A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbhAHSR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:17:27 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235FC061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:16:47 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id f26so9302361qka.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mL09HQd5W+44PwPcuaBUp7pjSzo50ABFARlQMrsKfh8=;
        b=FLFLhMQzBPPvKaT5GIlnNjOfyA63KhxIZAFEPPBelKbzocrsjFB/WNoCty3HBCbyYw
         kaEbnh79Jgrj4KtGN0tCXpV6R3GuiGzQ7cJO99bpAsfUYMDMGt7pa8Vo5joTyOuRxm0b
         NmJCiownA0miTkJ1k8t6fJ+xBiRWUa0hw4+UOFpNw4earbK2lOjY0CssstSTwUQM6ncC
         MfZSQzmBabtEHjaXGz9q0AE/g9nuL6SbgdD2OoN+3oYhpCTB2RSkcd9+rfF52Gx/99cT
         /7ac3hmT8Iu8NOHghR9PxhSeMkvl4GtPGPQ7liP4YDUfkN3VXDdz0yz/hI2uKsxrlA+D
         pTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mL09HQd5W+44PwPcuaBUp7pjSzo50ABFARlQMrsKfh8=;
        b=uoTLxFD158DQuh08e0lKgu5XYVnUPvmgd3mmp7PHB7gXOoZ6z9PKx66yIdqri/lHCm
         PcCEwAbMkEb/M8Ur1eZCHoEBP4W5ro9Uk9ypYM9ehHZtH5rUQGfjVrL3rOyg0vdnp8OT
         X3PhcyCuJou2in3wDE30uvWetoNitSgnIEyIF3lU97MH3Kqwj23T8o4qb3C5BTiLzIK4
         N+qhnVVWguJOMapUkj6kttyGmGTR2fS6au6KJbEa9WhZVzUxiQrJ9vxEklG+KCaKFsSt
         FNxb4SZO9goOOqvTy+vL2MHF9VQp2yPgwqZ1gCJJNhMTgoWJovfhkaXAPJDEd4UNuFSa
         qtpQ==
X-Gm-Message-State: AOAM531Q1Y7qdw0LU68RvBrtYWNEWjNkw73ahm1gKyhG99jJl9jh26lH
        /XS7nG7b7KxNgYN33FRR3QOpk4st756pfA==
X-Google-Smtp-Source: ABdhPJzXxS7c00uQGqN6UUpJmnJ2B4RPkJMksIUpN2C1jbO8KNYYChpVegsrbqe5SbO9plfB0F/M6A==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr5027660qki.319.1610129806338;
        Fri, 08 Jan 2021 10:16:46 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id c139sm5231845qke.24.2021.01.08.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:16:45 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:16:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next several patches, we will prepare for loading a reverse index
either in memory, or from a yet-to-be-introduced on-disk format. To do
that, we'll introduce an API that avoids the caller explicitly indexing
the revindex pointer in the packed_git structure.

There are four ways to interact with the reverse index. Accordingly,
four functions will be exported from 'pack-revindex.h' by the time that
the existing API is removed. A caller may:

 1. Load the pack's reverse index. This involves opening up the index,
    generating an array, and then sorting it. Since opening the index
    can fail, this function ('load_pack_revindex()') returns an int.
    Accordingly, it takes only a single argument: the 'struct
    packed_git' the caller wants to build a reverse index for.

    This function is well-suited for both the current and new API.
    Callers will have to continue to open the reverse index explicitly,
    but this function will eventually learn how to detect and load a
    reverse index from the on-disk format, if one exists. Otherwise, it
    will fallback to generating one in memory from scratch.

 2. Convert a pack position into an offset. This operation is now
    called `pack_pos_to_offset()`. It takes a pack and a position, and
    returns the corresponding off_t.

 3. Convert a pack position into an index position. Same as above; this
    takes a pack and a position, and returns a uint32_t. This operation
    is known as `pack_pos_to_index()`.

 4. Find the pack position for a given offset. This operation is now
    known as `offset_to_pack_pos()`. It takes a pack, an offset, and a
    pointer to a uint32_t where the position is written, if an object
    exists at that offset. Otherwise, -1 is returned to indicate
    failure.

    Unlike some of the callers that used to access '->offset' and '->nr'
    directly, the error checking around this call is somewhat more
    robust. This is important since callers can pass an offset which
    does not contain an object.

    This will become important in a subsequent patch where a caller
    which does not but could check the return value treats the signed
    `-1` from `find_revindex_position()` as an index into the 'revindex'
    array.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 32 ++++++++++++++++++++++++++++++++
 pack-revindex.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index ecdde39cf4..6d86a85208 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -203,3 +203,35 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 
 	return p->revindex + pos;
 }
+
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
+{
+	int ret;
+
+	if (load_pack_revindex(p) < 0)
+		return -1;
+
+	ret = find_revindex_position(p, ofs);
+	if (ret < 0)
+		return -1;
+	*pos = ret;
+	return 0;
+}
+
+uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
+{
+	if (!p->revindex)
+		BUG("pack_pos_to_index: reverse index not yet loaded");
+	if (pos >= p->num_objects)
+		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
+	return p->revindex[pos].nr;
+}
+
+off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
+{
+	if (!p->revindex)
+		BUG("pack_pos_to_index: reverse index not yet loaded");
+	if (pos > p->num_objects)
+		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
+	return p->revindex[pos].offset;
+}
diff --git a/pack-revindex.h b/pack-revindex.h
index 848331d5d6..256c0a9106 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -13,4 +13,8 @@ int find_revindex_position(struct packed_git *p, off_t ofs);
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
+uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
+off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
+
 #endif
-- 
2.30.0.138.g6d7191ea01


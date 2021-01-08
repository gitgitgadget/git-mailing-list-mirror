Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A909DC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6939F23A75
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbhAHSRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:17:32 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44707C0612EA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:16:52 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p5so4712751qvs.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIcEAq97ikHbEAiV58Hl3iJqqlyUqS4d3wqSJUqHQHI=;
        b=JjKwI1BjkHOzwMAq+a1kkPHiWr7dCjeO8jLWm8FKidR3R0WePU+DtvruePoiYj8mDL
         KWuY6iuL8ZGnMHdQ4uLhDxQdVzJJVqyqdIVnXXvhJWUMQX5dAawdYNyM9bh1dyo6e0tq
         i97kBe358IeBMICIKH/0oq/to6oe0PKfuaEU7Y4XZ8zw3mfbkeLeN0pGIIgJ3kee41AG
         V9DWE07AwWGU07cqyaH+c/ZaBVNiBoOUsNbPK3S0EY+CYB7m/TE371ZZ+JpEhqHzlPI3
         T+bNMtbMNum/ZSc/g5NMc3z75+I53e3tiTvjZ4t88OtXH8zvx74pmo9uMXiquslBVTLn
         4MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIcEAq97ikHbEAiV58Hl3iJqqlyUqS4d3wqSJUqHQHI=;
        b=qLC/xA3NbcikYKiqr6YoD91URsv1o9jHX5tYx7qdT0aytkPS34F21G/xH2FmvJNfAF
         aWwYfWW01f26PtHiJ4HiEk4qGO6RS+1mIkxJlEvEC3nlmtlWuXcY/qG9En44z+ftroIb
         DRsftQsQd6uGiAs7qMSfKya3FgeA5ajxUjthRt9/s3bTyv2SadXAIiY1ltnmJNV75bF4
         nZqEUxpMls3NePxm2RV5wWC/KQGk1ZKHdDusr/PpX6ysvDiIQ7ETEx/GFTgqEPT3tbRV
         CwnPFf3od0exzOQY4fs42GNN7fNDoagAgRcnG0VlBOHj+THiV+e0igwS4j85iPGwzuC/
         wxkw==
X-Gm-Message-State: AOAM531urKgASB8U8WjJUWS4EiXsNCb4EtxgtCk50c2srb2nbi+zt1vC
        l8eNpNiIuk9HKBOpkzY7ajxCPxEmgeQ/sQ==
X-Google-Smtp-Source: ABdhPJxR6fiO1x542+CaB3feSaXicmINF/wYS2cIPMoDbGSpeai8esiuKdqIBBxWOIwymomEC0ui7Q==
X-Received: by 2002:a0c:a789:: with SMTP id v9mr4561028qva.41.1610129811297;
        Fri, 08 Jan 2021 10:16:51 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id t5sm4894051qte.20.2021.01.08.10.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:16:50 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:16:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 02/20] write_reuse_object(): convert to new revindex API
Message-ID: <00668523e1cd860f6de08dd7c5a2a54edc08b7b6.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First replace 'find_pack_revindex()' with its replacement
'offset_to_pack_pos()'. This prevents any bogus OFS_DELTA that may make
its way through until 'write_reuse_object()' from causing a bad memory
read (if 'revidx' is 'NULL')

Next, replace a direct access of '->nr' with the wrapper function
'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..03d25db442 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -419,7 +419,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 {
 	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
-	struct revindex_entry *revidx;
+	uint32_t pos;
 	off_t offset;
 	enum object_type type = oe_type(entry);
 	off_t datalen;
@@ -436,10 +436,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 					      type, entry_size);
 
 	offset = entry->in_pack_offset;
-	revidx = find_pack_revindex(p, offset);
-	datalen = revidx[1].offset - offset;
+	if (offset_to_pack_pos(p, offset, &pos) < 0)
+		die(_("write_reuse_object: could not locate %s"),
+		    oid_to_hex(&entry->idx.oid));
+	datalen = pack_pos_to_offset(p, pos + 1) - offset;
 	if (!pack_to_stdout && p->index_version > 1 &&
-	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
+	    check_pack_crc(p, &w_curs, offset, datalen,
+			   pack_pos_to_index(p, pos))) {
 		error(_("bad packed object CRC for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
-- 
2.30.0.138.g6d7191ea01


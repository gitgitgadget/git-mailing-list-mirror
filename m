Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC41C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A1D2242A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbhANCJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124DBC061795
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:39 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id w79so4434174qkb.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FcrMgWKoL9JcvtnnDPFkP5fIWQ2mPWD0Tf8r1DdjpfA=;
        b=oyNBQzeutsAOaTKaqC7Hrvf2hh4hKNMZR3hJ7NAXbN7HpZckJ4c59aWNrSjnqkWG66
         gpVx20Mqz/Iyxx3OKN1Ia+o5pIUet5ikGAhzyrnY9mzxDkPfJEWu+/8BNTx03Py3J73s
         4uh1ctAk4ykxZ9IMMEvJuj5sQeaVXr1zi6d/lX9jfRbHMTTA57nRaxz2a9QCUMUU19Bn
         WvcGn9uBIx91LinFU1ai0Zy5Et08k/hv/LuiRnga2yPklvy4qVL6nPVZTF+xWyoNUb/1
         pkZ9FfI9MRM1u04Pz+9Pf15gl5RhHmnnM0bwwY4iTGzwiYm4a7OmIhMtsqmItmUl3TgR
         XYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FcrMgWKoL9JcvtnnDPFkP5fIWQ2mPWD0Tf8r1DdjpfA=;
        b=ino+Q6srzIQHOYqHPggQp7cJNmW4HncI0n5PEYLA5PezBw/p/3LCRK1Teer8MpaZRf
         a2MUiRHz6UHcEdnQ/MtngkYtcdzA3uHlOl0670ZnJSqAXdPvGiCO+DdOHtNs6qgw1czg
         6fyxCdt88bUJYG60LfKfZb8ykoknUTkpSc/lx+FIPXJWkp+mmsl5zumTJPgU5QSoMULH
         RCyKoOYui5Q8KugCSuxAc662tu8SK3gDwVvcioQOnhErq0af2FvyOEx8rFwxEvHWEa3A
         tbo61+D/JN0bG/+UhdE1Gwy/m7KCWUsk9vtl/YWM+NQZ9JRfiPe4e33z8oMiRDDigaEy
         fdrw==
X-Gm-Message-State: AOAM530XsrymS0BCRQf5GG4GlhR4M9hB3TQwFHWF3tp1IYJsm2F958yl
        faSYfLJygM4RsC4tV8F2OsauhCRCG0mUag==
X-Google-Smtp-Source: ABdhPJy+H4Nkxx9z4m4iyG5RgX0XQPfqYZnd+4ybqG3XliOCuaYG2A8FMLDGBoel8oD6Unx7tHh4Dw==
X-Received: by 2002:a37:65ca:: with SMTP id z193mr4353912qkb.171.1610576618104;
        Wed, 13 Jan 2021 14:23:38 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id n195sm1890190qke.20.2021.01.13.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:37 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 02/20] write_reuse_object(): convert to new revindex API
Message-ID: <0fca7d5812185d482fd48f7df6c062ab44933055.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
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
 builtin/pack-objects.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..ab1fd853f1 100644
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
@@ -436,10 +436,15 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 					      type, entry_size);
 
 	offset = entry->in_pack_offset;
-	revidx = find_pack_revindex(p, offset);
-	datalen = revidx[1].offset - offset;
+	if (offset_to_pack_pos(p, offset, &pos) < 0)
+		die(_("write_reuse_object: could not locate %s, expected at "
+		      "offset %"PRIuMAX" in pack %s"),
+		    oid_to_hex(&entry->idx.oid), (uintmax_t)offset,
+		    p->pack_name);
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


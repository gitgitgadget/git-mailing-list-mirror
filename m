Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D430ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiISRsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiISRru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFD43307
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z6so347511wrq.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=FFu/FIPc/gw7c8ttqSXitVma2QR9/XqbPMOBsAkdZX4=;
        b=oL2CaEHt+PPEYIcJgaAFd20A30ZzYlfMRpysyKomkpVbzu/10V83+hCVW3Ffy0IHZm
         TdID8wsGj34782CDhYvTZYHnghh3vG3OqpZjAtIqe5wvYowEUaB3gntfSHR7DXJ5+Rhp
         icaeh2KVhKrZk/7OCtRVVLH8f6qHoNwAg0l+PDHcyf4BdDz9zbx+zAuq2+11XV8NuQTA
         dnb7m5OUqEq7rHlSIUdEqqnWtqh7+2uU56f+EYxnq3WFiHrlkta3hTKImmheHzAuiNLm
         LRuETnwcgW4XvCg86sEUabx7UdtuUnmzKPwrcgmrCX1FoDNfYv6LRjSA2cyZRLyTN7Em
         tj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FFu/FIPc/gw7c8ttqSXitVma2QR9/XqbPMOBsAkdZX4=;
        b=vZGA+AcMeHSySNN74+/UicgNL6YnRgrbURZYGHSxdyzBb3LKumIsXPIft7LiBCCG4J
         vz8A6b+MhBMnge2IjLAqc/DDj2JqbKgploKWTb2xABzofehUW5V1c/rq9pmxYI+T/ep6
         XqEWQ4upthcKcYgMijdLay79Onanzh2zS3Kz0gy73dyuWksWahOy5cBv+5gnI79ZX1mP
         NZ1o2LN6OqbO8yKOK1Lcc7aC2OVMBiso/CaAkHnzo/xi5AXHAGkXFuCT1fiUL8YLJALS
         J7a05GM93mDIHJducrk/9mUJyZBObcF1fwBXEQ74ucHSKJhG3GhBMb10CxjAslInh9IF
         R++A==
X-Gm-Message-State: ACrzQf1mO6kTEgcNsX6N+CUsg0NjyLVhh6zhY+4pwcC8fzngczKDRUan
        rFkXMjbWbQxGjuuj+Knw/ktta2GoiCQ=
X-Google-Smtp-Source: AMsMyM48X84nabUl2vqgtMlXWiRbEWQuz5hFCx3PLajs0whDteEOy86zvwf5HPDqrlcfnwa9xXNvrw==
X-Received: by 2002:adf:fa12:0:b0:228:62a8:7c79 with SMTP id m18-20020adffa12000000b0022862a87c79mr11259575wrr.231.1663609666626;
        Mon, 19 Sep 2022 10:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q126-20020a1c4384000000b003b4bd18a23bsm13989353wma.12.2022.09.19.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:47:45 -0700 (PDT)
Message-Id: <683b0c625418278e4775978cb663edd03a113faa.1663609660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:47:38 +0000
Subject: [PATCH 4/5] roaring: introduce a new config option for roaring
 bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Though Git can write roaring bitmaps, there is still no way (e.g.
configurations) to control the writing of roaring bitmaps.

Introduce `pack.useroaringbitmap` option to control the writing of
roaring bitmaps.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 builtin/multi-pack-index.c | 5 +++++
 builtin/pack-objects.c     | 7 ++++++-
 midx.c                     | 7 +++++++
 midx.h                     | 1 +
 pack-bitmap.h              | 7 +++----
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9b126d6ce0e..9e221dd7cc9 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -80,6 +80,11 @@ static struct option *add_common_options(struct option *prev)
 static int git_multi_pack_index_write_config(const char *var, const char *value,
 					     void *cb UNUSED)
 {
+	if (!strcmp(var, "pack.useroaringbitmap")) {
+		if (git_config_bool(var, value))
+			opts.flags |= MIDX_WRITE_ROARING_BITMAP;
+	}
+
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
 		if (git_config_bool(var, value))
 			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..439c5572c18 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -228,7 +228,7 @@ static enum {
 	WRITE_BITMAP_QUIET,
 	WRITE_BITMAP_TRUE,
 } write_bitmap_index;
-static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_SET_EWAH_BITMAP;
 
 static int exclude_promisor_objects;
 
@@ -1258,6 +1258,7 @@ static void write_pack_file(void)
 				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
+				bitmap_writer_init_bm_type(write_bitmap_options);
 				bitmap_writer_set_checksum(hash);
 				bitmap_writer_build_type_index(
 					&to_pack, written_list, nr_written);
@@ -3143,6 +3144,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		cache_max_small_delta_size = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.useroaringbitmap")) {
+		if (git_config_bool(k, v))
+			write_bitmap_options |= BITMAP_SET_ROARING_BITMAP;
+	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
 		if (git_config_bool(k, v))
 			write_bitmap_options |= BITMAP_OPT_HASH_CACHE;
diff --git a/midx.c b/midx.c
index c27d0e5f151..b80db2239a8 100644
--- a/midx.c
+++ b/midx.c
@@ -1112,10 +1112,16 @@ static int write_midx_bitmap(const char *midx_name,
 {
 	int ret, i;
 	uint16_t options = 0;
+	unsigned version = 0;
 	struct pack_idx_entry **index;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
 					hash_to_hex(midx_hash));
 
+	if (flags & MIDX_WRITE_ROARING_BITMAP)
+		version |= BITMAP_SET_ROARING_BITMAP;
+	else
+		version |= BITMAP_SET_EWAH_BITMAP;
+
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
@@ -1131,6 +1137,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
+	bitmap_writer_init_bm_type(version);
 	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
 
diff --git a/midx.h b/midx.h
index 5578cd7b835..c0b19b93c9c 100644
--- a/midx.h
+++ b/midx.h
@@ -48,6 +48,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP (1 << 2)
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
+#define MIDX_WRITE_ROARING_BITMAP (1 << 5)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 7d71deca023..6103e0d57e7 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -30,9 +30,6 @@ struct bitmap_disk_header {
 
 #define NEEDS_BITMAP (1u<<22)
 
-#define BITMAP_SET_EWAH_BITMAP 0x1
-#define BITMAP_SET_ROARING_BITMAP (1 << 1)
-
 /*
  * The width in bytes of a single triplet in the lookup table
  * extension:
@@ -44,7 +41,9 @@ struct bitmap_disk_header {
 
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 0x1,
-	BITMAP_OPT_HASH_CACHE = 0x4,
+	BITMAP_SET_EWAH_BITMAP = 0x2,
+	BITMAP_SET_ROARING_BITMAP = 0x4,
+	BITMAP_OPT_HASH_CACHE = 0x8,
 	BITMAP_OPT_LOOKUP_TABLE = 0x10,
 };
 
-- 
gitgitgadget


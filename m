Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0386B1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfFSJ7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44294 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbfFSJ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so9417511pfe.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGYeAPN7w6w1sm6Sh8QryALnaq1DTY1XELy/WQasz2s=;
        b=oASr2Drwgq9BVInFct8/fRtT5kKcNNUt1s2EpfrDv8qUCi61NUfrhRwQlRDR1MbS9X
         vBomhFQwy7u8dJ1m076NUhvivu0OkHqpd/kpgbdAbyAQKymD+zLCFFOJUFByThR+97X4
         NCnslc8h5RlSSoDAloaryucyMSHu9ayVNX+xaobvzwuWsKZqFAt25WPkJJXvlk80j8A9
         kw/PdilII6sCaoWDcJGxyn1ieUrs6QctPGgy++tK1N70cziGxbRDj+mKShFBQVJ4ppIN
         RKzalmhS16ZXZBrE6ZpAKDwStvdqu9L8F5LEKZSOjuINzoTYh/mlwi1pt4sMc6PE2Seh
         u2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGYeAPN7w6w1sm6Sh8QryALnaq1DTY1XELy/WQasz2s=;
        b=i7hjHt0tQxstKAwi6vxuxy1ORbyLgqtKxYoUehWYQGyGJRk8Wr7sqe2FGMP2hgqby/
         I/NKy5DPBQa/V07hx2rYvtD06E/962cHKC8G1DD+dMIb0bs1e4EUOqFLbeOO3UwfMZVQ
         T6A3948PMO47uEADZ2464F+TMAfZwB/AljKEh0hG2+9Z/WldLDSVks5IoTWkTuvEGkUT
         vcGbom/SrEJ4xAJqYeQlnSe+NbOYnDXE6yUoKU4HMTKr+UFq/hnuXaB1mO1IaCY3dzGh
         16U9AvfFmLuQxF0Zd6icoF0hJppXuHj6PXkN4Y+UtQoBAGrz5JcpgZ4sv0odW7zlpkaF
         ZO6g==
X-Gm-Message-State: APjAAAUX3X4y4W5Occ/SORU6CEeUr9b9MYwQ10NgfBD03koyXqsXcFHl
        Ry/oiTfImZ76oUSnFniKco1katww
X-Google-Smtp-Source: APXvYqzPlGqReBJAQSKK9WWBpVG6LS1l1jDqb766gBQoYc6+efmS6lkZtLb/eF+S/MKr2ANxULc81g==
X-Received: by 2002:a62:ce07:: with SMTP id y7mr9106048pfg.12.1560938373086;
        Wed, 19 Jun 2019 02:59:33 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id a22sm21413139pfn.173.2019.06.19.02.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/8] read-cache.c: dump "IEOT" extension as json
Date:   Wed, 19 Jun 2019 16:58:56 +0700
Message-Id: <20190619095858.30124-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 04863c3853..200834e77e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1911,7 +1911,7 @@ struct index_entry_offset_table
 	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
-static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
+static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset, struct json_writer *jw);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size, struct json_writer *jw);
@@ -2232,6 +2232,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		nr_threads = 1;
 
 	if (istate->jw) {
+		size_t off;
+
 		jw_object_begin(istate->jw, jw_pretty);
 		jw_object_intmax(istate->jw, "version", istate->version);
 		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
@@ -2243,8 +2245,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		 * debugging only, so performance is not a concern.
 		 */
 		nr_threads = 1;
-		/* and dump EOIE extension even with threading off */
-		read_eoie_extension(mmap, mmap_size, istate->jw);
+		/* and dump EOIE/IOET extensions even with threading off */
+		off = read_eoie_extension(mmap, mmap_size, istate->jw);
+		if (off)
+			free(read_ieot_extension(mmap, mmap_size,
+						 off, istate->jw));
 	}
 
 	if (nr_threads > 1) {
@@ -2266,7 +2271,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	 * to multi-thread the reading of the cache entries.
 	 */
 	if (extension_offset && nr_threads > 1)
-		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
+		ieot = read_ieot_extension(mmap, mmap_size, extension_offset, NULL);
 
 	if (ieot) {
 		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
@@ -3630,7 +3635,9 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 
 #define IEOT_VERSION	(1)
 
-static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
+static struct index_entry_offset_table *read_ieot_extension(
+	const char *mmap, size_t mmap_size,
+	size_t offset, struct json_writer *jw)
 {
 	const char *index = NULL;
 	uint32_t extsize, ext_version;
@@ -3666,6 +3673,12 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 		error("invalid number of IEOT entries %d", nr);
 		return NULL;
 	}
+	if (jw) {
+		jw_object_inline_begin_object(jw, "index-entry-offsets");
+		jw_object_intmax(jw, "version", ext_version);
+		jw_object_intmax(jw, "ext-size", extsize);
+		jw_object_inline_begin_array(jw, "entries");
+	}
 	ieot = xmalloc(sizeof(struct index_entry_offset_table)
 		       + (nr * sizeof(struct index_entry_offset)));
 	ieot->nr = nr;
@@ -3674,6 +3687,17 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 		index += sizeof(uint32_t);
 		ieot->entries[i].nr = get_be32(index);
 		index += sizeof(uint32_t);
+
+		if (jw) {
+			jw_array_inline_begin_object(jw);
+			jw_object_intmax(jw, "offset", ieot->entries[i].offset);
+			jw_object_intmax(jw, "count", ieot->entries[i].nr);
+			jw_end(jw);
+		}
+	}
+	if (jw) {
+		jw_end(jw);	/* entries */
+		jw_end(jw);	/* index-entry-offsets */
 	}
 
 	return ieot;
-- 
2.22.0.rc0.322.g2b0371e29a


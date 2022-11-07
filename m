Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D991C43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiKGShm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiKGShE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28C2612F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o4so17577409wrq.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpMd01WBMeG+LCpD0GW+bvFGhemRwxfM+YE1DxabB84=;
        b=ZLyCtnL1wMIJHd0CHLyajBvTqpXv2CExtDvXLHyoioibGuin7nW5YBNl5wk5PlhpeY
         U7kZbHkwbVhKA3bMCB47jwaXDmtyA7QJ2sPuQiiIJAUs22c2hMhWzthIIEea1taoeO/h
         +LL9NSTOGiDdl2UQcKKi22eV7C+BxB74dVEd+ymESHKkOqd9RJas6aLqo6T0sutlr7W0
         F6wdgrsmyZiVDKhb3vERPtIy9weHYcaNd9tEz0Zhsir4r641LNtMHaG0FsHJG+d0KK9w
         GiJWv31evAvJKLKSFIGiWYuUEzKp2ov1OYPcxuYO05jEMC1jw6qEZpfcVbS0je3PSZjd
         sTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpMd01WBMeG+LCpD0GW+bvFGhemRwxfM+YE1DxabB84=;
        b=fJ4U6NxVK6EvXMn+5evM+nyh2gT9I6HSBV7p4A/3UWiSRg3r4HJz2YFEf45VVG7b18
         sH7y9ooSFz0GA6+Ij3roWHraKCC/mpCCuVEvEgVYbE6207xCJlDUSaVmPCcQGJnZaDPp
         x91BEIQx/UqIv3GuEB9GFHs/6BrD5af3Qc5nxEBASttw7qr6BSNJnYqqgr11jgf8sNX+
         dBSp1QWyzhB+mwj7FcGJO8zuiwbNm9wUc9zHT488t0l4/Vc/7XipCdSqgdE/8bVXaADf
         g0m18A50Pu3zjvUcYVxVaIeAAe9jPCqVU6vjngThSYGcsS9FlaKaAjKsT739/QTbmuVR
         SHNQ==
X-Gm-Message-State: ACrzQf0N7spNOYujz0Wt+A52eJ2vswwHxTsTj7kcYUzMn67X686L578Y
        Fiyj6W18rVYXYC+V+awnzdJSih6t0k8=
X-Google-Smtp-Source: AMsMyM60ORh/6OlzmT3uPfgB5uvPn8kMOnqOVaDImbJAieP7UE0WYN8F0ut4duDLGpz5TkvAkJgS2w==
X-Received: by 2002:a5d:42c4:0:b0:236:637c:6c71 with SMTP id t4-20020a5d42c4000000b00236637c6c71mr32861665wrr.499.1667846186432;
        Mon, 07 Nov 2022 10:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a6125562e1sm9478018wms.46.2022.11.07.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:25 -0800 (PST)
Message-Id: <9b3bd93e51e5ed4358c76263e96c4b4e218987b7.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:54 +0000
Subject: [PATCH 20/30] packed-refs: read optional prefix chunks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c   |   2 +
 refs/packed-backend.h   |   9 +++
 refs/packed-format-v2.c | 159 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 549cce1f84a..ae904de9014 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -475,6 +475,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->version = snapshot->version;
 	iter->row = v2_row;
 
+	init_iterator_prefix_info(prefix, iter);
+
 	iter->pos = start;
 	iter->eof = snapshot->eof;
 	strbuf_init(&iter->refname_buf, 0);
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 3a8649857f1..1936bb5c76c 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -103,9 +103,12 @@ struct snapshot {
 	 * packed-refs v2 values *
 	 *************************/
 	size_t nr;
+	size_t prefixes_nr;
 	size_t buflen;
 	const unsigned char *offset_chunk;
 	const char *refs_chunk;
+	const unsigned char *prefix_offsets_chunk;
+	const char *prefix_chunk;
 
 	/*
 	 * Count of references to this instance, including the pointer
@@ -212,6 +215,9 @@ struct packed_ref_iterator {
 	 ***********************************/
 	size_t nr;
 	size_t row;
+	size_t prefix_row_end;
+	size_t prefix_i;
+	const char *cur_prefix;
 };
 
 typedef int (*write_ref_fn)(const char *refname,
@@ -308,4 +314,7 @@ struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *
 int write_packed_refs_v2(struct write_packed_refs_v2_context *ctx);
 void free_v2_context(struct write_packed_refs_v2_context *ctx);
 
+void init_iterator_prefix_info(const char *prefix,
+			       struct packed_ref_iterator *iter);
+
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
index d75df9545ec..0ab277f7ad4 100644
--- a/refs/packed-format-v2.c
+++ b/refs/packed-format-v2.c
@@ -14,6 +14,79 @@
 #define PACKED_REFS_SIGNATURE          0x50524546 /* "PREF" */
 #define CHREFS_CHUNKID_OFFSETS         0x524F4646 /* "ROFF" */
 #define CHREFS_CHUNKID_REFS            0x52454653 /* "REFS" */
+#define CHREFS_CHUNKID_PREFIX_DATA     0x50465844 /* "PFXD" */
+#define CHREFS_CHUNKID_PREFIX_OFFSETS  0x5046584F /* "PFXO" */
+
+static const char *get_nth_prefix(struct snapshot *snapshot,
+				  size_t n, size_t *len)
+{
+	uint64_t offset, next_offset;
+
+	if (n >= snapshot->prefixes_nr)
+		BUG("asking for prefix %"PRIu64" outside of bounds (%"PRIu64")",
+		    (uint64_t)n, (uint64_t)snapshot->prefixes_nr);
+
+	if (n)
+		offset = get_be32(snapshot->prefix_offsets_chunk +
+				  2 * sizeof(uint32_t) * (n - 1));
+	else
+		offset = 0;
+
+	if (len) {
+		next_offset = get_be32(snapshot->prefix_offsets_chunk +
+				       2 * sizeof(uint32_t) * n);
+
+		/* Prefix includes null terminator. */
+		*len = next_offset - offset - 1;
+	}
+
+	return snapshot->prefix_chunk + offset;
+}
+
+/*
+ * Find the place in `snapshot->buf` where the start of the record for
+ * `refname` starts. If `mustexist` is true and the reference doesn't
+ * exist, then return NULL. If `mustexist` is false and the reference
+ * doesn't exist, then return the point where that reference would be
+ * inserted, or `snapshot->eof` (which might be NULL) if it would be
+ * inserted at the end of the file. In the latter mode, `refname`
+ * doesn't have to be a proper reference name; for example, one could
+ * search for "refs/replace/" to find the start of any replace
+ * references.
+ *
+ * The record is sought using a binary search, so `snapshot->buf` must
+ * be sorted.
+ */
+static const char *find_prefix_location(struct snapshot *snapshot,
+					const char *refname, size_t *pos)
+{
+	size_t lo = 0, hi = snapshot->prefixes_nr;
+
+	while (lo != hi) {
+		const char *rec;
+		int cmp;
+		size_t len;
+		size_t mid = lo + (hi - lo) / 2;
+
+		rec = get_nth_prefix(snapshot, mid, &len);
+		cmp = strncmp(rec, refname, len);
+		if (cmp < 0) {
+			lo = mid + 1;
+		} else if (cmp > 0) {
+			hi = mid;
+		} else {
+			/* we have a prefix match! */
+			*pos = mid;
+			return rec;
+		}
+	}
+
+	*pos = lo;
+	if (lo < snapshot->prefixes_nr)
+		return get_nth_prefix(snapshot, lo, NULL);
+	else
+		return NULL;
+}
 
 int detect_packed_format_v2_header(struct packed_ref_store *refs,
 				   struct snapshot *snapshot)
@@ -63,6 +136,46 @@ const char *find_reference_location_v2(struct snapshot *snapshot,
 {
 	size_t lo = 0, hi = snapshot->nr;
 
+	if (snapshot->prefix_chunk) {
+		size_t prefix_row;
+		const char *prefix;
+		int found = 1;
+
+		prefix = find_prefix_location(snapshot, refname, &prefix_row);
+
+		if (!prefix || !starts_with(refname, prefix)) {
+			if (mustexist)
+				return NULL;
+			found = 0;
+		}
+
+		/* The second 4-byte column of the prefix offsets */
+		if (prefix_row) {
+			/* if prefix_row == 0, then lo = 0, which is already true. */
+			lo = get_be32(snapshot->prefix_offsets_chunk +
+				2 * sizeof(uint32_t) * (prefix_row - 1) + sizeof(uint32_t));
+		}
+
+		if (!found) {
+			const char *ret;
+			/* Terminate early with this lo position as the insertion point. */
+			if (pos)
+				*pos = lo;
+
+			if (lo >= snapshot->nr)
+				return NULL;
+
+			ret = get_nth_ref(snapshot, lo);
+			return ret;
+		}
+
+		hi = get_be32(snapshot->prefix_offsets_chunk +
+			      2 * sizeof(uint32_t) * prefix_row + sizeof(uint32_t));
+
+		if (prefix)
+			refname += strlen(prefix);
+	}
+
 	while (lo != hi) {
 		const char *rec;
 		int cmp;
@@ -132,6 +245,16 @@ static int packed_refs_read_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int packed_refs_read_prefix_offsets(const unsigned char *chunk_start,
+					    size_t chunk_size, void *data)
+{
+	struct snapshot *snapshot = data;
+
+	snapshot->prefix_offsets_chunk = chunk_start;
+	snapshot->prefixes_nr = chunk_size / sizeof(uint64_t);
+	return 0;
+}
+
 void fill_snapshot_v2(struct snapshot *snapshot)
 {
 	uint32_t file_signature, file_version, hash_version;
@@ -163,6 +286,9 @@ void fill_snapshot_v2(struct snapshot *snapshot)
 	read_chunk(cf, CHREFS_CHUNKID_OFFSETS, packed_refs_read_offsets, snapshot);
 	pair_chunk(cf, CHREFS_CHUNKID_REFS, (const unsigned char**)&snapshot->refs_chunk);
 
+	read_chunk(cf, CHREFS_CHUNKID_PREFIX_OFFSETS, packed_refs_read_prefix_offsets, snapshot);
+	pair_chunk(cf, CHREFS_CHUNKID_PREFIX_DATA, (const unsigned char**)&snapshot->prefix_chunk);
+
 	/* TODO: add error checks for invalid chunk combinations. */
 
 cleanup:
@@ -187,6 +313,8 @@ int next_record_v2(struct packed_ref_iterator *iter)
 
 	iter->base.flags = REF_ISPACKED;
 
+	if (iter->cur_prefix)
+		strbuf_addstr(&iter->refname_buf, iter->cur_prefix);
 	strbuf_addstr(&iter->refname_buf, pos);
 	iter->base.refname = iter->refname_buf.buf;
 	pos += strlen(pos) + 1;
@@ -221,9 +349,40 @@ int next_record_v2(struct packed_ref_iterator *iter)
 
 	iter->row++;
 
+	if (iter->row == iter->prefix_row_end && iter->snapshot->prefix_chunk) {
+		size_t prefix_pos = get_be32(iter->snapshot->prefix_offsets_chunk +
+					     2 * sizeof(uint32_t) * iter->prefix_i);
+		iter->cur_prefix = iter->snapshot->prefix_chunk + prefix_pos;
+		iter->prefix_i++;
+		iter->prefix_row_end = get_be32(iter->snapshot->prefix_offsets_chunk +
+						2 * sizeof(uint32_t) * iter->prefix_i + sizeof(uint32_t));
+	}
+
 	return ITER_OK;
 }
 
+void init_iterator_prefix_info(const char *prefix,
+			       struct packed_ref_iterator *iter)
+{
+	struct snapshot *snapshot = iter->snapshot;
+
+	if (snapshot->version != 2 || !snapshot->prefix_chunk) {
+		iter->prefix_row_end = snapshot->nr;
+		return;
+	}
+
+	if (prefix)
+		iter->cur_prefix = find_prefix_location(snapshot, prefix, &iter->prefix_i);
+	else {
+		iter->cur_prefix = snapshot->prefix_chunk;
+		iter->prefix_i = 0;
+	}
+
+	iter->prefix_row_end = get_be32(snapshot->prefix_offsets_chunk +
+					2 * sizeof(uint32_t) * iter->prefix_i +
+					sizeof(uint32_t));
+}
+
 struct write_packed_refs_v2_context {
 	struct packed_ref_store *refs;
 	struct string_list *updates;
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5ED01F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeI0CJd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:09:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37310 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeI0CJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:09:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id n6-v6so259459qtl.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wl0aIdR7XAhHlMAIRyIwcuhjCIeJAgM+7pjBg+gs2lE=;
        b=OZ8fEYg3MNcwgUCqM/iuueQQtUh4OIeHC0dwbQp/ltVO9G/JpAPfUptmitf5/v8Mze
         IG8n83G1kIBfQdbrn5IVRb0ViNGjAzkp2/qX/sr19AYBxydvb892KiIy9mHvlnZax/q3
         tdwTYIa8o4SjLqisEEIUXLYxEjngDMTFiL6HJEXzPhAr8itqsBALpOvKG+Di1YZgApQ4
         28a6lqteF71q0XSz6kRsAfA0pdRsCvzFT9OsTVOdZ/2bOqdh4omMFL0t43zjbCI9hJ90
         k3ta4G4MX8l4SQjDE0UiImTc4g6UaN9NkdpkkNsvHUiwXaM6B9dOHECydjm4BaC6ypB2
         ZlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wl0aIdR7XAhHlMAIRyIwcuhjCIeJAgM+7pjBg+gs2lE=;
        b=STFNoc46p/71Q9SRDyfKlrUwEGqWxTFP0dk0KNqQgLNnThywzyTd9liFraVZoofWw1
         frMu/zi6KX9pqZ/vL75Bs7WXGY0grhG0aHwxrwWbhCKjmSvNSWuZdosF4areqKm6TxTd
         KEAJal8a9ZyHphzqgkUSaXp3tcZ/aPcys+h31gOr8s0O5oK4p3m+A58NoGlbSggnYL1W
         PdAOeNG1x3UGyX/c4AyZYAI8J6MMOylT/WeCf05CtT4SFeDrb4rcZMiVys1pdWWTKVGQ
         G8TpamX8G91UL7Hf8nua7xX3iuTPKNCE2aRZ2obX0Lv3oU6yLVBSUcv+kxN24F2TUCAh
         4NJQ==
X-Gm-Message-State: ABuFfojVonqKuvQg+4w739Lp3duinCY1r73OvPpG9INeY6T+uxUMbMqI
        7PbGqT/8DNY1RbmvqYzbWAcKESlY/Ag=
X-Google-Smtp-Source: ACcGV63hvTgyMUCkPNeX6m9Zgfjm0UnXBP/bGV70HPJ8c3VAsSBLg5h0/tlC8EhFt/W1EM+xeH9ckg==
X-Received: by 2002:a0c:bd1e:: with SMTP id m30-v6mr5503376qvg.234.1537991697226;
        Wed, 26 Sep 2018 12:54:57 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 23-v6sm3314922qkn.11.2018.09.26.12.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:54:56 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
Date:   Wed, 26 Sep 2018 15:54:38 -0400
Message-Id: <20180926195442.1380-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The End of Index Entry (EOIE) is used to locate the end of the variable
length index entries and the beginning of the extensions. Code can take
advantage of this to quickly locate the index extensions without having
to parse through all of the index entries.

Because it must be able to be loaded before the variable length cache
entries and other index extensions, this extension must be written last.
The signature for this extension is { 'E', 'O', 'I', 'E' }.

The extension consists of:

- 32-bit offset to the end of the index entries

- 160-bit SHA-1 over the extension types and their sizes (but not
their contents).  E.g. if we have "TREE" extension that is N-bytes
long, "REUC" extension that is M-bytes long, followed by "EOIE",
then the hash would be:

SHA-1("TREE" + <binary representation of N> +
	"REUC" + <binary representation of M>)

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/technical/index-format.txt |  23 ++++
 read-cache.c                             | 151 +++++++++++++++++++++--
 t/README                                 |   5 +
 t/t1700-split-index.sh                   |   1 +
 4 files changed, 172 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index db3572626b..6bc2d90f7f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -314,3 +314,26 @@ The remaining data of each directory block is grouped by type:
 
   - An ewah bitmap, the n-th bit indicates whether the n-th index entry
     is not CE_FSMONITOR_VALID.
+
+== End of Index Entry
+
+  The End of Index Entry (EOIE) is used to locate the end of the variable
+  length index entries and the begining of the extensions. Code can take
+  advantage of this to quickly locate the index extensions without having
+  to parse through all of the index entries.
+
+  Because it must be able to be loaded before the variable length cache
+  entries and other index extensions, this extension must be written last.
+  The signature for this extension is { 'E', 'O', 'I', 'E' }.
+
+  The extension consists of:
+
+  - 32-bit offset to the end of the index entries
+
+  - 160-bit SHA-1 over the extension types and their sizes (but not
+	their contents).  E.g. if we have "TREE" extension that is N-bytes
+	long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	then the hash would be:
+
+	SHA-1("TREE" + <binary representation of N> +
+		"REUC" + <binary representation of M>)
diff --git a/read-cache.c b/read-cache.c
index 6ba99e2c96..80255d3088 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -43,6 +43,7 @@
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
 #define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
+#define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945	/* "EOIE" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1693,6 +1694,9 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_FSMONITOR:
 		read_fsmonitor_extension(istate, data, sz);
 		break;
+	case CACHE_EXT_ENDOFINDEXENTRIES:
+		/* already handled in do_read_index() */
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1883,6 +1887,9 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
 
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -2190,11 +2197,15 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(git_hash_ctx *context, int fd,
-				  unsigned int ext, unsigned int sz)
+static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
+				  int fd, unsigned int ext, unsigned int sz)
 {
 	ext = htonl(ext);
 	sz = htonl(sz);
+	if (eoie_context) {
+		the_hash_algo->update_fn(eoie_context, &ext, 4);
+		the_hash_algo->update_fn(eoie_context, &sz, 4);
+	}
 	return ((ce_write(context, fd, &ext, 4) < 0) ||
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
@@ -2437,7 +2448,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 {
 	uint64_t start = getnanotime();
 	int newfd = tempfile->fd;
-	git_hash_ctx c;
+	git_hash_ctx c, eoie_c;
 	struct cache_header hdr;
 	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
@@ -2446,6 +2457,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
+	off_t offset;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2479,6 +2491,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
 	for (i = 0; i < entries; i++) {
@@ -2512,11 +2525,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return err;
 
 	/* Write extension data here */
+	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	the_hash_algo->init_fn(&eoie_c);
+
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
 
 		err = write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
+			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
 					       sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2527,7 +2543,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2537,7 +2553,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2548,7 +2564,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2559,7 +2575,23 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
-		err = write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
+		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+
+	/*
+	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before the SHA1
+	 * so that it can be found and processed before all the index entries are
+	 * read.
+	 */
+	if (!strip_extensions && offset && !git_env_bool("GIT_TEST_DISABLE_EOIE", 0)) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_eoie_extension(&sb, &eoie_c, offset);
+		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2975,3 +3007,106 @@ int should_validate_cache_entries(void)
 
 	return validate_index_cache_entries;
 }
+
+#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
+#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
+
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
+{
+	/*
+	 * The end of index entries (EOIE) extension is guaranteed to be last
+	 * so that it can be found by scanning backwards from the EOF.
+	 *
+	 * "EOIE"
+	 * <4-byte length>
+	 * <4-byte offset>
+	 * <20-byte hash>
+	 */
+	const char *index, *eoie;
+	uint32_t extsize;
+	size_t offset, src_offset;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	git_hash_ctx c;
+
+	/* ensure we have an index big enough to contain an EOIE extension */
+	if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
+		return 0;
+
+	/* validate the extension signature */
+	index = eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER - the_hash_algo->rawsz;
+	if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
+		return 0;
+	index += sizeof(uint32_t);
+
+	/* validate the extension size */
+	extsize = get_be32(index);
+	if (extsize != EOIE_SIZE)
+		return 0;
+	index += sizeof(uint32_t);
+
+	/*
+	 * Validate the offset we're going to look for the first extension
+	 * signature is after the index header and before the eoie extension.
+	 */
+	offset = get_be32(index);
+	if (mmap + offset < mmap + sizeof(struct cache_header))
+		return 0;
+	if (mmap + offset >= eoie)
+		return 0;
+	index += sizeof(uint32_t);
+
+	/*
+	 * The hash is computed over extension types and their sizes (but not
+	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
+	 * long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	 * then the hash would be:
+	 *
+	 * SHA-1("TREE" + <binary representation of N> +
+	 *	 "REUC" + <binary representation of M>)
+	 */
+	src_offset = offset;
+	the_hash_algo->init_fn(&c);
+	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize;
+		memcpy(&extsize, mmap + src_offset + 4, 4);
+		extsize = ntohl(extsize);
+
+		/* verify the extension size isn't so large it will wrap around */
+		if (src_offset + 8 + extsize < src_offset)
+			return 0;
+
+		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
+
+		src_offset += 8;
+		src_offset += extsize;
+	}
+	the_hash_algo->final_fn(hash, &c);
+	if (hashcmp(hash, (const unsigned char *)index))
+		return 0;
+
+	/* Validate that the extension offsets returned us back to the eoie extension. */
+	if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
+		return 0;
+
+	return offset;
+}
+
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset)
+{
+	uint32_t buffer;
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	/* offset */
+	put_be32(&buffer, offset);
+	strbuf_add(sb, &buffer, sizeof(uint32_t));
+
+	/* hash */
+	the_hash_algo->final_fn(hash, eoie_context);
+	strbuf_add(sb, hash, the_hash_algo->rawsz);
+}
diff --git a/t/README b/t/README
index 3ea6c85460..aa33ac4f26 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,11 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_DISABLE_EOIE=<boolean> disables writing the EOIE extension.
+This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
+as they currently hard code SHA values for the index which are no longer
+valid due to the addition of the EOIE extension.
+
 Naming Tests
 ------------
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index be22398a85..1f168378c8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -7,6 +7,7 @@ test_description='split index mode tests'
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
 sane_unset GIT_FSMONITOR_TEST
+GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.18.0.windows.1


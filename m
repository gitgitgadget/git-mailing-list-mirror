Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF761F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeJAUYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41563 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeJAUYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15-v6so13933999qtp.8
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6U5x9A0j4y1e4FGCxZBipDWjx++zpvs+VCo0Yi425Xs=;
        b=s7mCxF7r1Yx449B+t/1JERGfTBy4Yd044EEXgf2kd6Wvs+2yM+GZmEvlEp9WU9xukf
         +677MPoSyIzzX9R4WM5W+ldNLQbSYh6am9LyRYnkJbp5Q0aLer/7Ky08SNGACxfIGTyM
         vwcIskTzNymFAS7JqErnAkAazV2UWTa0TbFKXSwMJ/8SMzilQjbluW+UBLqzQVRtXm8N
         iYdY86QBHa/d+oaY0AtdX8fSHK1EqV2SbPPjUm3D1PH+C22LSEBXkrpkx6wRZrlF/W02
         87muIcv9Z09AxtKKlEv3LIhPkwYzHdZ6wglQvybRguG0mKvWTeufE704x8+Qdw7ptVob
         lGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6U5x9A0j4y1e4FGCxZBipDWjx++zpvs+VCo0Yi425Xs=;
        b=hfuM9lhuKhaoz9K9neF6ZHEHKB62QOLKu+jhYZISc5UOkHG+SJfxgQzgE0y3UvJFfl
         5fJaRfGtT7ufsrCV8L0unl4DsZGtfGxfKx5nTu3V876REqCwBd8FGpi3/eftGVzTpvbP
         osR3E36VIVkfT+78B6kB6Muh6PzOoQQWPECxI88Kx0ZUdN7HpZzWHlXeUOlDFmJYAhQo
         4zKnOSu/+y90XU9WWsCBKOoUhjcCeukEORanuAz4RCxJzu5M/xtK1u/j/Lg9ZD03lV7V
         7XYi+LV2xLRRyk7dRgmpRrUTm67JgLB09fGN17OjUOOhO5Lw3phRVbRFumVMABqJyikz
         CKLA==
X-Gm-Message-State: ABuFfog3RsNQW1g8HLNMVQMLipB+y7G1ZbUygj/OUczh5ktladrDKrK5
        Rb/Y7F6GryqowMxtYvkWS0RAV6j0as4=
X-Google-Smtp-Source: ACcGV62gZWqsioZ98jGu/LWOs6XkmG/APB8PUMGBfw1sm+dx5hn88C+Sabo9LzFCioXkYiYkTj0hMA==
X-Received: by 2002:ac8:5508:: with SMTP id j8-v6mr8486774qtq.139.1538401574908;
        Mon, 01 Oct 2018 06:46:14 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:14 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 3/7] eoie: add End of Index Entry (EOIE) extension
Date:   Mon,  1 Oct 2018 09:45:52 -0400
Message-Id: <20181001134556.33232-4-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181001134556.33232-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

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

Signed-off-by: Ben Peart <peartben@gmail.com>
---
 Documentation/technical/index-format.txt |  23 ++++
 read-cache.c                             | 152 +++++++++++++++++++++--
 t/t1700-split-index.sh                   |   8 +-
 3 files changed, 171 insertions(+), 12 deletions(-)

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
index 6ba99e2c96..af2605a168 100644
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
@@ -2559,7 +2575,24 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
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
+	 * read.  Write it out regardless of the strip_extensions parameter as we need it
+	 * when loading the shared index.
+	 */
+	if (offset) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_eoie_extension(&sb, &eoie_c, offset);
+		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2975,3 +3008,106 @@ int should_validate_cache_entries(void)
 
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
+	if (!hasheq(hash, (const unsigned char *)index))
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
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index be22398a85..8e17f8e7a0 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -15,11 +15,11 @@ test_expect_success 'enable split index' '
 	indexversion=$(test-tool index-version <.git/index) &&
 	if test "$indexversion" = "4"
 	then
-		own=432ef4b63f32193984f339431fd50ca796493569
-		base=508851a7f0dfa8691e9f69c7f055865389012491
+		own=3527df833c6c100d3d1d921a9a782d62a8be4b58
+		base=746f7ab2ed44fb839efdfbffcf399d0b113fb4cb
 	else
-		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
-		base=39d890139ee5356c7ef572216cebcd27aa41f9df
+		own=5e9b60117ece18da410ddecc8b8d43766a0e4204
+		base=4370042739b31cd17a5c5cd6043a77c9a00df113
 	fi &&
 	cat >expect <<-EOF &&
 	own $own
-- 
2.18.0.windows.1


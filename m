Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24B71F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeJAUYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeJAUYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id v18-v6so8066807qka.10
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wedyn1uD5hwQKhDbezneNp1Lk0KKhL7ndlnKMGbeyVY=;
        b=WQ6cR0efs5z4+maEQbxl7JLGIM7Wgtl7iWaCLzYFMdw61pvyMqyxnpRTNmVnKHmGOZ
         glzS8w7rVYSXUzwfNoAB0ramFNaMR8GYqCHBie/4q+KBXVfCbGjRE1tQ4rkR4vbkfdYG
         Du4ZobsqKJh+dwO0SJC8h+2lmVhFS083qGwcDu6QQqw21Ir3pZ0MO35hwEoQ02TWwHwd
         XY1XGTJcmIl/L0Xg+tc6L86xdbp0mkCvfUNOQfQ/vr6SizIduuU0UynoVqx9nLPdPAMY
         VakWjugn+rxGyKgRFcM7aP2fYJcvAuk5mrTABWtynKyeq1mDrZ+dHH92kNNBxDe885q/
         96CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wedyn1uD5hwQKhDbezneNp1Lk0KKhL7ndlnKMGbeyVY=;
        b=U5NfUg+RqumZvwY3gwqVYrXPzQlBDCgg0uPn8DecbXpky/7Zz5R8+LTVSjPOyhgPTH
         dh+e3/oWLE39fL1Wd0X4OMeesMSKwKb9BdvQWNH2HiYTWQmWAN+kxNi1UjOIKEjbzkIR
         QRsOQVRvxr33OaexBgQ6CakK+/AtubMXleERWVDJS3fdEM583wJEhKK8Fc626m9gf+q6
         cC1gz3viEb5CQYnlcGyF+o9FFvKKEnzv4VW2Ml9p5QiWnmabqVqCMoDGw+8LzhZxBYst
         O5KJ3Wup5DtgMM4H1CPMqLjQvjCbY2TOVonoJTX9jpbN6NWCEXglQAgtAxN7lyrxxtgD
         EwTw==
X-Gm-Message-State: ABuFfogsWi4B8UY8OJQHVmBmkaZ98GbKITslenIQWc9HIryyp2MAA8mE
        ZX13Z3V0tD9Y2sDPCxxpKDIB2oONv+g=
X-Google-Smtp-Source: ACcGV63hCxDurw6NxoTZeG70WlxkoZUjpsaCQ2f19dQtUEKGpJ68risv/EUoQRjaMPK0hz32GFu5vw==
X-Received: by 2002:a37:5c44:: with SMTP id q65-v6mr8449118qkb.97.1538401580712;
        Mon, 01 Oct 2018 06:46:20 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:19 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 6/7] ieot: add Index Entry Offset Table (IEOT) extension
Date:   Mon,  1 Oct 2018 09:45:55 -0400
Message-Id: <20181001134556.33232-7-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181001134556.33232-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This patch enables addressing the CPU cost of loading the index by adding
additional data to the index that will allow us to efficiently multi-
thread the loading and conversion of cache entries.

It accomplishes this by adding an (optional) index extension that is a
table of offsets to blocks of cache entries in the index file.  To make
this work for V4 indexes, when writing the cache entries, it periodically
"resets" the prefix-compression by encoding the current entry as if the
path name for the previous entry is completely different and saves the
offset of that entry in the IEOT.  Basically, with V4 indexes, it
generates offsets into blocks of prefix-compressed entries.

Signed-off-by: Ben Peart <peartben@gmail.com>
---
 Documentation/technical/index-format.txt |  18 +++
 read-cache.c                             | 173 +++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 6bc2d90f7f..7c4d67aa6a 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -337,3 +337,21 @@ The remaining data of each directory block is grouped by type:
 
 	SHA-1("TREE" + <binary representation of N> +
 		"REUC" + <binary representation of M>)
+
+== Index Entry Offset Table
+
+  The Index Entry Offset Table (IEOT) is used to help address the CPU
+  cost of loading the index by enabling multi-threading the process of
+  converting cache entries from the on-disk format to the in-memory format.
+  The signature for this extension is { 'I', 'E', 'O', 'T' }.
+
+  The extension consists of:
+
+  - 32-bit version (currently 1)
+
+  - A number of index offset entries each consisting of:
+
+    - 32-bit offset from the begining of the file to the first cache entry
+	in this block of entries.
+
+    - 32-bit count of cache entries in this block
diff --git a/read-cache.c b/read-cache.c
index 77083ab8bb..9557376e78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -45,6 +45,7 @@
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
 #define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
 #define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945	/* "EOIE" */
+#define CACHE_EXT_INDEXENTRYOFFSETTABLE 0x49454F54 /* "IEOT" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1696,6 +1697,7 @@ static int read_index_extension(struct index_state *istate,
 		read_fsmonitor_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_ENDOFINDEXENTRIES:
+	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
 		/* already handled in do_read_index() */
 		break;
 	default:
@@ -1888,6 +1890,23 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
 
+struct index_entry_offset
+{
+	/* starting byte offset into index file, count of index entries in this block */
+	int offset, nr;
+};
+
+struct index_entry_offset_table
+{
+	int nr;
+	struct index_entry_offset entries[0];
+};
+
+#ifndef NO_PTHREADS
+static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
+static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
+#endif
+
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
@@ -1931,6 +1950,15 @@ static void *load_index_extensions(void *_data)
 	return NULL;
 }
 
+/*
+ * Mostly randomly chosen maximum thread counts: we
+ * cap the parallelism to online_cpus() threads, and we want
+ * to have at least 10000 cache entries per thread for it to
+ * be worth starting a thread.
+ */
+
+#define THREAD_COST		(10000)
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -2523,6 +2551,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
+	int ieot_work = 1;
+	struct index_entry_offset_table *ieot = NULL;
+	int nr;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2556,7 +2587,38 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+#ifndef NO_PTHREADS
+	if ((nr = git_config_get_index_threads()) != 1) {
+		int ieot_blocks, cpus;
+
+		/*
+		 * ensure default number of ieot blocks maps evenly to the
+		 * default number of threads that will process them
+		 */
+		if (!nr) {
+			ieot_blocks = istate->cache_nr / THREAD_COST;
+			cpus = online_cpus();
+			if (ieot_blocks > cpus - 1)
+				ieot_blocks = cpus - 1;
+		} else {
+			ieot_blocks = nr;
+		}
+
+		/*
+		 * no reason to write out the IEOT extension if we don't
+		 * have enough blocks to utilize multi-threading
+		 */
+		if (ieot_blocks > 1) {
+			ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
+				+ (ieot_blocks * sizeof(struct index_entry_offset)));
+			ieot->nr = 0;
+			ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
+		}
+	}
+#endif
+
 	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	nr = 0;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
 	for (i = 0; i < entries; i++) {
@@ -2578,11 +2640,31 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
+		if (ieot && i && (i % ieot_work == 0)) {
+			ieot->entries[ieot->nr].nr = nr;
+			ieot->entries[ieot->nr].offset = offset;
+			ieot->nr++;
+			/*
+			 * If we have a V4 index, set the first byte to an invalid
+			 * character to ensure there is nothing common with the previous
+			 * entry
+			 */
+			if (previous_name)
+				previous_name->buf[0] = 0;
+			nr = 0;
+			offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+		}
 		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
 			break;
+		nr++;
+	}
+	if (ieot && nr) {
+		ieot->entries[ieot->nr].nr = nr;
+		ieot->entries[ieot->nr].offset = offset;
+		ieot->nr++;
 	}
 	strbuf_release(&previous_name_buf);
 
@@ -2593,6 +2675,26 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
 	the_hash_algo->init_fn(&eoie_c);
 
+	/*
+	 * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
+	 * can minimze the number of extensions we have to scan through to
+	 * find it during load.  Write it out regardless of the
+	 * strip_extensions parameter as we need it when loading the shared
+	 * index.
+	 */
+#ifndef NO_PTHREADS
+	if (ieot) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_ieot_extension(&sb, ieot);
+		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+#endif
+
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
 
@@ -3176,3 +3278,74 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 	the_hash_algo->final_fn(hash, eoie_context);
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
+
+#ifndef NO_PTHREADS
+#define IEOT_VERSION	(1)
+
+static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
+{
+       const char *index = NULL;
+       uint32_t extsize, ext_version;
+       struct index_entry_offset_table *ieot;
+       int i, nr;
+
+       /* find the IEOT extension */
+       if (!offset)
+	       return NULL;
+       while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
+	       extsize = get_be32(mmap + offset + 4);
+	       if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
+		       index = mmap + offset + 4 + 4;
+		       break;
+	       }
+	       offset += 8;
+	       offset += extsize;
+       }
+       if (!index)
+	       return NULL;
+
+       /* validate the version is IEOT_VERSION */
+       ext_version = get_be32(index);
+       if (ext_version != IEOT_VERSION)
+	       return NULL;
+       index += sizeof(uint32_t);
+
+       /* extension size - version bytes / bytes per entry */
+       nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
+       if (!nr)
+	       return NULL;
+       ieot = xmalloc(sizeof(struct index_entry_offset_table)
+	       + (nr * sizeof(struct index_entry_offset)));
+       ieot->nr = nr;
+       for (i = 0; i < nr; i++) {
+	       ieot->entries[i].offset = get_be32(index);
+	       index += sizeof(uint32_t);
+	       ieot->entries[i].nr = get_be32(index);
+	       index += sizeof(uint32_t);
+       }
+
+       return ieot;
+}
+
+static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot)
+{
+       uint32_t buffer;
+       int i;
+
+       /* version */
+       put_be32(&buffer, IEOT_VERSION);
+       strbuf_add(sb, &buffer, sizeof(uint32_t));
+
+       /* ieot */
+       for (i = 0; i < ieot->nr; i++) {
+
+	       /* offset */
+	       put_be32(&buffer, ieot->entries[i].offset);
+	       strbuf_add(sb, &buffer, sizeof(uint32_t));
+
+	       /* count */
+	       put_be32(&buffer, ieot->entries[i].nr);
+	       strbuf_add(sb, &buffer, sizeof(uint32_t));
+       }
+}
+#endif
-- 
2.18.0.windows.1


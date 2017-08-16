Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EEE1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdHPUQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:47 -0400
Received: from vie01a-dmta-pe05-1.mx.upcmail.net ([84.116.36.11]:48940 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752437AbdHPUQo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:44 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4k5-0008NP-DD
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:41 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGf1v00o5BuuEg01wGgJp; Wed, 16 Aug 2017 22:16:40 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 48E4745D4622; Wed, 16 Aug 2017 22:16:39 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 02/19] Convert size datatype to size_t
Date:   Wed, 16 Aug 2017 22:16:14 +0200
Message-Id: <1502914591-26215-3-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

It changes the signature of the core object access function
including any other functions to assure a clean compile if
sizeof(size_t) != sizeof(unsigned long).

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 apply.c                  |  6 +++---
 archive-tar.c            |  4 ++--
 archive-zip.c            |  2 +-
 archive.c                |  2 +-
 archive.h                |  2 +-
 blame.c                  |  4 ++--
 blame.h                  |  2 +-
 builtin/cat-file.c       | 14 +++++++-------
 builtin/difftool.c       |  2 +-
 builtin/fast-export.c    |  8 ++++----
 builtin/fmt-merge-msg.c  |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/grep.c           |  8 ++++----
 builtin/index-pack.c     | 16 ++++++++--------
 builtin/log.c            |  4 ++--
 builtin/ls-tree.c        |  4 ++--
 builtin/merge-tree.c     |  6 +++---
 builtin/mktag.c          |  2 +-
 builtin/notes.c          |  6 +++---
 builtin/pack-objects.c   | 24 ++++++++++++-----------
 builtin/reflog.c         |  2 +-
 builtin/tag.c            |  4 ++--
 builtin/unpack-file.c    |  2 +-
 builtin/unpack-objects.c | 14 +++++++-------
 builtin/verify-commit.c  |  2 +-
 bundle.c                 |  2 +-
 cache.h                  | 22 ++++++++++-----------
 combine-diff.c           |  9 +++++----
 commit.c                 |  6 +++---
 config.c                 |  2 +-
 delta.h                  | 26 ++++++++++++-------------
 diff-delta.c             | 16 ++++++++--------
 diff.c                   | 18 ++++++++---------
 diff.h                   |  2 +-
 diffcore.h               |  2 +-
 dir.c                    |  2 +-
 entry.c                  |  4 ++--
 fast-import.c            | 24 +++++++++++------------
 fsck.c                   |  2 +-
 grep.h                   |  2 +-
 http-push.c              |  5 +++--
 mailmap.c                |  2 +-
 match-trees.c            |  4 ++--
 merge-blobs.c            |  6 +++---
 merge-blobs.h            |  2 +-
 merge-recursive.c        |  4 ++--
 notes-cache.c            |  2 +-
 notes-merge.c            |  2 +-
 notes.c                  |  6 +++---
 object.c                 |  2 +-
 pack-check.c             |  2 +-
 pack-objects.h           |  6 +++---
 patch-delta.c            | 11 ++++++-----
 read-cache.c             |  4 ++--
 ref-filter.c             |  4 ++--
 remote-testsvn.c         |  4 ++--
 rerere.c                 |  2 +-
 sha1_file.c              | 50 +++++++++++++++++++++++++-----------------------
 streaming.c              |  8 ++++----
 streaming.h              |  2 +-
 submodule-config.c       |  2 +-
 t/helper/test-delta.c    |  2 +-
 tag.c                    |  4 ++--
 tree-walk.c              |  8 ++++----
 tree.c                   |  2 +-
 xdiff-interface.c        |  2 +-
 66 files changed, 219 insertions(+), 212 deletions(-)

diff --git a/apply.c b/apply.c
index 41ee63e..af9ffee 100644
--- a/apply.c
+++ b/apply.c
@@ -3082,7 +3082,7 @@ static int apply_binary_fragment(struct apply_state *state,
 				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
-	unsigned long len;
+	size_t len;
 	void *dst;
 
 	if (!fragment)
@@ -3171,7 +3171,7 @@ static int apply_binary(struct apply_state *state,
 	if (has_sha1_file(oid.hash)) {
 		/* We already have the postimage */
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *result;
 
 		result = read_sha1_file(oid.hash, &type, &size);
@@ -3233,7 +3233,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		unsigned long sz;
+		size_t sz;
 		char *result;
 
 		result = read_sha1_file(oid->hash, &type, &sz);
diff --git a/archive-tar.c b/archive-tar.c
index c6ed96e..719673d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -115,7 +115,7 @@ static int stream_blocked(const unsigned char *sha1)
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
@@ -240,7 +240,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
 	unsigned int old_mode = mode;
-	unsigned long size, size_in_header;
+	size_t size, size_in_header;
 	void *buffer;
 	int err = 0;
 
diff --git a/archive-zip.c b/archive-zip.c
index e8913e5..4492d64 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -295,7 +295,7 @@ static int write_zip_entry(struct archiver_args *args,
 	void *buffer;
 	struct git_istream *stream = NULL;
 	unsigned long flags = 0;
-	unsigned long size;
+	size_t size;
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
 	unsigned int creator_version = 0;
diff --git a/archive.c b/archive.c
index 557dd2d..92f3960 100644
--- a/archive.c
+++ b/archive.c
@@ -66,7 +66,7 @@ static void format_subst(const struct commit *commit,
 void *sha1_file_to_archive(const struct archiver_args *args,
 			   const char *path, const unsigned char *sha1,
 			   unsigned int mode, enum object_type *type,
-			   unsigned long *sizep)
+			   size_t *sizep)
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
diff --git a/archive.h b/archive.h
index 62d1d82..dd831a3 100644
--- a/archive.h
+++ b/archive.h
@@ -42,6 +42,6 @@ const char *archive_format_from_filename(const char *filename);
 extern void *sha1_file_to_archive(const struct archiver_args *args,
 				  const char *path, const unsigned char *sha1,
 				  unsigned int mode, enum object_type *type,
-				  unsigned long *sizep);
+				  size_t *sizep);
 
 #endif	/* ARCHIVE_H */
diff --git a/blame.c b/blame.c
index f575e9c..739a280 100644
--- a/blame.c
+++ b/blame.c
@@ -193,7 +193,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		struct stat st;
 		const char *read_from;
 		char *buf_ptr;
-		unsigned long buf_len;
+		size_t buf_len;
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -290,7 +290,7 @@ static void fill_origin_blob(struct diff_options *opt,
 {
 	if (!o->file.ptr) {
 		enum object_type type;
-		unsigned long file_size;
+		size_t file_size;
 
 		(*num_read_blob)++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
diff --git a/blame.h b/blame.h
index a6c915c..9a0ed1c 100644
--- a/blame.h
+++ b/blame.h
@@ -111,7 +111,7 @@ struct blame_scoreboard {
 	 * indexed with scoreboard.lineno[blame_entry.lno].
 	 */
 	const char *final_buf;
-	unsigned long final_buf_size;
+	size_t final_buf_size;
 
 	/* linked list of blames */
 	struct blame_entry *ent;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 62c8cf0..045cab5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -27,7 +27,7 @@ static const char *force_path;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
-			 char **buf, unsigned long *size)
+			 char **buf, size_t *size)
 {
 	enum object_type type;
 
@@ -53,7 +53,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	struct object_context obj_context;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -89,7 +89,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		oi.sizep = &size;
 		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
-		printf("%lu\n", size);
+		printf("%" PRIuMAX "\n", (uintmax_t)size);
 		return 0;
 
 	case 'e':
@@ -176,7 +176,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
@@ -232,7 +232,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.sizep = &data->size;
 		else
-			strbuf_addf(sb, "%lu", data->size);
+			strbuf_addf(sb, "%" PRIuMAX, (uintmax_t)data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
@@ -288,7 +288,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			fflush(stdout);
 		if (opt->cmdmode) {
 			char *contents;
-			unsigned long size;
+			size_t size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
@@ -316,7 +316,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 	else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *contents;
 
 		contents = read_sha1_file(oid->hash, &type, &size);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 8864d84..525d4d9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -305,7 +305,7 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 		data = strbuf_detach(&link, NULL);
 	} else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		data = read_sha1_file(oid->hash, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d412c0a..9ef2fc1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -205,7 +205,7 @@ static void show_progress(void)
  * There's no need to cache this result with anonymize_mem, since
  * we already handle blob content caching with marks.
  */
-static char *anonymize_blob(unsigned long *size)
+static char *anonymize_blob(size_t *size)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -216,7 +216,7 @@ static char *anonymize_blob(unsigned long *size)
 
 static void export_blob(const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	struct object *object;
@@ -250,7 +250,7 @@ static void export_blob(const struct object_id *oid)
 
 	mark_next_object(object);
 
-	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\ndata %" PRIuMAX "\n", last_idnum, (uintmax_t)size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die_errno ("Could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
@@ -644,7 +644,7 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs)
 
 static void handle_tag(const char *name, struct tag *tag)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	const char *tagger, *tagger_end, *message;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e99b5dd..61ab796 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -486,7 +486,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i = 0; i < origins.nr; i++) {
 		unsigned char *sha1 = origins.items[i].util;
 		enum object_type type;
-		unsigned long size, len;
+		size_t size, len;
 		char *buf = read_sha1_file(sha1, &type, &size);
 		struct strbuf sig = STRBUF_INIT;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a92f448..635902c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -489,7 +489,7 @@ static struct object *parse_loose_object(const struct object_id *oid,
 	struct object *obj;
 	void *contents;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	int eaten;
 
 	if (read_loose_object(path, oid->hash, &type, &size, &contents) < 0)
diff --git a/builtin/grep.c b/builtin/grep.c
index a70d8e2..b032d24 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -302,7 +302,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, size_t *size)
 {
 	void *data;
 
@@ -437,7 +437,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		struct object *object;
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base = STRBUF_INIT;
 
 		object = parse_object_or_die(oid, oid_to_hex(oid));
@@ -564,7 +564,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			unsigned long size;
+			size_t size;
 
 			data = lock_and_read_oid_file(entry.oid, &type, &size);
 			if (!data)
@@ -600,7 +600,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base;
 		int hit, len;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 26828c1..7f3ccd0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -18,8 +18,8 @@ static const char index_pack_usage[] =
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;
-	unsigned char hdr_size;
+	size_t size;
+	size_t hdr_size;
 	signed char type;
 	signed char real_type;
 };
@@ -34,7 +34,7 @@ struct base_data {
 	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
 };
@@ -219,7 +219,7 @@ static unsigned check_object(struct object *obj)
 		return 0;
 
 	if (!(obj->flags & FLAG_CHECKED)) {
-		unsigned long size;
+		size_t size;
 		int type = sha1_object_info(obj->oid.hash, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
@@ -763,7 +763,7 @@ static int check_collison(struct object_entry *entry)
 {
 	struct compare_data data;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	if (entry->size <= big_file_threshold || entry->type != OBJ_BLOB)
 		return -1;
@@ -807,7 +807,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
-		unsigned long has_size;
+		size_t has_size;
 		read_lock();
 		has_type = sha1_object_info(oid->hash, &has_size);
 		if (has_type < 0)
@@ -1585,9 +1585,9 @@ static void show_pack_info(int stat_only)
 			chain_histogram[obj_stat[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
-		printf("%s %-6s %lu %lu %"PRIuMAX,
+		printf("%s %-6s %" PRIuMAX " %lu %" PRIuMAX,
 		       oid_to_hex(&obj->idx.oid),
-		       typename(obj->real_type), obj->size,
+		       typename(obj->real_type), (uintmax_t)obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
diff --git a/builtin/log.c b/builtin/log.c
index 725c7b8..2330822 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -480,7 +480,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	struct object_id oidc;
 	struct object_context obj_context;
 	char *buf;
-	unsigned long size;
+	size_t size;
 
 	fflush(rev->diffopt.file);
 	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
@@ -506,7 +506,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 
 static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = read_sha1_file(oid->hash, &type, &size);
 	int offset = 0;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef96540..b09d9cb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -93,13 +93,13 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
-				unsigned long size;
+				size_t size;
 				if (sha1_object_info(sha1, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
 				else
 					xsnprintf(size_text, sizeof(size_text),
-						  "%lu", size);
+						  "%" PRIuMAX, (uintmax_t)size);
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
 			printf("%06o %s %s %7s\t", mode, type,
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f12da29..2edbad2 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -53,7 +53,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-static void *result(struct merge_list *entry, unsigned long *size)
+static void *result(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	struct blob *base, *our, *their;
@@ -77,7 +77,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	return merge_blobs(path, base, our, their, size);
 }
 
-static void *origin(struct merge_list *entry, unsigned long *size)
+static void *origin(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	while (entry) {
@@ -98,7 +98,7 @@ static int show_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 
 static void show_diff(struct merge_list *entry)
 {
-	unsigned long size;
+	size_t size;
 	mmfile_t src, dst;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750..0663106 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -22,7 +22,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 {
 	int ret = -1;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buffer = read_sha1_file(sha1, &type, &size);
 	const unsigned char *repl = lookup_replace_object(sha1);
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 4303848..7932a8e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -120,7 +120,7 @@ static int list_each_note(const struct object_id *object_oid,
 
 static void copy_obj_to_fd(int fd, const unsigned char *sha1)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = read_sha1_file(sha1, &type, &size);
 	if (buf) {
@@ -246,7 +246,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	char *buf;
 	struct object_id object;
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
@@ -605,7 +605,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */
-		unsigned long size;
+		size_t size;
 		enum object_type type;
 		char *prev_buf = read_sha1_file(note->hash, &type, &size);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c753e92..d94fd17 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -103,7 +103,7 @@ static void index_commit_for_bitmap(struct commit *commit)
 
 static void *get_delta(struct object_entry *entry)
 {
-	unsigned long size, base_size, delta_size;
+	size_t size, base_size, delta_size;
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
@@ -241,7 +241,7 @@ static void copy_pack_data(struct sha1file *f,
 static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
 					   unsigned long limit, int usable_delta)
 {
-	unsigned long size, datalen;
+	size_t size, datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
@@ -1147,7 +1147,7 @@ static struct pbase_tree_cache *pbase_tree_get(const unsigned char *sha1)
 {
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int neigh;
 	int my_ix = pbase_tree_cache_ix(sha1);
@@ -1330,7 +1330,7 @@ static void add_preferred_base(unsigned char *sha1)
 {
 	struct pbase_tree *it;
 	void *data;
-	unsigned long size;
+	size_t size;
 	unsigned char tree_sha1[20];
 
 	if (window <= num_preferred_base++)
@@ -1805,7 +1805,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
-	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	size_t trg_size, src_size, delta_size, sizediff, max_size, sz;
 	unsigned ref_depth;
 	enum object_type type;
 	void *delta_buf;
@@ -1863,9 +1863,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			die("object %s cannot be read",
 			    oid_to_hex(&trg_entry->idx.oid));
 		if (sz != trg_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
-			    oid_to_hex(&trg_entry->idx.oid), sz,
-			    trg_size);
+			die("object %s inconsistent object length (%" PRIuMAX
+			    " vs %" PRIuMAX ")",
+			    oid_to_hex(&trg_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)trg_size);
 		*mem_usage += sz;
 	}
 	if (!src->data) {
@@ -1891,9 +1892,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			    oid_to_hex(&src_entry->idx.oid));
 		}
 		if (sz != src_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
-			    oid_to_hex(&src_entry->idx.oid), sz,
-			    src_size);
+			die("object %s inconsistent object length (%" PRIuMAX
+			    " vs %" PRIuMAX ")",
+			    oid_to_hex(&src_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)src_size);
 		*mem_usage += sz;
 	}
 	if (!src->index) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index e237d92..7f0382d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -73,7 +73,7 @@ static int tree_is_complete(const struct object_id *oid)
 
 	if (!tree->buffer) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *data = read_sha1_file(oid->hash, &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
diff --git a/builtin/tag.c b/builtin/tag.c
index c627794..864461b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -163,7 +163,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 static void write_tag_body(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf, *sp;
 
@@ -280,7 +280,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	enum object_type type;
 	struct commit *c;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int subject_len = 0;
 	const char *subject_start;
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 281ca1d..16c1431 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -6,7 +6,7 @@ static char *create_temp_file(struct object_id *oid)
 	static char path[50];
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	int fd;
 
 	buf = read_sha1_file(oid->hash, &type, &size);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 689a29f..001dd4b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -196,7 +196,7 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 		die("object type mismatch");
 
 	if (!(obj->flags & FLAG_OPEN)) {
-		unsigned long size;
+		size_t size;
 		int type = sha1_object_info(obj->oid.hash, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
@@ -271,11 +271,11 @@ static void write_object(unsigned nr, enum object_type type,
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
-			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *base, size_t base_size,
+			  void *delta, size_t delta_size)
 {
 	void *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	result = patch_delta(base, base_size,
 			     delta, delta_size,
@@ -322,7 +322,7 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, size_t delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -337,11 +337,11 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 	return 1;
 }
 
-static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
+static void unpack_delta_entry(enum object_type type, size_t delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
-	unsigned long base_size;
+	size_t base_size;
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ba38ac9..ea0857a 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -38,7 +38,7 @@ static int verify_commit(const char *name, unsigned flags)
 	enum object_type type;
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (get_oid(name, &oid))
diff --git a/bundle.c b/bundle.c
index d15db03..c49cb13 100644
--- a/bundle.c
+++ b/bundle.c
@@ -209,7 +209,7 @@ int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
 
 static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = NULL, *line, *lineend;
 	timestamp_t date;
diff --git a/cache.h b/cache.h
index 3c44a25..ee96192 100644
--- a/cache.h
+++ b/cache.h
@@ -1170,8 +1170,8 @@ extern char *xdg_cache_home(const char *filename);
 
 extern void *read_sha1_file_extended(const unsigned char *sha1,
 				     enum object_type *type,
-				     unsigned long *size, int lookup_replace);
-static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+				     size_t *size, int lookup_replace);
+static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, size_t *size)
 {
 	return read_sha1_file_extended(sha1, type, size, 1);
 }
@@ -1196,7 +1196,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 }
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, unsigned long *);
+extern int sha1_object_info(const unsigned char *, size_t *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
@@ -1206,12 +1206,12 @@ extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int parse_sha1_header(const char *hdr, size_t *sizep);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+extern int check_sha1_signature(const unsigned char *sha1, void *buf, size_t size, const char *type);
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
@@ -1227,7 +1227,7 @@ extern int has_sha1_pack(const unsigned char *sha1);
 int read_loose_object(const char *path,
 		      const unsigned char *expected_sha1,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents);
 
 /*
@@ -1405,7 +1405,7 @@ extern int cache_name_stage_compare(const char *name1, int len1, int stage1, con
 
 extern void *read_object_with_reference(const unsigned char *sha1,
 					const char *required_type,
-					unsigned long *size,
+					size_t *size,
 					unsigned char *sha1_ret);
 
 extern struct object *peel_to_type(const char *name, int namelen,
@@ -1730,10 +1730,10 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, size_t *);
+extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 
 /*
  * Iterate over the files in the loose-object parts of the object
@@ -1799,7 +1799,7 @@ extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags)
 struct object_info {
 	/* Request */
 	enum object_type *typep;
-	unsigned long *sizep;
+	size_t *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
diff --git a/combine-diff.c b/combine-diff.c
index 9e163d5..acf39ec 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -285,7 +285,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 }
 
 static char *grab_blob(const struct object_id *oid, unsigned int mode,
-		       unsigned long *size, struct userdiff_driver *textconv,
+		       size_t *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
 	char *blob;
@@ -401,7 +401,7 @@ static void combine_diff(const struct object_id *parent, unsigned int mode,
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
 	struct combine_diff_state state;
-	unsigned long sz;
+	size_t sz;
 
 	if (result_deleted)
 		return; /* result deleted */
@@ -971,7 +971,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
-	unsigned long result_size, cnt, lno;
+	size_t result_size;
+	unsigned long cnt, lno;
 	int result_deleted = 0;
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
@@ -1087,7 +1088,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		is_binary = buffer_is_binary(result, result_size);
 		for (i = 0; !is_binary && i < num_parent; i++) {
 			char *buf;
-			unsigned long size;
+			size_t size;
 			buf = grab_blob(&elem->parent[i].oid,
 					elem->parent[i].mode,
 					&size, NULL, NULL);
diff --git a/commit.c b/commit.c
index 8b28415..22e66b8 100644
--- a/commit.c
+++ b/commit.c
@@ -261,7 +261,7 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	const void *ret = get_cached_commit_buffer(commit, sizep);
 	if (!ret) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		ret = read_sha1_file(commit->object.oid.hash, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
@@ -372,7 +372,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (!item)
@@ -1203,7 +1203,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
 	char *buf;
-	unsigned long size, len;
+	size_t size, len;
 	enum object_type type;
 
 	desc = merge_remote_util(parent);
diff --git a/config.c b/config.c
index c145073..bf4e2e4 100644
--- a/config.c
+++ b/config.c
@@ -1471,7 +1471,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	buf = read_sha1_file(oid->hash, &type, &size);
diff --git a/delta.h b/delta.h
index 9b67531..2df0f55 100644
--- a/delta.h
+++ b/delta.h
@@ -14,7 +14,7 @@ struct delta_index;
  * using free_delta_index().
  */
 extern struct delta_index *
-create_delta_index(const void *buf, unsigned long bufsize);
+create_delta_index(const void *buf, size_t bufsize);
 
 /*
  * free_delta_index: free the index created by create_delta_index()
@@ -28,7 +28,7 @@ extern void free_delta_index(struct delta_index *index);
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-extern unsigned long sizeof_delta_index(struct delta_index *index);
+extern size_t sizeof_delta_index(struct delta_index *index);
 
 /*
  * create_delta: create a delta from given index for the given buffer
@@ -42,8 +42,8 @@ extern unsigned long sizeof_delta_index(struct delta_index *index);
  */
 extern void *
 create_delta(const struct delta_index *index,
-	     const void *buf, unsigned long bufsize,
-	     unsigned long *delta_size, unsigned long max_delta_size);
+	     const void *buf, size_t bufsize,
+	     size_t *delta_size, size_t max_delta_size);
 
 /*
  * diff_delta: create a delta from source buffer to target buffer
@@ -54,9 +54,9 @@ create_delta(const struct delta_index *index,
  * updated with its size.  The returned buffer must be freed by the caller.
  */
 static inline void *
-diff_delta(const void *src_buf, unsigned long src_bufsize,
-	   const void *trg_buf, unsigned long trg_bufsize,
-	   unsigned long *delta_size, unsigned long max_delta_size)
+diff_delta(const void *src_buf, size_t src_bufsize,
+	   const void *trg_buf, size_t trg_bufsize,
+	   size_t *delta_size, size_t max_delta_size)
 {
 	struct delta_index *index = create_delta_index(src_buf, src_bufsize);
 	if (index) {
@@ -75,9 +75,9 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-extern void *patch_delta(const void *src_buf, unsigned long src_size,
-			 const void *delta_buf, unsigned long delta_size,
-			 unsigned long *dst_size);
+extern void *patch_delta(const void *src_buf, size_t src_size,
+			 const void *delta_buf, size_t delta_size,
+			 size_t *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
@@ -86,11 +86,11 @@ extern void *patch_delta(const void *src_buf, unsigned long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
+static inline size_t get_delta_hdr_size(const unsigned char **datap,
+					const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned long cmd, size = 0;
+	size_t cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
diff --git a/diff-delta.c b/diff-delta.c
index db27c1a..dffbab1 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -123,14 +123,14 @@ struct unpacked_index_entry {
 };
 
 struct delta_index {
-	unsigned long memsize;
+	size_t memsize;
 	const void *src_buf;
-	unsigned long src_size;
+	size_t src_size;
 	unsigned int hash_mask;
 	struct index_entry *hash[FLEX_ARRAY];
 };
 
-struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
+struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
@@ -138,7 +138,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	struct unpacked_index_entry *entry, **hash;
 	struct index_entry *packed_entry, **packed_hash;
 	void *mem;
-	unsigned long memsize;
+	size_t memsize;
 
 	if (!buf || !bufsize)
 		return NULL;
@@ -300,7 +300,7 @@ void free_delta_index(struct delta_index *index)
 	free(index);
 }
 
-unsigned long sizeof_delta_index(struct delta_index *index)
+size_t sizeof_delta_index(struct delta_index *index)
 {
 	if (index)
 		return index->memsize;
@@ -316,8 +316,8 @@ unsigned long sizeof_delta_index(struct delta_index *index)
 
 void *
 create_delta(const struct delta_index *index,
-	     const void *trg_buf, unsigned long trg_size,
-	     unsigned long *delta_size, unsigned long max_size)
+	     const void *trg_buf, size_t trg_size,
+	     size_t *delta_size, size_t max_size)
 {
 	unsigned int i, val;
 	size_t l, outpos, moff, outsize, msize;
@@ -406,7 +406,7 @@ create_delta(const struct delta_index *index,
 			}
 			msize = 0;
 		} else {
-			unsigned int left;
+			size_t left;
 			unsigned char *op;
 
 			if (inscnt) {
diff --git a/diff.c b/diff.c
index 9c38258..c12d062 100644
--- a/diff.c
+++ b/diff.c
@@ -2200,8 +2200,8 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 }
 
 static unsigned char *deflate_it(char *data,
-				 unsigned long size,
-				 unsigned long *result_size)
+				 size_t size,
+				 size_t *result_size)
 {
 	int bound;
 	unsigned char *deflated;
@@ -2229,10 +2229,10 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	void *delta;
 	void *deflated;
 	void *data;
-	unsigned long orig_size;
-	unsigned long delta_size;
-	unsigned long deflate_size;
-	unsigned long data_size;
+	size_t orig_size;
+	size_t delta_size;
+	size_t deflate_size;
+	size_t data_size;
 
 	/* We could do deflated delta, or we could do just deflated two,
 	 * whichever is smaller.
@@ -2252,13 +2252,13 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		fprintf(file, "%sdelta %" PRIuMAX "\n", prefix, (uintmax_t)orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
 	}
 	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+		fprintf(file, "%sliteral %" PRIuMAX "\n", prefix, (uintmax_t)two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -5267,7 +5267,7 @@ int textconv_object(const char *path,
 		    const struct object_id *oid,
 		    int oid_valid,
 		    char **buf,
-		    unsigned long *buf_size)
+		    size_t *buf_size)
 {
 	struct diff_filespec *df;
 	struct userdiff_driver *textconv;
diff --git a/diff.h b/diff.h
index 2d442e2..0901822 100644
--- a/diff.h
+++ b/diff.h
@@ -390,7 +390,7 @@ extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
  * if the textconv driver exists.
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
-extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
+extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, size_t *buf_size);
 
 extern int parse_rename_score(const char **cp_p);
 
diff --git a/diffcore.h b/diffcore.h
index a30da16..8ad1823 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -29,7 +29,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	unsigned long size;
+	size_t size;
 	int count;               /* Reference count */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
diff --git a/dir.c b/dir.c
index 1c55dc3..f161c26 100644
--- a/dir.c
+++ b/dir.c
@@ -605,7 +605,7 @@ static void *read_skip_worktree_file_from_index(const struct index_state *istate
 						struct sha1_stat *sha1_stat)
 {
 	int pos, len;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *data;
 
diff --git a/entry.c b/entry.c
index 65458f0..6db2d2e 100644
--- a/entry.c
+++ b/entry.c
@@ -80,7 +80,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+static void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
 	void *new = read_sha1_file(ce->oid.hash, &type, size);
@@ -243,7 +243,7 @@ static int write_entry(struct cache_entry *ce,
 	int fd, ret, fstat_done = 0;
 	char *new;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	size_t wrote, newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
diff --git a/fast-import.c b/fast-import.c
index a959161..334cabf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1090,7 +1090,7 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	size_t hdrlen, deltalen;
 	git_SHA_CTX c;
 	git_zstream s;
 
@@ -1345,7 +1345,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
  */
 static void *gfi_unpack_entry(
 	struct object_entry *oe,
-	unsigned long *sizep)
+	size_t *sizep)
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
@@ -1391,7 +1391,7 @@ static void load_tree(struct tree_entry *root)
 	struct object_id *oid = &root->versions[1].oid;
 	struct object_entry *myoe;
 	struct tree_content *t;
-	unsigned long size;
+	size_t size;
 	char *buf;
 	const char *c;
 
@@ -2579,7 +2579,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
-		unsigned long size;
+		size_t size;
 		char *buf = read_object_with_reference(commit_oid.hash,
 			commit_type, &size, commit_oid.hash);
 		if (!buf || size < 46)
@@ -2647,7 +2647,7 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[0].oid);
 		oidclr(&b->branch_tree.versions[1].oid);
 	} else {
-		unsigned long size;
+		size_t size;
 		char *buf;
 
 		buf = read_object_with_reference(b->oid.hash,
@@ -2685,7 +2685,7 @@ static int parse_from(struct branch *b)
 		if (oidcmp(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
-				unsigned long size;
+				size_t size;
 				char *buf = gfi_unpack_entry(oe, &size);
 				parse_from_commit(b, buf, size);
 				free(buf);
@@ -2728,7 +2728,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
-			unsigned long size;
+			size_t size;
 			char *buf = read_object_with_reference(n->oid.hash,
 				commit_type, &size, n->oid.hash);
 			if (!buf || size < 46)
@@ -2958,7 +2958,7 @@ static void cat_blob_write(const char *buf, unsigned long size)
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line = STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	enum object_type type = 0;
 	char *buf;
 
@@ -2986,8 +2986,8 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		die("Object %s is a %s but a blob was expected.",
 		    oid_to_hex(oid), typename(type));
 	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", oid_to_hex(oid),
-						typename(type), size);
+	strbuf_addf(&line, "%s %s %" PRIuMAX "\n", oid_to_hex(oid),
+		    typename(type), (uintmax_t)size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
@@ -3042,7 +3042,7 @@ static void parse_cat_blob(const char *p)
 static struct object_entry *dereference(struct object_entry *oe,
 					struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	char *buf = NULL;
 	if (!oe) {
 		enum object_type type = sha1_object_info(oid->hash, NULL);
@@ -3538,7 +3538,7 @@ int cmd_main(int argc, const char **argv)
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
 		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (uintmax_t)(total_allocd + alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_allocd/1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
diff --git a/fsck.c b/fsck.c
index 2d2d2e9..feca3a8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -796,7 +796,7 @@ static int fsck_commit(struct commit *commit, const char *data,
 }
 
 static int fsck_tag_buffer(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	unsigned char sha1[20];
 	int ret = 0;
diff --git a/grep.h b/grep.h
index 52aecfa..f810a93 100644
--- a/grep.h
+++ b/grep.h
@@ -197,7 +197,7 @@ struct grep_source {
 	void *identifier;
 
 	char *buf;
-	unsigned long size;
+	size_t size;
 
 	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
diff --git a/http-push.c b/http-push.c
index c91f40a..4c06802 100644
--- a/http-push.c
+++ b/http-push.c
@@ -355,13 +355,14 @@ static void start_put(struct transfer_request *request)
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
-	unsigned long len;
+	size_t len;
 	int hdrlen;
 	ssize_t size;
 	git_zstream stream;
 
 	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(type), (uintmax_t)len) + 1;
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/mailmap.c b/mailmap.c
index cb921b4..323bbef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ static int read_mailmap_blob(struct string_list *map,
 {
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (!name)
diff --git a/match-trees.c b/match-trees.c
index 396b733..d4b7c1e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -52,7 +52,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 {
 	void *buffer;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	buffer = read_sha1_file(hash->hash, &type, &size);
 	if (!buffer)
@@ -169,7 +169,7 @@ static int splice_tree(const unsigned char *hash1,
 	char *subpath;
 	int toplen;
 	char *buf;
-	unsigned long sz;
+	size_t sz;
 	struct tree_desc desc;
 	unsigned char *rewrite_here;
 	const unsigned char *rewrite_with;
diff --git a/merge-blobs.c b/merge-blobs.c
index 9b6eac2..f7e55c4 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -8,7 +8,7 @@
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	buf = read_sha1_file(obj->object.oid.hash, &type, &size);
@@ -28,7 +28,7 @@ static void free_mmfile(mmfile_t *f)
 	free(f->ptr);
 }
 
-static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, size_t *size)
 {
 	int merge_status;
 	mmbuffer_t res;
@@ -48,7 +48,7 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	return res.ptr;
 }
 
-void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, size_t *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
diff --git a/merge-blobs.h b/merge-blobs.h
index 62b569e..e66eee7 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -3,6 +3,6 @@
 
 #include "blob.h"
 
-extern void *merge_blobs(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
+extern void *merge_blobs(const char *, struct blob *, struct blob *, struct blob *, size_t *);
 
 #endif /* MERGE_BLOBS_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffd..e6b547c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -787,7 +787,7 @@ static int update_file_flags(struct merge_options *o,
 	if (update_wd) {
 		enum object_type type;
 		void *buf;
-		unsigned long size;
+		size_t size;
 
 		if (S_ISGITLINK(mode)) {
 			/*
@@ -1602,7 +1602,7 @@ static int read_oid_strbuf(struct merge_options *o,
 {
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
 		return err(o, _("cannot read object %s"), oid_to_hex(oid));
diff --git a/notes-cache.c b/notes-cache.c
index 29b4ced..df86765 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -72,7 +72,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	const struct object_id *value_oid;
 	enum object_type type;
 	char *value;
-	unsigned long size;
+	size_t size;
 
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
diff --git a/notes-merge.c b/notes-merge.c
index c12b354..b1bf7ff 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -323,7 +323,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 				   const struct object_id *note)
 {
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buf = read_sha1_file(note->hash, &type, &size);
 
 	if (!buf)
diff --git a/notes.c b/notes.c
index 503754d..5b9bb96 100644
--- a/notes.c
+++ b/notes.c
@@ -808,7 +808,7 @@ int combine_notes_concatenate(unsigned char *cur_sha1,
 		const unsigned char *new_sha1)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
-	unsigned long cur_len, new_len, buf_len;
+	size_t cur_len, new_len, buf_len;
 	enum object_type cur_type, new_type;
 	int ret;
 
@@ -869,7 +869,7 @@ static int string_list_add_note_lines(struct string_list *list,
 				      const unsigned char *sha1)
 {
 	char *data;
-	unsigned long len;
+	size_t len;
 	enum object_type t;
 
 	if (is_null_sha1(sha1))
@@ -1222,7 +1222,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
 	char *msg, *msg_p;
-	unsigned long linelen, msglen;
+	size_t linelen, msglen;
 	enum object_type type;
 
 	if (!t)
diff --git a/object.c b/object.c
index 321d7e9..dff9f52 100644
--- a/object.c
+++ b/object.c
@@ -241,7 +241,7 @@ struct object *parse_object_or_die(const struct object_id *oid,
 
 struct object *parse_object(const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int eaten;
 	const unsigned char *repl = lookup_replace_object(oid->hash);
diff --git a/pack-check.c b/pack-check.c
index e1fcb22..6f7714f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -104,7 +104,7 @@ static int verify_packfile(struct packed_git *p,
 	for (i = 0; i < nr_objects; i++) {
 		void *data;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		off_t curpos;
 		int data_valid;
 
diff --git a/pack-objects.h b/pack-objects.h
index 03f1191..3a2cf4e 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,7 +3,7 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
+	size_t size;	/* uncompressed size */
 	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
@@ -12,8 +12,8 @@ struct object_entry {
 					     * uses the same base as me
 					     */
 	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
+	size_t delta_size;	/* delta data size (uncompressed) */
+	size_t z_delta_size;	/* delta data size (compressed) */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
diff --git a/patch-delta.c b/patch-delta.c
index 56e0a5e..8b2fa20 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "delta.h"
 
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size)
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size)
 {
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
-	unsigned long size;
+	size_t size;
 
 	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
@@ -39,7 +39,8 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 	while (data < top) {
 		cmd = *data++;
 		if (cmd & 0x80) {
-			unsigned long cp_off = 0, cp_size = 0;
+			off_t cp_off = 0;
+			size_t cp_size = 0;
 			if (cmd & 0x01) cp_off = *data++;
 			if (cmd & 0x02) cp_off |= (*data++ << 8);
 			if (cmd & 0x04) cp_off |= (*data++ << 16);
diff --git a/read-cache.c b/read-cache.c
index acfb028..854a5d6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -172,7 +172,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 {
 	int match = -1;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2583,7 +2583,7 @@ void *read_blob_data_from_index(const struct index_state *istate,
 				const char *path, unsigned long *size)
 {
 	int pos, len;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *data;
 
diff --git a/ref-filter.c b/ref-filter.c
index bc591f4..5c903a5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -692,7 +692,7 @@ int verify_ref_format(struct ref_format *format)
  * by the "struct object" representation, set *eaten as well---it is a
  * signal from parse_object_buffer to us not to free the buffer.
  */
-static void *get_obj(const struct object_id *oid, struct object **obj, unsigned long *sz, int *eaten)
+static void *get_obj(const struct object_id *oid, struct object **obj, size_t *sz, int *eaten)
 {
 	enum object_type type;
 	void *buf = read_sha1_file(oid->hash, &type, sz);
@@ -1311,7 +1311,7 @@ static void populate_value(struct ref_array_item *ref)
 	void *buf;
 	struct object *obj;
 	int eaten, i;
-	unsigned long size;
+	size_t size;
 	const struct object_id *tagged;
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 0ff4a31..08748ca 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -55,7 +55,7 @@ static char *read_ref_note(const struct object_id *oid)
 {
 	const struct object_id *note_oid;
 	char *msg = NULL;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;
 
 	init_notes(NULL, notes_ref, NULL, 0);
@@ -104,7 +104,7 @@ static int note2mark_cb(const struct object_id *object_oid,
 {
 	FILE *file = (FILE *)cb_data;
 	char *msg;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;
 	struct rev_note note;
 
diff --git a/rerere.c b/rerere.c
index 70634d4..41852f0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -974,7 +974,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 
 	while (pos < active_nr) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 
 		ce = active_cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15..97b39b0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1631,7 +1631,7 @@ static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
  * the streaming interface and rehash it to do the same.
  */
 int check_sha1_signature(const unsigned char *sha1, void *map,
-			 unsigned long size, const char *type)
+			 size_t size, const char *type)
 {
 	unsigned char real_sha1[20];
 	enum object_type obj_type;
@@ -1650,7 +1650,8 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(obj_type), (uintmax_t)size) + 1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -1795,11 +1796,11 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+		unsigned long len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
-	unsigned long used = 0;
+	size_t size, c;
+	size_t used = 0;
 
 	c = buf[used++];
 	*type = (c >> 4) & 7;
@@ -1997,7 +1998,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }
 
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header(const char *hdr, size_t *sizep)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 
@@ -2118,7 +2119,7 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	unsigned char *base;
 	unsigned long left;
@@ -2171,7 +2172,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
-		unsigned long size;
+		size_t size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -2306,7 +2307,7 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type)
+	size_t *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
 
@@ -2370,7 +2371,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		       struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
+	size_t size;
 	off_t curpos = obj_offset;
 	enum object_type type;
 
@@ -2484,7 +2485,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size);
+			 size_t *size);
 
 static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
 {
@@ -2503,12 +2504,12 @@ struct unpack_entry_stack_ent {
 };
 
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
+		   enum object_type *final_type, size_t *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
 	void *data = NULL;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
@@ -2608,7 +2609,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		void *delta_data;
 		void *base = data;
 		void *external_base = NULL;
-		unsigned long delta_size, base_size = size;
+		size_t delta_size, base_size = size;
 		int i;
 
 		data = NULL;
@@ -2913,7 +2914,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	git_zstream stream;
 	char hdr[32];
 	struct strbuf hdrbuf = STRBUF_INIT;
-	unsigned long size_scratch;
+	size_t size_scratch;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -3050,7 +3051,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 }
 
 /* returns enum object_type or negative */
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+int sha1_object_info(const unsigned char *sha1, size_t *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -3064,7 +3065,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 }
 
 static void *read_packed_sha1(const unsigned char *sha1,
-			      enum object_type *type, unsigned long *size)
+			      enum object_type *type, size_t *size)
 {
 	struct pack_entry e;
 	void *data;
@@ -3106,7 +3107,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size)
+			 size_t *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -3126,7 +3127,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
  */
 void *read_sha1_file_extended(const unsigned char *sha1,
 			      enum object_type *type,
-			      unsigned long *size,
+			      size_t *size,
 			      int lookup_replace)
 {
 	void *data;
@@ -3162,12 +3163,12 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 
 void *read_object_with_reference(const unsigned char *sha1,
 				 const char *required_type_name,
-				 unsigned long *size,
+				 size_t *size,
 				 unsigned char *actual_sha1_return)
 {
 	enum object_type type, required_type;
 	void *buffer;
-	unsigned long isize;
+	size_t isize;
 	unsigned char actual_sha1[20];
 
 	required_type = type_from_string(required_type_name);
@@ -3461,7 +3462,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 int force_object_loose(const unsigned char *sha1, time_t mtime)
 {
 	void *buf;
-	unsigned long len;
+	size_t len;
 	enum object_type type;
 	char hdr[32];
 	int hdrlen;
@@ -3472,7 +3473,8 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	buf = read_packed_sha1(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX,
+			   typename(type), (uintmax_t)len) + 1;
 	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
@@ -3985,7 +3987,7 @@ static int check_stream_sha1(git_zstream *stream,
 int read_loose_object(const char *path,
 		      const unsigned char *expected_sha1,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents)
 {
 	int ret = -1;
diff --git a/streaming.c b/streaming.c
index 9afa66b..04a8b99 100644
--- a/streaming.c
+++ b/streaming.c
@@ -65,7 +65,7 @@ struct filtered_istream {
 
 struct git_istream {
 	const struct stream_vtbl *vtbl;
-	unsigned long size; /* inflated size of full object */
+	size_t size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
@@ -108,7 +108,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 					enum object_type *type,
 					struct object_info *oi)
 {
-	unsigned long size;
+	size_t size;
 	int status;
 
 	oi->typep = type;
@@ -131,7 +131,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 struct git_istream *open_istream(const unsigned char *sha1,
 				 enum object_type *type,
-				 unsigned long *size,
+				 size_t *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
@@ -502,7 +502,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	ssize_t kept = 0;
 	int result = -1;
 
diff --git a/streaming.h b/streaming.h
index 73c1d15..49f42c3 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,7 @@
 /* opaque */
 struct git_istream;
 
-extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
+extern struct git_istream *open_istream(const unsigned char *, enum object_type *, size_t *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
diff --git a/submodule-config.c b/submodule-config.c
index 2b83c23..fa385e6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -482,7 +482,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
-	unsigned long config_size;
+	size_t config_size;
 	char *config = NULL;
 	struct object_id oid;
 	enum object_type type;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 59937dc..6524fbd 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -20,7 +20,7 @@ int cmd_main(int argc, const char **argv)
 	int fd;
 	struct stat st;
 	void *from_buf, *data_buf, *out_buf;
-	unsigned long from_size, data_size, out_size;
+	size_t from_size, data_size, out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
diff --git a/tag.c b/tag.c
index 7e10acf..b6bb5ea 100644
--- a/tag.c
+++ b/tag.c
@@ -38,7 +38,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	type = sha1_object_info(oid->hash, NULL);
@@ -177,7 +177,7 @@ int parse_tag(struct tag *item)
 {
 	enum object_type type;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (item->object.parsed)
diff --git a/tree-walk.c b/tree-walk.c
index 6a42e40..7c9f9e3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -80,7 +80,7 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned l
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 {
-	unsigned long size = 0;
+	size_t size = 0;
 	void *buf = NULL;
 
 	if (sha1) {
@@ -530,7 +530,7 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 {
 	int retval;
 	void *tree;
-	unsigned long size;
+	size_t size;
 	unsigned char root[20];
 
 	tree = read_object_with_reference(tree_sha1, tree_type, &size, root);
@@ -600,7 +600,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 		if (!t.buffer) {
 			void *tree;
 			unsigned char root[20];
-			unsigned long size;
+			size_t size;
 			tree = read_object_with_reference(current_tree_sha1,
 							  tree_type, &size,
 							  root);
@@ -696,7 +696,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			goto done;
 		} else if (S_ISLNK(*mode)) {
 			/* Follow a symlink */
-			unsigned long link_len;
+			size_t link_len;
 			size_t len;
 			char *contents, *contents_start;
 			struct dir_state *parent;
diff --git a/tree.c b/tree.c
index b224115..5e42f83 100644
--- a/tree.c
+++ b/tree.c
@@ -215,7 +215,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
-	 unsigned long size;
+	 size_t size;
 
 	if (item->object.parsed)
 		return 0;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 018e033..d82cd4a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -181,7 +181,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (!oidcmp(oid, &null_oid)) {
-- 
2.1.4


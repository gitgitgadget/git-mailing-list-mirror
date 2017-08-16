Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183D81F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbdHPURn (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:43 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:47990 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752535AbdHPUQp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:45 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4k8-0004LY-0M
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:44 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGg1v01c5BuuEg01wGhLE; Wed, 16 Aug 2017 22:16:42 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id C7CE145D4622; Wed, 16 Aug 2017 22:16:40 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 05/19] Convert sha1_file.c to size_t
Date:   Wed, 16 Aug 2017 22:16:17 +0200
Message-Id: <1502914591-26215-6-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 cache.h     | 16 +++++++--------
 sha1_file.c | 68 ++++++++++++++++++++++++++++++-------------------------------
 streaming.c |  2 +-
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/cache.h b/cache.h
index 5c85844..681dcb6 100644
--- a/cache.h
+++ b/cache.h
@@ -1197,15 +1197,15 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, size_t *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
-extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+extern int hash_sha1_file(const void *buf, size_t len, const char *type, unsigned char *sha1);
+extern int write_sha1_file(const void *buf, size_t len, const char *type, unsigned char *return_sha1);
+extern int hash_sha1_file_literally(const void *buf, size_t len, const char *type, unsigned char *sha1, unsigned flags);
+extern int pretend_sha1_file(void *, size_t, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
-extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+extern void *map_sha1_file(const unsigned char *sha1, size_t *size);
+extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, size_t mapsize, void *buffer, size_t bufsiz);
 extern int parse_sha1_header(const char *hdr, size_t *sizep);
 
 /* global flag to enable extra checks when accessing packed objects */
@@ -1731,8 +1731,8 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, size_t *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+extern size_t unpack_object_header_buffer(const unsigned char *buf, size_t len, enum object_type *type, size_t *sizep);
+extern size_t get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 3428172..1b3efea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -51,7 +51,7 @@ static struct cached_object {
 	unsigned char sha1[20];
 	enum object_type type;
 	void *buf;
-	unsigned long size;
+	size_t size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
@@ -818,8 +818,8 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
-		unsigned long max_size = min_size;
+		size_t min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
+		size_t max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size) {
@@ -1763,7 +1763,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
  */
 static void *map_sha1_file_1(const char *path,
 			     const unsigned char *sha1,
-			     unsigned long *size)
+			     size_t *size)
 {
 	void *map;
 	int fd;
@@ -1790,13 +1790,13 @@ static void *map_sha1_file_1(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(const unsigned char *sha1, size_t *size)
 {
 	return map_sha1_file_1(NULL, sha1, size);
 }
 
-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, size_t *sizep)
+size_t unpack_object_header_buffer(const unsigned char *buf,
+				   size_t len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
 	size_t size, c;
@@ -1821,8 +1821,8 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-				    unsigned char *map, unsigned long mapsize,
-				    void *buffer, unsigned long bufsiz)
+				    unsigned char *map, size_t mapsize,
+				    void *buffer, size_t bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1836,8 +1836,8 @@ static int unpack_sha1_short_header(git_zstream *stream,
 }
 
 int unpack_sha1_header(git_zstream *stream,
-		       unsigned char *map, unsigned long mapsize,
-		       void *buffer, unsigned long bufsiz)
+		       unsigned char *map, size_t mapsize,
+		       void *buffer, size_t bufsiz)
 {
 	int status = unpack_sha1_short_header(stream, map, mapsize,
 					      buffer, bufsiz);
@@ -1852,8 +1852,8 @@ int unpack_sha1_header(git_zstream *stream,
 }
 
 static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					unsigned long mapsize, void *buffer,
-					unsigned long bufsiz, struct strbuf *header)
+					size_t mapsize, void *buffer,
+					size_t bufsiz, struct strbuf *header)
 {
 	int status;
 
@@ -1887,11 +1887,11 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	return -1;
 }
 
-static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_sha1_rest(git_zstream *stream, void *buffer, size_t size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
-	unsigned long n;
+	size_t n;
 	int status = Z_OK;
 
 	n = stream->total_out - bytes;
@@ -1941,7 +1941,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 			       unsigned int flags)
 {
 	const char *type_buf = hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len = 0;
 
 	/*
@@ -2006,9 +2006,9 @@ int parse_sha1_header(const char *hdr, size_t *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-			          off_t curpos)
+size_t get_size_from_delta(struct packed_git *p,
+			   struct pack_window **w_curs,
+			   off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -2242,7 +2242,7 @@ struct delta_base_cache_entry {
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 };
 
@@ -2339,7 +2339,7 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+	void *base, size_t base_size, enum object_type type)
 {
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
@@ -2453,7 +2453,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    size_t size)
 {
 	int st;
 	git_zstream stream;
@@ -2500,7 +2500,7 @@ int do_check_packed_object_crc;
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
 	off_t curpos;
-	unsigned long size;
+	size_t size;
 };
 
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
@@ -2909,7 +2909,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 				  int flags)
 {
 	int status = 0;
-	unsigned long mapsize;
+	size_t mapsize;
 	void *map;
 	git_zstream stream;
 	char hdr[32];
@@ -3088,7 +3088,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	return data;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
+int pretend_sha1_file(void *buf, size_t len, enum object_type type,
 		      unsigned char *sha1)
 {
 	struct cached_object *co;
@@ -3209,14 +3209,14 @@ void *read_object_with_reference(const unsigned char *sha1,
 	}
 }
 
-static void write_sha1_file_prepare(const void *buf, unsigned long len,
+static void write_sha1_file_prepare(const void *buf, size_t len,
                                     const char *type, unsigned char *sha1,
                                     char *hdr, int *hdrlen)
 {
 	git_SHA_CTX c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %lu", type, len)+1;
+	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %" PRIuMAX, type, (uintmax_t)len)+1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
@@ -3275,7 +3275,7 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_sha1_file(const void *buf, unsigned long len, const char *type,
+int hash_sha1_file(const void *buf, size_t len, const char *type,
                    unsigned char *sha1)
 {
 	char hdr[32];
@@ -3339,7 +3339,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 }
 
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      const void *buf, unsigned long len, time_t mtime)
+			      const void *buf, size_t len, time_t mtime)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -3423,7 +3423,7 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
+int write_sha1_file(const void *buf, size_t len, const char *type, unsigned char *sha1)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
@@ -3437,7 +3437,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
 
-int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
+int hash_sha1_file_literally(const void *buf, size_t len, const char *type,
 			     unsigned char *sha1, unsigned flags)
 {
 	char *header;
@@ -3929,14 +3929,14 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
-			     unsigned long size,
+			     size_t size,
 			     const char *path,
 			     const unsigned char *expected_sha1)
 {
 	git_SHA_CTX c;
 	unsigned char real_sha1[GIT_MAX_RAWSZ];
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status = Z_OK;
 
 	git_SHA1_Init(&c);
@@ -3992,7 +3992,7 @@ int read_loose_object(const char *path,
 {
 	int ret = -1;
 	void *map = NULL;
-	unsigned long mapsize;
+	size_t mapsize;
 	git_zstream stream;
 	char hdr[32];
 
diff --git a/streaming.c b/streaming.c
index 04a8b99..448c4aa 100644
--- a/streaming.c
+++ b/streaming.c
@@ -77,7 +77,7 @@ struct git_istream {
 
 		struct {
 			void *mapped;
-			unsigned long mapsize;
+			size_t mapsize;
 			char hdr[32];
 			int hdr_avail;
 			int hdr_used;
-- 
2.1.4


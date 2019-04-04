Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6A620248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfDDXaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:30:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729267AbfDDXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:30:11 -0400
Received: (qmail 1532 invoked by uid 109); 4 Apr 2019 23:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20531 invoked by uid 111); 4 Apr 2019 23:30:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:30:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:30:08 -0400
Date:   Thu, 4 Apr 2019 19:30:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/12] packfile.h: drop extern from function declarations
Message-ID: <20190404233008.GJ21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As CodingGuidelines recommends, we do not need an "extern" when
declaring a public function. Let's drop these. Note that we leave the
extern on report_garbage(), as that is actually a function pointer, not
a function itself.

Signed-off-by: Jeff King <peff@peff.net>
---
I hesitated on this one, because it does have a minor conflict with pu.
But I just couldn't bring myself to add a new extern, nor to stick a
non-extern one amidst a bunch of others.

 packfile.h | 80 +++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/packfile.h b/packfile.h
index d70c6d9afb..b40fc34fb2 100644
--- a/packfile.h
+++ b/packfile.h
@@ -15,23 +15,23 @@ struct object_info;
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_name(const unsigned char *sha1);
+char *sha1_pack_name(const unsigned char *sha1);
 
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_index_name(const unsigned char *sha1);
+char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_pach, void *data);
@@ -45,8 +45,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void reprepare_packed_git(struct repository *r);
-extern void install_packed_git(struct repository *r, struct packed_git *pack);
+void reprepare_packed_git(struct repository *r);
+void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
@@ -59,32 +59,32 @@ struct packed_git *get_all_packs(struct repository *r);
  */
 unsigned long approximate_object_count(void);
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
-					 struct packed_git *packs);
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
+				  struct packed_git *packs);
 
-extern void pack_report(void);
+void pack_report(void);
 
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-extern int open_pack_index(struct packed_git *);
+int open_pack_index(struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
  */
-extern void close_pack_index(struct packed_git *);
+void close_pack_index(struct packed_git *);
 
-extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
+uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_pack(struct packed_git *);
-extern void close_all_packs(struct raw_object_store *o);
-extern void unuse_pack(struct pack_window **);
-extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+void close_pack_windows(struct packed_git *);
+void close_pack(struct packed_git *);
+void close_all_packs(struct raw_object_store *o);
+void unuse_pack(struct pack_window **);
+void clear_delta_base_cache(void);
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
@@ -94,7 +94,7 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
  * (like the 64-bit extended offset table), as we compare the size to the
  * fixed-length parts when we open the file.
  */
-extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
 /*
  * Perform binary search on a pack-index for a given oid. Packfile is expected to
@@ -110,59 +110,59 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  * at the SHA-1 within the mmapped index.  Return NULL if there is an
  * error.
  */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
 /*
  * Like nth_packed_object_sha1, but write the data into the object specified by
  * the the first argument.  Returns the first argument on success, and NULL on
  * error.
  */
-extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
  */
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 /*
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
-extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int is_pack_valid(struct packed_git *);
+void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
-extern void release_pack_memory(size_t);
+void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
-extern int do_check_packed_object_crc;
+int do_check_packed_object_crc;
 
-extern int packed_object_info(struct repository *r,
+int packed_object_info(struct repository *r,
 			      struct packed_git *pack,
 			      off_t offset, struct object_info *);
 
-extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
+void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
+const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-extern int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 
-extern int has_object_pack(const struct object_id *oid);
+int has_object_pack(const struct object_id *oid);
 
-extern int has_pack_index(const unsigned char *sha1);
+int has_pack_index(const unsigned char *sha1);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-extern int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(const struct object_id *oid);
 
 /*
  * Expose a function for fuzz testing.
@@ -174,7 +174,7 @@ extern int is_promisor_object(const struct object_id *oid);
  * have a convenient entry-point for fuzz testing. For real uses, you should
  * probably use open_pack_index() or parse_pack_index() instead.
  */
-extern int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
-		    size_t idx_size, struct packed_git *p);
+int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+	     size_t idx_size, struct packed_git *p);
 
 #endif
-- 
2.21.0.714.gd1be1d035b


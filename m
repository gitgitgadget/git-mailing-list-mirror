From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Fri, 21 Feb 2014 17:32:06 +0100
Message-ID: <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:33:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt25-0001NK-6l
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbaBUQcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:32:50 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42043 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932876AbaBUQcr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:32:47 -0500
X-AuditID: 12074411-f79ab6d000002f0e-de-53077faf33a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EA.05.12046.FAF77035; Fri, 21 Feb 2014 11:32:47 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgx026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:45 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqLu+nj3YoGENp0XXlW4mi4beK8wW
	t1fMZ7aY9+IFm8WPlh5mB1aPv+8/MHk8O9HO5vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGccfvCfsWCdUcXC+/8ZGxifaHQxcnJICJhI3Ds9mRnCFpO4cG89WxcjF4eQwGVGiabH
	d1ggnONMEjPmHWUFqWIT0JVY1NPMBGKLCORIbLl6kBHEZhZwkNj8uRHI5uAQFvCUWNkmCWKy
	CKhKrN1ZAlLBK+Ai8fzhcxaIXQoSLct2sYOUcAq4SnQs9wUxhYBKPnfVT2DkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJJgEdzDOOCl3iFGAg1GJh9chlT1YiDWx
	rLgy9xCjJAeTkijv91qgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe5migHG9KYmVValE+TEqa
	g0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgvdjHVCjYFFqempFWmZOCUKaiYMTZDiXlEhx
	al5KalFiaUlGPCgm4ouBUQGS4gHa+xmknbe4IDEXKArReopRUUqcNwkkIQCSyCjNgxsLSxGv
	GMWBvhTm5QAmDCEeYHqB634FNJgJaHDJRlaQwSWJCCmpBsaVKwxYpmY8v/xgTYFkoe2p/EUq
	RQ6/eVraVxlbNU582zLl8YP7Or97nyupCncv1P3Kpe7yr+zyQffjEdHs286VP3249lTwNRbD
	pKubBQITt2y5sX5F1LI605C6ebXl+38+1ltVyHNf2qvdR9ghUlXisfhBpulaBwtv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242473>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 sha1_file.c | 26 +++++++++++++-----------
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 1663478..e62fdec 100644
--- a/cache.h
+++ b/cache.h
@@ -659,9 +659,28 @@ extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Return the name of the file in the local object database that would
+ * be used to store a loose object with the specified sha1.  The
+ * return value is a pointer to a statically allocated buffer that is
+ * overwritten each time the function is called.
+ */
 extern const char *sha1_file_name(const unsigned char *sha1);
+
+/*
+ * Return the name of the (local) packfile with the specified sha1 in
+ * its name.  The return value is a pointer to memory that is
+ * overwritten each time this function is called.
+ */
 extern char *sha1_pack_name(const unsigned char *sha1);
+
+/*
+ * Return the name of the (local) pack index file with the specified
+ * sha1 in its name.  The return value is a pointer to memory that is
+ * overwritten each time this function is called.
+ */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
+
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
 
@@ -836,7 +855,19 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
+
+/*
+ * Return true iff we have an object named sha1, whether local or in
+ * an alternate object database, and whether packed or loose.  This
+ * function does not respect replace references.
+ */
 extern int has_sha1_file(const unsigned char *sha1);
+
+/*
+ * Return true iff an alternate object database has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
 extern int has_pack_index(const unsigned char *sha1);
@@ -1099,17 +1130,46 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
 extern void pack_report(void);
+
+/*
+ * mmap the index file for the specified packfile (if it is not
+ * already mmapped).  Return 0 on success.
+ */
 extern int open_pack_index(struct packed_git *);
+
+/*
+ * munmap the index file for the specified packfile (if it is
+ * currently mmapped).
+ */
 extern void close_pack_index(struct packed_git *);
+
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
-extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+
+/*
+ * Return the SHA-1 of the nth object within the specified packfile.
+ * Open the index if it is not already open.  The return value points
+ * at the SHA-1 within the mmapped index.  Return NULL if there is an
+ * error.
+ */
+extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+
+/*
+ * Return the offset of the nth object within the specified packfile.
+ * The index must already be opened.
+ */
+extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+
+/*
+ * If the object named sha1 is present in the specified packfile,
+ * return its offset within the packfile; otherwise, return 0.
+ */
+extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/sha1_file.c b/sha1_file.c
index ba62804..bb9f097 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -184,16 +184,6 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 	}
 }
 
-/*
- * NOTE! This returns a statically allocated buffer, so you have to be
- * careful about using it. Do an "xstrdup()" if you need to save the
- * filename.
- *
- * Also note that this returns the location for creating.  Reading
- * SHA1 file can happen from any alternate directory listed in the
- * DB_ENVIRONMENT environment variable if it is not found in
- * the primary object database.
- */
 const char *sha1_file_name(const unsigned char *sha1)
 {
 	static char buf[PATH_MAX];
@@ -214,6 +204,11 @@ const char *sha1_file_name(const unsigned char *sha1)
 	return buf;
 }
 
+/*
+ * Return the name of the pack or index file with the specified sha1
+ * in its filename.  *base and *name are scratch space that must be
+ * provided by the caller.  which should be "pack" or "idx".
+ */
 static char *sha1_get_pack_name(const unsigned char *sha1,
 				char **name, char **base, const char *which)
 {
@@ -496,7 +491,12 @@ void pack_report(void)
 		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
 }
 
-static int check_packed_git_idx(const char *path,  struct packed_git *p)
+/*
+ * Open and mmap the index file at path, perform a couple of
+ * consistency checks, then record its information to p.  Return 0 on
+ * success.
+ */
+static int check_packed_git_idx(const char *path, struct packed_git *p)
 {
 	void *idx_map;
 	struct pack_idx_header *hdr;
@@ -2449,6 +2449,10 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
+/*
+ * Iff a pack file contains the object named by sha1, return true and
+ * store its location to e.
+ */
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct packed_git *p;
-- 
1.8.5.3

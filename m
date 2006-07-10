From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 02:57:51 -0400
Message-ID: <20060710065751.22902.43316.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jul 10 08:58:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzpiT-0004XD-D1
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 08:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWGJG5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 02:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWGJG5z
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 02:57:55 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:17324 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161359AbWGJG5y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 02:57:54 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzpiL-0005u3-Lk
	for git@vger.kernel.org; Mon, 10 Jul 2006 02:57:53 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FzpiJ-0005xV-N4
	for git@vger.kernel.org; Mon, 10 Jul 2006 02:57:51 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23598>

From: Pavel Roskin <proski@gnu.org>

This doesn't make the code uglier or harder to read, yet it makes the
code more portable.  This also simplifies checking for other potential
incompatibilities.  "gcc -std=c89 -pedantic" can flag many incompatible
constructs as warnings, but C++ comments will cause it to emit an error.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 blame.c           |    6 +++---
 builtin-apply.c   |   21 +++++++++++----------
 builtin-push.c    |    2 +-
 convert-objects.c |   10 +++++-----
 dir.c             |    2 +-
 http-fetch.c      |    6 +++---
 mktag.c           |    5 +++--
 read-cache.c      |    2 +-
 sha1_file.c       |    4 ++--
 ssh-fetch.c       |    4 ++--
 10 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/blame.c b/blame.c
index 0a06026..b04b8f5 100644
--- a/blame.c
+++ b/blame.c
@@ -44,8 +44,8 @@ struct util_info {
 };
 
 struct chunk {
-	int off1, len1;	// ---
-	int off2, len2;	// +++
+	int off1, len1;	/* --- */
+	int off2, len2;	/* +++ */
 };
 
 struct patch {
@@ -255,7 +255,7 @@ static void print_map(struct commit *cmi
 }
 #endif
 
-// p is a patch from commit to other.
+/* p is a patch from commit to other. */
 static void fill_line_map(struct commit *commit, struct commit *other,
 			  struct patch *p)
 {
diff --git a/builtin-apply.c b/builtin-apply.c
index 1e5b846..c903146 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -14,14 +14,15 @@ #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
 
-//  --check turns on checking that the working tree matches the
-//    files that are being modified, but doesn't apply the patch
-//  --stat does just a diffstat, and doesn't actually apply
-//  --numstat does numeric diffstat, and doesn't actually apply
-//  --index-info shows the old and new index info for paths if available.
-//  --index updates the cache as well.
-//  --cached updates only the cache without ever touching the working tree.
-//
+/*
+ *  --check turns on checking that the working tree matches the
+ *    files that are being modified, but doesn't apply the patch
+ *  --stat does just a diffstat, and doesn't actually apply
+ *  --numstat does numeric diffstat, and doesn't actually apply
+ *  --index-info shows the old and new index info for paths if available.
+ *  --index updates the cache as well.
+ *  --cached updates only the cache without ever touching the working tree.
+ */
 static const char *prefix;
 static int prefix_length = -1;
 static int newfd = -1;
@@ -284,8 +285,8 @@ static void parse_traditional_patch(cons
 {
 	char *name;
 
-	first += 4;	// skip "--- "
-	second += 4;	// skip "+++ "
+	first += 4;	/* skip "--- " */
+	second += 4;	/* skip "+++ " */
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
diff --git a/builtin-push.c b/builtin-push.c
index a8fac88..31cbfd7 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -273,7 +273,7 @@ static int do_push(const char *repo)
 int cmd_push(int argc, const char **argv, char **envp)
 {
 	int i;
-	const char *repo = "origin";	// default repository
+	const char *repo = "origin";	/* default repository */
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/convert-objects.c b/convert-objects.c
index 0fabd89..478571f 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -241,13 +241,13 @@ static void convert_date(void *buffer, u
 	char *new = xmalloc(size + 100);
 	unsigned long newlen = 0;
 	
-	// "tree <sha1>\n"
+	/* "tree <sha1>\n" */
 	memcpy(new + newlen, buffer, 46);
 	newlen += 46;
 	buffer = (char *) buffer + 46;
 	size -= 46;
 
-	// "parent <sha1>\n"
+	/* "parent <sha1>\n" */
 	while (!memcmp(buffer, "parent ", 7)) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
@@ -255,12 +255,12 @@ static void convert_date(void *buffer, u
 		size -= 48;
 	}
 
-	// "author xyz <xyz> date"
+	/* "author xyz <xyz> date" */
 	newlen += convert_date_line(new + newlen, &buffer, &size);
-	// "committer xyz <xyz> date"
+	/* "committer xyz <xyz> date" */
 	newlen += convert_date_line(new + newlen, &buffer, &size);
 
-	// Rest
+	/* Rest */
 	memcpy(new + newlen, buffer, size);
 	newlen += size;
 
diff --git a/dir.c b/dir.c
index d778ecd..092d077 100644
--- a/dir.c
+++ b/dir.c
@@ -336,7 +336,7 @@ static int read_directory_recursive(stru
 				if (dir->show_other_directories &&
 				    (subdir || !dir->hide_empty_directories) &&
 				    !dir_exists(fullname, baselen + len)) {
-					// Rewind the read subdirectory
+					/* Rewind the read subdirectory */
 					while (dir->nr > rewind_base)
 						free(dir->entries[--dir->nr]);
 					break;
diff --git a/http-fetch.c b/http-fetch.c
index 44eba5f..12493fb 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -490,7 +490,7 @@ static int setup_index(struct alt_base *
 {
 	struct packed_git *new_pack;
 	if (has_pack_file(sha1))
-		return 0; // don't list this as something we can get
+		return 0; /* don't list this as something we can get */
 
 	if (fetch_index(repo, sha1))
 		return -1;
@@ -570,7 +570,7 @@ static void process_alternates_response(
 						 base[serverlen - 1] != '/');
 					i += 3;
 				}
-				// If the server got removed, give up.
+				/* If the server got removed, give up. */
 				okay = strchr(base, ':') - base + 3 <
 					serverlen;
 			} else if (alt_req->http_specific) {
@@ -581,7 +581,7 @@ static void process_alternates_response(
 					okay = 1;
 				}
 			}
-			// skip 'objects' at end
+			/* skip 'objects' at end */
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
 				strlcpy(target, base, serverlen);
diff --git a/mktag.c b/mktag.c
index f0fe528..27f4c4f 100644
--- a/mktag.c
+++ b/mktag.c
@@ -17,7 +17,7 @@ #include "tag.h"
  * in that size, you're doing something wrong.
  */
 
-// Some random size
+/* Some random size */
 #define MAXSIZE (8192)
 
 /*
@@ -123,7 +123,8 @@ int main(int argc, char **argv)
 		die("could not read from stdin");
 	}
 
-	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
+	/* Verify it for some basic sanity: it needs to start with
+	   "object <sha1>\ntype\ntagger " */
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
diff --git a/read-cache.c b/read-cache.c
index 3c32aae..a50d361 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -748,7 +748,7 @@ int read_cache(void)
 		die("index file open failed (%s)", strerror(errno));
 	}
 
-	size = 0; // avoid gcc warning
+	size = 0; /* avoid gcc warning */
 	map = MAP_FAILED;
 	if (!fstat(fd, &st)) {
 		size = st.st_size;
diff --git a/sha1_file.c b/sha1_file.c
index f7bb3a1..459430a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -453,7 +453,7 @@ int use_packed_git(struct packed_git *p)
 {
 	if (!p->pack_size) {
 		struct stat st;
-		// We created the struct before we had the pack
+		/* We created the struct before we had the pack */
 		stat(p->pack_name, &st);
 		if (!S_ISREG(st.st_mode))
 			die("packfile %s not a regular file", p->pack_name);
@@ -1504,7 +1504,7 @@ static void *repack_object(const unsigne
 	int hdrlen;
 	void *buf;
 
-	// need to unpack and recompress it by itself
+	/* need to unpack and recompress it by itself */
 	unpacked = read_packed_sha1(sha1, type, &len);
 
 	hdrlen = sprintf(hdr, "%s %lu", type, len) + 1;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 1e59cd2..28f7fd9 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -68,7 +68,7 @@ int fetch(unsigned char *sha1)
 	struct object_list *temp;
 
 	if (memcmp(sha1, in_transit->item->sha1, 20)) {
-		// we must have already fetched it to clean the queue
+		/* we must have already fetched it to clean the queue */
 		return has_sha1_file(sha1) ? 0 : -1;
 	}
 	prefetches--;
@@ -85,7 +85,7 @@ int fetch(unsigned char *sha1)
 		if (read(fd_in, &remote, 1) < 1)
 			return -1;
 	}
-	//fprintf(stderr, "Got %d\n", remote);
+	/* fprintf(stderr, "Got %d\n", remote); */
 	if (remote < 0)
 		return remote;
 	ret = write_sha1_from_fd(sha1, fd_in, conn_buf, 4096, &conn_buf_posn);

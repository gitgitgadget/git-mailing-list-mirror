From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] sha1_file_name(): declare to return a const string
Date: Fri, 21 Feb 2014 17:32:05 +0100
Message-ID: <1393000327-11402-5-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:39:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt8i-0000hO-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbaBUQjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:39:48 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55432 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932286AbaBUQjr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:39:47 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2014 11:39:47 EST
X-AuditID: 12074414-f79d96d000002d2b-66-53077fadc8c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 82.3B.11563.DAF77035; Fri, 21 Feb 2014 11:32:45 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgw026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:44 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLu2nj3YYN1cBYuuK91MFg29V5gt
	bq+Yz2wx78ULNosfLT3MDqwef99/YPJ4dqKdzeNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M54OvkbS8EUpYqVD16wNzBeke5i5OSQEDCRmLJrByOELSZx4d56ti5GLg4hgcuMElc2
	9bBAOMeZJE6cbWUDqWIT0JVY1NPMBGKLCORIbLl6EKybWcBBYvPnRjBbWMBd4sfanWA2i4Cq
	xMr+tywgNq+Ai8TVi7+YILYpSLQs28XexcjBwSngKtGx3BfEFAIq+dxVP4GRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkIAS2cF45KTcIUYBDkYlHl6HVPZgIdbE
	suLK3EOMkhxMSqK832uBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4m6OBcrwpiZVVqUX5MClp
	DhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErwf64AaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kFxEV8MjAyQFA/QXoN6kL3FBYm5QFGI1lOMilLivEkgcwVAEhmleXBjYWni
	FaM40JfCvBwg7TzAFAPX/QpoMBPQ4JKNrCCDSxIRUlINjM6NQQxmH+PbZglqsatsmiI259fn
	hfM/dvw6NoePj/f4v6cr/27Ic1NmV20pCfhrJc2xgS/w8Y2UuKA48fdvNk8wnrio00LuVuRF
	lQT23D/qT18rtC9f/s3hpMYFtuNc/9llMwtl7LgYzs8Ird865XiZhdSi8lZLab6J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242474>

Change the return value of sha1_file_name() to (const char *).
(Callers have no business mucking about here.)  Change callers
accordingly, deleting a few superfluous temporary variables along the
way.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     |  2 +-
 http.c      |  2 +-
 sha1_file.c | 24 +++++++++---------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index 0ecd1c8..1663478 100644
--- a/cache.h
+++ b/cache.h
@@ -659,7 +659,7 @@ extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)
 extern char *git_path_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-extern char *sha1_file_name(const unsigned char *sha1);
+extern const char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
diff --git a/http.c b/http.c
index 70eaa26..faa9dc8 100644
--- a/http.c
+++ b/http.c
@@ -1384,7 +1384,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
-	char *filename;
+	const char *filename;
 	char prevfile[PATH_MAX];
 	int prevlocal;
 	char prev_buf[PREV_BUF_SIZE];
diff --git a/sha1_file.c b/sha1_file.c
index 0910939..ba62804 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -194,7 +194,7 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
  * DB_ENVIRONMENT environment variable if it is not found in
  * the primary object database.
  */
-char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name(const unsigned char *sha1)
 {
 	static char buf[PATH_MAX];
 	const char *objdir;
@@ -444,8 +444,7 @@ void prepare_alt_odb(void)
 
 static int has_loose_object_local(const unsigned char *sha1)
 {
-	char *name = sha1_file_name(sha1);
-	return !access(name, F_OK);
+	return !access(sha1_file_name(sha1), F_OK);
 }
 
 int has_loose_object_nonlocal(const unsigned char *sha1)
@@ -1420,17 +1419,15 @@ static int git_open_noatime(const char *name)
 
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
 {
-	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
 
-	if (!lstat(name, st))
+	if (!lstat(sha1_file_name(sha1), st))
 		return 0;
 
 	prepare_alt_odb();
 	errno = ENOENT;
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		name = alt->name;
-		fill_sha1_path(name, sha1);
+		fill_sha1_path(alt->name, sha1);
 		if (!lstat(alt->base, st))
 			return 0;
 	}
@@ -1441,18 +1438,16 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
 static int open_sha1_file(const unsigned char *sha1)
 {
 	int fd;
-	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
 
-	fd = git_open_noatime(name);
+	fd = git_open_noatime(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 
 	prepare_alt_odb();
 	errno = ENOENT;
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		name = alt->name;
-		fill_sha1_path(name, sha1);
+		fill_sha1_path(alt->name, sha1);
 		fd = git_open_noatime(alt->base);
 		if (fd >= 0)
 			return fd;
@@ -2687,7 +2682,6 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 			      unsigned flag)
 {
 	void *data;
-	char *path;
 	const struct packed_git *p;
 	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
 
@@ -2705,7 +2699,8 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
 	if (has_loose_object(repl)) {
-		path = sha1_file_name(sha1);
+		const char *path = sha1_file_name(sha1);
+
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 	}
@@ -2903,10 +2898,9 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_zstream stream;
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
-	char *filename;
 	static char tmp_file[PATH_MAX];
+	const char *filename = sha1_file_name(sha1);
 
-	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmp_file, sizeof(tmp_file), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
-- 
1.8.5.3

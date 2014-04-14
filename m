From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/25] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Mon, 14 Apr 2014 15:54:39 +0200
Message-ID: <1397483695-10888-10-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMG-0000Kw-8f
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbaDNNz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:27 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49829 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaDNNzW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:22 -0400
X-AuditID: 1207440c-f79656d000003eba-d7-534be8c948f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 38.47.16058.9C8EB435; Mon, 14 Apr 2014 09:55:21 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt099010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:19 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHvyhXewwdptYhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGd8fLSfpaBZtmLXjwlsDYxd4l2M
	nBwSAiYST2cuZYewxSQu3FvP1sXIxSEkcJlRYtGvr8wQzkkmie8HlrOBVLEJ6Eos6mlmArFF
	BNQkJrYdYgEpYhZoZ5I4tKMXLCEsECxxfH8TI4jNIqAqsWvhDLBmXgFXia/X1zNDrJOTOHls
	MmsXIwcHJ1B84YcskLCQgIvE3S9TWCcw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuo
	l5tZopeaUrqJERKMPDsYv62TOcQowMGoxMPbMcc7WIg1say4MvcQoyQHk5Iob8YNoBBfUn5K
	ZUZicUZ8UWlOavEhRgkOZiURXtetQDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgTvt+dAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoH
	aG8SSDtvcUFiLlAUovUUo6KUOG8JSEIAJJFRmgc3FpZiXjGKA30pzHsfpIoHmJ7gul8BDWYC
	GszSDja4JBEhJdXAWCJ/zAoYmvwPSor3ceWrJ0vM2/m+OqupOHLvou13Dmycf/vby/slvErd
	dTJ//jyQKiq1i77K+3bCjUl2Lqo7N0gLztT3fXE05vnLGO31iy+phP1J2P9956Uf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246228>

There are a few places that use these values, so define constants for
them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
If I were confident that it would always be inlined, I would have
used

    #define LOCK_SUFFIX_LEN strlen(LOCK_SUFFIX)

Or maybe even have omitted this constant and write strlen(LOCK_SUFFIX)
inline where it is needed instead.  But I'm not so I didn't.

It's possible I missed other code that uses ".lock" or the magic
number 5, but these are the only ones I found.

 cache.h    |  4 ++++
 lockfile.c | 12 ++++++------
 refs.c     |  7 ++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 3a873a4..825cd0a 100644
--- a/cache.h
+++ b/cache.h
@@ -533,6 +533,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 
+/* String appended to a filename to derive the lockfile name: */
+#define LOCK_SUFFIX ".lock"
+#define LOCK_SUFFIX_LEN 5
+
 struct lock_file {
 	struct lock_file *next;
 	int fd;
diff --git a/lockfile.c b/lockfile.c
index 8f6652c..1ce0e87 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -172,14 +172,14 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
-
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
+	 * room for adding ".lock" for the lock file name:
 	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	static const size_t max_path_len = sizeof(lk->filename) -
+					   LOCK_SUFFIX_LEN;
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -202,7 +202,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
+	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		lk->owner = getpid();
@@ -296,7 +296,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
diff --git a/refs.c b/refs.c
index 67fe8b7..2805b31 100644
--- a/refs.c
+++ b/refs.c
@@ -63,7 +63,8 @@ static int check_refname_component(const char *refname, int flags)
 		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (cp - refname >= LOCK_SUFFIX_LEN &&
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
 }
@@ -2486,11 +2487,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
 
 		lock->lk->filename[i] = 0;
 		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		lock->lk->filename[i] = LOCK_SUFFIX[0];
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
1.9.1

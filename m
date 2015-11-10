From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 08/10] initdb: make safe_create_dir public
Date: Tue, 10 Nov 2015 12:42:38 +0100
Message-ID: <7e6da5e50ceda627136e2115aed1cff513a49128.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7Kp-0000ro-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbbKJLnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:10 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60562 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752035AbbKJLnH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:07 -0500
X-AuditID: 1207440f-f79df6d000007c0f-cc-5641d849af03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AF.F7.31759.948D1465; Tue, 10 Nov 2015 06:43:05 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABgljC014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:43:04 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOt5wzHM4MFRa4v5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGe0nJ7AWrBYqOL83C9sDYwn+LoY
	OTkkBEwkWtfeZYKwxSQu3FvP1sXIxSEkcJlR4sDi7SwQzgkmiTvrnoJVsQnoSizqaQazRQTU
	JCa2HWIBsZkFljFJzNprC2ILC9hKzD+yjB3EZhFQlbjycSIbiM0rECXxa88cNohtchJT7rcD
	zeHg4BSwkJh7LgMkLCRgLnG8fSLjBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRy
	M0v0UlNKNzFCQpF/B2PXeplDjAIcjEo8vBO+OYQJsSaWFVfmHmKU5GBSEuXdf8oxTIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIr/0LoHLelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgQv+3WgoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgyIgvBsYGSIoH
	aG/+NaB23uKCxFygKETrKUZFKXHebSAJAZBERmke3FhYgnnFKA70pTAvG8h2HmBygut+BTSY
	CWjwUn+Qh4pLEhFSUg2Misx8M97+2bK4V2PxiXXfnu07LHYkwPP0sc7Aq/9CjnhuW3EyMZ9/
	Za18+voDGrbKjftOXWpxPPL6v+DpOUnMa/akrH37eJ+cgfG/Cy8+h38vuOv5yWBu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281114>

From: David Turner <dturner@twopensource.com>

Soon we will want to create initdb functions for ref backends, and
code from initdb that calls this function needs to move into the files
backend. So this function needs to be public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 12 ------------
 cache.h           |  8 ++++++++
 path.c            | 12 ++++++++++++
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f59f407..07229d6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,18 +24,6 @@ static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
 
-static void safe_create_dir(const char *dir, int share)
-{
-	if (mkdir(dir, 0777) < 0) {
-		if (errno != EEXIST) {
-			perror(dir);
-			exit(1);
-		}
-	}
-	else if (share && adjust_shared_perm(dir))
-		die(_("Could not make %s writable by group"), dir);
-}
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
 {
diff --git a/cache.h b/cache.h
index 9a905a8..0f9808c 100644
--- a/cache.h
+++ b/cache.h
@@ -1737,4 +1737,12 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting. Only use this for
+ * directories under $GIT_DIR.  Don't use it for working tree
+ * directories.
+ */
+void safe_create_dir(const char *dir, int share);
+
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 212695a..9e0283c 100644
--- a/path.c
+++ b/path.c
@@ -723,6 +723,18 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+void safe_create_dir(const char *dir, int share)
+{
+	if (mkdir(dir, 0777) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+	else if (share && adjust_shared_perm(dir))
+		die(_("Could not make %s writable by group"), dir);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
-- 
2.6.2

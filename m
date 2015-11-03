From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 22/25] initdb: make safe_create_dir public
Date: Tue,  3 Nov 2015 08:40:06 +0100
Message-ID: <f1288dac85d4d298dfe2f03815cde751aa1aa8d0.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKd-0006Bb-HV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbKCHs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:27 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61774 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbbKCHsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:25 -0500
X-AuditID: 1207440e-f79516d0000012b3-f1-563864f98244
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 28.37.04787.9F468365; Tue,  3 Nov 2015 02:40:41 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdJ016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:40 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPszxSLM4PY7DYv5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M1pOT2At
	WCxUcX7uF7YGxhN8XYycHBICJhKvZ8xjh7DFJC7cW8/WxcjFISRwmVHi1J2NTCAJIYFjTBL/
	FieB2GwCuhKLeprB4iICahIT2w6xdDFycDALFEnc6dcBCQsL2EoseLyDFcRmEVCV2PLvChtI
	Ca9AlMTUr8IQq+QkptxvB5vCKWAh8eDuH3aITeYSm+4tY5vAyLuAkWEVo1xiTmmubm5iZk5x
	arJucXJiXl5qka6xXm5miV5qSukmRkjo8O1gbF8vc4hRgINRiYd3wRLzMCHWxLLiytxDjJIc
	TEqivOtiLMKE+JLyUyozEosz4otKc1KLDzFKcDArifAWBALleFMSK6tSi/JhUtIcLErivGpL
	1P2EBNITS1KzU1MLUotgsjIcHEoSvLOTgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJL
	SzLiQVERXwyMC5AUD9DehBSQvcUFiblAUYjWU4yKUuK8k0HmCoAkMkrz4MbCEsIrRnGgL4V5
	w0CqeIDJBK77FdBgJqDB4dtMQQaXJCKkpBoY3QMvrDntc0t7muGFQ7Mz5f72MOw6srz77GE1
	w7nLVAQWsuy9F3I1fHPWf67na9Te7Iv9f+P2kZsqz+YItH8MNAnN+zpnUuDMz/GsUxQeZj58
	3qnZtE1rwetm123bX/m/9Fc0190R0MaiweOznd+jVER+vni99ep+zeSmXbMtV+tf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280778>

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

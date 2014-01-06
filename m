From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/17] safe_create_leading_directories(): introduce enum for return values
Date: Mon,  6 Jan 2014 14:45:25 +0100
Message-ID: <1389015935-21936-8-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:53:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AcT-0001Ka-12
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbaAFNx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:53:26 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43990 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbaAFNxY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:53:24 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 08:53:24 EST
X-AuditID: 12074411-b7f426d000005455-4e-52cab3adfda2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EE.39.21589.DA3BAC25; Mon,  6 Jan 2014 08:46:22 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP8021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:20 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqLtu86kgg+b1jBZdV7qZLBp6rzBb
	vL25hNHi9or5zBa7py1gc2D1+Pv+A5PHzll32T0uXlL2eDzxBKvH501yAaxR3DZJiSVlwZnp
	efp2CdwZF07MYSrola+49+4iSwPjfYkuRk4OCQETiQ3/FzJC2GISF+6tZ+ti5OIQErjMKHG2
	vQPKOcYkcfdfEytIFZuArsSinmYmEFtEQE1iYtshFpAiZoHFjBJd076BjRIWiJV43fuIHcRm
	EVCV+PrxFguIzSvgItE0ayFQMwfQOgWJ1deFQMKcAq4S06YdZgOxhYBK1hx6xDKBkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJCgEtzBOOOk3CFGAQ5GJR5ej2cn
	g4RYE8uKK3MPMUpyMCmJ8nKuPhUkxJeUn1KZkVicEV9UmpNafIhRgoNZSYSXawFQjjclsbIq
	tSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbthE1CjYFFqempFWmZOCUKaiYMT
	RHCBbOAB2jADpJC3uCAxtzgzHaLoFKOilDjvFJCEAEgiozQPbgAs/l8xigP9I8y7BaSKB5g6
	4LpfAQ1mAhocGgc2uCQRISXVwFg6gSfi8q5ied2/eWV7nOu2G2gvfnZC1dfQfsmeVC/ndTP4
	v/hf4bksEZB88+Bs7lcXJdlelpmJLd0158ijg5JNd0XazqruVC0xduOZP2nX3TlPzC97S3Ds
	v3Uym7G5/Ivq632TXKp8j09w/RD3snD90j6jV9VMMiZLXnWXnz+9my2GI+JzUooS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240007>

Instead of returning magic integer values (which a couple of callers
go to the trouble of distinguishing), return values from an enum.  Add
a docstring.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c |  4 ++--
 cache.h           | 17 +++++++++++++++--
 merge-recursive.c |  2 +-
 sha1_file.c       | 16 ++++++++--------
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b3f03cf..6f69593 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,10 +515,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				saved = shared_repository;
 				shared_repository = 0;
 				switch (safe_create_leading_directories_const(argv[0])) {
-				case -3:
+				case SCLD_EXISTS:
 					errno = EEXIST;
 					/* fallthru */
-				case -1:
+				case SCLD_FAILED:
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				default:
diff --git a/cache.h b/cache.h
index ce377e1..c6a4157 100644
--- a/cache.h
+++ b/cache.h
@@ -736,8 +736,21 @@ enum sharedrepo {
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
-int safe_create_leading_directories(char *path);
-int safe_create_leading_directories_const(const char *path);
+
+/*
+ * Create the directory containing the named path, using care to be
+ * somewhat safe against races.  Return one of the scld_error values
+ * to indicate success/failure.
+ */
+enum scld_error {
+	SCLD_OK = 0,
+	SCLD_FAILED = -1,
+	SCLD_PERMS = -2,
+	SCLD_EXISTS = -3
+};
+enum scld_error safe_create_leading_directories(char *path);
+enum scld_error safe_create_leading_directories_const(const char *path);
+
 int mkdir_in_gitdir(const char *path);
 extern void home_config_paths(char **global, char **xdg, char *file);
 extern char *expand_user_path(const char *path);
diff --git a/merge-recursive.c b/merge-recursive.c
index a18bd15..8400a8e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -693,7 +693,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	/* Make sure leading directories are created */
 	status = safe_create_leading_directories_const(path);
 	if (status) {
-		if (status == -3) {
+		if (status == SCLD_EXISTS) {
 			/* something else exists */
 			error(msg, path, _(": perhaps a D/F conflict?"));
 			return -1;
diff --git a/sha1_file.c b/sha1_file.c
index 4513cbb..5594f11 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -105,12 +105,12 @@ int mkdir_in_gitdir(const char *path)
 	return adjust_shared_perm(path);
 }
 
-int safe_create_leading_directories(char *path)
+enum scld_error safe_create_leading_directories(char *path)
 {
 	char *next_component = path + offset_1st_component(path);
-	int ret = 0;
+	enum scld_error ret = SCLD_OK;
 
-	while (!ret && next_component) {
+	while (ret == SCLD_OK && next_component) {
 		struct stat st;
 		char *slash = strchr(next_component, '/');
 
@@ -127,26 +127,26 @@ int safe_create_leading_directories(char *path)
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode))
-				ret = -3;
+				ret = SCLD_EXISTS;
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
 			else
-				ret = -1;
+				ret = SCLD_FAILED;
 		} else if (adjust_shared_perm(path)) {
-			ret = -2;
+			ret = SCLD_PERMS;
 		}
 		*slash = '/';
 	}
 	return ret;
 }
 
-int safe_create_leading_directories_const(const char *path)
+enum scld_error safe_create_leading_directories_const(const char *path)
 {
 	/* path points to cache entries, so xstrdup before messing with it */
 	char *buf = xstrdup(path);
-	int result = safe_create_leading_directories(buf);
+	enum scld_error result = safe_create_leading_directories(buf);
 	free(buf);
 	return result;
 }
-- 
1.8.5.2

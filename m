From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] object.h: Add OBJECT_ARRAY_INIT macro and make use of it.
Date: Sat, 28 Aug 2010 23:04:17 -0300
Message-ID: <b5ec0461c869bb49b190c2f4f3203fa59107ac25.1283046991.git.tfransosi@gmail.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, srabbelier@gmail.com,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 04:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpXGH-0003Ps-HA
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 04:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0H2CE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 22:04:28 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37163 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab0H2CE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 22:04:27 -0400
Received: by gxk23 with SMTP id 23so1590701gxk.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=J+NdIfvN+1XtWctuXQaBWni25jcIRF9X9sp5yooVZcE=;
        b=ltW6O12VIGkiWm6kCpK0TMiBGpdcAcBppJkvmJWiT7eqCH3sqY53y8EARUjQKzp+8s
         4nx5TnqH9xb+cxOdck3/A0re9NLfyzd7bCPs7kU5o3vsj/6HyJViw908BAEUdaWJ7HUm
         jL4coFBTJaU2528QBRzQh3osxzKcLJZoA2qJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xTVb105O/ImQ1XZIjdD1alQUAI2QejUQcb53sKe6NM6F/lKECQayr+Ini75iLixClv
         RTm82RuUxqn4T6SsfFJ9JJwFndA+gGiwrWKPiBZTV59OtCqi1pzzrDL599ONcL4qhjka
         FULHBRyp1z+jpDOiKXREffhNUdm8l7NKv/igs=
Received: by 10.151.108.20 with SMTP id k20mr3531492ybm.416.1283047466696;
        Sat, 28 Aug 2010 19:04:26 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id q3sm5936505ybe.14.2010.08.28.19.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 19:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154666>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
As suggested in: <AANLkTimWQwBdcVgZK5GGmIXOcpgLpgp28ywFi6MJVnyJ@mail.gmail.com>,
by Sverre Rabbelier.

 builtin/fast-export.c |    2 +-
 builtin/grep.c        |    2 +-
 builtin/name-rev.c    |    2 +-
 object.h              |    2 ++
 reachable.c           |    2 +-
 shallow.c             |    2 +-
 upload-pack.c         |    2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 834ec8b..ab792d5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -565,7 +565,7 @@ static void import_marks(char *input_file)
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct object_array commits = { 0, 0, NULL };
+	struct object_array commits = OBJECT_ARRAY_INIT;
 	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
diff --git a/builtin/grep.c b/builtin/grep.c
index cf6c29f..b725ede 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -834,7 +834,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int external_grep_allowed__ignored;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
-	struct object_array list = { 0, 0, NULL };
+	struct object_array list = OBJECT_ARRAY_INIT;
 	const char **paths = NULL;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 06a38ac..31f5c1c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -220,7 +220,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
-	struct object_array revs = { 0, 0, NULL };
+	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0;
 	struct name_ref_data data = { 0, 0, NULL };
 	struct option opts[] = {
diff --git a/object.h b/object.h
index 82877c8..4d1d615 100644
--- a/object.h
+++ b/object.h
@@ -21,6 +21,8 @@ struct object_array {
 	} *objects;
 };
 
+#define OBJECT_ARRAY_INIT { 0, 0, NULL }
+
 #define TYPE_BITS   3
 #define FLAG_BITS  27
 
diff --git a/reachable.c b/reachable.c
index b515fa2..a03fabf 100644
--- a/reachable.c
+++ b/reachable.c
@@ -90,7 +90,7 @@ static void walk_commit_list(struct rev_info *revs)
 {
 	int i;
 	struct commit *commit;
-	struct object_array objects = { 0, 0, NULL };
+	struct object_array objects = OBJECT_ARRAY_INIT;
 
 	/* Walk all commits, process their trees */
 	while ((commit = get_revision(revs)) != NULL)
diff --git a/shallow.c b/shallow.c
index 4d90eda..a0363de 100644
--- a/shallow.c
+++ b/shallow.c
@@ -47,7 +47,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 {
 	int i = 0, cur_depth = 0;
 	struct commit_list *result = NULL;
-	struct object_array stack = {0, 0, NULL};
+	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
 
 	while (commit || i < heads->nr || stack.nr) {
diff --git a/upload-pack.c b/upload-pack.c
index fc79dde..92f9530 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -482,7 +482,7 @@ static int get_common_commits(void)
 
 static void receive_needs(void)
 {
-	struct object_array shallows = {0, 0, NULL};
+	struct object_array shallows = OBJECT_ARRAY_INIT;
 	static char line[1000];
 	int len, depth = 0;
 
-- 
1.7.2.1.95.g3d045

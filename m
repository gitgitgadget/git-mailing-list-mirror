From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 1/3] stylefix: pointers bind to the variable, not the type
Date: Sun, 31 Aug 2014 13:11:31 -0700
Message-ID: <1409515893-48017-1-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 22:10:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOBSh-0007zl-G6
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 22:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbaHaUKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 16:10:43 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34598 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaHaUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 16:10:43 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so4466694pdj.21
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=hfoF49FwJtrovI7NHqC8R2ZWKgADY365/vCCnuadHh8=;
        b=IkJw5n3REpXYBstBkoL7M9DBu1qQbApcBdgHhc9xCL0t2wiICE5u05MM0g5lCaveNx
         mhDpAlj8pBnclMsjQrNLr97GCrddY4pqoCAaXvi9D2T/k5ptV1KriaW0fDN307oAu22M
         A3BaOSpYq1CibsCEXjjs91Bah/4DzV2hW8MCXPnCmiaS31l/IliYHyS1dbhSjUvYOHAY
         2ZiXqcVmUqWT9kqCDP1hqIzdiYa+ebeQWwStkq3uCHZ1G6FpdOG2npLSDH86aN//zYrF
         LRyjLExl74nl50vcsW0PVHyat9JoiXi2aOiGsQFoQDomNUAsOhoGq2MiQljgL4ujF4bs
         +rlw==
X-Received: by 10.66.102.37 with SMTP id fl5mr33613386pab.35.1409515842646;
        Sun, 31 Aug 2014 13:10:42 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ps1sm8947446pdb.73.2014.08.31.13.10.41
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 Aug 2014 13:10:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g0bdc89a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256296>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is an RFC patch but this is probably fine as-is,
and is orthogonal to the next two patches.

 builtin/clone.c | 7 ++++---
 commit.c        | 2 +-
 commit.h        | 2 +-
 reflog-walk.c   | 2 +-
 reflog-walk.h   | 2 +-
 refs.h          | 2 +-
 remote-curl.c   | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd169c..315969d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -685,9 +685,10 @@ static void write_config(struct string_list *config)
 	}
 }
 
-static void write_refspec_config(const char* src_ref_prefix,
-		const struct ref* our_head_points_at,
-		const struct ref* remote_head_points_at, struct strbuf* branch_top)
+static void write_refspec_config(const char *src_ref_prefix,
+		const struct ref *our_head_points_at,
+		const struct ref *remote_head_points_at,
+		struct strbuf *branch_top)
 {
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
diff --git a/commit.c b/commit.c
index ae7f2b1..4de6be4 100644
--- a/commit.c
+++ b/commit.c
@@ -1256,7 +1256,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	}
 }
 
-void check_commit_signature(const struct commit* commit, struct signature_check *sigc)
+void check_commit_signature(const struct commit *commit, struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
diff --git a/commit.h b/commit.h
index a8cbf52..268c9d7 100644
--- a/commit.h
+++ b/commit.h
@@ -346,7 +346,7 @@ extern void print_commit_list(struct commit_list *list,
  * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
  * sig->signer and sig->key.
  */
-extern void check_commit_signature(const struct commit* commit, struct signature_check *sigc);
+extern void check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 9ce8b53..0e5174b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -133,7 +133,7 @@ struct reflog_walk_info {
 	struct commit_reflog *last_commit_reflog;
 };
 
-void init_reflog_walk(struct reflog_walk_info** info)
+void init_reflog_walk(struct reflog_walk_info **info)
 {
 	*info = xcalloc(1, sizeof(struct reflog_walk_info));
 }
diff --git a/reflog-walk.h b/reflog-walk.h
index 50265f5..a9bd60e 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -5,7 +5,7 @@
 
 struct reflog_walk_info;
 
-extern void init_reflog_walk(struct reflog_walk_info** info);
+extern void init_reflog_walk(struct reflog_walk_info **info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
diff --git a/refs.h b/refs.h
index ec46acd..00f209a 100644
--- a/refs.h
+++ b/refs.h
@@ -77,7 +77,7 @@ static inline const char *has_glob_specials(const char *pattern)
 extern int for_each_rawref(each_ref_fn, void *);
 
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
-extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list* refnames);
+extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
 /*
  * Lock the packed-refs file for writing.  Flags is passed to
diff --git a/remote-curl.c b/remote-curl.c
index 0fcf2ce..d2229e0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -221,7 +221,7 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	return 0;
 }
 
-static struct discovery* discover_refs(const char *service, int for_push)
+static struct discovery *discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
-- 
2.1.0.30.g0bdc89a

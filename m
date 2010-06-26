From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use of it.
Date: Sat, 26 Jun 2010 20:40:56 -0300
Message-ID: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
References: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
Cc: jrnieder@gmail.com, srabbelier@gmail.com,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 27 01:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSf05-0005e8-VR
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 01:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0FZXlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 19:41:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45721 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0FZXlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 19:41:12 -0400
Received: by gxk28 with SMTP id 28so1758884gxk.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3zITmUym6rNGpiRQxqfVuTV+SaK6j//rp/koyFujke4=;
        b=DdlfDZNFZXZmeUuRUkT8TgAYqJ3CtTsnqgTIz/woMGYtm1QpXSB1reIFLQRKCuJozT
         l4xL9Lg99DQihWMeQHRo4bIhe7n+2TnwOqmCfKl2uDpPSo+2r6qK7KKVDkmBRFssqmwV
         V7zceBZjdNRmNuCz6IxMZ63RLMx5focqH20Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LiaqZGM0FF4pApuyiwBz0sOZU6NMGudFVhq6H6jmvqtsemqoHPrVqwl/nOc4C7ifdG
         MKfouvD4EHgIz5fFrX2PyICCG4mEJQCvfXl4+QC6f7Nask9OSSqyabvgBHkOipudc2nD
         XPl1IMBZ26uEdpgrX3t7jT9dWgytVwehUC1Mo=
Received: by 10.91.44.4 with SMTP id w4mr2526676agj.86.1277595671610;
        Sat, 26 Jun 2010 16:41:11 -0700 (PDT)
Received: from localhost ([189.60.232.11])
        by mx.google.com with ESMTPS id w6sm13533490anb.3.2010.06.26.16.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 16:41:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.576.gef57c
In-Reply-To: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149782>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/fast-export.c  |    2 +-
 builtin/fetch.c        |    8 ++++----
 builtin/receive-pack.c |    2 +-
 builtin/remote.c       |    4 ++--
 builtin/show-ref.c     |    2 +-
 merge-recursive.c      |    3 ++-
 remote.c               |    4 ++--
 string-list.h          |    2 ++
 8 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..89945bc 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -566,7 +566,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
-	struct string_list extra_refs = { NULL, 0, 0, 0 };
+	struct string_list extra_refs = STRING_LIST_INIT;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5cb369c..a16fb43 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -572,8 +572,8 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list remote_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT;
+	struct string_list remote_refs = STRING_LIST_INIT;
 	struct tag_data data;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
@@ -667,7 +667,7 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT;
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
@@ -890,7 +890,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list list = { NULL, 0, 0, 0 };
+	struct string_list list = STRING_LIST_INIT;
 	struct remote *remote;
 	int result = 0;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29bc8d5..c40a4ba 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -530,7 +530,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 static void check_aliased_updates(struct command *commands)
 {
 	struct command *cmd;
-	struct string_list ref_list = { NULL, 0, 0, 0 };
+	struct string_list ref_list = STRING_LIST_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct string_list_item *item =
diff --git a/builtin/remote.c b/builtin/remote.c
index 0a52667..9d41792 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -596,7 +596,7 @@ static int mv(int argc, const char **argv)
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
-	struct string_list remote_branches = { NULL, 0, 0, 0 };
+	struct string_list remote_branches = STRING_LIST_INIT;
 	struct rename_info rename;
 	int i;
 
@@ -1044,7 +1044,7 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
-	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct string_list info_list = STRING_LIST_INIT;
 	struct show_info info;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 17ada88..25c280a 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -120,7 +120,7 @@ static int add_existing(const char *refname, const unsigned char *sha1, int flag
  */
 static int exclude_existing(const char *match)
 {
-	static struct string_list existing_refs = { NULL, 0, 0, 0 };
+	static struct string_list existing_refs = STRING_LIST_INIT;
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..e9a5513 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -806,7 +806,8 @@ static int process_renames(struct merge_options *o,
 			   struct string_list *b_renames)
 {
 	int clean_merge = 1, i, j;
-	struct string_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
+	struct string_list a_by_dst = STRING_LIST_INIT;
+        struct string_list b_by_dst = STRING_LIST_INIT;
 	const struct rename *sre;
 
 	for (i = 0; i < a_renames->nr; i++) {
diff --git a/remote.c b/remote.c
index e51cd22..059d757 100644
--- a/remote.c
+++ b/remote.c
@@ -754,7 +754,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 
 void ref_remove_duplicates(struct ref *ref_map)
 {
-	struct string_list refs = { NULL, 0, 0, 0 };
+	struct string_list refs = STRING_LIST_INIT;
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
 	for (; ref_map; prev = ref_map, ref_map = next) {
@@ -1704,7 +1704,7 @@ static int get_stale_heads_cb(const char *refname,
 struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
-	struct string_list ref_names = { NULL, 0, 0, 0 };
+	struct string_list ref_names = STRING_LIST_INIT;
 	struct stale_heads_info info;
 	info.remote = remote;
 	info.ref_names = &ref_names;
diff --git a/string-list.h b/string-list.h
index 63b69c8..037d058 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,6 +12,8 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
+#define STRING_LIST_INIT { NULL, 0, 0, 0 }
+
 void print_string_list(const char *text, const struct string_list *p);
 void string_list_clear(struct string_list *list, int free_util);
 
-- 
1.7.1.576.gef57c

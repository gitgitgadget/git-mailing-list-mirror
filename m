From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Remove unused variables
Date: Tue, 22 Mar 2011 13:50:08 +0100 (CET)
Message-ID: <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 13:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q212b-0007aY-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1CVMuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:50:25 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:37214 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754911Ab1CVMuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 08:50:23 -0400
Received: (qmail invoked by alias); 22 Mar 2011 12:50:20 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp071) with SMTP; 22 Mar 2011 13:50:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SA/8aW5dSf65YdzxhMVFxM2HNqFUnu/6CK2qFCP
	OFrANf6Cew1Ap/
X-X-Sender: gene099@bonsai2
In-Reply-To: <cover.1300798069.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169729>

Noticed by gcc 4.6.0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c       |    3 +--
 builtin/remote-ext.c |    4 ----
 diff.c               |    3 +--
 merge-recursive.c    |    4 ----
 reachable.c          |    5 -----
 test-subprocess.c    |    3 +--
 transport-helper.c   |    3 +--
 7 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 795aba0..5ae0366 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -140,11 +140,10 @@ static int traverse_reachable(void)
 	int result = 0;
 	while (pending.nr) {
 		struct object_array_entry *entry;
-		struct object *obj, *parent;
+		struct object *obj;
 
 		entry = pending.objects + --pending.nr;
 		obj = entry->item;
-		parent = (struct object *) entry->name;
 		result |= traverse_one_object(obj);
 	}
 	return !!result;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index ea71977..2343030 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -30,16 +30,12 @@ static char *strip_escapes(const char *str, const char *service,
 	size_t rpos = 0;
 	int escape = 0;
 	char special = 0;
-	size_t pslen = 0;
-	size_t pSlen = 0;
 	size_t psoff = 0;
 	struct strbuf ret = STRBUF_INIT;
 
 	/* Calculate prefix length for \s and lengths for \s and \S */
 	if (!strncmp(service, "git-", 4))
 		psoff = 4;
-	pSlen = strlen(service);
-	pslen = pSlen - psoff;
 
 	/* Pass the service to command. */
 	setenv("GIT_EXT_SERVICE", service, 1);
diff --git a/diff.c b/diff.c
index 42a107c..18f8e99 100644
--- a/diff.c
+++ b/diff.c
@@ -1242,7 +1242,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
-	const char *reset, *set, *add_c, *del_c;
+	const char *reset, *add_c, *del_c;
 	const char *line_prefix = "";
 	struct strbuf *msg = NULL;
 
@@ -1269,7 +1269,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	/* Find the longest filename and max number of changes */
 	reset = diff_get_color_opt(options, DIFF_RESET);
-	set   = diff_get_color_opt(options, DIFF_PLAIN);
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index c8343d7..7c12673 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -357,7 +357,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	 */
 	const char *last_file = NULL;
 	int last_len = 0;
-	struct stage_data *last_e;
 	int i;
 
 	/*
@@ -394,7 +393,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 		if (S_ISREG(e->stages[2].mode) || S_ISLNK(e->stages[2].mode)) {
 			last_file = path;
 			last_len = len;
-			last_e = e;
 		} else {
 			last_file = NULL;
 		}
@@ -969,7 +967,6 @@ static int process_renames(struct merge_options *o,
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
-		char *src;
 		struct string_list *renames1, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
@@ -1004,7 +1001,6 @@ static int process_renames(struct merge_options *o,
 			ren2 = ren1;
 			ren1 = tmp;
 		}
-		src = ren1->pair->one->path;
 
 		ren1->dst_entry->processed = 1;
 		ren1->src_entry->processed = 1;
diff --git a/reachable.c b/reachable.c
index a03fabf..3fc6b1d 100644
--- a/reachable.c
+++ b/reachable.c
@@ -70,16 +70,11 @@ static void process_tree(struct tree *tree,
 static void process_tag(struct tag *tag, struct object_array *p, const char *name)
 {
 	struct object *obj = &tag->object;
-	struct name_path me;
 
 	if (obj->flags & SEEN)
 		return;
 	obj->flags |= SEEN;
 
-	me.up = NULL;
-	me.elem = "tag:/";
-	me.elem_len = 5;
-
 	if (parse_tag(tag) < 0)
 		die("bad tag object %s", sha1_to_hex(obj->sha1));
 	if (tag->tagged)
diff --git a/test-subprocess.c b/test-subprocess.c
index 667d3e5..8926bc5 100644
--- a/test-subprocess.c
+++ b/test-subprocess.c
@@ -3,11 +3,10 @@
 
 int main(int argc, char **argv)
 {
-	const char *prefix;
 	struct child_process cp;
 	int nogit = 0;
 
-	prefix = setup_git_directory_gently(&nogit);
+	setup_git_directory_gently(&nogit);
 	if (nogit)
 		die("No git repo found");
 	if (!strcmp(argv[1], "--setup-work-tree")) {
diff --git a/transport-helper.c b/transport-helper.c
index 0c5b1bd..a4f40fb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -561,10 +561,9 @@ static int push_refs_with_push(struct transport *transport,
 	int mirror = flags & TRANSPORT_PUSH_MIRROR;
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
-	struct child_process *helper;
 	struct ref *ref;
 
-	helper = get_helper(transport);
+	get_helper(transport);
 	if (!data->push)
 		return 1;
 
-- 
1.7.4.msysgit.0.167.ge91fd

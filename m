From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for master] Rename path_list to string_list
Date: Mon, 21 Jul 2008 19:05:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807211904090.8986@racer>
References: <alpine.DEB.1.00.0807211858330.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 21 20:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzmU-0007rM-Pm
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbYGUSFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbYGUSFg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:05:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:40963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbYGUSFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:05:35 -0400
Received: (qmail invoked by alias); 21 Jul 2008 18:05:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp063) with SMTP; 21 Jul 2008 20:05:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fZrtxnENfeoHEuPD6zlvioNzY1MsSO6/HeZejoB
	HAAfmVxwzyWVqE
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807211858330.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89373>

Hi,

On Mon, 21 Jul 2008, Johannes Schindelin wrote:

> 	Will reply with the interdiff between the tree after said commands 
> 	and the tree with this patch, i.e. the non-automatic replacements.

And so I do.

This looks much nicer than the big patch I just sent out, as it only
contains the changes after the semi-automatic replacements with perl.

Ciao,
Dscho

 Documentation/technical/api-string-list.txt |   20 +++++++++++---------
 builtin-commit.c                            |    6 +++---
 builtin-fast-export.c                       |    2 +-
 builtin-mailsplit.c                         |    2 +-
 builtin-merge-recursive.c                   |    6 +++---
 builtin-mv.c                                |    9 +++++----
 builtin-remote.c                            |   18 +++++++++---------
 builtin-rerere.c                            |    6 +++---
 builtin-shortlog.c                          |    8 ++++----
 diff-no-index.c                             |    8 ++++----
 my-prepare-patch.sh                         |    2 +-
 rerere.c                                    |    8 ++++----
 12 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 9d9190d..8557f9a 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -1,11 +1,11 @@
 string-list API
-=============
+===============
 
 The string_list API offers a data structure and functions to handle sorted
 and unsorted string lists.
 
-The name is a bit misleading, a string_list may store not only paths but
-strings in general.
+The 'string_list' struct used to be called 'path_list', but was renamed
+because it is not specific to paths.
 
 The caller:
 
@@ -20,7 +20,8 @@ If you need something advanced, you can manually malloc() the `items`
 member (you need this if you add things later) and you should set the
 `nr` and `alloc` members in that case, too.
 
-. Adds new items to the list, using `string_list_append` or `string_list_insert`.
+. Adds new items to the list, using `string_list_append` or
+  `string_list_insert`.
 
 . Can check if a string is in the list using `string_list_has_string` or
   `unsorted_string_list_has_string` and get it from the list using
@@ -64,9 +65,10 @@ Functions
 
 `string_list_clear`::
 
-	Free a string_list. The `path` pointer of the items will be freed in case
-	the `strdup_strings` member of the string_list is set. The second parameter
-	controls if the `util` pointer of the items should be freed or not.
+	Free a string_list. The `path` pointer of the items will be freed in
+	case the `strdup_strings` member of the string_list is set. The second
+	parameter controls if the `util` pointer of the items should be freed
+	or not.
 
 * Functions for sorted lists only
 
@@ -76,8 +78,8 @@ Functions
 
 `string_list_insert`::
 
-	Insert a new element to the string_list. The returned pointer can be handy
-	if you want to write something to the `util` pointer of the
+	Insert a new element to the string_list. The returned pointer can be
+	handy if you want to write something to the `util` pointer of the
 	string_list_item containing the just added string.
 +
 Since this function uses xrealloc() (which die()s if it fails) if the
diff --git a/builtin-commit.c b/builtin-commit.c
index 54aa83f..97e64de 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -182,11 +182,11 @@ static void add_remove_files(struct string_list *list)
 		struct stat st;
 		struct string_list_item *p = &(list->items[i]);
 
-		if (!lstat(p->path, &st)) {
-			if (add_to_cache(p->path, &st, 0))
+		if (!lstat(p->string, &st)) {
+			if (add_to_cache(p->string, &st, 0))
 				die("updating files failed");
 		} else
-			remove_file_from_cache(p->path);
+			remove_file_from_cache(p->string);
 	}
 }
 
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 822e039..e508ced 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -362,7 +362,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 	int i;
 
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
-		const char *name = extra_refs->items[i].path;
+		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
 		switch (object->type) {
 		case OBJ_TAG:
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 99b35e0..71f3b3b 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -159,7 +159,7 @@ static int split_maildir(const char *maildir, const char *dir,
 
 	for (i = 0; i < list.nr; i++) {
 		FILE *f;
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].path);
+		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index e0b6ffe..43e55bf 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -818,8 +818,8 @@ static int process_renames(struct string_list *a_renames,
 			compare = -1;
 			ren1 = a_renames->items[i++].util;
 		} else {
-			compare = strcmp(a_renames->items[i].path,
-					b_renames->items[j].path);
+			compare = strcmp(a_renames->items[i].string,
+					b_renames->items[j].string);
 			if (compare <= 0)
 				ren1 = a_renames->items[i++].util;
 			if (compare >= 0)
@@ -1186,7 +1186,7 @@ int merge_trees(struct tree *head,
 		clean = process_renames(re_head, re_merge,
 				branch1, branch2);
 		for (i = 0; i < entries->nr; i++) {
-			const char *path = entries->items[i].path;
+			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed
 				&& !process_entry(path, e, branch1, branch2))
diff --git a/builtin-mv.c b/builtin-mv.c
index c3038e2..736a0b8 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -42,7 +42,8 @@ static void show_list(const char *label, struct string_list *list)
 		int i;
 		printf("%s", label);
 		for (i = 0; i < list->nr; i++)
-			printf("%s%s", i > 0 ? ", " : "", list->items[i].path);
+			printf("%s%s", i > 0 ? ", " : "",
+					list->items[i].string);
 		putchar('\n');
 	}
 }
@@ -245,7 +246,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		show_list("Deleting : ", &deleted);
 	} else {
 		for (i = 0; i < changed.nr; i++) {
-			const char *path = changed.items[i].path;
+			const char *path = changed.items[i].string;
 			int j = cache_name_pos(path, strlen(path));
 			struct cache_entry *ce = active_cache[j];
 
@@ -255,13 +256,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 
 		for (i = 0; i < added.nr; i++) {
-			const char *path = added.items[i].path;
+			const char *path = added.items[i].string;
 			if (add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0))
 				die("updating index entries failed");
 		}
 
 		for (i = 0; i < deleted.nr; i++)
-			remove_file_from_cache(deleted.items[i].path);
+			remove_file_from_cache(deleted.items[i].string);
 
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/builtin-remote.c b/builtin-remote.c
index 04de9e1..54d1c3e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -104,10 +104,10 @@ static int add(int argc, const char **argv)
 		strbuf_addch(&buf2, '+');
 		if (mirror)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->path, item->path);
+					item->string, item->string);
 		else
 			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->path, name, item->path);
+					item->string, name, item->string);
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return 1;
 	}
@@ -337,7 +337,7 @@ static int remove_branches(struct string_list *branches)
 	int i, result = 0;
 	for (i = 0; i < branches->nr; i++) {
 		struct string_list_item *item = branches->items + i;
-		const char *refname = item->path;
+		const char *refname = item->string;
 		unsigned char *sha1 = item->util;
 
 		if (delete_ref(refname, sha1))
@@ -382,7 +382,7 @@ static int rm(int argc, const char **argv)
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
-						item->path, *k);
+						item->string, *k);
 				if (git_config_set(buf.buf, NULL)) {
 					strbuf_release(&buf);
 					return -1;
@@ -417,7 +417,7 @@ static void show_list(const char *title, struct string_list *list)
 	printf(title, list->nr > 1 ? "es" : "");
 	printf("\n    ");
 	for (i = 0; i < list->nr; i++)
-		printf("%s%s", i ? " " : "", list->items[i].path);
+		printf("%s%s", i ? " " : "", list->items[i].string);
 	printf("\n");
 }
 
@@ -496,9 +496,9 @@ static int show(int argc, const char **argv)
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
 				info->merge.nr > 1 ? "es" : "",
-				branch->path);
+				branch->string);
 			for (j = 0; j < info->merge.nr; j++)
-				printf(" %s", info->merge.items[j].path);
+				printf(" %s", info->merge.items[j].string);
 			printf("\n");
 		}
 
@@ -639,7 +639,7 @@ static int update(int argc, const char **argv)
 		result = for_each_remote(get_one_remote_for_update, &list);
 
 	for (i = 0; i < list.nr; i++)
-		result |= fetch_remote(list.items[i].path);
+		result |= fetch_remote(list.items[i].string);
 
 	/* all names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
@@ -671,7 +671,7 @@ static int show_all(void)
 		sort_string_list(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			printf("%s%s%s\n", item->path,
+			printf("%s%s%s\n", item->string,
 				verbose ? "\t" : "",
 				verbose && item->util ?
 					(const char *)item->util : "");
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 7315d1a..dd4573f 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -72,7 +72,7 @@ static void garbage_collect(struct string_list *rr)
 			string_list_append(name, &to_remove);
 	}
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].path);
+		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
 }
 
@@ -132,10 +132,10 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[1], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].path);
+			printf("%s\n", merge_rr.items[i].string);
 	else if (!strcmp(argv[1], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
-			const char *path = merge_rr.items[i].path;
+			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
 			diff_two(rr_path(name, "preimage"), path, path, path);
 		}
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4ab66d3..d03f14f 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -113,7 +113,7 @@ static void insert_one_record(struct shortlog *log,
 	}
 
 	onelines->items[onelines->nr].util = NULL;
-	onelines->items[onelines->nr++].path = buffer;
+	onelines->items[onelines->nr++].string = buffer;
 }
 
 static void read_from_stdin(struct shortlog *log)
@@ -305,11 +305,11 @@ void shortlog_output(struct shortlog *log)
 		struct string_list *onelines = log->list.items[i].util;
 
 		if (log->summary) {
-			printf("%6d\t%s\n", onelines->nr, log->list.items[i].path);
+			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
 		} else {
-			printf("%s (%d):\n", log->list.items[i].path, onelines->nr);
+			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
-				const char *msg = onelines->items[j].path;
+				const char *msg = onelines->items[j].string;
 
 				if (log->wrap_lines) {
 					int col = print_wrapped_text(msg, log->in1, log->in2, log->wrap);
diff --git a/diff-no-index.c b/diff-no-index.c
index 31e7708..7d68b7f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -95,14 +95,14 @@ static int queue_diff(struct diff_options *o,
 			else if (i2 == p2.nr)
 				comp = -1;
 			else
-				comp = strcmp(p1.items[i1].path,
-					p2.items[i2].path);
+				comp = strcmp(p1.items[i1].string,
+					p2.items[i2].string);
 
 			if (comp > 0)
 				n1 = NULL;
 			else {
 				n1 = buffer1;
-				strncpy(buffer1 + len1, p1.items[i1++].path,
+				strncpy(buffer1 + len1, p1.items[i1++].string,
 						PATH_MAX - len1);
 			}
 
@@ -110,7 +110,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = NULL;
 			else {
 				n2 = buffer2;
-				strncpy(buffer2 + len2, p2.items[i2++].path,
+				strncpy(buffer2 + len2, p2.items[i2++].string,
 						PATH_MAX - len2);
 			}
 
diff --git a/my-prepare-patch.sh b/my-prepare-patch.sh
index b565487..46cb7d7 100755
--- a/my-prepare-patch.sh
+++ b/my-prepare-patch.sh
@@ -24,7 +24,7 @@ Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
 
 EOF
 
-git apply --stat < $tmp
+git-apply --stat < $tmp
 
 echo
 
diff --git a/rerere.c b/rerere.c
index c659cfb..323e493 100644
--- a/rerere.c
+++ b/rerere.c
@@ -58,7 +58,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 		int length;
 		if (!rr->items[i].util)
 			continue;
-		path = rr->items[i].path;
+		path = rr->items[i].string;
 		length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
 		    write_in_full(out_fd, "\t", 1) != 1 ||
@@ -219,7 +219,7 @@ static int update_paths(struct string_list *update)
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->path, ADD_CACHE_IGNORE_ERRORS))
+		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
 			status = -1;
 	}
 
@@ -248,7 +248,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	 */
 
 	for (i = 0; i < conflict.nr; i++) {
-		const char *path = conflict.items[i].path;
+		const char *path = conflict.items[i].string;
 		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
@@ -273,7 +273,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 
 	for (i = 0; i < rr->nr; i++) {
 		int ret;
-		const char *path = rr->items[i].path;
+		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_resolution(name)) {

From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 2/2] headers: include dependent headers
Date: Sat,  6 Sep 2014 12:20:11 -0700
Message-ID: <1410031211-14599-2-git-send-email-davvid@gmail.com>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 21:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQLXL-0007wL-Pv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 21:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaIFTUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 15:20:33 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48183 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaIFTUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 15:20:30 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so468121pdi.21
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=KdxjwDa8ydotGgI2zfpcJ4RAzU9cjKpA9guoo6DktBo=;
        b=SIdnWzWzkydMREkBAdlLgOYL6bsDxqN84Walil+Yc1KKFxI7Zsp34wAdDZBkfOzbLf
         ODCpYlRBfIBPgnIOGI6v/eM63wLELtftvcZIrz/jhiI17ubouJlIh5Im8eVqT1j2bBhP
         7QheeqIbaM6sRyVzBW0XtRnNOAEcXv4/xVSHRmHKI2M3EvwoPJAMlBHaGCSzBpZdiuew
         8sKjRk5SZsbQVN/z0Hk5/pnUZUTDmGmhwUruO6UyioFauXPWL0T/mKNQa66bPoEnY/1Z
         o5A27Hc+NisEusmN2uHhbFQTNbm9oXAouXsHJoE6phWoJlSt7DJlwGBk/ibcTsCyV7Vd
         KRfQ==
X-Received: by 10.66.121.200 with SMTP id lm8mr32909786pab.1.1410031230287;
        Sat, 06 Sep 2014 12:20:30 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id h4sm5267241pat.11.2014.09.06.12.20.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Sep 2014 12:20:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.62.g5fbb67f
In-Reply-To: <1410031211-14599-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256600>

Add dependent headers so that including a header does not
require including additional headers.

This makes it so that "gcc -c $header" succeeds for each header.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch was prepared by using the "check-headers" target introduced
by PATCH 1/2 to find headers that were not including their dependencies.

The only significant code movement was the movement of a struct defined
in utf8.c to utf8.h so that it can be included by unicode_width.h.

 archive.h         | 1 +
 argv-array.h      | 2 ++
 attr.h            | 2 ++
 branch.h          | 3 +++
 cache-tree.h      | 1 +
 color.h           | 3 ++-
 column.h          | 2 ++
 commit.h          | 1 +
 convert.h         | 3 +++
 credential.h      | 1 +
 csum-file.h       | 2 ++
 delta.h           | 2 ++
 diff.h            | 2 +-
 diffcore.h        | 2 ++
 dir.h             | 2 ++
 ewah/ewok.h       | 2 ++
 exec_cmd.h        | 2 ++
 fsck.h            | 2 ++
 gpg-interface.h   | 2 ++
 graph.h           | 2 ++
 hashmap.h         | 2 ++
 help.h            | 2 ++
 khash.h           | 3 +++
 kwset.h           | 2 ++
 line-log.h        | 1 +
 list-objects.h    | 2 ++
 ll-merge.h        | 2 ++
 mailmap.h         | 3 +++
 merge-recursive.h | 2 ++
 notes-cache.h     | 1 +
 notes-merge.h     | 3 +++
 notes-utils.h     | 1 +
 notes.h           | 1 +
 object.h          | 2 ++
 pack-bitmap.h     | 2 ++
 pack-objects.h    | 2 ++
 pack-revindex.h   | 2 ++
 parse-options.h   | 2 ++
 patch-ids.h       | 3 +++
 pathspec.h        | 2 ++
 progress.h        | 2 ++
 quote.h           | 3 ++-
 reachable.h       | 2 ++
 reflog-walk.h     | 1 +
 refs.h            | 4 ++++
 remote.h          | 1 +
 resolve-undo.h    | 2 ++
 send-pack.h       | 4 ++++
 sequencer.h       | 3 +++
 sha1-lookup.h     | 2 ++
 shortlog.h        | 2 ++
 sideband.h        | 2 ++
 strbuf.h          | 2 ++
 submodule.h       | 6 ++++--
 tag.h             | 1 +
 tree-walk.h       | 2 ++
 tree.h            | 1 +
 unicode_width.h   | 3 +++
 unpack-trees.h    | 2 ++
 url.h             | 2 ++
 urlmatch.h        | 2 ++
 utf8.c            | 7 -------
 utf8.h            | 9 +++++++++
 wt-status.h       | 1 +
 64 files changed, 133 insertions(+), 12 deletions(-)

diff --git a/archive.h b/archive.h
index 4a791e1..b2ca5bf 100644
--- a/archive.h
+++ b/archive.h
@@ -1,6 +1,7 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
+#include "cache.h"
 #include "pathspec.h"
 
 struct archiver_args {
diff --git a/argv-array.h b/argv-array.h
index c65e6e8..7d877af 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -1,6 +1,8 @@
 #ifndef ARGV_ARRAY_H
 #define ARGV_ARRAY_H
 
+#include "git-compat-util.h"
+
 extern const char *empty_argv[];
 
 struct argv_array {
diff --git a/attr.h b/attr.h
index 8b08d33..34e63f8 100644
--- a/attr.h
+++ b/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+#include "cache.h"
+
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
diff --git a/branch.h b/branch.h
index 64173ab..a61fd1a 100644
--- a/branch.h
+++ b/branch.h
@@ -3,6 +3,9 @@
 
 /* Functions for acting on the information about branches. */
 
+#include "cache.h"
+#include "strbuf.h"
+
 /*
  * Creates a new branch, where head is the branch currently checked
  * out, name is the new branch name, start_name is the name of the
diff --git a/cache-tree.h b/cache-tree.h
index b47ccec..30b0775 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -3,6 +3,7 @@
 
 #include "tree.h"
 #include "tree-walk.h"
+#include "cache.h"
 
 struct cache_tree;
 struct cache_tree_sub {
diff --git a/color.h b/color.h
index 9a8495b..6b50a0f 100644
--- a/color.h
+++ b/color.h
@@ -1,7 +1,8 @@
 #ifndef COLOR_H
 #define COLOR_H
 
-struct strbuf;
+#include "git-compat-util.h"
+#include "strbuf.h"
 
 /*  2 + (2 * num_attrs) + 8 + 1 + 8 + 'm' + NUL */
 /* "\033[1;2;4;5;7;38;5;2xx;48;5;2xxm\0" */
diff --git a/column.h b/column.h
index 0a61917..5d094b4 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,8 @@
 #ifndef COLUMN_H
 #define COLUMN_H
 
+#include "string-list.h"
+
 #define COL_LAYOUT_MASK   0x000F
 #define COL_ENABLE_MASK   0x0030   /* always, never or auto */
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline */
diff --git a/commit.h b/commit.h
index aa8c3ca..1fe0731 100644
--- a/commit.h
+++ b/commit.h
@@ -7,6 +7,7 @@
 #include "decorate.h"
 #include "gpg-interface.h"
 #include "string-list.h"
+#include "cache.h"
 
 struct commit_list {
 	struct commit *item;
diff --git a/convert.h b/convert.h
index 0c2143c..bb3266b 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,9 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+#include "git-compat-util.h"
+#include "strbuf.h"
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
diff --git a/credential.h b/credential.h
index 0c3e85e..cfa87f1 100644
--- a/credential.h
+++ b/credential.h
@@ -1,6 +1,7 @@
 #ifndef CREDENTIAL_H
 #define CREDENTIAL_H
 
+#include "git-compat-util.h"
 #include "string-list.h"
 
 struct credential {
diff --git a/csum-file.h b/csum-file.h
index bb543d5..9e29e35 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,6 +1,8 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+#include "cache.h"
+
 struct progress;
 
 /* A SHA1-protected file */
diff --git a/delta.h b/delta.h
index 9b67531..668e163 100644
--- a/delta.h
+++ b/delta.h
@@ -1,6 +1,8 @@
 #ifndef DELTA_H
 #define DELTA_H
 
+#include "git-compat-util.h"
+
 /* opaque object for delta index */
 struct delta_index;
 
diff --git a/diff.h b/diff.h
index b4a624d..27f7696 100644
--- a/diff.h
+++ b/diff.h
@@ -6,11 +6,11 @@
 
 #include "tree-walk.h"
 #include "pathspec.h"
+#include "strbuf.h"
 
 struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
-struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
 struct sha1_array;
diff --git a/diffcore.h b/diffcore.h
index c876dac..1f3290c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,6 +4,8 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
+#include "diff.h"
+
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
diff --git a/dir.h b/dir.h
index 6c45e9d..727160e 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,8 @@
 /* See Documentation/technical/api-directory-listing.txt */
 
 #include "strbuf.h"
+#include "pathspec.h"
+#include "cache.h"
 
 struct dir_entry {
 	unsigned int len;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index f6ad190..7812863 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -20,6 +20,8 @@
 #ifndef __EWOK_BITMAP_H__
 #define __EWOK_BITMAP_H__
 
+#include "git-compat-util.h"
+
 #ifndef ewah_malloc
 #	define ewah_malloc xmalloc
 #endif
diff --git a/exec_cmd.h b/exec_cmd.h
index e4c9702..daa26e2 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -1,6 +1,8 @@
 #ifndef GIT_EXEC_CMD_H
 #define GIT_EXEC_CMD_H
 
+#include "git-compat-util.h"
+
 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
diff --git a/fsck.h b/fsck.h
index 1e4f527..99b2802 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,8 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
+#include "object.h"
+
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
 
diff --git a/gpg-interface.h b/gpg-interface.h
index 37c23da..f42b706 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,8 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
 
+#include "strbuf.h"
+
 struct signature_check {
 	char *payload;
 	char *gpg_output;
diff --git a/graph.h b/graph.h
index 0be62bd..17e6a11 100644
--- a/graph.h
+++ b/graph.h
@@ -1,6 +1,8 @@
 #ifndef GRAPH_H
 #define GRAPH_H
 
+#include "revision.h"
+
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
diff --git a/hashmap.h b/hashmap.h
index ab7958a..8605fae 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,6 +1,8 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
+#include "git-compat-util.h"
+
 /*
  * Generic implementation of hash-based key-value mappings.
  * See Documentation/technical/api-hashmap.txt.
diff --git a/help.h b/help.h
index b21d7c9..a3bf882 100644
--- a/help.h
+++ b/help.h
@@ -1,6 +1,8 @@
 #ifndef HELP_H
 #define HELP_H
 
+#include "git-compat-util.h"
+
 struct cmdnames {
 	int alloc;
 	int cnt;
diff --git a/khash.h b/khash.h
index 06c7906..89f9579 100644
--- a/khash.h
+++ b/khash.h
@@ -26,6 +26,9 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
 
+#include "git-compat-util.h"
+#include "cache.h"
+
 #define AC_VERSION_KHASH_H "0.2.8"
 
 typedef uint32_t khint32_t;
diff --git a/kwset.h b/kwset.h
index a21b2ea..2acc585 100644
--- a/kwset.h
+++ b/kwset.h
@@ -25,6 +25,8 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
 
+#include "git-compat-util.h"
+
 struct kwsmatch
 {
   int index;			/* Index number of matching keyword. */
diff --git a/line-log.h b/line-log.h
index a9212d8..e1d47e0 100644
--- a/line-log.h
+++ b/line-log.h
@@ -2,6 +2,7 @@
 #define LINE_LOG_H
 
 #include "diffcore.h"
+#include "string-list.h"
 
 struct rev_info;
 struct commit;
diff --git a/list-objects.h b/list-objects.h
index 136a1da..8810db6 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,6 +1,8 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
 
+#include "revision.h"
+
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const struct name_path *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
diff --git a/ll-merge.h b/ll-merge.h
index 244a31f..b72b199 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,6 +5,8 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
 
+#include "xdiff/xdiff.h"
+
 struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
diff --git a/mailmap.h b/mailmap.h
index ed7c93b..27ac3c7 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,6 +1,9 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
+#include "git-compat-util.h"
+#include "string-list.h"
+
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
 
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..05500b3 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,7 +1,9 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
+#include "strbuf.h"
 #include "string-list.h"
+#include "commit.h"
 
 struct merge_options {
 	const char *ancestor;
diff --git a/notes-cache.h b/notes-cache.h
index 356f88f..4ecd767 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -1,6 +1,7 @@
 #ifndef NOTES_CACHE_H
 #define NOTES_CACHE_H
 
+#include "git-compat-util.h"
 #include "notes.h"
 
 struct notes_cache {
diff --git a/notes-merge.h b/notes-merge.h
index 1d01f6a..73d961d 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -1,6 +1,9 @@
 #ifndef NOTES_MERGE_H
 #define NOTES_MERGE_H
 
+#include "notes.h"
+#include "commit.h"
+
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
 
 enum notes_merge_verbosity {
diff --git a/notes-utils.h b/notes-utils.h
index 890ddb3..eaac967 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -2,6 +2,7 @@
 #define NOTES_UTILS_H
 
 #include "notes.h"
+#include "commit.h"
 
 /*
  * Create new notes commit from the given notes tree
diff --git a/notes.h b/notes.h
index 2a3f923..12318a4 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,7 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+#include "strbuf.h"
 #include "string-list.h"
 
 /*
diff --git a/object.h b/object.h
index 5e8d8ee..e61b290 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+#include "cache.h"
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..945ff30 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -1,9 +1,11 @@
 #ifndef PACK_BITMAP_H
 #define PACK_BITMAP_H
 
+#include "git-compat-util.h"
 #include "ewah/ewok.h"
 #include "khash.h"
 #include "pack-objects.h"
+#include "revision.h"
 
 struct bitmap_disk_entry {
 	uint32_t object_pos;
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..2c28bea 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,8 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#include "pack.h"
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
diff --git a/pack-revindex.h b/pack-revindex.h
index d737f98..4e574b3 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -1,6 +1,8 @@
 #ifndef PACK_REVINDEX_H
 #define PACK_REVINDEX_H
 
+#include "git-compat-util.h"
+
 struct revindex_entry {
 	off_t offset;
 	unsigned int nr;
diff --git a/parse-options.h b/parse-options.h
index 7940bc7..933a1b7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,8 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+#include "git-compat-util.h"
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..016eb2d 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -1,6 +1,9 @@
 #ifndef PATCH_IDS_H
 #define PATCH_IDS_H
 
+#include "commit.h"
+#include "diff.h"
+
 struct patch_id {
 	unsigned char patch_id[20];
 	char seen;
diff --git a/pathspec.h b/pathspec.h
index 0c11262..c92fafc 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,8 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
 
+#include "git-compat-util.h"
+
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
diff --git a/progress.h b/progress.h
index 611e4c4..4c78a2c 100644
--- a/progress.h
+++ b/progress.h
@@ -1,6 +1,8 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
 
+#include "git-compat-util.h"
+
 struct progress;
 
 void display_throughput(struct progress *progress, off_t total);
diff --git a/quote.h b/quote.h
index 71dcc3a..37f857b 100644
--- a/quote.h
+++ b/quote.h
@@ -1,7 +1,8 @@
 #ifndef QUOTE_H
 #define QUOTE_H
 
-struct strbuf;
+#include "git-compat-util.h"
+#include "strbuf.h"
 
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
diff --git a/reachable.h b/reachable.h
index 5d082ad..5536382 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,6 +1,8 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
 
+#include "revision.h"
+
 struct progress;
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog, struct progress *);
 
diff --git a/reflog-walk.h b/reflog-walk.h
index 50265f5..d5378b9 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -2,6 +2,7 @@
 #define REFLOG_WALK_H
 
 #include "cache.h"
+#include "commit.h"
 
 struct reflog_walk_info;
 
diff --git a/refs.h b/refs.h
index ec46acd..5c43232 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,10 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "string-list.h"
+
 struct ref_lock {
 	char *ref_name;
 	char *orig_ref_name;
diff --git a/remote.h b/remote.h
index 8b62efd..24bcbd7 100644
--- a/remote.h
+++ b/remote.h
@@ -3,6 +3,7 @@
 
 #include "parse-options.h"
 #include "hashmap.h"
+#include "strbuf.h"
 
 enum {
 	REMOTE_CONFIG,
diff --git a/resolve-undo.h b/resolve-undo.h
index 4630645..815050d 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,6 +1,8 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
 
+#include "cache.h"
+
 struct resolve_undo_info {
 	unsigned int mode[3];
 	unsigned char sha1[3][20];
diff --git a/send-pack.h b/send-pack.h
index 8e84392..f0c463a 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -1,6 +1,10 @@
 #ifndef SEND_PACK_H
 #define SEND_PACK_H
 
+#include "git-compat-util.h"
+#include "run-command.h"
+#include "remote.h"
+
 struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
diff --git a/sequencer.h b/sequencer.h
index db43e9c..c817247 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,9 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
+#include "git-compat-util.h"
+#include "strbuf.h"
+
 #define SEQ_DIR		"sequencer"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
diff --git a/sha1-lookup.h b/sha1-lookup.h
index 20af285..f375596 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -1,6 +1,8 @@
 #ifndef SHA1_LOOKUP_H
 #define SHA1_LOOKUP_H
 
+#include "git-compat-util.h"
+
 typedef const unsigned char *sha1_access_fn(size_t index, void *table);
 
 extern int sha1_pos(const unsigned char *sha1,
diff --git a/shortlog.h b/shortlog.h
index de4f86f..e5949e7 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -1,6 +1,8 @@
 #ifndef SHORTLOG_H
 #define SHORTLOG_H
 
+#include "git-compat-util.h"
+#include "commit.h"
 #include "string-list.h"
 
 struct shortlog {
diff --git a/sideband.h b/sideband.h
index e46bed0..411aa51 100644
--- a/sideband.h
+++ b/sideband.h
@@ -1,6 +1,8 @@
 #ifndef SIDEBAND_H
 #define SIDEBAND_H
 
+#include "git-compat-util.h"
+
 #define SIDEBAND_PROTOCOL_ERROR -2
 #define SIDEBAND_REMOTE_ERROR -1
 
diff --git a/strbuf.h b/strbuf.h
index 7bdc1da..c3ea9a2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+#include "git-compat-util.h"
+
 /* See Documentation/technical/api-strbuf.txt */
 
 extern char strbuf_slopbuf[];
diff --git a/submodule.h b/submodule.h
index 7beec48..52bb673 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,8 +1,10 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
 
-struct diff_options;
-struct argv_array;
+#include "git-compat-util.h"
+#include "diff.h"
+#include "argv-array.h"
+#include "string-list.h"
 
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
diff --git a/tag.h b/tag.h
index bc8a1e4..68b0334 100644
--- a/tag.h
+++ b/tag.h
@@ -1,6 +1,7 @@
 #ifndef TAG_H
 #define TAG_H
 
+#include "git-compat-util.h"
 #include "object.h"
 
 extern const char *tag_type;
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..0818126 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+#include "strbuf.h"
+
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
diff --git a/tree.h b/tree.h
index d84ac63..9565406 100644
--- a/tree.h
+++ b/tree.h
@@ -2,6 +2,7 @@
 #define TREE_H
 
 #include "object.h"
+#include "pathspec.h"
 
 extern const char *tree_type;
 
diff --git a/unicode_width.h b/unicode_width.h
index 47cdd23..b35bdc4 100644
--- a/unicode_width.h
+++ b/unicode_width.h
@@ -1,3 +1,6 @@
+#include "git-compat-util.h"
+#include "utf8.h"
+
 static const struct interval zero_width[] = {
 { 0x0300, 0x036F },
 { 0x0483, 0x0489 },
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6..e4792ec 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,7 +1,9 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
 
+#include "cache.h"
 #include "string-list.h"
+#include "tree-walk.h"
 
 #define MAX_UNPACK_TREES 8
 
diff --git a/url.h b/url.h
index abdaf6f..f4a23c3 100644
--- a/url.h
+++ b/url.h
@@ -1,6 +1,8 @@
 #ifndef URL_H
 #define URL_H
 
+#include "strbuf.h"
+
 extern int is_url(const char *url);
 extern int is_urlschemechar(int first_flag, int ch);
 extern char *url_decode(const char *url);
diff --git a/urlmatch.h b/urlmatch.h
index b461dfd..9f7c781 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -1,4 +1,6 @@
 #ifndef URL_MATCH_H
+
+#include "git-compat-util.h"
 #include "string-list.h"
 
 struct url_info {
diff --git a/utf8.c b/utf8.c
index b30790d..fb9f299 100644
--- a/utf8.c
+++ b/utf8.c
@@ -2,13 +2,6 @@
 #include "strbuf.h"
 #include "utf8.h"
 
-/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
-
-struct interval {
-	ucs_char_t first;
-	ucs_char_t last;
-};
-
 size_t display_mode_esc_sequence_len(const char *s)
 {
 	const char *p = s;
diff --git a/utf8.h b/utf8.h
index 65d0e42..af855c5 100644
--- a/utf8.h
+++ b/utf8.h
@@ -1,8 +1,17 @@
 #ifndef GIT_UTF8_H
 #define GIT_UTF8_H
 
+#include "strbuf.h"
+
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
+/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
+
+struct interval {
+	ucs_char_t first;
+	ucs_char_t last;
+};
+
 size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, int len, int skip_ansi);
diff --git a/wt-status.h b/wt-status.h
index 283a9fe..38f930a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "string-list.h"
 #include "color.h"
+#include "pathspec.h"
 
 enum color_wt_status {
 	WT_STATUS_HEADER = 0,
-- 
2.1.0.62.g7dc6c49

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] standardize brace placement in struct definitions
Date: Wed, 16 Mar 2011 02:08:34 -0500
Message-ID: <20110316070834.GF5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:08:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkqf-0007qm-UV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1CPHIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:08:44 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52915 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1CPHIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:08:41 -0400
Received: by yia27 with SMTP id 27so543728yia.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vsyG6DNZcm2QStPLQJuLSXhiGxGb/CzhOS13SW5a070=;
        b=A6yLbDlSomjgFh+NhTTskzseNm4PXb0XZKPYRec7wnm8pe7JddYsyAJkkbI/2J3Uvz
         J0GSv5NGONDbpVbOq1uLMFAtkA8m62yGOA8oNV5HKQpnY8C8eifMyqGYHIvxXkxD+RH6
         Ty2dt+YdBQ8Y4N5YIi+Jji3fbX5E2xYS/jUp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eUwI5DHNJT3XkN8o8xFt+kvYUXjxEBTDzxxblgIVEMyOyn3YX2eDg2O8Wuknuzkoqz
         m1bVMyMj96YHms8WLKS4UxZixGsn5ali0VwflH7rOAGMU5OJFkmryi6wGkJXh8ZqSZL+
         MKOvBpHceXyMAKDjnwybWIH4sHL2GcvC2gOa8=
Received: by 10.150.160.19 with SMTP id i19mr1019889ybe.111.1300259319106;
        Wed, 16 Mar 2011 00:08:39 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id v35sm3375387yba.16.2011.03.16.00.08.37
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:08:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169113>

In a struct definitions, unlike functions, the prevailing style is for
the opening brace to go on the same line as the struct name, like so:

 struct foo {
	int bar;
	char *baz;
 };

Indeed, grepping for 'struct [a-z_]* {$' yields about 5 times as many
matches as 'struct [a-z_]*$'.

Linus sayeth:

 Heretic people all over the world have claimed that this inconsistency
 is ...  well ...  inconsistent, but all right-thinking people know that
 (a) K&R are _right_ and (b) K&R are right.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The real reason: when I read through fast-import I end up wishing I
could fit more struct definitions in my 31-line terminal.

 builtin/add.c        |    3 +--
 builtin/blame.c      |    3 +--
 builtin/grep.c       |    3 +--
 builtin/index-pack.c |    6 ++----
 commit.h             |    3 +--
 config.c             |    3 +--
 diff.c               |    6 ++----
 fast-import.c        |   42 ++++++++++++++----------------------------
 fetch-pack.h         |    3 +--
 generate-cmdlist.sh  |    3 +--
 http-push.c          |   15 +++++----------
 http-walker.c        |    6 ++----
 http.h               |   15 +++++----------
 merge-recursive.c    |   12 ++++--------
 pack-check.c         |    3 +--
 string-list.h        |    3 +--
 transport-helper.c   |    3 +--
 17 files changed, 44 insertions(+), 88 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f7a17e4..e127d5a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -21,8 +21,7 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 
-struct update_callback_data
-{
+struct update_callback_data {
 	int flags;
 	int add_errors;
 };
diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec5..f6b03f7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1312,8 +1312,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 /*
  * Information on commits, used for output.
  */
-struct commit_info
-{
+struct commit_info {
 	const char *author;
 	const char *author_mail;
 	unsigned long author_time;
diff --git a/builtin/grep.c b/builtin/grep.c
index 5afee2f..eaf8560 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -40,8 +40,7 @@ enum work_type {WORK_SHA1, WORK_FILE};
  * threads. The producer adds struct work_items to 'todo' and the
  * consumers pick work items from the same array.
  */
-struct work_item
-{
+struct work_item {
 	enum work_type type;
 	char *name;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8dc5c0b..c7e600d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -13,8 +13,7 @@
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [ --keep | --keep=<msg> ] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
-struct object_entry
-{
+struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
 	unsigned int hdr_size;
@@ -44,8 +43,7 @@ struct base_data {
 #define FLAG_LINK (1u<<20)
 #define FLAG_CHECKED (1u<<21)
 
-struct delta_entry
-{
+struct delta_entry {
 	union delta_base base;
 	int obj_no;
 };
diff --git a/commit.h b/commit.h
index 659c87c..4198513 100644
--- a/commit.h
+++ b/commit.h
@@ -68,8 +68,7 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED
 };
 
-struct pretty_print_context
-{
+struct pretty_print_context {
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
diff --git a/config.c b/config.c
index b94de8f..fa740a6 100644
--- a/config.c
+++ b/config.c
@@ -20,8 +20,7 @@ static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
 
-struct config_item
-{
+struct config_item {
 	struct config_item *next;
 	char *name;
 	char *value;
diff --git a/diff.c b/diff.c
index 6640857..3fd9e0c 100644
--- a/diff.c
+++ b/diff.c
@@ -615,16 +615,14 @@ static void diff_words_append(char *line, unsigned long len,
 	buffer->text.ptr[buffer->text.size] = '\0';
 }
 
-struct diff_words_style_elem
-{
+struct diff_words_style_elem {
 	const char *prefix;
 	const char *suffix;
 	const char *color; /* NULL; filled in by the setup code if
 			    * color is enabled */
 };
 
-struct diff_words_style
-{
+struct diff_words_style {
 	enum diff_words_type type;
 	struct diff_words_style_elem new, old, ctx;
 	const char *newline;
diff --git a/fast-import.c b/fast-import.c
index e24ee2c..d9f9a3f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -170,8 +170,7 @@ Format of STDIN stream:
 #define DEPTH_BITS 13
 #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
 
-struct object_entry
-{
+struct object_entry {
 	struct pack_idx_entry idx;
 	struct object_entry *next;
 	uint32_t type : TYPE_BITS,
@@ -179,16 +178,14 @@ struct object_entry
 		depth : DEPTH_BITS;
 };
 
-struct object_entry_pool
-{
+struct object_entry_pool {
 	struct object_entry_pool *next_pool;
 	struct object_entry *next_free;
 	struct object_entry *end;
 	struct object_entry entries[FLEX_ARRAY]; /* more */
 };
 
-struct mark_set
-{
+struct mark_set {
 	union {
 		struct object_entry *marked[1024];
 		struct mark_set *sets[1024];
@@ -196,57 +193,49 @@ struct mark_set
 	unsigned int shift;
 };
 
-struct last_object
-{
+struct last_object {
 	struct strbuf data;
 	off_t offset;
 	unsigned int depth;
 	unsigned no_swap : 1;
 };
 
-struct mem_pool
-{
+struct mem_pool {
 	struct mem_pool *next_pool;
 	char *next_free;
 	char *end;
 	uintmax_t space[FLEX_ARRAY]; /* more */
 };
 
-struct atom_str
-{
+struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
 	char str_dat[FLEX_ARRAY]; /* more */
 };
 
 struct tree_content;
-struct tree_entry
-{
+struct tree_entry {
 	struct tree_content *tree;
 	struct atom_str *name;
-	struct tree_entry_ms
-	{
+	struct tree_entry_ms {
 		uint16_t mode;
 		unsigned char sha1[20];
 	} versions[2];
 };
 
-struct tree_content
-{
+struct tree_content {
 	unsigned int entry_capacity; /* must match avail_tree_content */
 	unsigned int entry_count;
 	unsigned int delta_depth;
 	struct tree_entry *entries[FLEX_ARRAY]; /* more */
 };
 
-struct avail_tree_content
-{
+struct avail_tree_content {
 	unsigned int entry_capacity; /* must match tree_content */
 	struct avail_tree_content *next_avail;
 };
 
-struct branch
-{
+struct branch {
 	struct branch *table_next_branch;
 	struct branch *active_next_branch;
 	const char *name;
@@ -258,16 +247,14 @@ struct branch
 	unsigned char sha1[20];
 };
 
-struct tag
-{
+struct tag {
 	struct tag *next_tag;
 	const char *name;
 	unsigned int pack_id;
 	unsigned char sha1[20];
 };
 
-struct hash_list
-{
+struct hash_list {
 	struct hash_list *next;
 	unsigned char sha1[20];
 };
@@ -278,8 +265,7 @@ typedef enum {
 	WHENSPEC_NOW
 } whenspec_type;
 
-struct recent_command
-{
+struct recent_command {
 	struct recent_command *prev;
 	struct recent_command *next;
 	char *buf;
diff --git a/fetch-pack.h b/fetch-pack.h
index fbe85ac..0608eda 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -1,8 +1,7 @@
 #ifndef FETCH_PACK_H
 #define FETCH_PACK_H
 
-struct fetch_pack_args
-{
+struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 75c68d9..3ef4861 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,8 +1,7 @@
 #!/bin/sh
 
 echo "/* Automatically generated by $0 */
-struct cmdname_help
-{
+struct cmdname_help {
     char name[16];
     char help[80];
 };
diff --git a/http-push.c b/http-push.c
index ff41a0e..d18346c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -82,8 +82,7 @@ static int helper_status;
 
 static struct object_list *objects;
 
-struct repo
-{
+struct repo {
 	char *url;
 	char *path;
 	int path_len;
@@ -108,8 +107,7 @@ enum transfer_state {
 	COMPLETE
 };
 
-struct transfer_request
-{
+struct transfer_request {
 	struct object *obj;
 	char *url;
 	char *dest;
@@ -127,8 +125,7 @@ struct transfer_request
 
 static struct transfer_request *request_queue_head;
 
-struct xml_ctx
-{
+struct xml_ctx {
 	char *name;
 	int len;
 	char *cdata;
@@ -136,8 +133,7 @@ struct xml_ctx
 	void *userData;
 };
 
-struct remote_lock
-{
+struct remote_lock {
 	char *url;
 	char *owner;
 	char *token;
@@ -156,8 +152,7 @@ struct remote_lock
 /* Flags that remote_ls passes to callback functions */
 #define IS_DIR (1u << 0)
 
-struct remote_ls_ctx
-{
+struct remote_ls_ctx {
 	char *path;
 	void (*userFunc)(struct remote_ls_ctx *ls);
 	void *userData;
diff --git a/http-walker.c b/http-walker.c
index 18bd650..9bc8114 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,8 +3,7 @@
 #include "walker.h"
 #include "http.h"
 
-struct alt_base
-{
+struct alt_base {
 	char *base;
 	int got_indices;
 	struct packed_git *packs;
@@ -18,8 +17,7 @@ enum object_request_state {
 	COMPLETE
 };
 
-struct object_request
-{
+struct object_request {
 	struct walker *walker;
 	unsigned char sha1[20];
 	struct alt_base *repo;
diff --git a/http.h b/http.h
index 5c6e243..e9ed3c2 100644
--- a/http.h
+++ b/http.h
@@ -42,14 +42,12 @@
 #define NO_CURL_IOCTL
 #endif
 
-struct slot_results
-{
+struct slot_results {
 	CURLcode curl_result;
 	long http_code;
 };
 
-struct active_request_slot
-{
+struct active_request_slot {
 	CURL *curl;
 	FILE *local;
 	int in_use;
@@ -62,8 +60,7 @@ struct active_request_slot
 	struct active_request_slot *next;
 };
 
-struct buffer
-{
+struct buffer {
 	struct strbuf buf;
 	size_t posn;
 };
@@ -149,8 +146,7 @@ extern int http_fetch_ref(const char *base, struct ref *ref);
 extern int http_get_info_packs(const char *base_url,
 	struct packed_git **packs_head);
 
-struct http_pack_request
-{
+struct http_pack_request {
 	char *url;
 	struct packed_git *target;
 	struct packed_git **lst;
@@ -166,8 +162,7 @@ extern int finish_http_pack_request(struct http_pack_request *preq);
 extern void release_http_pack_request(struct http_pack_request *preq);
 
 /* Helpers for fetching object */
-struct http_object_request
-{
+struct http_object_request {
 	char *url;
 	char tmpfile[PATH_MAX];
 	int localfile;
diff --git a/merge-recursive.c b/merge-recursive.c
index 2a4f739..3debbc4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -83,10 +83,8 @@ struct rename_df_conflict_info {
  * Since we want to write the index eventually, we cannot reuse the index
  * for these (temporary) data.
  */
-struct stage_data
-{
-	struct
-	{
+struct stage_data {
+	struct {
 		unsigned mode;
 		unsigned char sha[20];
 	} stages[4];
@@ -390,8 +388,7 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	}
 }
 
-struct rename
-{
+struct rename {
 	struct diff_filepair *pair;
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
@@ -704,8 +701,7 @@ static void update_file(struct merge_options *o,
 
 /* Low level file merging, update and removal */
 
-struct merge_file_info
-{
+struct merge_file_info {
 	unsigned char sha[20];
 	unsigned mode;
 	unsigned clean:1,
diff --git a/pack-check.c b/pack-check.c
index 9d0cb9a..c3bf21d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -2,8 +2,7 @@
 #include "pack.h"
 #include "pack-revindex.h"
 
-struct idx_entry
-{
+struct idx_entry {
 	off_t                offset;
 	const unsigned char *sha1;
 	unsigned int nr;
diff --git a/string-list.h b/string-list.h
index 4946938..bda6983 100644
--- a/string-list.h
+++ b/string-list.h
@@ -5,8 +5,7 @@ struct string_list_item {
 	char *string;
 	void *util;
 };
-struct string_list
-{
+struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
 	unsigned int strdup_strings:1;
diff --git a/transport-helper.c b/transport-helper.c
index ba06b70..0c5b1bd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -12,8 +12,7 @@
 
 static int debug;
 
-struct helper_data
-{
+struct helper_data {
 	const char *name;
 	struct child_process *helper;
 	FILE *out;
-- 
1.7.4.1

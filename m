From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH 1/2] removed some unused variables
Date: Sat, 7 Mar 2009 21:02:10 +0100
Message-ID: <7f978c810903071202w59a5ca37id6d1fee405c24e9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:03:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2kJ-0004zt-1v
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbZCGUCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbZCGUCO
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:02:14 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:64202 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbZCGUCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:02:13 -0500
Received: by bwz26 with SMTP id 26so750305bwz.37
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=87r4YJS6cSHSQo/96w3CIVqGGCEt3Nval/8xr9I7Q6w=;
        b=pkD2WkjSQ8RBLRwvKtL1Mo7rDJHz6MUEZj+bbcfJN0K7lPACxCk5dEftuWGpsXMSZk
         B+jAlXoElmyDIP/+xXSOvyBMETlrLNtV9gKVDAccC7THGdB/dczJqe7vzuQrmBtEhUZV
         G7gbP3V/sxnexK1phugtxw8tojFUVLWpFvldg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=m7SiJs8YSU2OoPZQNjykR9sa8x2DQO03x2r0h1S8eFKLdOHjqYvS2Xzi5FrRGcifXs
         JjsRuwHoak2NaWxUyrQDfuZ4W/d3kXEdDj66hqmoWkpxaOWx2lw4Ev513+wUvbfYjdmq
         TfhAgzonL5wP3FdqE5b3VBXVkyUazrx9GeCyk=
Received: by 10.103.213.10 with SMTP id p10mr1745793muq.17.1236456130082; Sat, 
	07 Mar 2009 12:02:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112572>

these variables were unused and can be removed safely

builtin-clone: removed unused variable 'option_no_hardlinks'
builtin-clone: removed unused variable 'use_separate_remote'
builtin-fetch-pack: removed unused variable 'len'
builtin-remote: removed unused variable 'symref'
diff: removed unused variable 'total'
diffcore-break: removed unused variable 'base_size'
fast-import: removed unused variable 'date'
fast-import: removed unused variable 'sign'
fsck: removed unused variable 'o_sha1'
fsck: removed unused variable 'sha1'
xdiff-interface: removed unused variable 'read_some'

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 builtin-clone.c      |    6 ------
 builtin-fetch-pack.c |    3 +--
 builtin-remote.c     |    3 +--
 diff.c               |    4 +---
 diffcore-break.c     |    3 +--
 fast-import.c        |    8 +++-----
 fsck.c               |    6 +-----
 xdiff-interface.c    |    3 +--
 8 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..92826cd 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -365,8 +365,6 @@ static void install_branch_config(const char *local,

 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
-	int use_local_hardlinks = 1;
-	int use_separate_remote = 1;
 	int is_bundle = 0;
 	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
@@ -388,9 +386,6 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
 	if (argc == 0)
 		die("You must specify a repository to clone.");

-	if (option_no_hardlinks)
-		use_local_hardlinks = 0;
-
 	if (option_mirror)
 		option_bare = 1;

@@ -399,7 +394,6 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
 		option_no_checkout = 1;
-		use_separate_remote = 0;
 	}

 	if (!option_origin)
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 67fb80e..c2e5adc 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -216,9 +216,8 @@ static int find_common(int fd[2], unsigned char
*result_sha1,
 	if (args.depth > 0) {
 		char line[1024];
 		unsigned char sha1[20];
-		int len;

-		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
+		while (packet_read_line(fd[0], line, sizeof(line))) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
diff --git a/builtin-remote.c b/builtin-remote.c
index ac69d37..e171096 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -484,9 +484,8 @@ static int mv(int argc, const char **argv)
 		struct string_list_item *item = remote_branches.items + i;
 		int flag = 0;
 		unsigned char sha1[20];
-		const char *symref;

-		symref = resolve_ref(item->string, sha1, 1, &flag);
+		resolve_ref(item->string, sha1, 1, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
diff --git a/diff.c b/diff.c
index 3feca1b..e06c937 100644
--- a/diff.c
+++ b/diff.c
@@ -875,7 +875,7 @@ static void fill_print_name(struct diffstat_file *file)

 static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
-	int i, len, add, del, total, adds = 0, dels = 0;
+	int i, len, add, del, adds = 0, dels = 0;
 	int max_change = 0, max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
@@ -978,14 +978,12 @@ static void show_stats(struct diffstat_t* data,
struct diff_options *options)
 		 */
 		add = added;
 		del = deleted;
-		total = add + del;
 		adds += add;
 		dels += del;

 		if (width <= max_change) {
 			add = scale_linear(add, width, max_change);
 			del = scale_linear(del, width, max_change);
-			total = add + del;
 		}
 		show_name(options->file, prefix, name, len, reset, set);
 		fprintf(options->file, "%5d%s", added + deleted,
diff --git a/diffcore-break.c b/diffcore-break.c
index 31cdcfe..d7097bb 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -45,7 +45,7 @@ static int should_break(struct diff_filespec *src,
 	 * The value we return is 1 if we want the pair to be broken,
 	 * or 0 if we do not.
 	 */
-	unsigned long delta_size, base_size, max_size;
+	unsigned long delta_size, max_size;
 	unsigned long src_copied, literal_added, src_removed;

 	*merge_score_p = 0; /* assume no deletion --- "do not break"
@@ -64,7 +64,6 @@ static int should_break(struct diff_filespec *src,
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */

-	base_size = ((src->size < dst->size) ? src->size : dst->size);
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
 	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
diff --git a/fast-import.c b/fast-import.c
index 3748ddf..beeac0d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1745,21 +1745,19 @@ static void parse_data(struct strbuf *sb)
 static int validate_raw_date(const char *src, char *result, int maxlen)
 {
 	const char *orig_src = src;
-	char *endp, sign;
-	unsigned long date;
+	char *endp;

 	errno = 0;

-	date = strtoul(src, &endp, 10);
+	strtoul(src, &endp, 10);
 	if (errno || endp == src || *endp != ' ')
 		return -1;

 	src = endp + 1;
 	if (*src != '-' && *src != '+')
 		return -1;
-	sign = *src;

-	date = strtoul(src + 1, &endp, 10);
+	strtoul(src + 1, &endp, 10);
 	if (errno || endp == src || *endp || (endp - orig_src) >= maxlen)
 		return -1;

diff --git a/fsck.c b/fsck.c
index 97f76c5..511b82c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -148,20 +148,17 @@ static int fsck_tree(struct tree *item, int
strict, fsck_error error_func)
 	struct tree_desc desc;
 	unsigned o_mode;
 	const char *o_name;
-	const unsigned char *o_sha1;

 	init_tree_desc(&desc, item->buffer, item->size);

 	o_mode = 0;
 	o_name = NULL;
-	o_sha1 = NULL;

 	while (desc.size) {
 		unsigned mode;
 		const char *name;
-		const unsigned char *sha1;

-		sha1 = tree_entry_extract(&desc, &name, &mode);
+		tree_entry_extract(&desc, &name, &mode);

 		if (strchr(name, '/'))
 			has_full_path = 1;
@@ -207,7 +204,6 @@ static int fsck_tree(struct tree *item, int
strict, fsck_error error_func)

 		o_mode = mode;
 		o_name = name;
-		o_sha1 = sha1;
 	}

 	retval = 0;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index d782f06..b9b0db8 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -15,11 +15,10 @@ static int parse_num(char **cp_p, int *num_p)
 {
 	char *cp = *cp_p;
 	int num = 0;
-	int read_some;

 	while ('0' <= *cp && *cp <= '9')
 		num = num * 10 + *cp++ - '0';
-	if (!(read_some = cp - *cp_p))
+	if (!(cp - *cp_p))
 		return -1;
 	*cp_p = cp;
 	*num_p = num;
-- 
1.6.2.81.ge603.dirty

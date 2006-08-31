From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use xmalloc instead of malloc
Date: Fri, 1 Sep 2006 00:32:39 +0200
Message-ID: <20060831223239.GB482@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 01 00:33:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIv5c-0006KP-DC
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 00:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWHaWcp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWHaWcp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 18:32:45 -0400
Received: from [130.225.96.91] ([130.225.96.91]:48322 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932464AbWHaWco (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 18:32:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id AC2EA77005F
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:32:41 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07743-08 for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:32:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 209FA77004C
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:32:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 5C8176DF835
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:31:13 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0EA4762A06; Fri,  1 Sep 2006 00:32:40 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26281>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-fmt-merge-msg.c |    6 +++---
 builtin-repo-config.c   |    4 ++--
 config.c                |    4 ++--
 git.c                   |    2 +-
 help.c                  |    2 +-
 merge-recursive.c       |    6 +++---
 mktag.c                 |    2 +-
 send-pack.c             |    4 ++--
 sha1_file.c             |    2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 76d22b4..ed59e77 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -140,14 +140,14 @@ static int handle_line(char *line)
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
 		int len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'') {
-			char *new_origin = malloc(len - 1);
+			char *new_origin = xmalloc(len - 1);
 			memcpy(new_origin, origin + 1, len - 2);
 			new_origin[len - 1] = 0;
 			origin = new_origin;
 		} else
 			origin = strdup(origin);
 	} else {
-		char *new_origin = malloc(strlen(origin) + strlen(src) + 5);
+		char *new_origin = xmalloc(strlen(origin) + strlen(src) + 5);
 		sprintf(new_origin, "%s of %s", origin, src);
 		origin = new_origin;
 	}
@@ -214,7 +214,7 @@ static void shortlog(const char *name, u
 
 		if (eol) {
 			int len = eol - bol;
-			oneline = malloc(len + 1);
+			oneline = xmalloc(len + 1);
 			memcpy(oneline, bol, len);
 			oneline[len] = 0;
 		} else
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index 888466c..d19f7dc 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -84,7 +84,7 @@ static int get_value(const char* key_, c
 		*tl = tolower(*tl);
 
 	if (use_key_regexp) {
-		key_regexp = (regex_t*)malloc(sizeof(regex_t));
+		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			goto free_strings;
@@ -97,7 +97,7 @@ static int get_value(const char* key_, c
 			regex_++;
 		}
 
-		regexp = (regex_t*)malloc(sizeof(regex_t));
+		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
 			goto free_strings;
diff --git a/config.c b/config.c
index d9f2b78..782cc31 100644
--- a/config.c
+++ b/config.c
@@ -565,7 +565,7 @@ int git_config_set_multivar(const char* 
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	store.key = (char*)malloc(strlen(key)+1);
+	store.key = xmalloc(strlen(key) + 1);
 	dot = 0;
 	for (i = 0; key[i]; i++) {
 		unsigned char c = key[i];
@@ -633,7 +633,7 @@ int git_config_set_multivar(const char* 
 			} else
 				store.do_not_match = 0;
 
-			store.value_regex = (regex_t*)malloc(sizeof(regex_t));
+			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
 				fprintf(stderr, "Invalid pattern: %s\n",
diff --git a/git.c b/git.c
index bd07289..05871ad 100644
--- a/git.c
+++ b/git.c
@@ -29,7 +29,7 @@ static void prepend_to_path(const char *
 
 	path_len = len + strlen(old_path) + 1;
 
-	path = malloc(path_len + 1);
+	path = xmalloc(path_len + 1);
 
 	memcpy(path, dir, len);
 	path[len] = ':';
diff --git a/help.c b/help.c
index 9ecdefd..0824c25 100644
--- a/help.c
+++ b/help.c
@@ -184,7 +184,7 @@ static void show_man_page(const char *gi
 		page = git_cmd;
 	else {
 		int page_len = strlen(git_cmd) + 4;
-		char *p = malloc(page_len + 1);
+		char *p = xmalloc(page_len + 1);
 		strcpy(p, "git-");
 		strcpy(p + 4, git_cmd);
 		p[page_len] = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 39a1eae..48b2763 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -283,7 +283,7 @@ static int save_files_dirs(const unsigne
 		unsigned int mode, int stage)
 {
 	int len = strlen(path);
-	char *newpath = malloc(baselen + len + 1);
+	char *newpath = xmalloc(baselen + len + 1);
 	memcpy(newpath, base, baselen);
 	memcpy(newpath + baselen, path, len);
 	newpath[baselen + len] = '\0';
@@ -455,7 +455,7 @@ static int remove_path(const char *name)
 	if (ret)
 		return ret;
 	len = strlen(name);
-	dirs = malloc(len+1);
+	dirs = xmalloc(len+1);
 	memcpy(dirs, name, len);
 	dirs[len] = '\0';
 	while ((slash = strrchr(name, '/'))) {
@@ -572,7 +572,7 @@ void update_file_flags(const unsigned ch
 			flush_buffer(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
-			char *lnk = malloc(size + 1);
+			char *lnk = xmalloc(size + 1);
 			memcpy(lnk, buf, size);
 			lnk[size] = '\0';
 			mkdir_p(path, 0777);
diff --git a/mktag.c b/mktag.c
index be23e58..3448a5d 100644
--- a/mktag.c
+++ b/mktag.c
@@ -119,7 +119,7 @@ #undef PD_FMT
 int main(int argc, char **argv)
 {
 	unsigned long size = 4096;
-	char *buffer = malloc(size);
+	char *buffer = xmalloc(size);
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
diff --git a/send-pack.c b/send-pack.c
index fd79a61..ac4501d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -53,7 +53,7 @@ static void exec_rev_list(struct ref *re
 		if (900 < i)
 			die("git-rev-list environment overflow");
 		if (!is_zero_sha1(ref->new_sha1)) {
-			char *buf = malloc(100);
+			char *buf = xmalloc(100);
 			args[i++] = buf;
 			snprintf(buf, 50, "%s", sha1_to_hex(ref->new_sha1));
 			buf += 50;
@@ -75,7 +75,7 @@ static void exec_rev_list(struct ref *re
 		if (is_zero_sha1(ref->new_sha1) &&
 		    !is_zero_sha1(ref->old_sha1) &&
 		    has_sha1_file(ref->old_sha1)) {
-			char *buf = malloc(42);
+			char *buf = xmalloc(42);
 			args[i++] = buf;
 			snprintf(buf, 42, "^%s", sha1_to_hex(ref->old_sha1));
 		}
diff --git a/sha1_file.c b/sha1_file.c
index 01aa745..912e1cc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1774,7 +1774,7 @@ int read_pipe(int fd, char** return_buf,
 int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 {
 	unsigned long size = 4096;
-	char *buf = malloc(size);
+	char *buf = xmalloc(size);
 	int ret;
 	unsigned char hdr[50];
 	int hdrlen;
-- 
1.4.2.g2ba6b-dirty

-- 
Jonas Fonseca

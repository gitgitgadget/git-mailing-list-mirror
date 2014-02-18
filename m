From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Rename read_replace_refs to check_replace_refs
Date: Tue, 18 Feb 2014 12:24:55 +0100
Message-ID: <1392722695-31815-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 12:25:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFinl-000102-0w
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 12:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbaBRLZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 06:25:20 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53089 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbaBRLZS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 06:25:18 -0500
X-AuditID: 12074413-f79076d000002d17-b2-5303431d23b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.D5.11543.D1343035; Tue, 18 Feb 2014 06:25:17 -0500 (EST)
Received: from michael.fritz.box (p4FDD42DF.dip0.t-ipconnect.de [79.221.66.223])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1IBOvml015881
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 18 Feb 2014 06:25:16 -0500
X-Mailer: git-send-email 1.8.5.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqCvnzBxs8IfXoutKN5NFQ+8VZovb
	K+YzOzB7/H3/gcnj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M5Y8m89W8MC8Yn9rM1sD43Td
	LkZODgkBE4nV+2+xQdhiEhfurQeyuTiEBC4zSjS93sMI4Zxgkti05i9YFZuArsSinmYmEFtE
	QE1iYtshFhCbWcBBYvPnRqAGDg5hAXuJ0ycjQMIsAqoSW9Y+ZQaxeQVcJJp+NrNALFOQaFm2
	i30CI/cCRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCGeF97BuOuk3CFG
	AQ5GJR7eH1pMwUKsiWXFlbmHGCU5mJREeU86MgcL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH1
	MwPK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeL2cgBoFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQYEeXwwMdZAUD9BeJ5B23uKCxFygKETrKUZFKXHe
	RSDHCoAkMkrz4MbC4vkVozjQl8K8EiDtPMBUANf9CmgwE9Bgr72MIINLEhFSUg2MhrPXfSvp
	dHQ62mb9eE76kVnf3Ln8cy5ca9/8wNB1esDjNQGyOWaCCmumi9Qv3Mq05FTZ7hdnbP/PEbh8
	+npO76/H62VX1j20nJB4YPWM9xmuS2NNUsplpk0qNmf7mxt4j7XN9qXPeZ5vFxv2FnSz/G0M
	mt69Pu1+5+w/l/d3+mq3b5jQslW/V4mlOCPRUIu5qDgRAHHqG9nCAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242296>

The semantics of this flag was changed in commit

    e1111cef23 inline lookup_replace_object() calls

but wasn't renamed at the time to minimize code churn.  Rename it now,
and add a comment explaining its use.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This change doesn't conflict with anything in pu; perhaps we can
squeeze it in now?

 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/pack-objects.c   |  2 +-
 builtin/prune.c          |  2 +-
 builtin/replace.c        |  2 +-
 builtin/unpack-objects.c |  2 +-
 cache.h                  | 14 ++++++++++++--
 environment.c            |  4 ++--
 git.c                    |  2 +-
 log-tree.c               |  2 +-
 replace_object.c         |  2 +-
 upload-pack.c            |  2 +-
 12 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..3d42978 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -630,7 +630,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	struct alternate_object_database *alt;
 
 	errors_found = 0;
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2f37a38..a6b1c17 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1502,7 +1502,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 541667f..124015d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2507,7 +2507,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
diff --git a/builtin/prune.c b/builtin/prune.c
index de43b26..68adc1c 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -150,7 +150,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 	init_revisions(&revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/replace.c b/builtin/replace.c
index 2336325..8b59775 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -178,7 +178,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ff673..df2d3e3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -497,7 +497,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	int i;
 	unsigned char sha1[20];
 
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	git_config(git_default_config, NULL);
 
diff --git a/cache.h b/cache.h
index dc040fb..b039abc 100644
--- a/cache.h
+++ b/cache.h
@@ -580,7 +580,17 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
-extern int read_replace_refs;
+
+/*
+ * Do replace refs need to be checked this run?  This variable is
+ * initialized to true unless --no-replace-object is used or
+ * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
+ * commands that do not want replace references to be active.  As an
+ * optimization it is also set to false if replace references have
+ * been sought but there were none.
+ */
+extern int check_replace_refs;
+
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
@@ -791,7 +801,7 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
-	if (!read_replace_refs)
+	if (!check_replace_refs)
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
diff --git a/environment.c b/environment.c
index 4a3437d..c3c8606 100644
--- a/environment.c
+++ b/environment.c
@@ -45,7 +45,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int read_replace_refs = 1; /* NEEDSWORK: rename to use_replace_refs */
+int check_replace_refs = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -147,7 +147,7 @@ static void setup_git_env(void)
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
-		read_replace_refs = 0;
+		check_replace_refs = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/git.c b/git.c
index 7cf2953..9efd1a3 100644
--- a/git.c
+++ b/git.c
@@ -78,7 +78,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
-			read_replace_refs = 0;
+			check_replace_refs = 0;
 			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
diff --git a/log-tree.c b/log-tree.c
index 08970bf..5ce217d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -100,7 +100,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 
 	if (starts_with(refname, "refs/replace/")) {
 		unsigned char original_sha1[20];
-		if (!read_replace_refs)
+		if (!check_replace_refs)
 			return 0;
 		if (get_sha1_hex(refname + 13, original_sha1)) {
 			warning("invalid replace ref %s", refname);
diff --git a/replace_object.c b/replace_object.c
index cdcaf8c..c5cf9f4 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -86,7 +86,7 @@ static void prepare_replace_object(void)
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
 	if (!replace_object_nr)
-		read_replace_refs = 0;
+		check_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..9314c25 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -796,7 +796,7 @@ int main(int argc, char **argv)
 
 	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
-	read_replace_refs = 0;
+	check_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
-- 
1.8.5.3

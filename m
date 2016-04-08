From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 11/18] merge: Add a new --index-only option, not yet implemented
Date: Thu,  7 Apr 2016 23:58:39 -0700
Message-ID: <1460098726-5958-12-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOk-0002y6-2n
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbcDHG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:51 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33031 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550AbcDHG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:10 -0400
Received: by mail-pa0-f65.google.com with SMTP id q6so8527133pav.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XYqugW9qhoBSGJl/ceHj8wUB1AJzIQLKAp7qkN/nMGc=;
        b=s3KV8OOoDMyr2izJkCgS6qL5o54GG6pIJvDBad95Y7lCypEDGSk5hdWstz5RngjVam
         tOsOV3HDJak8r9vWTGbmqUymRHBqtyfEPzNlJ3EYFO5jy/g+8+hj9OaVw/V4jexuWk2+
         StEm7juFosZ7uMzwlHAL5vSu1SK9ReAkqldbRratyEqx9J+dfCizL8v15/DMBJVD8UUd
         fXH+fH5v0FV0lzM/+scSlyTMbxTPR0Bb0h8RoKK3M0Yid03q1mZnni6N5MLAkvUaRopi
         3Pk59glFQ45dVXMUYDFdUKqmHO0PukZ4+xU9eW6sbv5U9KFlkdUxDgv3m8VyKuSVIKmK
         QOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XYqugW9qhoBSGJl/ceHj8wUB1AJzIQLKAp7qkN/nMGc=;
        b=MhKkET7U9x/eBs8j4jO4WYwLzpCoyFz+83scjBHHe+KwcQiLQ2N9/nRgi7HfNdJmKq
         2HIkYRf+1dUmYu/PQ8xAcFur1wlehrt+iGMYlhuA3qbTlypV6f41HjW+CeJn+TnUtFO/
         AntMyxT6RMTzsLvft7FdKtk+DczzAoIX/uUjlGB7g4TdCV3I3QvylZGOGdRRDLHXvpVN
         gnSrFs0O86SKwEZApfMUkfKnoCLT4/kF66MswNvH8YRjVFtoHZ7Ce0HTuXPn88X31wvc
         98Icio3rC6I49mJDfnE+LUBJI4wxve7grlBHIA5N6pkgpVx0ZXQ6Hk+y0KQf8J+UsJLB
         UK+w==
X-Gm-Message-State: AD7BkJI1NUB3K4dCGTrX0rCF/stDY7Ed2OWk0OR/CohArNxOq09ABYATWlwF1dX1EMibqQ==
X-Received: by 10.66.246.234 with SMTP id xz10mr10489099pac.49.1460098749748;
        Thu, 07 Apr 2016 23:59:09 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291016>

Subsequent commits will add implementation for each relevant merge strategy

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge.txt | 14 ++++++++++++++
 builtin/merge.c             |  7 +++++++
 git.c                       |  2 +-
 merge-recursive.c           |  1 +
 merge-recursive.h           |  1 +
 t/t6043-merge-index-only.sh |  4 ++--
 6 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 07f7295..82a6d43 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -86,6 +86,20 @@ invocations. The automated message can include the branch description.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--index-only::
+	Perform merge on index only, leaving working tree alone.  Most
+	users do NOT want to use this flag, as it will leave the
+	working tree and the index completely out of sync, which is
+	very likely to confuse users and prevent a subsequent 'git
+	merge --abort' from working.  It is intended for script
+	writers to have a way to easily check whether a merge would
+	succeed and which files would conflict, typically from bare
+	clones.
++
+Note that files other than the index in the git-dir may also be
+modified when using this flag (e.g. MERGE_HEAD, MERGE_MSG, MERGE_RR,
+HEAD, whatever HEAD points at, and new objects under objects/).
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..ce5be0a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -63,6 +63,7 @@ static char *branch_mergeoptions;
 static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
+static int index_only = 0;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream = 1;
@@ -221,6 +222,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "index-only", &index_only,
+		N_("perform merge on index only, leaving working tree alone")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
@@ -663,6 +666,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			o.subtree_shift = "";
 
 		o.renormalize = option_renormalize;
+		o.index_only = index_only;
 		o.show_rename_progress =
 			show_progress == -1 ? isatty(2) : show_progress;
 
@@ -1193,6 +1197,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (!index_only)
+		setup_work_tree();
+
 	if (shortlog_len < 0)
 		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
 
diff --git a/git.c b/git.c
index 6cc0c07..b07485a 100644
--- a/git.c
+++ b/git.c
@@ -427,7 +427,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo },
 	{ "mailsplit", cmd_mailsplit },
-	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
+	{ "merge", cmd_merge, RUN_SETUP },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP },
diff --git a/merge-recursive.c b/merge-recursive.c
index 06d31ed..b346ed6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2041,6 +2041,7 @@ void init_merge_options(struct merge_options *o)
 	o->merge_rename_limit = -1;
 	o->renormalize = 0;
 	o->detect_rename = 1;
+	o->index_only = 0;
 	merge_recursive_config(o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
diff --git a/merge-recursive.h b/merge-recursive.h
index 52f0201..7e9955f 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -15,6 +15,7 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
+	unsigned index_only : 1;
 	long xdl_opts;
 	int verbosity;
 	int detect_rename;
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 5eda6b3..9bb64d8 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -374,7 +374,7 @@ test_expect_failure '--index-only octopus, bare' '
 	)
 '
 
-test_expect_failure '--index-only ours, non-bare' '
+test_expect_success '--index-only ours, non-bare' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -387,7 +387,7 @@ test_expect_failure '--index-only ours, non-bare' '
 	test ! -f c
 '
 
-test_expect_failure '--index-only ours, bare' '
+test_expect_success '--index-only ours, bare' '
 	rm -rf bare.clone &&
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
-- 
2.8.0.18.gc685494

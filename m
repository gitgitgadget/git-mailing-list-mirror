Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552241A79E
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169393; cv=none; b=HwHQ6ct0eflA79u4lrE4b4QQ+w8mc3BrtewBkEkD2yPebgCjnNebjj6PpcgWXXOr83S6ZoEvykrikA5BNzgBGXCq1TBCfqXp8gWKzvWxvYpsbn21n9ftd9nTvJUlFQ/aJA+MG7qUYeiBD9ZEUH6yoVwQX6YuPmX2nMhClMANAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169393; c=relaxed/simple;
	bh=IQ/utmjtZlNREzUbsoAUVfKmQpyJObcppuuZUjtch4o=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=b1QibpQ8kJx+cILkGrnAhsp4shY08RqgZisKioAI7oDKECm+WfCKzFZYWn5WgK8Fun5Ele+MWMaRmHaIWa8CaftuZ4oylwAhp3yAc67I4hUL1g6qZDdrVjrePBITJ0Cp80wt1Xzup8Hl3q4v6ShLObpNq/GUTTeTaCtSBQmntB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StQSnWKR; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StQSnWKR"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffef2so51180b6e.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789169389; x=1789774189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pAua0xd1LUi5V5XAzXTDIXTvHw5J6ikEmheZUe63UP8=;
        b=StQSnWKRGWW6ooILTsfo6l/SadI6mhNbjW6cF6HqEbUNAguOURNW4kc724sWD+AJ3s
         6LNDnFn7LCJcVf6ie+t1IgSjAfXVjiooBVQEigw00LkQi7CUeK1bI0+Joo67gONEWuC6
         gsfg2Rk9PpaeIiU+ZVsRaL8IgzfcKBmC9vBuJnLEa9d7dcfSM3c+5/zTEaneUAjM238c
         gmYhyhO8JBBmcZTpkPSrJ4ei1NVbCZdCq70yE/amlkfIAD5Pxyt26MAa2VoNnlZSYPYa
         iiz+kb52qQzCgf42GofkJ4HS4jMcTYM1j72qR6Zz0JMj0A/gRWDNpsBTTLM5DgoUowaC
         nvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169389; x=1789774189;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pAua0xd1LUi5V5XAzXTDIXTvHw5J6ikEmheZUe63UP8=;
        b=BL4XxP/g4d5LCQQ9xiUcd9t3y69pq/nhV494yBCEbjnjIkFhfHyh73iEUm9Ut4qWXB
         bAmZsRZllz70n5E9PnesWisLj8J5ukoa9I3i0znk8RoSTjmbnPA/S9Te5jjpVcSb95nb
         x/xz7Xddc/BJiKeoWbZRSp0O1PfByq2MyKtETs4cPnSYAUxQ00v05AtuBMByY416rA8w
         DlYBIpl//6RaMbM7nmVeAChkxA6FDZcsqkiIBBrxeFTuWTzTNlGk2H/IrwowD2izlxrw
         5NpbzkOpkCNtJR6SUmLTIGjahJTDnHqVS8WRXNQogZuZkV+69X4g3LWnsJxAaNJa0TZ+
         F4Pg==
X-Gm-Message-State: AFuF++kxUkcQN4z29MKjuwNAd2lSIGHNKTeFe6lHU2yykdX8KGImvJrH
	rLY/VQwYYoIVIWETehXTTwWOEkIY5nLhDIXblYcCuy5UgsjDAffLhJzm1vwaRg==
X-Gm-Gg: AYBFou1vc/ae/QVFcYb1N2aYfjbseP3Uc7HTSA+k9197OLUeO3DPY0g0rCqWdXCWfA8
	y6gxMyQsmsRvkpdIkh7aPH2Jiu1YpnBUkJdjGt8EzVm4p+x6QUqXX5hkfoX7DU61gALmtoANBCs
	Y7IcDR58gEH3yBKkshLpwWA7VyuJ2cCtUgCYfwoOKadFHQ+4wfXtkx0F9RbGjP/y1G0/PQvA3Ys
	fdlwKBKSalzZ8yBV0F8NqIfXPTczCPsI26eP1TdSjd4Xrr43i2V6DGJ7PmpTJh69ZltKQu2Q7po
	02vW5lbbcWwLdEVLYQB4LJwsZGdY9RhZM3Y38JjEDRBxApEwR36IPKZOsCjvotsc4/Nxk6tNt8k
	MU8jLmpDzDizGsk08soP7jcrBmzE504aRQsDcuNO+4iC1um6zO6uesKsnvk91hnN77gKtfdEkQa
	WeaJ6yxMvfJ2o/yD+n60SG8IP/RUd6Oq7ZaIHL+QzBQUtALj1nSNnyMGmZwqqXK77tzkWd4AQju
	Q==
X-Received: by 2002:a05:6808:1914:b0:4bb:5ceb:47e9 with SMTP id 5614622812f47-4c4a9acbe12mr689994b6e.37.1789169387399;
        Fri, 11 Sep 2026 16:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.13.234])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330dac382sm3726292b6e.6.2026.09.11.16.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:29:46 -0700 (PDT)
Message-Id: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 23:29:44 +0000
Subject: [PATCH] blame: default to ignoring revisions in
 .git-blame-ignore-revs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

git-blame(1) can ignore a list of commits specified via
--ignore-revs-file or the blame.ignoreRevsFile configuration option.
This is useful for skipping uninteresting revisions such as tree-wide
formatting changes, large-scale refactors, and code modernizations that
would otherwise obscure genuine historical authorship.

When revision-ignoring was introduced in commit ae3f36dea1 ("blame: add
blame.ignoreRevsFile config option", 2019-10-18), it intentionally
avoided adopting a default ignore file. At the time, the capability was
new and unproven, so avoiding unrequested filesystem I/O or unexpected
attribution shifts took priority over a project-wide default.
Requiring explicit opt-in per clone was therefore the prudent design.

Since then, maintaining a .git-blame-ignore-revs file in the repository
root has become the de facto standard across the Git ecosystem, adopted
by major hosting platforms (GitHub, GitLab, Gerrit) and prominent open
source projects (such as Chromium and LLVM). As a consequence,
developers frequently encounter a jarring mismatch: web interfaces
seamlessly ignore formatting commits, but local git-blame(1) and
git-annotate(1) runs do not, unless each user manually configures
blame.ignoreRevsFile for every local checkout.

Teach git-blame(1) and git-annotate(1) to automatically check for a
regular .git-blame-ignore-revs file at the root of the working tree when
operating in a non-bare repository.

To ensure consistent precedence, security, and override semantics:
- Loading the default file occurs before reading configuration and CLI
  options, preserving user and repository config overrides.
- Path resolution is anchored to repo_get_work_tree() and verified via
  lstat() to ensure it is a regular file. Symbolic links, directories,
  FIFOs, and sockets are safely skipped, preventing local information
  disclosure and denial-of-service hangs.
- In build_ignorelist(), ignore-rev files are parsed starting after the
  last empty string entry. This ensures setting blame.ignoreRevsFile to
  "" or passing --ignore-revs-file "" or --no-ignore-revs-file cleanly
  discards the default file without attempting to open or parse it,
  allowing users to bypass corrupted default files.
- Duplicate parsing is prevented by tracking seen files in a strset.

Update documentation in blame-options.adoc and config/blame.adoc, and
add comprehensive test coverage in t8013 for the default file lookup,
subdirectory invocations, CLI and config overrides, symlink rejection,
comments and whitespace handling, and bare repositories.

Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ravi Mistry <rmistry@google.com>
---
    blame: default to ignoring revisions in .git-blame-ignore-revs
    
    This series restarts the conversation from the stalled attempt in PR
    https://github.com/gitgitgadget/git/pull/1809 and addresses feature
    request https://github.com/gitgitgadget/git/issues/1494
    
    See the previous discussion in
    https://lore.kernel.org/git/pull.1809.v2.git.1728707867.gitgitgadget@gmail.com/
    
    In addition to resolving the questions raised by reviewers during the
    previous discussion, this updated iteration introduces important
    security hardening, bug fixes, and test improvements:
    
     1. Commit message rationale: The commit message now details why
        revision ignoring originally avoided a default file when the feature
        was first added:
        https://github.com/git/git/commit/ae3f36dea16e51041c56ba9ed6b38380c8421816
        It explains why ecosystem standardization across GitHub, GitLab,
        Gerrit, Chromium, and LLVM makes a default file desirable today,
        addressing the previous feedback from Phillip Wood. Trailers
        acknowledge earlier patch authorship and reviewer contributions.
    
     2. Security and path resolution: Path lookup is anchored to
        repo_get_work_tree(). Using lstat ensures that symbolic links,
        directories, FIFOs, and sockets are skipped safely.
    
     3. Configuration and option override semantics: The build_ignorelist()
        function begins processing after the last empty string entry.
        Setting blame.ignoreRevsFile to an empty string or providing an
        empty filename option on the command line allows users to bypass a
        corrupted default file without encountering a fatal error.
    
     4. Documentation updates: Documentation clarifies that configured files
        are processed after the default file. It explains how providing an
        empty filename disables the default file and notes that bare
        repositories do not search for the file. Documentation checks pass
        without warning.
    
     5. Test harness improvements: The test suite removes the destructive
        repository reset in t8013 and adds test coverage for comments,
        whitespace, zero byte files, symlink rejection, corrupted file
        overrides, and git annotate parity. Test lint checks pass without
        error.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

 Documentation/blame-options.adoc |   6 +-
 Documentation/config/blame.adoc  |   9 +-
 builtin/blame.c                  |  42 +++++++--
 t/t8013-blame-ignore-revs.sh     | 151 +++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+), 12 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 1ae1222b6b..17f5734d61 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -133,8 +133,10 @@ take effect.
 	Ignore revisions listed in _<file>_, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
 	processed after any files specified with the `blame.ignoreRevsFile` config
-	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	option or the default `.git-blame-ignore-revs` file.  An empty file name,
+	`""`, will clear the list of revs from previously processed files.
+	`--no-ignore-revs-file` will clear all previously specified ignore revs
+	files, including the default `.git-blame-ignore-revs` file.
 
 `--color-lines`::
 	Color line annotations in the default format differently if they come from
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..6f9be627e1 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -23,9 +23,12 @@ blame.showRoot::
 blame.ignoreRevsFile::
 	Ignore revisions listed in the file, one unabbreviated object name per
 	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
-	`#` are ignored.  This option may be repeated multiple times.  Empty
-	file names will reset the list of ignored revisions.  This option will
-	be handled before the command line option `--ignore-revs-file`.
+	`#` are ignored.  If `.git-blame-ignore-revs` exists at the root of the
+	working tree in a non-bare repository, it is used by default.  This option
+	may be repeated multiple times; files specified here are processed after
+	the default file.  An empty file name will reset the list of ignored
+	revisions from previously processed files and disable the default file.
+	This option is handled before the command-line option `--ignore-revs-file`.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..0935d864ad 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -15,9 +15,11 @@
 #include "hex.h"
 #include "commit.h"
 #include "diff.h"
+#include "path.h"
 #include "revision.h"
 #include "quote.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "prio-queue.h"
@@ -768,8 +770,12 @@ static int git_blame_config(const char *var, const char *value,
 		ret = git_config_pathname(&str, var, value);
 		if (ret)
 			return ret;
-		if (str)
-			string_list_insert(&ignore_revs_file_list, str);
+		if (str) {
+			if (!*str)
+				string_list_clear(&ignore_revs_file_list, 0);
+			else
+				string_list_append(&ignore_revs_file_list, str);
+		}
 		free(str);
 		return 0;
 	}
@@ -936,16 +942,24 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 {
 	struct string_list_item *i;
 	struct object_id oid;
+	struct strset seen_files = STRSET_INIT;
+	size_t start_idx = 0, idx;
+
+	for (idx = 0; idx < ignore_revs_file_list->nr; idx++) {
+		if (!*ignore_revs_file_list->items[idx].string)
+			start_idx = idx + 1;
+	}
 
 	oidset_init(&sb->ignore_list, 0);
-	for_each_string_list_item(i, ignore_revs_file_list) {
-		if (!strcmp(i->string, ""))
-			oidset_clear(&sb->ignore_list);
-		else
-			oidset_parse_file_carefully(&sb->ignore_list, i->string,
+	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
+		const char *path = ignore_revs_file_list->items[idx].string;
+
+		if (strset_add(&seen_files, path))
+			oidset_parse_file_carefully(&sb->ignore_list, path,
 						    the_repository->hash_algo,
 						    peel_to_commit_oid, sb);
 	}
+	strset_clear(&seen_files);
 	for_each_string_list_item(i, ignore_rev_list) {
 		if (repo_get_oid_committish(the_repository, i->string, &oid) ||
 		    peel_to_commit_oid(&oid, sb))
@@ -1020,6 +1034,20 @@ int cmd_blame(int argc,
 	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
+	{
+		const char *work_tree = repo_get_work_tree(the_repository);
+
+		if (work_tree) {
+			char *default_file = mkpathdup("%s/%s", work_tree,
+						       ".git-blame-ignore-revs");
+			struct stat st;
+
+			if (!lstat(default_file, &st) && S_ISREG(st.st_mode) &&
+			    !access(default_file, R_OK))
+				string_list_append(&ignore_revs_file_list, default_file);
+			free(default_file);
+		}
+	}
 	repo_config(the_repository, git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index cace00ae8d..a43654a7ba 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -327,4 +327,155 @@ test_expect_success ignore_merge '
 	test_cmp expect actual
 '
 
+# Tests for default .git-blame-ignore-revs file
+test_expect_success 'setup default .git-blame-ignore-revs' '
+	git checkout -b default-file-branch &&
+	test_write_lines line1 line2 >def-file &&
+	git add def-file &&
+	test_tick &&
+	git commit -m "default base" &&
+	git tag DEF_A &&
+
+	test_write_lines line1-modified line2-modified >def-file &&
+	git add def-file &&
+	test_tick &&
+	git commit -m "default mod" &&
+	git tag DEF_B &&
+
+	git rev-parse DEF_B >.git-blame-ignore-revs
+'
+
+test_expect_success 'default .git-blame-ignore-revs is used by default' '
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs respected by git annotate' '
+	git rev-parse --short DEF_A >expect_sha &&
+	git annotate def-file >actual &&
+	test_grep "^$(cat expect_sha)" actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs works from subdirectory' '
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git blame --line-porcelain ../def-file >blame_raw &&
+		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+		git rev-parse DEF_A >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with --no-ignore-revs-file' '
+	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with --ignore-revs-file ""' '
+	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable default .git-blame-ignore-revs with blame.ignoreRevsFile=""' '
+	test_config blame.ignoreRevsFile "" &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs handles comments and whitespace' '
+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
+	{
+		echo "# Leading comment" &&
+		echo "" &&
+		echo "   $(git rev-parse DEF_B)   " &&
+		echo "# Trailing comment"
+	} >.git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty default .git-blame-ignore-revs is harmless' '
+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
+	: >.git-blame-ignore-revs &&
+	git blame def-file
+'
+
+test_expect_success SYMLINKS 'symlink .git-blame-ignore-revs is ignored' '
+	test_when_finished "rm -f target_file .git-blame-ignore-revs && git rev-parse DEF_B >.git-blame-ignore-revs" &&
+	git rev-parse DEF_B >target_file &&
+	ln -sf target_file .git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'malformed default .git-blame-ignore-revs fails but can be bypassed' '
+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
+	echo "invalid-oid-value" >.git-blame-ignore-revs &&
+	test_must_fail git blame def-file &&
+	git blame --no-ignore-revs-file def-file &&
+	git blame --ignore-revs-file "" def-file
+'
+
+test_expect_success 'default .git-blame-ignore-revs deduplicated when also set in config' '
+	test_config blame.ignoreRevsFile .git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
+	test_write_lines line1-modified line2-c >def-file &&
+	git add def-file &&
+	test_tick &&
+	git commit -m C &&
+	git tag DEF_C &&
+	git rev-parse DEF_C >custom_ignore &&
+	test_config blame.ignoreRevsFile custom_ignore &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .git-blame-ignore-revs ignored in bare repo' '
+	git clone --bare . bare.git &&
+	git -C bare.git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_C >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame works when .git-blame-ignore-revs does not exist' '
+	rm -f .git-blame-ignore-revs &&
+	git blame --line-porcelain def-file >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse DEF_B >expect &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
-- 
gitgitgadget

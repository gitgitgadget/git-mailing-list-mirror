Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E993D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJaELd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 00:11:33 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46572 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeJaELc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 00:11:32 -0400
Received: by mail-qt1-f175.google.com with SMTP id c16-v6so14838471qtj.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xrtemvd539Eb1lgdhEfG5ARCHK+/midxWJnZO6tTrPw=;
        b=QoULh6bAmv730Y3/K92H0yKzKBgBQgl2pNF/PeswfvK0cEpcbwnou1qxChNoYXVkYX
         /SMvFVZzSupB3pdQsZ42wtgmBh6bJFu8k9HcfmqsUyOWCMUAypbu5YgTMHkVsH0I0Zwu
         /KRLTQvy/cciYe/c3xoqt/MoSZN90/VzAQPVRCKhGvJXw7faCv9jPYHMN/nNH17VIqEE
         r/7GNBcm/hk4en3ZyG/1txDnGMJpt/+mOI4nTO3Bw5KAJTLCiSKllW+P0LyJA27YzODW
         G67cKQ9l8RdLEGcJbIkxIXZg+aY9bSYYnY8L7CpHnBp8W38kCm5O8cCQn6MWHnK3seMV
         tvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xrtemvd539Eb1lgdhEfG5ARCHK+/midxWJnZO6tTrPw=;
        b=qlxFPAJ5YB20Wufl5LM7vwIWL6ld4VCe53Nfputeh998gOXN4XOMzoiXN3Sb5gRdD/
         p7DbpJY1ihUdHSTHL0zW5Iy1sh0F5lTGs2mbs64M4+9OUBZ3L04lcQsHmAOAlDLAUEHn
         ZbWOxtS95P4HBwilNueSOVpYvGXhBxZVUpoqIFyz20e1LrrxT4y2a2L6mbQkt9VTIs/J
         EThIl5dpd3ItnTeknCxcRT71h4T+a/OrSIytebCFMqDhf0bxZ3IDc0z+TrhxkW5MKTTQ
         m6ovigoFBSNcXC0GgDWRKh363IkOxDCMuQrhG2t/UiGZVWas/tzTh8NsH5ArEDCZhLMA
         d3eg==
X-Gm-Message-State: AGRZ1gJxvJ/BgskodQqjjfVqOmJYwgA9pp5AnKIY/19d2hU7eFbQ7GGR
        ToLwTlHk5/q3aPrRiGMGzXya3Z9z
X-Google-Smtp-Source: AJdET5dKgLnxD/8bsuBtxzIn3CVdOYdYnTqUfDnITA7gHvfQZhzRwjihs/AosFJB8xG4dU03en+qMA==
X-Received: by 2002:ac8:1185:: with SMTP id d5-v6mr3405612qtj.354.1540927005832;
        Tue, 30 Oct 2018 12:16:45 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p3-v6sm12302836qtc.81.2018.10.30.12.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 12:16:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ben Peart <benpeart@microsoft.com>
Subject: [RFC v1] Add virtual file system settings and hook proc
Date:   Tue, 30 Oct 2018 15:16:08 -0400
Message-Id: <20181030191608.18716-1-peartben@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.27918.g0990287eef
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

On index load, clear/set the skip worktree bits based on the virtual
file system data. Use virtual file system data to update skip-worktree
bit in unpack-trees. Use virtual file system data to exclude files and
folders not explicitly requested.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

We have taken several steps to make git perform well on very large repos.
Some of those steps include: improving underlying algorithms, utilizing
multi-threading where possible, and simplifying the behavior of some commands.
These changes typically benefit all git repos to varying degrees.  While
these optimizations all help, they are insufficient to provide adequate
performance on the very large repos we often work with.

To make git perform well on the very largest repos, we had to make more
significant changes.  The biggest performance win by far is the work we have
done to make git operations O(modified) instead of O(size of repo).  This
takes advantage of the fact that the number of files a developer has modified
is a tiny fraction of the overall repo size.

We accomplished this by utilizing the existing internal logic for the skip
worktree bit and excludes to tell git to ignore all files and folders other
than those that have been modified.  This logic is driven by an external
process that monitors writes to the repo and communicates the list of files
and folders with changes to git via the virtual file system hook in this patch.

The external process maintains a list of files and folders that have been
modified.  When git runs, it requests the list of files and folders that
have been modified via the virtual file system hook.  Git then sets/clears
the skip-worktree bit on the cache entries and builds a hashmap of the
modified files/folders that is used by the excludes logic to avoid scanning
the entire repo looking for changes and untracked files.

With this system, we have been able to make local git command performance on
extremely large repos (millions of files, 1/2 million folders) entirely
manageable (30 second checkout, 3.5 seconds status, 4 second add, 7 second
commit, etc).

Our desire is to eliminate all custom patches in our fork of git.  To that
end, I'm submitting this as an RFC to see how much interest there is and how
much willingness to take this type of change into git.

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/c06b290d2f
    Checkout: git fetch https://github.com/benpeart/git virtual-filesystem-v1 && git checkout c06b290d2f

 Documentation/config.txt     |   8 +
 Documentation/githooks.txt   |  20 ++
 Makefile                     |   1 +
 cache.h                      |   1 +
 config.c                     |  37 +++-
 config.h                     |   1 +
 dir.c                        |  34 +++-
 environment.c                |   1 +
 read-cache.c                 |   2 +
 t/README                     |   3 +
 t/t1092-virtualfilesystem.sh | 354 +++++++++++++++++++++++++++++++++++
 t/t1092/virtualfilesystem    |  23 +++
 unpack-trees.c               |  23 ++-
 virtualfilesystem.c          | 308 ++++++++++++++++++++++++++++++
 virtualfilesystem.h          |  25 +++
 15 files changed, 833 insertions(+), 8 deletions(-)
 create mode 100755 t/t1092-virtualfilesystem.sh
 create mode 100755 t/t1092/virtualfilesystem
 create mode 100644 virtualfilesystem.c
 create mode 100644 virtualfilesystem.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 09e95e9e98..dd4b834375 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -441,6 +441,14 @@ core.fsmonitor::
 	avoiding unnecessary processing of files that have not changed.
 	See the "fsmonitor-watchman" section of linkgit:githooks[5].
 
+core.virtualFilesystem::
+	If set, the value of this variable is used as a command which
+	will identify all files and directories that are present in
+	the working directory.  Git will only track and update files
+	listed in the virtual file system.  Using the virtual file system
+	will supersede the sparse-checkout settings which will be ignored.
+	See the "virtual file system" section of linkgit:githooks[6].
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..87f9ad2a77 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,26 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
 `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
 
+virtualFilesystem
+~~~~~~~~~~~~~~~~~~
+
+"Virtual File System" allows populating the working directory sparsely.
+The projection data is typically automatically generated by an external
+process.  Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names given.
+Git will also only update those files listed in the projection.
+
+The hook is invoked when the configuration option core.virtualFilesystem
+is set.  It takes one argument, a version (currently 1).
+
+The hook should output to stdout the list of all files in the working
+directory that git should track.  The paths are relative to the root
+of the working directory and are separated by a single NUL.  Full paths
+('dir1/a.txt') as well as directories are supported (ie 'dir1/').
+
+The exit status determines whether git will use the data from the
+hook.  On error, git will abort the command with an error message.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index b08d5ea258..bcb404c28d 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,6 +1009,7 @@ LIB_OBJS += utf8.o
 LIB_OBJS += varint.o
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
+LIB_OBJS += virtualfilesystem.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
 LIB_OBJS += worktree.o
diff --git a/cache.h b/cache.h
index f7fabdde8f..d5815397c2 100644
--- a/cache.h
+++ b/cache.h
@@ -881,6 +881,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern const char *core_virtualfilesystem;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index 4051e38823..96e05ee0f1 100644
--- a/config.c
+++ b/config.c
@@ -1325,7 +1325,11 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
+		/* virtual file system relies on the sparse checkout logic so force it on */
+		if (core_virtualfilesystem)
+			core_apply_sparse_checkout = 1;
+		else
+			core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -2307,6 +2311,37 @@ int git_config_get_index_threads(void)
 	return 0; /* auto */
 }
 
+int git_config_get_virtualfilesystem(void)
+{
+	if (git_config_get_pathname("core.virtualfilesystem", &core_virtualfilesystem))
+		core_virtualfilesystem = getenv("GIT_TEST_VIRTUALFILESYSTEM");
+
+	if (core_virtualfilesystem && !*core_virtualfilesystem)
+		core_virtualfilesystem = NULL;
+
+	if (core_virtualfilesystem) {
+		/*
+		 * Some git commands spawn helpers and redirect the index to a different
+		 * location.  These include "difftool -d" and the sequencer
+		 * (i.e. `git rebase -i`, `git cherry-pick` and `git revert`) and others.
+		 * In those instances we don't want to update their temporary index with
+		 * our virtualization data.
+		 */
+		char *default_index_file = xstrfmt("%s/%s", the_repository->gitdir, "index");
+		int should_run_hook = !strcmp(default_index_file, the_repository->index_file);
+
+		free(default_index_file);
+		if (should_run_hook) {
+			/* virtual file system relies on the sparse checkout logic so force it on */
+			core_apply_sparse_checkout = 1;
+			return 1;
+		}
+		core_virtualfilesystem = NULL;
+	}
+
+	return 0;
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index a06027e69b..2ed36d5e26 100644
--- a/config.h
+++ b/config.h
@@ -251,6 +251,7 @@ extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
 extern int git_config_get_index_threads(void);
+extern int git_config_get_virtualfilesystem(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/dir.c b/dir.c
index 47c2fca8dc..3097b0e446 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "submodule-config.h"
+#include "virtualfilesystem.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -1109,6 +1110,18 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el, struct index_state *istate)
 {
 	struct exclude *exclude;
+
+	/*
+	 * The virtual file system data is used to prevent git from traversing
+	 * any part of the tree that is not in the virtual file system.  Return
+	 * 1 to exclude the entry if it is not found in the virtual file system,
+	 * else fall through to the regular excludes logic as it may further exclude.
+	 */
+	if (*dtype == DT_UNKNOWN)
+		*dtype = get_dtype(NULL, istate, pathname, pathlen);
+	if (is_excluded_from_virtualfilesystem(pathname, pathlen, *dtype) > 0)
+		return 1;
+
 	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, el, istate);
 	if (exclude)
@@ -1324,8 +1337,20 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
-	struct exclude *exclude =
-		last_exclude_matching(dir, istate, pathname, dtype_p);
+	struct exclude *exclude;
+
+	/*
+	 * The virtual file system data is used to prevent git from traversing
+	 * any part of the tree that is not in the virtual file system.  Return
+	 * 1 to exclude the entry if it is not found in the virtual file system,
+	 * else fall through to the regular excludes logic as it may further exclude.
+	 */
+	if (*dtype_p == DT_UNKNOWN)
+		*dtype_p = get_dtype(NULL, istate, pathname, strlen(pathname));
+	if (is_excluded_from_virtualfilesystem(pathname, strlen(pathname), *dtype_p) > 0)
+		return 1;
+
+	exclude = last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1678,6 +1703,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
+	if (is_excluded_from_virtualfilesystem(path->buf, path->len, dtype) > 0)
+		return path_excluded;
+
 	/*
 	 * When we are looking at a directory P in the working tree,
 	 * there are three cases:
@@ -2018,6 +2046,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* add the path to the appropriate result list */
 		switch (state) {
 		case path_excluded:
+			if (is_excluded_from_virtualfilesystem(path.buf, path.len, DT_DIR) > 0)
+				break;
 			if (dir->flags & DIR_SHOW_IGNORED)
 				dir_add_name(dir, istate, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
diff --git a/environment.c b/environment.c
index 3f3c8746c2..eea50b71a7 100644
--- a/environment.c
+++ b/environment.c
@@ -68,6 +68,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+const char *core_virtualfilesystem;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/read-cache.c b/read-cache.c
index d57958233e..afe09a0343 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "virtualfilesystem.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1890,6 +1891,7 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
 	tweak_fsmonitor(istate);
+	apply_virtualfilesystem(istate);
 }
 
 static size_t estimate_cache_size_from_compressed(unsigned int entries)
diff --git a/t/README b/t/README
index 8847489640..b79c77c8b5 100644
--- a/t/README
+++ b/t/README
@@ -343,6 +343,9 @@ of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
 index loading single threaded.
 
+GIT_TEST_VIRTUALFILESYSTEM=$PWD/t1092/virtualfilesystem exercises the
+virtual file system code path for limiting what git pays attention to.
+
 Naming Tests
 ------------
 
diff --git a/t/t1092-virtualfilesystem.sh b/t/t1092-virtualfilesystem.sh
new file mode 100755
index 0000000000..a0f4200360
--- /dev/null
+++ b/t/t1092-virtualfilesystem.sh
@@ -0,0 +1,354 @@
+#!/bin/sh
+
+test_description='virtual file system tests'
+
+. ./test-lib.sh
+
+# We need total control of the virtual file system hook
+sane_unset GIT_TEST_VIRTUALFILESYSTEM
+
+clean_repo () {
+	rm .git/index &&
+	git -c core.virtualfilesystem= reset --hard HEAD &&
+	git -c core.virtualfilesystem= clean -fd &&
+	touch untracked.txt &&
+	touch dir1/untracked.txt &&
+	touch dir2/untracked.txt
+}
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks/ &&
+	cat > .gitignore <<-\EOF &&
+		.gitignore
+		expect*
+		actual*
+	EOF
+	mkdir -p dir1 &&
+	touch dir1/file1.txt &&
+	touch dir1/file2.txt &&
+	mkdir -p dir2 &&
+	touch dir2/file1.txt &&
+	touch dir2/file2.txt &&
+	git add . &&
+	git commit -m "initial" &&
+	git config --local core.virtualfilesystem .git/hooks/virtualfilesystem
+'
+
+test_expect_success 'test hook parameters and version' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		if test "$#" -ne 1
+		then
+			echo "$0: Exactly 1 argument expected" >&2
+			exit 2
+		fi
+
+		if test "$1" != 1
+		then
+			echo "$0: Unsupported hook version." >&2
+			exit 1
+		fi
+	EOF
+	git status &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		exit 3
+	EOF
+	test_must_fail git status
+'
+
+test_expect_success 'verify status is clean' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir2/file1.txt\0"
+	EOF
+	rm -f .git/index &&
+	git checkout -f &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir2/file1.txt\0"
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+	EOF
+	git status > actual &&
+	cat > expected <<-\EOF &&
+		On branch master
+		nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify skip-worktree bit is set for absolute path' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		H dir1/file1.txt
+		S dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify skip-worktree bit is cleared for absolute path' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file2.txt\0"
+	EOF
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		S dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify folder wild cards' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/\0"
+	EOF
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify folders not included are ignored' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	touch dir1/a &&
+	touch dir1/b &&
+	touch dir1/dir2/a &&
+	touch dir1/dir2/b &&
+	git add . &&
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify including one file doesnt include the rest' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+		printf "dir1/dir2/a\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	touch dir1/a &&
+	touch dir1/b &&
+	touch dir1/dir2/a &&
+	touch dir1/dir2/b &&
+	git add . &&
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		H dir1/dir2/a
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify files not listed are ignored by git clean -f -x' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "untracked.txt\0"
+		printf "dir1/\0"
+	EOF
+	mkdir -p dir3 &&
+	touch dir3/untracked.txt &&
+	git clean -f -x &&
+	test ! -f untracked.txt &&
+	test -d dir1 &&
+	test -f dir1/file1.txt &&
+	test -f dir1/file2.txt &&
+	test ! -f dir1/untracked.txt &&
+	test -f dir2/file1.txt &&
+	test -f dir2/file2.txt &&
+	test -f dir2/untracked.txt &&
+	test -d dir3 &&
+	test -f dir3/untracked.txt
+'
+
+test_expect_success 'verify files not listed are ignored by git clean -f -d -x' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "untracked.txt\0"
+		printf "dir1/\0"
+		printf "dir3/\0"
+	EOF
+	mkdir -p dir3 &&
+	touch dir3/untracked.txt &&
+	git clean -f -d -x &&
+	test ! -f untracked.txt &&
+	test -d dir1 &&
+	test -f dir1/file1.txt &&
+	test -f dir1/file2.txt &&
+	test ! -f dir1/untracked.txt &&
+	test -f dir2/file1.txt &&
+	test -f dir2/file2.txt &&
+	test -f dir2/untracked.txt &&
+	test ! -d dir3 &&
+	test ! -f dir3/untracked.txt
+'
+
+test_expect_success 'verify folder entries include all files' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	touch dir1/a &&
+	touch dir1/b &&
+	touch dir1/dir2/a &&
+	touch dir1/dir2/b &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+		?? dir1/a
+		?? dir1/b
+		?? dir1/dir2/a
+		?? dir1/dir2/b
+		?? dir1/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify case insensitivity of virtual file system entries' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/a\0"
+		printf "Dir1/Dir2/a\0"
+		printf "DIR2/\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	touch dir1/a &&
+	touch dir1/b &&
+	touch dir1/dir2/a &&
+	touch dir1/dir2/b &&
+	git -c core.ignorecase=false status -su > actual &&
+	cat > expected <<-\EOF &&
+		?? dir1/a
+	EOF
+	test_cmp expected actual &&
+	git -c core.ignorecase=true status -su > actual &&
+	cat > expected <<-\EOF &&
+		?? dir1/a
+		?? dir1/dir2/a
+		?? dir2/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file created' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file3.txt\0"
+	EOF
+	touch dir1/file3.txt &&
+	git add . &&
+	git ls-files -v > actual &&
+	cat > expected <<-\EOF &&
+		S dir1/file1.txt
+		S dir1/file2.txt
+		H dir1/file3.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file renamed' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file3.txt\0"
+	EOF
+	mv dir1/file1.txt dir1/file3.txt &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+		 D dir1/file1.txt
+		?? dir1/file3.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file deleted' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	rm dir1/file1.txt &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+		 D dir1/file1.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file overwritten' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	echo "overwritten" > dir1/file1.txt &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+		 M dir1/file1.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on folder created' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir1/dir1/\0"
+	EOF
+	mkdir -p dir1/dir1 &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+	EOF
+	test_cmp expected actual &&
+	git clean -fd &&
+	test ! -d "/dir1/dir1"
+'
+
+test_expect_success 'on folder renamed' '
+	clean_repo &&
+	write_script .git/hooks/virtualfilesystem <<-\EOF &&
+		printf "dir3/\0"
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+		printf "dir3/file1.txt\0"
+		printf "dir3/file2.txt\0"
+	EOF
+	mv dir1 dir3 &&
+	git status -su > actual &&
+	cat > expected <<-\EOF &&
+		 D dir1/file1.txt
+		 D dir1/file2.txt
+		?? dir3/file1.txt
+		?? dir3/file2.txt
+		?? dir3/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t1092/virtualfilesystem b/t/t1092/virtualfilesystem
new file mode 100755
index 0000000000..3f29c5f91f
--- /dev/null
+++ b/t/t1092/virtualfilesystem
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test the virtual file system.
+#
+# The hook is passed a version (currently 1) and outputs to stdout all files
+# that git should paid attention to.  Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+
+if test "$#" -ne 1
+then
+	echo "$0: exactly 1 argument expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.virtualfilesystem hook version." >&2
+	exit 1
+fi
+
+#find -type f -printf '%P\0'
+find -type d -printf '%P/\0'
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..ee3cda2e94 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "virtualfilesystem.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1363,6 +1364,14 @@ static int clear_ce_flags_1(struct index_state *istate,
 			continue;
 		}
 
+		/* if it's not in the virtual file system, exit early */
+		if (core_virtualfilesystem) {
+			if (is_included_in_virtualfilesystem(ce->name, ce->ce_namelen) > 0)
+				ce->ce_flags &= ~clear_mask;
+			cache++;
+			continue;
+		}
+
 		if (prefix->len && strncmp(ce->name, prefix->buf, prefix->len))
 			break;
 
@@ -1481,12 +1490,16 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
-		char *sparse = git_pathdup("info/sparse-checkout");
-		if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
-			o->skip_sparse_checkout = 1;
-		else
+		if (core_virtualfilesystem) {
 			o->el = &el;
-		free(sparse);
+		} else {
+			char *sparse = git_pathdup("info/sparse-checkout");
+			if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
+				o->skip_sparse_checkout = 1;
+			else
+				o->el = &el;
+			free(sparse);
+		}
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
diff --git a/virtualfilesystem.c b/virtualfilesystem.c
new file mode 100644
index 0000000000..0d45803dbc
--- /dev/null
+++ b/virtualfilesystem.c
@@ -0,0 +1,308 @@
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "hashmap.h"
+#include "run-command.h"
+#include "virtualfilesystem.h"
+
+#define HOOK_INTERFACE_VERSION	(1)
+
+static struct strbuf virtual_filesystem_data = STRBUF_INIT;
+static struct hashmap virtual_filesystem_hashmap;
+static struct hashmap parent_directory_hashmap;
+
+struct virtualfilesystem {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *pattern;
+	int patternlen;
+};
+
+static unsigned int(*vfshash)(const void *buf, size_t len);
+static int(*vfscmp)(const char *a, const char *b, size_t len);
+
+static int vfs_hashmap_cmp(const void *unused_cmp_data,
+	const void *a, const void *b, const void *key)
+{
+	const struct virtualfilesystem *vfs1 = a;
+	const struct virtualfilesystem *vfs2 = b;
+
+	return vfscmp(vfs1->pattern, vfs2->pattern, vfs1->patternlen);
+}
+
+static void get_virtual_filesystem_data(struct strbuf *vfs_data)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int err;
+
+	strbuf_init(vfs_data, 0);
+
+	argv_array_push(&cp.args, core_virtualfilesystem);
+	argv_array_pushf(&cp.args, "%d", HOOK_INTERFACE_VERSION);
+	cp.use_shell = 1;
+	cp.dir = get_git_work_tree();
+
+	err = capture_command(&cp, vfs_data, 1024);
+	if (err)
+		die("unable to load virtual file system");
+}
+
+static int check_includes_hashmap(struct hashmap *map, const char *pattern, int patternlen)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct virtualfilesystem vfs;
+	char *slash;
+
+	/* Check straight mapping */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pattern, patternlen);
+	vfs.pattern = sb.buf;
+	vfs.patternlen = sb.len;
+	hashmap_entry_init(&vfs, vfshash(vfs.pattern, vfs.patternlen));
+	if (hashmap_get(map, &vfs, NULL)) {
+		strbuf_release(&sb);
+		return 1;
+	}
+
+	/*
+	 * Check to see if it matches a directory or any path
+	 * underneath it.  In other words, 'a/b/foo.txt' will match
+	 * '/', 'a/', and 'a/b/'.
+	 */
+	slash = strchr(sb.buf, '/');
+	while (slash) {
+		vfs.pattern = sb.buf;
+		vfs.patternlen = slash - sb.buf + 1;
+		hashmap_entry_init(&vfs, vfshash(vfs.pattern, vfs.patternlen));
+		if (hashmap_get(map, &vfs, NULL)) {
+			strbuf_release(&sb);
+			return 1;
+		}
+		slash = strchr(slash + 1, '/');
+	}
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+static void includes_hashmap_add(struct hashmap *map, const char *pattern, const int patternlen)
+{
+	struct virtualfilesystem *vfs;
+
+	vfs = xmalloc(sizeof(struct virtualfilesystem));
+	vfs->pattern = pattern;
+	vfs->patternlen = patternlen;
+	hashmap_entry_init(vfs, vfshash(vfs->pattern, vfs->patternlen));
+	hashmap_add(map, vfs);
+}
+
+static void initialize_includes_hashmap(struct hashmap *map, struct strbuf *vfs_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the virtual file system data we can use to look
+	 * for cache entry matches quickly
+	 */
+	vfshash = ignore_case ? memihash : memhash;
+	vfscmp = ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, vfs_hashmap_cmp, NULL, 0);
+
+	entry = buf = vfs_data->buf;
+	len = vfs_data->len;
+	for (i = 0; i < len; i++) {
+		if (buf[i] == '\0') {
+			includes_hashmap_add(map, entry, buf + i - entry);
+			entry = buf + i + 1;
+		}
+	}
+}
+
+/*
+ * Return 1 if the requested item is found in the virtual file system,
+ * 0 for not found and -1 for undecided.
+ */
+int is_included_in_virtualfilesystem(const char *pathname, int pathlen)
+{
+	if (!core_virtualfilesystem)
+		return -1;
+
+	if (!virtual_filesystem_hashmap.tablesize && virtual_filesystem_data.len)
+		initialize_includes_hashmap(&virtual_filesystem_hashmap, &virtual_filesystem_data);
+	if (!virtual_filesystem_hashmap.tablesize)
+		return -1;
+
+	return check_includes_hashmap(&virtual_filesystem_hashmap, pathname, pathlen);
+}
+
+static void parent_directory_hashmap_add(struct hashmap *map, const char *pattern, const int patternlen)
+{
+	char *slash;
+	struct virtualfilesystem *vfs;
+
+	/*
+	 * Add any directories leading up to the file as the excludes logic
+	 * needs to match directories leading up to the files as well. Detect
+	 * and prevent unnecessary duplicate entries which will be common.
+	 */
+	if (patternlen > 1) {
+		slash = strchr(pattern + 1, '/');
+		while (slash) {
+			vfs = xmalloc(sizeof(struct virtualfilesystem));
+			vfs->pattern = pattern;
+			vfs->patternlen = slash - pattern + 1;
+			hashmap_entry_init(vfs, vfshash(vfs->pattern, vfs->patternlen));
+			if (hashmap_get(map, vfs, NULL))
+				free(vfs);
+			else
+				hashmap_add(map, vfs);
+			slash = strchr(slash + 1, '/');
+		}
+	}
+}
+
+static void initialize_parent_directory_hashmap(struct hashmap *map, struct strbuf *vfs_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the parent directories contained in the virtual
+	 * file system data we can use to look for matches quickly
+	 */
+	vfshash = ignore_case ? memihash : memhash;
+	vfscmp = ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, vfs_hashmap_cmp, NULL, 0);
+
+	entry = buf = vfs_data->buf;
+	len = vfs_data->len;
+	for (i = 0; i < len; i++) {
+		if (buf[i] == '\0') {
+			parent_directory_hashmap_add(map, entry, buf + i - entry);
+			entry = buf + i + 1;
+		}
+	}
+}
+
+static int check_directory_hashmap(struct hashmap *map, const char *pathname, int pathlen)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct virtualfilesystem vfs;
+
+	/* Check for directory */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pathname, pathlen);
+	strbuf_addch(&sb, '/');
+	vfs.pattern = sb.buf;
+	vfs.patternlen = sb.len;
+	hashmap_entry_init(&vfs, vfshash(vfs.pattern, vfs.patternlen));
+	if (hashmap_get(map, &vfs, NULL)) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	strbuf_release(&sb);
+	return 1;
+}
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_virtualfilesystem(const char *pathname, int pathlen, int dtype)
+{
+	if (!core_virtualfilesystem)
+		return -1;
+
+	if (dtype != DT_REG && dtype != DT_DIR && dtype != DT_LNK)
+		die(_("is_excluded_from_virtualfilesystem passed unhandled dtype"));
+
+	if (dtype == DT_REG || dtype == DT_LNK) {
+		int ret = is_included_in_virtualfilesystem(pathname, pathlen);
+		if (ret > 0)
+			return 0;
+		if (ret == 0)
+			return 1;
+		return ret;
+	}
+
+	if (dtype == DT_DIR) {
+		int ret = is_included_in_virtualfilesystem(pathname, pathlen);
+		if (ret > 0)
+			return 0;
+
+		if (!parent_directory_hashmap.tablesize && virtual_filesystem_data.len)
+			initialize_parent_directory_hashmap(&parent_directory_hashmap, &virtual_filesystem_data);
+		if (!parent_directory_hashmap.tablesize)
+			return -1;
+
+		return check_directory_hashmap(&parent_directory_hashmap, pathname, pathlen);
+	}
+
+	return -1;
+}
+
+/*
+ * Update the CE_SKIP_WORKTREE bits based on the virtual file system.
+ */
+void apply_virtualfilesystem(struct index_state *istate)
+{
+	char *buf, *entry;
+	int i;
+
+	if (!git_config_get_virtualfilesystem())
+		return;
+
+	if (!virtual_filesystem_data.len)
+		get_virtual_filesystem_data(&virtual_filesystem_data);
+
+	/* set CE_SKIP_WORKTREE bit on all entries */
+	for (i = 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags |= CE_SKIP_WORKTREE;
+
+	/* clear CE_SKIP_WORKTREE bit for everything in the virtual file system */
+	entry = buf = virtual_filesystem_data.buf;
+	for (i = 0; i < virtual_filesystem_data.len; i++) {
+		if (buf[i] == '\0') {
+			int pos, len;
+
+			len = buf + i - entry;
+
+			/* look for a directory wild card (ie "dir1/") */
+			if (buf[i - 1] == '/') {
+				if (ignore_case)
+					adjust_dirname_case(istate, entry);
+				pos = index_name_pos(istate, entry, len - 1);
+				if (pos < 0) {
+					pos = -pos - 1;
+					while (pos < istate->cache_nr && !fspathncmp(istate->cache[pos]->name, entry, len)) {
+						istate->cache[pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+						pos++;
+					}
+				}
+			} else {
+				if (ignore_case) {
+					struct cache_entry *ce = index_file_exists(istate, entry, len, ignore_case);
+					if (ce)
+						ce->ce_flags &= ~CE_SKIP_WORKTREE;
+				} else {
+					int pos = index_name_pos(istate, entry, len);
+					if (pos >= 0)
+						istate->cache[pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+				}
+			}
+
+			entry += len + 1;
+		}
+	}
+}
+
+/*
+ * Free the virtual file system data structures.
+ */
+void free_virtualfilesystem(void) {
+	hashmap_free(&virtual_filesystem_hashmap, 1);
+	hashmap_free(&parent_directory_hashmap, 1);
+	strbuf_release(&virtual_filesystem_data);
+}
diff --git a/virtualfilesystem.h b/virtualfilesystem.h
new file mode 100644
index 0000000000..5e8c5b096d
--- /dev/null
+++ b/virtualfilesystem.h
@@ -0,0 +1,25 @@
+#ifndef VIRTUALFILESYSTEM_H
+#define VIRTUALFILESYSTEM_H
+
+/*
+ * Update the CE_SKIP_WORKTREE bits based on the virtual file system.
+ */
+void apply_virtualfilesystem(struct index_state *istate);
+
+/*
+ * Return 1 if the requested item is found in the virtual file system,
+ * 0 for not found and -1 for undecided.
+ */
+int is_included_in_virtualfilesystem(const char *pathname, int pathlen);
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_virtualfilesystem(const char *pathname, int pathlen, int dtype);
+
+/*
+ * Free the virtual file system data structures.
+ */
+void free_virtualfilesystem(void);
+
+#endif

base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
-- 
2.9.2.gvfs.2.27918.g0990287eef


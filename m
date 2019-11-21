Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE0C43141
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BCF206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg3CJfgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKUWFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id 4so2985855wro.7
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hfGxL5pvpLNzfYVcwXpK5EPJsZOZtAxN0QSleWQ3k60=;
        b=rg3CJfgVjjpXId8erzyeH2hqaYsLomIghQxwFlFhTQ2+Ez0o4tXWonk9bafkuIO2Rc
         h9kviu2EPKVbE1BnDB6vj3HDaswMxY3btfY+rT2z3wl1mGphYCt1DEr31TdeBCu3OvIy
         3KvUKdG80/r5UR4M9eiaPN6LGWP0p26b3eZopEqS3cga5z/Sd5NMjh1KqVj6kLuUUGs/
         wbEwLEtBqfobhxf2kvH0Dz75JMP8rcXYXVBgk62CSuFawrooG0SFiKD1CxUcJhQi16iv
         e5xIRjXnZX9/z5jpNDTLyz62DCvWXZNXYiQ6uRz+u++Dts+DZl9RmPvukjzkwBFMFETY
         ilWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hfGxL5pvpLNzfYVcwXpK5EPJsZOZtAxN0QSleWQ3k60=;
        b=UlHKSy81q0nRaMfp0FM79TLwStJeOQNhgyo1kULkIrWAdeaX/IdRpHJ56mwOdQJhCs
         DZsQXxD9jbyNF55q6tEck+35Gvi/b135d2HdThGidT874/0ytKG1qQlFRTq0ecOaPgmX
         BQslTkgeC4XKOPTLyfSdzf8qp6BIWRrcj8MAlgAzxeb71Eay5M9mhx8kLy0q6dKbBX14
         FH2j1FvaKDPJ9jA479tHVoXicJI/V/BAGfpsMaxRGryGJshQ9qecrFPyGQ2eXUMgZnB9
         rBtshpkOqT04KBxkX7+KqSp2P3G3KXTF745WA+OzuABt0n9Iqdv/SBQS5VIIgFL3eQuV
         1+8g==
X-Gm-Message-State: APjAAAV3dDGH2zgz0KUYqVeLEId+G1ItaRpR/UrntoOvEG670fK59CqC
        lyXmAlp9r5AMehu7RXuJM0C6J+Vm
X-Google-Smtp-Source: APXvYqwUDoEZSzA6fhKasFUDEzfoAlzxkF3F7FZGdD5QcBa5lKpAIf9kZkW5BM1uPlBDiO0f6AGGKA==
X-Received: by 2002:adf:c649:: with SMTP id u9mr14391732wrg.20.1574373894207;
        Thu, 21 Nov 2019 14:04:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm4695810wrx.93.2019.11.21.14.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:53 -0800 (PST)
Message-Id: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:32 +0000
Subject: [PATCH v6 00/19] New sparse-checkout builtin and "cone" mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the sparse-checkout feature more user-friendly. While
there, I also present a way to use a limited set of patterns to gain a
significant performance boost in very large repositories.

Sparse-checkout is only documented as a subsection of the read-tree docs
[1], which makes the feature hard to discover. Users have trouble navigating
the feature, especially at clone time [2], and have even resorted to
creating their own helper tools [3].

This series attempts to solve these problems using a new builtin. Here is a
sample workflow to give a feeling for how it can work:

In an existing repo:

$ git sparse-checkout init
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder
$ ls myFolder
a.c a.h
$ git sparse-checkout disable
$ ls
hiddenFolder myFile1.txt myFile2.txt myFolder

At clone time:

$ git clone --sparse origin repo
$ cd repo
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder

Here are some more specific details:

 * git sparse-checkout init enables core.sparseCheckout and populates the
   sparse-checkout file with patterns that match only the files at root.
   
   
 * git clone learns the --sparse argument to run git sparse-checkout init 
   before the first checkout.
   
   
 * git sparse-checkout set reads patterns from the arguments, or with
   --stdin reads patterns from stdin one per line, then writes them to the
   sparse-checkout file and refreshes the working directory.
   
   
 * git sparse-checkout disable removes the patterns from the sparse-checkout
   file, disables core.sparseCheckout, and refills the working directory.
   
   
 * git sparse-checkout list lists the contents of the sparse-checkout file.
   
   

The documentation for the sparse-checkout feature can now live primarily
with the git-sparse-checkout documentation.

Cone Mode
=========

What really got me interested in this area is a performance problem. If we
have N patterns in the sparse-checkout file and M entries in the index, then
we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
quadratic growth is not sustainable in a repo with 1,000+ patterns and
1,000,000+ index entries.

To solve this problem, I propose a new, more restrictive mode to
sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
matches at a directory level. This can then use hashsets for fast
performance -- O(M) instead of O(N*M). My hashset implementation is based on
the virtual filesystem hook in the VFS for Git custom code [4].

In cone mode, a user specifies a list of folders which the user wants every
file inside. In addition, the cone adds all blobs that are siblings of the
folders in the directory path to that folder. This makes the directories
look "hydrated" as a user drills down to those recursively-closed folders.
These directories are called "parent" folders, as a file matches them only
if the file's immediate parent is that directory.

When building a prototype of this feature, I used a separate file to contain
the list of recursively-closed folders and built the hashsets dynamically
based on that file. In this implementation, I tried to maximize the amount
of backwards-compatibility by storing all data in the sparse-checkout file
using patterns recognized by earlier Git versions.

For example, if we add A/B/C as a recursive folder, then we add the
following patterns to the sparse-checkout file:

/*
!/*/
/A/
!/A/*/
/A/B/
!/A/B/*/
/A/B/C/

The alternating positive/negative patterns say "include everything in this
folder, but exclude everything another level deeper". The final pattern has
no matching negation, so is a recursively closed pattern.

Note that I have some basic warnings to try and check that the
sparse-checkout file doesn't match what would be written by a cone-mode add.
In such a case, Git writes a warning to stderr and continues with the old
pattern matching algorithm. These checks are currently very barebones, and
would need to be updated with more robust checks for things like regex
characters in the middle of the pattern. As review moves forward (and if we
don't change the data storage) then we could spend more time on this.

Thanks, -Stolee

Updates in v2, relative to the RFC:

 * Instead of an 'add' subcommand, use a 'set' subcommand. We can consider
   adding 'add' and/or 'remove' subcommands later.
   
   
 * 'set' reads from the arguments by default. '--stdin' option is available.
   
   
 * A new performance-oriented commit is added at the end.
   
   
 * Patterns no longer end with a trailing asterisk except for the first "/*"
   pattern.
   
   
 * References to a "bug" (that was really a strange GVFS interaction in
   microsoft/git) around deleting outside the cone are removed.
   
   

Updates in v3:

 * The bad interaction with "cone mode" and .gitignore files is fixed. A
   test is added in the last patch.
   
   
 * Several patches are added that make the feature more robust. One
   sanitizes user input, another few add progress indicators, and another
   more prevent users from getting in bad states due to working directory
   changes or concurrent processes.
   
   
 * Updated several docs and commit messages according to feedback. Thanks,
   Elijah!
   
   

Updates in V4:

 * Updated hashmap API usage to respond to ew/hashmap
   
   
 * Responded to detailed review by Elijah. Thanks!
   
   
 * Marked the feature as experimental in git-sparse-checkout.txt the same
   way that git-switch.txt does.
   
   

Updates in V5:

 * The 'set' subcommand now enables the core.sparseCheckout config setting
   (unless the checkout fails).
   
   
 * If the in-process unpack_trees() fails with the new patterns, the
   index.lock file is rolled back before the replay of the old
   sparse-checkout patterns.
   
   
 * Some documentation fixes, f(d)open->xf(d)open calls, and other nits.
   Thanks everyone!
   
   

Updates in V6:

 * The init, set, and disable commands now require a clean status.
   
   
 * Git config is now set in-process instead of via a run_command call.
   
   
 * The working directory was being updated twice, leading to multiple errors
   being shown if the working directory would become empty.
   
   
 * Before, only the 'set' command used the in-process workdir update. Now
   'init' and 'disable' also use this in-process code, which removes some
   error cases.
   
   

Things to leave for future patches:

 1. Integrate in 'git worktree add' to copy the sparse-checkout file to a
    worktree-specific file.
    
    
 2. More robustness around detecting non-cone patterns with wildcards in the
    middle of the line.
    
    
 3. 'git clone --sparse-cone' to clone into "cone mode" sparse-checkouts
    (i.e. set 'core.sparseCheckoutCone=true'). This may not be
    super-valuable, as it only starts changing behavior when someone calls
    'git sparse-checkout set', but may be interesting.
    
    
 4. Make the working-directory update not modify the staging environment.
    Block only if it would lose work-in-progress.
    
    
 5. Some robustness things can be saved for later, such as including pattern
    arguments next to "--stdin", "set --cone", etc.
    
    

[1] https://git-scm.com/docs/git-read-tree#_sparse_checkoutSparse-checkout
documentation in git-read-tree.

[2] https://stackoverflow.com/a/4909267/127088Is it possible to do a sparse
checkout without checking out the whole repository first?

[3] http://www.marcoyuen.com/articles/2016/06/07/git-sparse.htmlA blog post
of a user's extra "git-sparse" helper.

[4] 
https://github.com/git/git/compare/fc5fd706ff733392053e6180086a4d7f96acc2af...01204f24c5349aa2fb0c474546d768946d315dab
The virtual filesystem hook in microsoft/git.

Derrick Stolee (18):
  sparse-checkout: create builtin with 'list' subcommand
  sparse-checkout: create 'init' subcommand
  clone: add --sparse mode
  sparse-checkout: 'set' subcommand
  sparse-checkout: add '--stdin' option to set subcommand
  sparse-checkout: create 'disable' subcommand
  sparse-checkout: add 'cone' mode
  sparse-checkout: use hashmaps for cone patterns
  sparse-checkout: init and set in cone mode
  unpack-trees: hash less in cone mode
  unpack-trees: add progress to clear_ce_flags()
  sparse-checkout: sanitize for nested folders
  sparse-checkout: update working directory in-process
  sparse-checkout: use in-process update for disable subcommand
  sparse-checkout: write using lockfile
  sparse-checkout: cone mode should not interact with .gitignore
  sparse-checkout: update working directory in-process for 'init'
  sparse-checkout: check for dirty status

Jeff Hostetler (1):
  trace2: add region in clear_ce_flags

 .gitignore                            |   1 +
 Documentation/config/core.txt         |  10 +-
 Documentation/git-clone.txt           |   8 +-
 Documentation/git-read-tree.txt       |   2 +-
 Documentation/git-sparse-checkout.txt | 161 +++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/read-tree.c                   |   2 +-
 builtin/sparse-checkout.c             | 489 ++++++++++++++++++++++++++
 cache.h                               |   6 +-
 command-list.txt                      |   1 +
 config.c                              |   5 +
 dir.c                                 | 207 ++++++++++-
 dir.h                                 |  36 ++
 environment.c                         |   1 +
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 307 ++++++++++++++++
 unpack-trees.c                        | 110 ++++--
 unpack-trees.h                        |   3 +-
 20 files changed, 1331 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/316

Range-diff vs v5:

  1:  55c306a73a !  1:  81a1526069 sparse-checkout: create builtin with 'list' subcommand
     @@ -59,8 +59,8 @@
      +NAME
      +----
      +git-sparse-checkout - Initialize and modify the sparse-checkout
     -+configuration, which reduces the checkout to a set of directories
     -+given by a list of prefixes.
     ++configuration, which reduces the checkout to a set of paths
     ++given by a list of atterns.
      +
      +
      +SYNOPSIS
     @@ -73,7 +73,7 @@
      +-----------
      +
      +Initialize and modify the sparse-checkout configuration, which reduces
     -+the checkout to a set of directories given by a list of prefixes.
     ++the checkout to a set of paths given by a list of patterns.
      +
      +THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
      +COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
  2:  a161cee0df !  2:  fcfe477813 sparse-checkout: create 'init' subcommand
     @@ -75,26 +75,19 @@
      +	MODE_ALL_PATTERNS = 1,
      +};
      +
     -+static int sc_set_config(enum sparse_checkout_mode mode)
     ++static int set_config(enum sparse_checkout_mode mode)
      +{
     -+	struct argv_array argv = ARGV_ARRAY_INIT;
     ++	const char *config_path;
      +
      +	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
      +		error(_("failed to set extensions.worktreeConfig setting"));
      +		return 1;
      +	}
      +
     -+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
     -+
     -+	if (mode)
     -+		argv_array_pushl(&argv, "true", NULL);
     -+	else
     -+		argv_array_pushl(&argv, "false", NULL);
     -+
     -+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     -+		error(_("failed to enable core.sparseCheckout"));
     -+		return 1;
     -+	}
     ++	config_path = git_path("config.worktree");
     ++	git_config_set_in_file_gently(config_path,
     ++				      "core.sparseCheckout",
     ++				      mode ? "true" : NULL);
      +
      +	return 0;
      +}
     @@ -106,7 +99,7 @@
      +	FILE *fp;
      +	int res;
      +
     -+	if (sc_set_config(MODE_ALL_PATTERNS))
     ++	if (set_config(MODE_ALL_PATTERNS))
      +		return 1;
      +
      +	memset(&pl, 0, sizeof(pl));
     @@ -122,6 +115,9 @@
      +
      +	/* initial mode: all blobs at root */
      +	fp = xfopen(sparse_filename, "w");
     ++	if (!fp)
     ++		die(_("failed to open '%s'"), sparse_filename);
     ++
      +	free(sparse_filename);
      +	fprintf(fp, "/*\n!/*/\n");
      +	fclose(fp);
     @@ -157,8 +153,7 @@
      +		!/*/
      +	EOF
      +	test_cmp expect repo/.git/info/sparse-checkout &&
     -+	git -C repo config --list >config &&
     -+	test_i18ngrep "core.sparsecheckout=true" config &&
     ++	test_cmp_config -C repo true core.sparsecheckout &&
      +	ls repo >dir  &&
      +	echo a >expect &&
      +	test_cmp expect dir
  3:  cd150853b7 !  3:  7ef5f2ef69 clone: add --sparse mode
     @@ -122,7 +122,7 @@
       	int res;
      +	struct object_id oid;
       
     - 	if (sc_set_config(MODE_ALL_PATTERNS))
     + 	if (set_config(MODE_ALL_PATTERNS))
       		return 1;
      @@
       	fprintf(fp, "/*\n!/*/\n");
  4:  7d9d66a89f !  4:  248fc172ac sparse-checkout: 'set' subcommand
     @@ -47,6 +47,15 @@
       	NULL
       };
       
     +@@
     + 	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
     + 
     + 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     +-		error(_("failed to update index with new sparse-checkout paths"));
     ++		error(_("failed to update index with new sparse-checkout patterns"));
     + 		result = 1;
     + 	}
     + 
      @@
       	return update_working_directory();
       }
     @@ -71,22 +80,22 @@
      +	int i;
      +	struct pattern_list pl;
      +	int result;
     -+	int set_config = 0;
     ++	int changed_config = 0;
      +	memset(&pl, 0, sizeof(pl));
      +
      +	for (i = 1; i < argc; i++)
      +		add_pattern(argv[i], empty_base, 0, &pl, 0);
      +
      +	if (!core_apply_sparse_checkout) {
     -+		sc_set_config(MODE_ALL_PATTERNS);
     ++		set_config(MODE_ALL_PATTERNS);
      +		core_apply_sparse_checkout = 1;
     -+		set_config = 1;
     ++		changed_config = 1;
      +	}
      +
      +	result = write_patterns_and_update(&pl);
      +
     -+	if (result && set_config)
     -+		sc_set_config(MODE_NO_PATTERNS);
     ++	if (result && changed_config)
     ++		set_config(MODE_NO_PATTERNS);
      +
      +	clear_pattern_list(&pl);
      +	return result;
     @@ -119,9 +128,10 @@
      +		test_commit test file &&
      +		test_path_is_missing .git/config.worktree &&
      +		test_must_fail git sparse-checkout set nothing &&
     -+		test_i18ngrep "sparseCheckout = false" .git/config.worktree &&
     ++		test_path_is_file .git/config.worktree &&
     ++		test_must_fail git config core.sparseCheckout &&
      +		git sparse-checkout set "/*" &&
     -+		test_i18ngrep "sparseCheckout = true" .git/config.worktree
     ++		test_cmp_config true core.sparseCheckout
      +	)
      +'
      +
  5:  0e08898dcb !  5:  751798216f sparse-checkout: add '--stdin' option to set subcommand
     @@ -11,6 +11,20 @@
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
     + --- a/Documentation/git-sparse-checkout.txt
     + +++ b/Documentation/git-sparse-checkout.txt
     +@@
     + 	a list of arguments following the 'set' subcommand. Update the
     + 	working directory to match the new patterns. Enable the
     + 	core.sparseCheckout config setting if it is not already enabled.
     +++
     ++When the `--stdin` option is provided, the patterns are read from
     ++standard in as a newline-delimited list instead of from the arguments.
     + 
     + SPARSE CHECKOUT
     + ---------------
     +
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
     @@ -19,7 +33,7 @@
       }
       
      +static char const * const builtin_sparse_checkout_set_usage[] = {
     -+	N_("git sparse-checkout set [--stdin|<patterns>]"),
     ++	N_("git sparse-checkout set (--stdin | <patterns>)"),
      +	NULL
      +};
      +
     @@ -33,7 +47,7 @@
      @@
       	struct pattern_list pl;
       	int result;
     - 	int set_config = 0;
     + 	int changed_config = 0;
      +
      +	static struct option builtin_sparse_checkout_set_options[] = {
      +		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
     @@ -54,8 +68,7 @@
      +		struct strbuf line = STRBUF_INIT;
      +
      +		while (!strbuf_getline(&line, stdin)) {
     -+			size_t len;
     -+			char *buf = strbuf_detach(&line, &len);
     ++			char *buf = strbuf_detach(&line, NULL);
      +			add_pattern(buf, empty_base, 0, &pl, 0);
      +		}
      +	} else {
     @@ -64,7 +77,7 @@
      +	}
       
       	if (!core_apply_sparse_checkout) {
     - 		sc_set_config(MODE_ALL_PATTERNS);
     + 		set_config(MODE_ALL_PATTERNS);
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
  6:  c48535cd5c !  6:  6431141e03 sparse-checkout: create 'disable' subcommand
     @@ -13,8 +13,8 @@
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
      @@
     - 	working directory to match the new patterns. Enable the
     - 	core.sparseCheckout config setting if it is not already enabled.
     + When the `--stdin` option is provided, the patterns are read from
     + standard in as a newline-delimited list instead of from the arguments.
       
      +'disable'::
      +	Remove the sparse-checkout file, set `core.sparseCheckout` to
     @@ -82,7 +82,7 @@
      +	char *sparse_filename;
      +	FILE *fp;
      +
     -+	if (sc_set_config(MODE_ALL_PATTERNS))
     ++	if (set_config(MODE_ALL_PATTERNS))
      +		die(_("failed to change config"));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     @@ -96,7 +96,7 @@
      +	unlink(sparse_filename);
      +	free(sparse_filename);
      +
     -+	return sc_set_config(MODE_NO_PATTERNS);
     ++	return set_config(MODE_NO_PATTERNS);
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     @@ -123,7 +123,7 @@
      +	git -C repo sparse-checkout disable &&
      +	test_path_is_missing repo/.git/info/sparse-checkout &&
      +	git -C repo config --list >config &&
     -+	test_i18ngrep "core.sparsecheckout=false" config &&
     ++	test_must_fail git config core.sparseCheckout &&
      +	ls repo >dir &&
      +	cat >expect <<-EOF &&
      +		a
  7:  44b0245e65 =  7:  0bc87c1a88 trace2: add region in clear_ce_flags
  8:  121d878882 !  8:  3b9e11d7f2 sparse-checkout: add 'cone' mode
     @@ -42,11 +42,23 @@
       diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
     +@@
     + To repopulate the working directory with all files, use the
     + `git sparse-checkout disable` command.
     + 
     +-## FULL PATTERN SET
     ++
     ++FULL PATTERN SET
     ++----------------
     + 
     + By default, the sparse-checkout file uses the same syntax as `.gitignore`
     + files.
      @@
       ----------------
       
       
     -+## CONE PATTERN SET
     ++CONE PATTERN SET
     ++----------------
      +
      +The full pattern set allows for arbitrary pattern matches and complicated
      +inclusion/exclusion rules. These can result in O(N*M) pattern matches when
     @@ -68,17 +80,17 @@
      +added as a parent pattern. At this point, the sparse-checkout file contains
      +the following patterns:
      +
     -+```
     ++----------------
      +/*
      +!/*/
     -+```
     ++----------------
      +
      +This says "include everything in root, but nothing two levels below root."
      +If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
      +`A/B` are added as parent patterns. The resulting sparse-checkout file is
      +now
      +
     -+```
     ++----------------
      +/*
      +!/*/
      +/A/
     @@ -86,7 +98,7 @@
      +/A/B/
      +!/A/B/*/
      +/A/B/C/
     -+```
     ++----------------
      +
      +Here, order matters, so the negative patterns are overridden by the positive
      +patterns that appear lower in the file.
  9:  ff2a59bfff =  9:  eca0bbf930 sparse-checkout: use hashmaps for cone patterns
 10:  0258ee8026 ! 10:  951e622aac sparse-checkout: init and set in cone mode
     @@ -3,7 +3,7 @@
          sparse-checkout: init and set in cone mode
      
          To make the cone pattern set easy to use, update the behavior of
     -    'git sparse-checkout [init|set]'.
     +    'git sparse-checkout (init|set)'.
      
          Add '--cone' flag to 'git sparse-checkout init' to set the config
          option 'core.sparseCheckoutCone=true'.
     @@ -34,35 +34,78 @@
       static char const * const builtin_sparse_checkout_usage[] = {
       	N_("git sparse-checkout (init|list|set|disable) <options>"),
      @@
     + 	return result;
     + }
     + 
     ++static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
     ++{
     ++	int i;
     ++	struct pattern_entry *pe;
     ++	struct hashmap_iter iter;
     ++	struct string_list sl = STRING_LIST_INIT_DUP;
     ++
     ++	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
     ++		string_list_insert(&sl, pe->pattern);
     ++
     ++	string_list_sort(&sl);
     ++	string_list_remove_duplicates(&sl, 0);
     ++
     ++	fprintf(fp, "/*\n!/*/\n");
     ++
     ++	for (i = 0; i < sl.nr; i++) {
     ++		char *pattern = sl.items[i].string;
     ++
     ++		if (strlen(pattern))
     ++			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
     ++	}
     ++
     ++	string_list_clear(&sl, 0);
     ++
     ++	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
     ++		string_list_insert(&sl, pe->pattern);
     ++
     ++	string_list_sort(&sl);
     ++	string_list_remove_duplicates(&sl, 0);
     ++
     ++	for (i = 0; i < sl.nr; i++) {
     ++		char *pattern = sl.items[i].string;
     ++		fprintf(fp, "%s/\n", pattern);
     ++	}
     ++}
     ++
     ++static int write_patterns_and_update(struct pattern_list *pl)
     ++{
     ++	char *sparse_filename;
     ++	FILE *fp;
     ++
     ++	sparse_filename = get_sparse_checkout_filename();
     ++	fp = fopen(sparse_filename, "w");
     ++
     ++	if (core_sparse_checkout_cone)
     ++		write_cone_to_file(fp, pl);
     ++	else
     ++		write_patterns_to_file(fp, pl);
     ++
     ++	fclose(fp);
     ++	free(sparse_filename);
     ++
     ++	return update_working_directory();
     ++}
     ++
       enum sparse_checkout_mode {
       	MODE_NO_PATTERNS = 0,
       	MODE_ALL_PATTERNS = 1,
      +	MODE_CONE_PATTERNS = 2,
       };
       
     - static int sc_set_config(enum sparse_checkout_mode mode)
     - {
     - 	struct argv_array argv = ARGV_ARRAY_INIT;
     -+	struct argv_array cone_argv = ARGV_ARRAY_INIT;
     - 
     - 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
     - 		error(_("failed to set extensions.worktreeConfig setting"));
     + static int set_config(enum sparse_checkout_mode mode)
      @@
     - 		return 1;
     - 	}
     + 				      "core.sparseCheckout",
     + 				      mode ? "true" : NULL);
       
     -+	argv_array_pushl(&cone_argv, "config", "--worktree",
     -+			 "core.sparseCheckoutCone", NULL);
     -+
     -+	if (mode == MODE_CONE_PATTERNS)
     -+		argv_array_push(&cone_argv, "true");
     -+	else
     -+		argv_array_push(&cone_argv, "false");
     -+
     -+	if (run_command_v_opt(cone_argv.argv, RUN_GIT_CMD)) {
     -+		error(_("failed to enable core.sparseCheckoutCone"));
     -+		return 1;
     -+	}
     ++	git_config_set_in_file_gently(config_path,
     ++				      "core.sparseCheckoutCone",
     ++				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
      +
       	return 0;
       }
     @@ -85,7 +128,7 @@
       	struct object_id oid;
      +	int mode;
       
     --	if (sc_set_config(MODE_ALL_PATTERNS))
     +-	if (set_config(MODE_ALL_PATTERNS))
      +	static struct option builtin_sparse_checkout_init_options[] = {
      +		OPT_BOOL(0, "cone", &init_opts.cone_mode,
      +			 N_("initialize the sparse-checkout in cone mode")),
     @@ -98,7 +141,7 @@
      +
      +	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
      +
     -+	if (sc_set_config(mode))
     ++	if (set_config(mode))
       		return 1;
       
       	memset(&pl, 0, sizeof(pl));
     @@ -106,15 +149,24 @@
       	return update_working_directory();
       }
       
     +-static int write_patterns_and_update(struct pattern_list *pl)
      +static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
     -+{
     + {
     +-	char *sparse_filename;
     +-	FILE *fp;
      +	struct pattern_entry *e = xmalloc(sizeof(*e));
      +	e->patternlen = path->len;
      +	e->pattern = strbuf_detach(path, NULL);
      +	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
     -+
     + 
     +-	sparse_filename = get_sparse_checkout_filename();
     +-	fp = fopen(sparse_filename, "w");
     +-	write_patterns_to_file(fp, pl);
     +-	fclose(fp);
     +-	free(sparse_filename);
      +	hashmap_add(&pl->recursive_hashmap, &e->ent);
     -+
     + 
     +-	return update_working_directory();
      +	while (e->patternlen) {
      +		char *slash = strrchr(e->pattern, '/');
      +		char *oldpattern = e->pattern;
     @@ -134,62 +186,6 @@
      +	}
      +}
      +
     -+static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
     -+{
     -+	int i;
     -+	struct pattern_entry *pe;
     -+	struct hashmap_iter iter;
     -+	struct string_list sl = STRING_LIST_INIT_DUP;
     -+
     -+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
     -+		string_list_insert(&sl, pe->pattern);
     -+
     -+	string_list_sort(&sl);
     -+	string_list_remove_duplicates(&sl, 0);
     -+
     -+	fprintf(fp, "/*\n!/*/\n");
     -+
     -+	for (i = 0; i < sl.nr; i++) {
     -+		char *pattern = sl.items[i].string;
     -+
     -+		if (strlen(pattern))
     -+			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
     -+	}
     -+
     -+	string_list_clear(&sl, 0);
     -+
     -+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
     -+		string_list_insert(&sl, pe->pattern);
     -+
     -+	string_list_sort(&sl);
     -+	string_list_remove_duplicates(&sl, 0);
     -+
     -+	for (i = 0; i < sl.nr; i++) {
     -+		char *pattern = sl.items[i].string;
     -+		fprintf(fp, "%s/\n", pattern);
     -+	}
     -+}
     -+
     - static int write_patterns_and_update(struct pattern_list *pl)
     - {
     - 	char *sparse_filename;
     -@@
     - 
     - 	sparse_filename = get_sparse_checkout_filename();
     - 	fp = fopen(sparse_filename, "w");
     --	write_patterns_to_file(fp, pl);
     -+
     -+	if (core_sparse_checkout_cone)
     -+		write_cone_to_file(fp, pl);
     -+	else
     -+		write_patterns_to_file(fp, pl);
     -+
     - 	fclose(fp);
     - 	free(sparse_filename);
     - 
     - 	return update_working_directory();
     - }
     - 
      +static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
      +{
      +	strbuf_trim(line);
     @@ -203,11 +199,9 @@
      +		strbuf_insert(line, 0, "/", 1);
      +
      +	insert_recursive_pattern(pl, line);
     -+}
     -+
     + }
     + 
       static char const * const builtin_sparse_checkout_set_usage[] = {
     - 	N_("git sparse-checkout set [--stdin|<patterns>]"),
     - 	NULL
      @@
       			     builtin_sparse_checkout_set_usage,
       			     PARSE_OPT_KEEP_UNKNOWN);
     @@ -215,10 +209,9 @@
      -	if (set_opts.use_stdin) {
      +	if (core_sparse_checkout_cone) {
       		struct strbuf line = STRBUF_INIT;
     --
     + 
      -		while (!strbuf_getline(&line, stdin)) {
     --			size_t len;
     --			char *buf = strbuf_detach(&line, &len);
     +-			char *buf = strbuf_detach(&line, NULL);
      -			add_pattern(buf, empty_base, 0, &pl, 0);
      +		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
      +		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
     @@ -301,7 +294,7 @@
      +	echo a >expect &&
      +	test_cmp expect dir &&
      +	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
     -+	test_line_count = 0 err &&
     ++	test_must_be_empty err &&
      +	ls repo >dir  &&
      +	cat >expect <<-EOF &&
      +		a
     @@ -334,7 +327,7 @@
      +		folder1
      +		folder2
      +	EOF
     -+	test_line_count = 0 err &&
     ++	test_must_be_empty err &&
      +	cat >expect <<-EOF &&
      +		a
      +		folder1
 11:  7b5c5bad2d = 11:  745910bb8e unpack-trees: hash less in cone mode
 12:  386f4f8eb5 = 12:  3d0f951d33 unpack-trees: add progress to clear_ce_flags()
 13:  a229e1ee0c <  -:  ---------- read-tree: show progress by default
 14:  f03bb23305 = 13:  2703b344f6 sparse-checkout: sanitize for nested folders
 15:  d7af75672b ! 14:  63e01c2021 sparse-checkout: update working directory in-process
     @@ -68,11 +68,11 @@
      +	struct repository *r = the_repository;
       
      -	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     --		error(_("failed to update index with new sparse-checkout paths"));
     +-		error(_("failed to update index with new sparse-checkout patterns"));
      -		result = 1;
      -	}
      +	if (repo_read_index_unmerged(r))
     -+		die(_("You need to resolve your current index first"));
     ++		die(_("you need to resolve your current index first"));
      +
      +	if (get_oid("HEAD", &oid))
      +		return 0;
     @@ -113,29 +113,6 @@
       	return result;
       }
       
     -@@
     - 			     builtin_sparse_checkout_init_options,
     - 			     builtin_sparse_checkout_init_usage, 0);
     - 
     --	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
     -+	if (init_opts.cone_mode) {
     -+		mode = MODE_CONE_PATTERNS;
     -+		core_sparse_checkout_cone = 1;
     -+	} else
     -+		mode = MODE_ALL_PATTERNS;
     - 
     - 	if (sc_set_config(mode))
     - 		return 1;
     -@@
     - 	}
     - 
     - reset_dir:
     --	return update_working_directory();
     -+	core_apply_sparse_checkout = 1;
     -+	return update_working_directory(NULL);
     - }
     - 
     - static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
      @@
       {
       	char *sparse_filename;
     @@ -164,9 +141,32 @@
      +	return 0;
       }
       
     - static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
     + enum sparse_checkout_mode {
      @@
     - 		struct strbuf line = STRBUF_INIT;
     + 			     builtin_sparse_checkout_init_options,
     + 			     builtin_sparse_checkout_init_usage, 0);
     + 
     +-	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
     ++	if (init_opts.cone_mode) {
     ++		mode = MODE_CONE_PATTERNS;
     ++		core_sparse_checkout_cone = 1;
     ++	} else
     ++		mode = MODE_ALL_PATTERNS;
     + 
     + 	if (set_config(mode))
     + 		return 1;
     +@@
     + 	}
     + 
     + reset_dir:
     +-	return update_working_directory();
     ++	core_apply_sparse_checkout = 1;
     ++	return update_working_directory(NULL);
     + }
     + 
     + static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
     +@@
     + 
       		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
       		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
      +		pl.use_cone_patterns = 1;
  -:  ---------- > 15:  cc6773e49b sparse-checkout: use in-process update for disable subcommand
 16:  88eff318e0 ! 16:  a0dca0056a sparse-checkout: write using lockfile
     @@ -24,12 +24,11 @@
      +	struct lock_file lk = LOCK_INIT;
       	int result;
       
     - 	result = update_working_directory(pl);
     - 
     +-	result = update_working_directory(pl);
      +	sparse_filename = get_sparse_checkout_filename();
      +	fd = hold_lock_file_for_update(&lk, sparse_filename,
      +				      LOCK_DIE_ON_ERROR);
     -+
     + 
      +	result = update_working_directory(pl);
       	if (result) {
      +		rollback_lock_file(&lk);
 17:  ab20c11d71 = 17:  4097d8f6de sparse-checkout: cone mode should not interact with .gitignore
  -:  ---------- > 18:  c62d9750ef sparse-checkout: update working directory in-process for 'init'
  -:  ---------- > 19:  7577ffc034 sparse-checkout: check for dirty status

-- 
gitgitgadget

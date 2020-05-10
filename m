Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1531DC47255
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D655D21775
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="QCK9vg9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgEJAmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 20:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbgEJAmX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 20:42:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB82C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 17:42:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so6037086qke.8
        for <git@vger.kernel.org>; Sat, 09 May 2020 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbUqt6B0oS+ikGLm0xi86meP+iWRcL8tdlJcOtH1rKI=;
        b=QCK9vg9igkSwH9Hzp8rMjHaiAdG5aMqPI1NN2tM0JIITuQk1ewCvEiLsUU6hqax/jT
         IkqrbVLq4cDrn3acbB3syYVPZbl0IYGi5wnPwCrsaTs+Io7nwE3yQWMQ6gxgl2WtjJwm
         B1G7639GbVUCyNccysNxu2DVLwYtEE6irYNnDWadxO5E3MXiS7fhxYQ52GHQcPaCUe5S
         7sZxkDf70cgu+vg3U3qYXNf/EkuLhawCdMWFC1vPRcVfYjtWRqbXW3BM/Vjj5q3O6FEC
         BRz1OepjIMwE6I61X9oRKgWXPejqqfPCNrxkxlfj9D3GmE5H2WRHQ2LvaUw5X1kyDFno
         qB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbUqt6B0oS+ikGLm0xi86meP+iWRcL8tdlJcOtH1rKI=;
        b=Fs4XHQYuqyohXkWCB+loRkW8rs0RZxEdMAEFMIPbe2DSoMxCDcV2TRMDTO2tPzzMiM
         WPI7tmm5YB9khvt/Nha5OEIzTqafZUAwILaE5cAbc5AReIwiUJio0KPpFPSvg3bkcVrT
         F7VId/+g0EBzTkYDVTeqkrlWBf879wltZf4Ez2tbusdHlV84YqeALlZViYYkmWPLY/u0
         FPJzUmVjITGANgfD0iDn/kA9xzbRET/mszMA1Eaw3lVYkeofPM5a7i6xH0IJ5Cy6+QfV
         LbFqhXhjxZMkTOnFbOVwt6NIQ0Rd3B7sjZZHiGjfJ+xE1HovQOD+RflPGDf10HRrFETZ
         rq3w==
X-Gm-Message-State: AGi0PuYOAF7syQRqfWAWQLlLcC25L7Ui1dmalN/9DX4f8LHwRyCZ42Mw
        ln2tAYTmpEdifDMjDxDDlhoHr70HEQ8=
X-Google-Smtp-Source: APiQypIDAzS+ApAN8OH/1h1mAxzQ8pOAa2lN+dPQbl9Gd1zqKqmC/zLsxofrRB5qNbvp865/DZ8s8Q==
X-Received: by 2002:a37:8045:: with SMTP id b66mr1754717qkd.231.1589071341735;
        Sat, 09 May 2020 17:42:21 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id s8sm5615974qtb.0.2020.05.09.17.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:42:21 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [RFC PATCH v2 4/4] config: add setting to ignore sparsity patterns in some cmds
Date:   Sat,  9 May 2020 21:41:30 -0300
Message-Id: <3e9e90624901113fd5c5670c0c2023c709f71d6d.1589058209.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589058209.git.matheus.bernardino@usp.br>
References: <cover.1589058209.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sparse checkout is enabled, some users expect the output of certain
commands (such as grep, diff, and log) to be also restricted within the
sparsity patterns. This would allow them to effectively work only on the
subset of files in which they are interested; and allow some commands to
possibly perform better, by not considering uninteresting paths. For
this reason, we taught grep to honor the sparsity patterns, in the
previous commit. But, on the other hand, allowing grep and the other
commands mentioned to optionally ignore the patterns also make for some
interesting use cases. E.g. using grep to search for a function
definition that resides outside the sparse checkout.

In any case, there is no current way for users to configure the behavior
they want for these commands. Aiming to provide this flexibility, let's
introduce the sparse.restrictCmds setting (and the analogous
--[no]-restrict-to-sparse-paths global option). The default value is
true. For now, grep is the only one affected by this setting, but the
goal is to have support for more commands, in the future.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Some notes/questions about this one:

- I guess having the additional sparse-checkout.o only for the
  restrict_to_sparse_paths() function is not very justifiable.
  Especially since builtin/grep.c is currently its only caller. But
  since Stolee is already moving some code out of the sparse-checkout
  builtin and into sparse-checkout.o [1], I thought it would be better
  to place this function here from the start, as it will likely be
  needed by other cmds when they start honoring sparse.restrictCmds.
  (Side note: I think I will also be able to use the
  populate_sparse_checkout_patterns() function added by Stolee in the
  same patchset [2], to avoid code duplication in the
  get_sparsity_patterns() function added in this patch).

[1]: https://lore.kernel.org/git/0181a134bfb6986dc0e54ae624c478446a1324a9.1588857462.git.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/444a6b5f894f28e96f713e5caccba18e1ea3b3eb.1588857462.git.gitgitgadget@gmail.com/

- With that said, the only reason we need restrict_to_sparse_paths() to
  begin with, is so that commands which recurse into submodules may
  respect the value set in each submodule for the sparse.restrictCmds
  config. This is already being done for grep, in this patch. But,
  should we do like this or should we use the value set at the
  superproject, for all submodules as well, when recursing (ignoring the
  value set on them)?

- It's possible to also make read-tree respect the new setting/option,
  using --no-restrict-to-sparse-paths as a synonym for its
  --no-sparse-checkout option (with lower precedence). However, as this
  command can change the sparse checked out paths, I thought it kind
  of falls under a different category. Also, `git read-tree -mu
  --sparse-checkout` doesn't have the effect of *restricting* the
  command's behavior to the sparsity patterns, but of applying them to
  the working tree, right? So maybe it could be confusing to make this
  command honor the new setting. Does that make sense, or should we do
  it?

- Finally, if we decide to make read-tree be affected by
  sparse.restrictCmds, there is also the case of whether the config
  should be honored for submodules or just propagate the superproject's
  value. I think the latter would be as simple as adding this line,
  before calling parse_options() in builtin/read-tree.c:

  opts.skip_sparse_checkout = !restrict_to_sparse_paths(the_repository);

  As for the former, I'm not very familiar with the code in
  unpack_trees(), so I'm not sure how complicated that would be.


 Documentation/config.txt               |  2 +
 Documentation/config/sparse.txt        | 22 ++++++++
 Documentation/git-grep.txt             |  3 +
 Documentation/git.txt                  |  4 ++
 Makefile                               |  1 +
 builtin/grep.c                         | 14 ++++-
 contrib/completion/git-completion.bash |  2 +
 git.c                                  |  6 ++
 sparse-checkout.c                      | 16 ++++++
 sparse-checkout.h                      | 11 ++++
 t/t7817-grep-sparse-checkout.sh        | 78 +++++++++++++++++++++++++-
 t/t9902-completion.sh                  |  4 +-
 12 files changed, 159 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef0768b91a..fd74b80302 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -436,6 +436,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sparse.txt[]
+
 include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
new file mode 100644
index 0000000000..83a4e0018f
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,22 @@
+sparse.restrictCmds::
+	Only meaningful in conjunction with core.sparseCheckout. This option
+	extends sparse checkouts (which limit which paths are written to the
+	working tree), so that output and operations are also limited to the
+	sparsity paths where possible and implemented. The purpose of this
+	option is to (1) focus output for the user on the portion of the
+	repository that is of interest to them, and (2) enable potentially
+	dramatic performance improvements, especially in conjunction with
+	partial clones.
++
+When this option is true (default), some git commands may limit their behavior
+to the paths specified by the sparsity patterns, or to the intersection of
+those paths and any (like `*.c) that the user might also specify on the command
+line. When false, the affected commands will work on full trees, ignoring the
+sparsity patterns. For now, only git-grep honors this setting. In this command,
+the restriction becomes relevant in one of these three cases: with --cached;
+when a commit-ish is given; when searching a working tree that contains paths
+previously excluded by the sparsity patterns.
++
+Note: commands which export, integrity check, or create history will always
+operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
+unaffected by any sparsity patterns.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 9bdf807584..abbf100109 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,6 +41,9 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------
 
+git-grep honors the sparse.restrictCmds setting. See its definition in
+linkgit:git-config[1].
+
 :git-grep: 1
 include::config/grep.txt[]
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d6769e95a..5e107c6246 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -180,6 +180,10 @@ If you just want to run git as if it was started in `<path>` then use
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
+--[no-]restrict-to-sparse-paths::
+	Overrides the sparse.restrictCmds configuration (see
+	linkgit:git-config[1]) for this execution.
+
 --list-cmds=group[,group...]::
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
diff --git a/Makefile b/Makefile
index 3d3a39fc19..67580c691b 100644
--- a/Makefile
+++ b/Makefile
@@ -986,6 +986,7 @@ LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-checkout.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
diff --git a/builtin/grep.c b/builtin/grep.c
index 91ee0b2734..3f92e7fd6c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -25,6 +25,7 @@
 #include "submodule-config.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "sparse-checkout.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -498,6 +499,7 @@ static int grep_cache(struct grep_opt *opt,
 	int nr;
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
+	int sparse_paths_only =	restrict_to_sparse_paths(repo);
 	if (repo->submodule_prefix) {
 		name_base_len = strlen(repo->submodule_prefix);
 		strbuf_addstr(&name, repo->submodule_prefix);
@@ -509,7 +511,8 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
+		if (sparse_paths_only && ce_skip_worktree(ce) &&
+		    !S_ISGITLINK(ce->ce_mode))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -717,9 +720,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     int is_root_tree)
 {
 	struct pattern_list *patterns = NULL;
+	int sparse_paths_only = restrict_to_sparse_paths(opt->repo);
 	int ret;
 
-	if (is_root_tree)
+	if (is_root_tree && sparse_paths_only)
 		patterns = get_sparsity_patterns(opt->repo);
 
 	ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
@@ -1259,6 +1263,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
+
+		if (opt_restrict_to_sparse_paths >= 0) {
+			warning(_("--[no-]restrict-to-sparse-paths is ignored"
+				  " with --no-index or --untracked"));
+		}
+
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b1d6e5ebed..cba0f9166c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3207,6 +3207,8 @@ __git_main ()
 			--namespace=
 			--no-replace-objects
 			--help
+			--restrict-to-sparse-paths
+			--no-restrict-to-sparse-paths
 			"
 			;;
 		*)
diff --git a/git.c b/git.c
index 2e4efb4ff0..f967c75d9c 100644
--- a/git.c
+++ b/git.c
@@ -37,6 +37,7 @@ const char git_more_info_string[] =
 	   "See 'git help git' for an overview of the system.");
 
 static int use_pager = -1;
+int opt_restrict_to_sparse_paths = -1;
 
 static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
@@ -310,6 +311,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (!strcmp(cmd, "--restrict-to-sparse-paths")) {
+			opt_restrict_to_sparse_paths = 1;
+		} else if (!strcmp(cmd, "--no-restrict-to-sparse-paths")) {
+			opt_restrict_to_sparse_paths = 0;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
@@ -318,6 +323,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		(*argv)++;
 		(*argc)--;
 	}
+
 	return (*argv) - orig_argv;
 }
 
diff --git a/sparse-checkout.c b/sparse-checkout.c
new file mode 100644
index 0000000000..9a9e50fd29
--- /dev/null
+++ b/sparse-checkout.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+#include "config.h"
+#include "sparse-checkout.h"
+
+int restrict_to_sparse_paths(struct repository *repo)
+{
+	int ret;
+
+	if (opt_restrict_to_sparse_paths >= 0)
+		return opt_restrict_to_sparse_paths;
+
+	if (repo_config_get_bool(repo, "sparse.restrictcmds", &ret))
+		ret = 1;
+
+	return ret;
+}
diff --git a/sparse-checkout.h b/sparse-checkout.h
new file mode 100644
index 0000000000..1de3b588d8
--- /dev/null
+++ b/sparse-checkout.h
@@ -0,0 +1,11 @@
+#ifndef SPARSE_CHECKOUT_H
+#define SPARSE_CHECKOUT_H
+
+struct repository;
+
+extern int opt_restrict_to_sparse_paths; /* from git.c */
+
+/* Whether or not cmds should restrict behavior on sparse paths, in this repo */
+int restrict_to_sparse_paths(struct repository *repo);
+
+#endif /* SPARSE_CHECKOUT_H */
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index 3bd67082eb..8509694bf1 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -63,12 +63,28 @@ test_expect_success 'setup' '
 	test_path_is_file sub/B/b
 '
 
+# The two tests bellow check a special case: the sparsity patterns exclude '/b'
+# and sparse checkout is enable, but the path exists on the working tree (e.g.
+# manually created after `git sparse-checkout init`). In this case, grep should
+# honor --restrict-to-sparse-paths.
 test_expect_success 'grep in working tree should honor sparse checkout' '
 	cat >expect <<-EOF &&
 	a:text
 	EOF
+	echo newtext >b &&
 	git grep "text" >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	rm b
+'
+test_expect_success 'grep w/ --no-restrict-to-sparse-paths for sparsely excluded but present paths' '
+	cat >expect <<-EOF &&
+	a:text
+	b:newtext
+	EOF
+	echo newtext >b &&
+	git --no-restrict-to-sparse-paths grep "text" >actual &&
+	test_cmp expect actual &&
+	rm b
 '
 
 test_expect_success 'grep --cached should honor sparse checkout' '
@@ -137,4 +153,64 @@ test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse
 	test_cmp expect_t-commit actual_t-commit
 '
 
+for cmd in 'git --no-restrict-to-sparse-paths grep' \
+	   'git -c sparse.restrictCmds=false grep' \
+	   'git -c sparse.restrictCmds=true --no-restrict-to-sparse-paths grep'
+do
+
+	test_expect_success "$cmd --cached should ignore sparsity patterns" '
+		cat >expect <<-EOF &&
+		a:text
+		b:text
+		dir/c:text
+		EOF
+		$cmd --cached "text" >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd <commit-ish> should ignore sparsity patterns" '
+		commit=$(git rev-parse HEAD) &&
+		cat >expect_commit <<-EOF &&
+		$commit:a:text
+		$commit:b:text
+		$commit:dir/c:text
+		EOF
+		cat >expect_t-commit <<-EOF &&
+		t-commit:a:text
+		t-commit:b:text
+		t-commit:dir/c:text
+		EOF
+		$cmd "text" $commit >actual_commit &&
+		test_cmp expect_commit actual_commit &&
+		$cmd "text" t-commit >actual_t-commit &&
+		test_cmp expect_t-commit actual_t-commit
+	'
+done
+
+test_expect_success 'should respect the sparse.restrictCmds values from submodules' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/A/a:text
+	sub/B/b:text
+	EOF
+	git -C sub config sparse.restrictCmds false &&
+	git grep --cached --recurse-submodules "text" >actual &&
+	test_cmp expect actual &&
+	git -C sub config --unset sparse.restrictCmds
+'
+
+test_expect_success 'should propagate --[no]-restrict-to-sparse-paths to submodules' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	sub/A/a:text
+	sub/B/b:text
+	EOF
+	git -C sub config sparse.restrictCmds true &&
+	git --no-restrict-to-sparse-paths grep --cached --recurse-submodules "text" >actual &&
+	test_cmp expect actual &&
+	git -C sub config --unset sparse.restrictCmds
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3c44af6940..a4a7767e06 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1473,6 +1473,8 @@ test_expect_success 'double dash "git" itself' '
 	--namespace=
 	--no-replace-objects Z
 	--help Z
+	--restrict-to-sparse-paths Z
+	--no-restrict-to-sparse-paths Z
 	EOF
 '
 
@@ -1515,7 +1517,7 @@ test_expect_success 'general options' '
 	test_completion "git --nam" "--namespace=" &&
 	test_completion "git --bar" "--bare " &&
 	test_completion "git --inf" "--info-path " &&
-	test_completion "git --no-r" "--no-replace-objects "
+	test_completion "git --no-rep" "--no-replace-objects "
 '
 
 test_expect_success 'general options plus command' '
-- 
2.26.2


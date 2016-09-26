Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853AE207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbcIZWr2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:47:28 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35888 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbcIZWrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:47:23 -0400
Received: by mail-pa0-f47.google.com with SMTP id qn7so49772499pac.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h34BN9Be3+B2UjV6LjuDI6jp+ZniBhiKi5b3W+ynPrY=;
        b=ehLH1sj1bfRHmYLGP8heubMyORPGCWnfGr3K5O4zOhJbAQMj18SS5AaIjO5bhLp7iy
         qbB5lAN/xRnUXP3UFJr7KzGMxtIHkfoWNr/suW/JpJspkEzVlZwTLDyGDr3a3EZi+Dcy
         5XE71J7dLyH7rKtwV2j8hHDakdrv9FB3hvBcKStBJeRkriBAqnhLcvXnf9jfeE9B4Qrl
         AmL4C8q+PDf1bWM0hEhsDLArspy+2z/MYQIIXNFaJPGuix6HcrEzC05l8MVnKk7Va8xx
         /ilV8bZ5yoGuZnD3J5KcNlIv/fCY/mTqT6qvEOz7bAV5SXfogKMxxX4qd61aDTmM9Qh+
         +uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h34BN9Be3+B2UjV6LjuDI6jp+ZniBhiKi5b3W+ynPrY=;
        b=jMtNnkIyOSSJssEsowb57zP62ytMY/OYAML46vdAj/+R8K1e425ahpySnlqlZF4xKJ
         3yLvZ3VDGEI5Q010xYG+gp51q8wXTtYDMoF/vgOPrTYZcL/BAnUgawE8xYQA5B2IB2Te
         HPYPAOIL5KkoJDOQN6wVuMqffPJS5RWSq8uPvrvloreMPU+mSW6IgiyliM42ud6FlbIO
         WRZEvivsUafMyHlwATJLc/VJCFv0Bs+sBrK//oSKrYHFI3kAINNh7wwl2ZrBPtQ74tUE
         rVmkW9ojIlAIp6t6iFaf86JukbH5CbcySkfpZqxmrZn3q3/oDTepjZknJo4uxUWyFShS
         aO2A==
X-Gm-Message-State: AA6/9Rm1dgGh+VvEQzmbNW7WIV0aWh7ye+V+X8KEq35hRvydJzvDrt3nG/ibz6OVu2ZckC0N
X-Received: by 10.66.85.198 with SMTP id j6mr7375638paz.110.1474930032470;
        Mon, 26 Sep 2016 15:47:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:9046:8098:b971:afcc])
        by smtp.gmail.com with ESMTPSA id i4sm33424677pav.27.2016.09.26.15.47.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 15:47:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
Date:   Mon, 26 Sep 2016 15:46:42 -0700
Message-Id: <1474930003-83750-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474930003-83750-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass through some known-safe options when recursing into submodules.
(--cached, --stage, -v, -t, -z, --debug, --eol)

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 34 ++++++++++++++++++++++++++++++----
 t/t3007-ls-files-recurse-submodules.sh | 17 ++++++++++++-----
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d4bfc60..a39367f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
 static const char *submodule_prefix;
+static struct argv_array recurse_submodules_opts = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -170,6 +171,27 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/*
+ * Compile an argv_array with all of the options supported by --recurse_submodules
+ */
+static void compile_submodule_options(int show_tag)
+{
+	if (show_cached)
+		argv_array_push(&recurse_submodules_opts, "--cached");
+	if (show_stage)
+		argv_array_push(&recurse_submodules_opts, "--stage");
+	if (show_valid_bit)
+		argv_array_push(&recurse_submodules_opts, "-v");
+	if (show_tag)
+		argv_array_push(&recurse_submodules_opts, "-t");
+	if (line_terminator == '\0')
+		argv_array_push(&recurse_submodules_opts, "-z");
+	if (debug_mode)
+		argv_array_push(&recurse_submodules_opts, "--debug");
+	if (show_eol)
+		argv_array_push(&recurse_submodules_opts, "--eol");
+}
+
 /**
  * Recursively call ls-files on a submodule
  */
@@ -184,6 +206,9 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 
+	/* add supported options */
+	argv_array_pushv(&cp.args, recurse_submodules_opts.argv);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -568,14 +593,15 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
+	if (recurse_submodules) {
 		submodule_prefix = getenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT);
+		compile_submodule_options(show_tag);
+	}
 
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
+	    (show_deleted || show_others || show_unmerged ||
 	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol || with_tree ||
-	     (line_terminator == '\0')))
+	     with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index 7d225ac..40767da 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,18 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files correctly outputs files in submodule with -z' '
+	cat | tr "\n" "\0" >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules -z >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files does not output files not added to a repo' '
 	cat >expect <<-\EOF &&
 	.gitmodules
@@ -86,15 +98,10 @@ test_incompatible_with_recurse_submodules () {
 	"
 }
 
-test_incompatible_with_recurse_submodules -z
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.8.0.rc3.226.g39d4020


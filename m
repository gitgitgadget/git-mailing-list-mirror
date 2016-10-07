Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D22920986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbcJGST2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:19:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34285 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbcJGSTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:19:23 -0400
Received: by mail-pa0-f43.google.com with SMTP id rz1so25807478pab.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKEq4sJmqNsOMkZ2/KSEy0i0lZTc8MAP01svv0sUZXQ=;
        b=o9uXiBvaGnrlsnb7BVWCZQ/C8pfd+WcwITvFP3Bz5F5gfYVGrFyXPtWygjOwxBNp+3
         DFwzunD89aYtdDID8tt9quIXsqYkT642w+qc4YU8kMScwWDgkfwt4+6xjRcVKQMA3Tz3
         8cyc4xyXyvELtuFdbYMw1u+tjVbxzyq7v39HnMm+jtBHQgD9zYjJjxAOcGmlaNaBvQWu
         GLUiWq6U8z5m691lx//Z77CRL9wjsBFGtusfh/z0uEZktKaqTn6rD2hAR4ezgcdCxUKF
         VrGgKgV8cLnqn9ElYJbXstmlBwK4OytO3cAE2ZBg9ETbs4bhHeVPI1ahrGsQrZDl/VGU
         HjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKEq4sJmqNsOMkZ2/KSEy0i0lZTc8MAP01svv0sUZXQ=;
        b=cceG9DYqc+dlaidpGwxEdds2kL2UsYWOqz8AMk3TwR3bM7QfUr+QAGdFKH69d/Xlhs
         RDtnq50CBfsyrQbctzohaLsfdU3DXbydq3WCO7cLyFZH4rudawaEtARfw33CuR1HD6zM
         +atyENdx7X4+0M28R39zWMxVZUWa65HYSdBlxm765nsmFKSwKPjRNR5DYOeedlET7BN2
         sQNlUUDRLKrAsbiZkKGAySJunprsswdeQ/KowJIO/vxsxxs0jCeJMJwCBo83hhf1FOqU
         QFh3Qr0dlAFKuIFNjn+vWyebhOpBNr1QWSqwyL+x0zySLGfWTHusEdwSGSGW5GDQ+OAc
         MiXQ==
X-Gm-Message-State: AA6/9RkFCGUO2fD9O69STUUilGumhC3LVNQTVZ2WBKT+mO40V5gDYzyjLjoP1lFyDUTP12+b
X-Received: by 10.66.159.37 with SMTP id wz5mr21966857pab.175.1475864362474;
        Fri, 07 Oct 2016 11:19:22 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.36.144])
        by smtp.gmail.com with ESMTPSA id s74sm15641281pfk.61.2016.10.07.11.19.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 11:19:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v7 3/4] ls-files: pass through safe options for --recurse-submodules
Date:   Fri,  7 Oct 2016 11:18:50 -0700
Message-Id: <20161007181851.15063-4-bmwill@google.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007181851.15063-1-bmwill@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
 <20161007181851.15063-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass through some known-safe options when recursing into submodules.
(--cached, -v, -t, -z, --debug, --eol)

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 30 +++++++++++++++++++++++++++---
 t/t3007-ls-files-recurse-submodules.sh | 16 ++++++++++++----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 63befed..b6144a5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,6 +30,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static struct argv_array submodules_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static const char *super_prefix;
@@ -168,6 +169,25 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/*
+ * Compile an argv_array with all of the options supported by --recurse_submodules
+ */
+static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
+{
+	if (line_terminator == '\0')
+		argv_array_push(&submodules_options, "-z");
+	if (show_tag)
+		argv_array_push(&submodules_options, "-t");
+	if (show_valid_bit)
+		argv_array_push(&submodules_options, "-v");
+	if (show_cached)
+		argv_array_push(&submodules_options, "--cached");
+	if (show_eol)
+		argv_array_push(&submodules_options, "--eol");
+	if (debug_mode)
+		argv_array_push(&submodules_options, "--debug");
+}
+
 /**
  * Recursively call ls-files on a submodule
  */
@@ -182,6 +202,9 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 
+	/* add supported options */
+	argv_array_pushv(&cp.args, submodules_options.argv);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -567,11 +590,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules)
+		compile_submodule_options(&dir, show_tag);
+
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol || with_tree ||
-	     (line_terminator == '\0')))
+	     show_killed || show_modified || show_resolve_undo || with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index b5a53c3..33a2ea7 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,18 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files correctly outputs files in submodule with -z' '
+	lf_to_nul >expect <<-\EOF &&
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
@@ -86,15 +98,11 @@ test_incompatible_with_recurse_submodules () {
 	"
 }
 
-test_incompatible_with_recurse_submodules -z
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
 test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.10.0


Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05808C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0D206DA
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IekN0+i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKUWFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40671 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so5443359wmi.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hu0t5CgsSWWSJsNVgcqafIWPol6C25UdVdqh+XEAbMM=;
        b=IekN0+i9/FtvUVSM4zX2c+j+Ga0bO0RLKPUSTycD7PkV4e6voK/iLB9ESy+/NALQNt
         jyfPrYMVv8B8EMvpr34CaB3HIvrfzOxqBGq0+yVmXCbphWvvLks8PIcU0CL9LnLVwh7y
         mXSZPVA6aandkSUhw9EISv06D/wwHjFl1NTfnqGobyJIXJG8ZfZM5oQRaJRUO3zn25hh
         kVbNEVwp+dVGKIbDUdLXKcB/qBILWMaxB+2srDXvVZINLw9lfGskVRrEr9h7LyxpQAy8
         WcOJ4KuNrCticTMYuTPT64tEcp1j4XNPR8dcIUclcE3JRzzw12wxze9kUweJqVgOQupQ
         O62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hu0t5CgsSWWSJsNVgcqafIWPol6C25UdVdqh+XEAbMM=;
        b=DLPmNJIaw0FPhEyAgqkmkqBWb70L5yAGA2mMDrFctTQcHTAgrd/FXbterN5sGpHfmb
         n59/KaZLKYPTYLFL7BtYJRyHE3S5nSpaDPYxyYlBoShLbpvIykOVTUC2Ogk0gM1u5XhQ
         EfoOm17/sUerYHDnkkoipK1k5U9fjeISIIxiEi5Wd59YLcxH3SvFVqM0t8cKHEjqxTOm
         sFt77tL36CgOHsVyhbm/ff2BQv9QLmDqycmuw3m0uNPK7OZd98F4lhSsPSAxXlYQf30O
         5o/IHsNPUQGJEWw44nDgLi7LnQkyi115Sis/gUsaMqKlyI3tXhbBXp7pnZViIYOPP9Uc
         imnQ==
X-Gm-Message-State: APjAAAWJx9rWuZAC09XOc+g/Cy9/2HAIQjYbleuyqxHO5lkbYesCAqq/
        t1UqoxuiAvm1Ijt0EjvS8rowJynK
X-Google-Smtp-Source: APXvYqwwreV+F4BZIwSJM7zIdTzGZw/26PWVBYFVEe0UmpnSSW6vYQvFNuIKAeTLmFUV7JO437rPQg==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr13026833wmg.146.1574373898706;
        Thu, 21 Nov 2019 14:04:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm5091711wrx.11.2019.11.21.14.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:58 -0800 (PST)
Message-Id: <751798216f35a4d26563898b639d0757eca9c5ff.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:37 +0000
Subject: [PATCH v6 05/19] sparse-checkout: add '--stdin' option to set
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git sparse-checkout set' subcommand takes a list of patterns
and places them in the sparse-checkout file. Then, it updates the
working directory to match those patterns. For a large list of
patterns, the command-line call can get very cumbersome.

Add a '--stdin' option to instead read patterns over standard in.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  3 +++
 builtin/sparse-checkout.c             | 34 +++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh    | 20 ++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index ca62669b8c..a724eae09c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -47,6 +47,9 @@ To avoid interfering with other worktrees, it first enables the
 	a list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns. Enable the
 	core.sparseCheckout config setting if it is not already enabled.
++
+When the `--stdin` option is provided, the patterns are read from
+standard in as a newline-delimited list instead of from the arguments.
 
 SPARSE CHECKOUT
 ---------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95cbd0a42c..82bff0020d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -150,6 +150,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	return update_working_directory();
 }
 
+static char const * const builtin_sparse_checkout_set_usage[] = {
+	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_set_opts {
+	int use_stdin;
+} set_opts;
+
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static const char *empty_base = "";
@@ -157,10 +166,31 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	struct pattern_list pl;
 	int result;
 	int changed_config = 0;
+
+	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
 	memset(&pl, 0, sizeof(pl));
 
-	for (i = 1; i < argc; i++)
-		add_pattern(argv[i], empty_base, 0, &pl, 0);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_set_options,
+			     builtin_sparse_checkout_set_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (set_opts.use_stdin) {
+		struct strbuf line = STRBUF_INIT;
+
+		while (!strbuf_getline(&line, stdin)) {
+			char *buf = strbuf_detach(&line, NULL);
+			add_pattern(buf, empty_base, 0, &pl, 0);
+		}
+	} else {
+		for (i = 0; i < argc; i++)
+			add_pattern(argv[i], empty_base, 0, &pl, 0);
+	}
 
 	if (!core_apply_sparse_checkout) {
 		set_config(MODE_ALL_PATTERNS);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 72d8bc5c25..07e73b4674 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -128,4 +128,24 @@ test_expect_success 'set sparse-checkout using builtin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'set sparse-checkout using --stdin' '
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/folder1/
+		/folder2/
+	EOF
+	git -C repo sparse-checkout set --stdin <expect &&
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget


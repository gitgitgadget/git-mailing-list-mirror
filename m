Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796BC54EEB
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A087F20663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6hvKYek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCUSA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43452 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgCUSAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id n25so10182421eds.10
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o2Imms6Msy/F5vNlk+068THcMm4jKlXyRIVB5aLRE6c=;
        b=r6hvKYek4QUi2maYOQZwJVEbf7ow2SAvJaGkM09qC6fSaw+dtuVWRXd8ymr3Uny8HY
         i/cFSMgsvO+zf9fu4DZPn6ZfMNT01Zvm/YOPuuWSjc05RI2I/T1kWit82O01t8aTHBap
         F3AVoNtqm8IelryRpD4pW0Gw7hkfRUNFjpQNGZjocicL8AeJsHIhqpTUwmoAf1Pkm037
         4wnI8AO3Wo1UGnmshJncDyEOU8ojZMafpG9HdYsXpaTV28q9o2nTUHqH2U4MM5+u8Yc2
         EG1NvMzzIM91KjPK/00/HiQGuH8yk3Iv5djF7GOE0WRYmsoR8C1DST3qSaLWoET9ZTHD
         HlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o2Imms6Msy/F5vNlk+068THcMm4jKlXyRIVB5aLRE6c=;
        b=ia2mCQLgB2OtSc6KEEUQ1KETzZBhotyjBK2FLgxfa0U3daTaY4ehXh3q1OlrJhMC/v
         AY5KLr5Qex8a7tzjqzT5ZwreyHCt1hbsn7S9fo/Z4VF0n1rHemn/eVldyFAflz2vW/aM
         TGnsf1n/9LaqVULm/Dp+rMZnEgI7LYAURu84l7OB81vpyou/dOD5GFk3WNuLHRqsK9P+
         LmkykpiRTsa+/K7ohau+XjetjWiatB5BHy6ySkqSAHdJzJkcAMw9TpCwPNVQaOz9fUfj
         AM5RuVIDfk2un4tAW9SOiBsl3K09FAj8mdg2ApXCTXdcpQ5Y2KIgHsVQMalUUctxYg+e
         vRPQ==
X-Gm-Message-State: ANhLgQ13TfjhdMQ70HyOIjoWUdo7CMVTmSt8f24W3483ZVAtYqDNaK/z
        COcjJO3KGJgHDSvSjQ2DrWWXSvD3
X-Google-Smtp-Source: ADFU+vseksuQBfb2VOSFm46ImnSJXLpqDSNjJwgky0AQ98julNWvUBPczdmGlC67Xu0JJz/S9CqPZA==
X-Received: by 2002:a05:6402:b04:: with SMTP id bm4mr2804206edb.328.1584813623870;
        Sat, 21 Mar 2020 11:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm627152edm.52.2020.03.21.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:23 -0700 (PDT)
Message-Id: <5730f7d250a2025ae62edaf8779ff39bfbaa5ad6.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:09 +0000
Subject: [PATCH v2 18/18] sparse-checkout: provide a new reapply subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If commands like merge or rebase materialize files as part of their work,
or a previous sparse-checkout command failed to update individual files
due to dirty changes, users may want a command to simply 'reapply' the
sparsity rules.  Provide one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 10 ++++++++++
 builtin/sparse-checkout.c             | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c0342e53938..1a3ace60820 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,6 +70,16 @@ C-style quoted strings.
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
+'reapply::
+	Reapply the sparsity pattern rules to paths in the working tree.
+	Commands like merge or rebase can materialize paths to do their
+	work (e.g. in order to show you a conflict), and other
+	sparse-checkout commands might fail to sparsify an individual file
+	(e.g. because it has unstaged changes or conflicts).  In such
+	cases, it can make sense to run `git sparse-checkout reapply` later
+	after cleaning up affected paths (e.g. resolving conflicts, undoing
+	or committing changes, etc.).
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aa81199f85d..95d08824172 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -18,7 +18,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
+	N_("git sparse-checkout (init|list|set|add|reapply|disable) <options>"),
 	NULL
 };
 
@@ -554,6 +554,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	return modify_pattern_list(argc, argv, m);
 }
 
+static int sparse_checkout_reapply(int argc, const char **argv)
+{
+	repo_read_index(the_repository);
+	return update_working_directory(NULL);
+}
+
 static int sparse_checkout_disable(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -603,6 +609,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_set(argc, argv, prefix, REPLACE);
 		if (!strcmp(argv[0], "add"))
 			return sparse_checkout_set(argc, argv, prefix, ADD);
+		if (!strcmp(argv[0], "reapply"))
+			return sparse_checkout_reapply(argc, argv);
 		if (!strcmp(argv[0], "disable"))
 			return sparse_checkout_disable(argc, argv);
 	}
-- 
gitgitgadget

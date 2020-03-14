Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F3C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C82071B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR2XAv65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCOB5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:57:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35189 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCOB5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:57:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so17383420edj.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 18:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7vURZjwLWnQZCWJk6JJhvnUshrHeJ75H/tj5ds8LnMU=;
        b=VR2XAv65byNhTJzPvrZy2pd5fNuxz9LUB7YNoE2QSRUDMM73D3SRlAtJv0JtrmyjsN
         7LFuh09sPaS1EgIus7h3SBoE7wME6XbdvTN1RGle4URR05KouP0N9rrSdxS0xDseKsxl
         lOnhSG9TmdYrVc3KebZ5Ysp6udRUSqhThaF+wNguWzI29ZeoulHkW+NlZVqUcmDCE0Ck
         j7B9ktpJ/F1HqS5qwiz4ZfsOBdvChmIoKlH7KJBtJGlSTMT+z/14XMVGWQCXpAlHK2j1
         j6h6KLxoIS1AVuGr7CgdPXcmfzDk+crXomVZWzDaD7mwwpvnBEHU93WsYiY22fqxK0cU
         1hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7vURZjwLWnQZCWJk6JJhvnUshrHeJ75H/tj5ds8LnMU=;
        b=t8qkxaEWL8O+qAfbqLA9y0sleoPKyrTQYxO7AwsfBVC+M8XQ5fVywMrTIAaQfAKDLU
         E5BPJ0P+ztJEG5XtfBTfESOjPFNsZXQavhTdKtWAcEZYldFhYKMTGRz+b5iSJUHS+TXS
         a9wan01LGHZpwK63fP0eETGV3Td2qF4X85GlivpIDzKncpYzhialBAJSeFrZ4r+WjiHT
         DSPL+6AaK7p6YO66SscS/VbVmkEvAWh/moyU+9THHltdBSMSI8AVVuk261uSVhxZNVAd
         XqQ7pLQZz+egIjdb5o2fBT71cGe5SDdxK5dvsaf9g0zKEWFE6fYO0TbvYjdwJrswFcVQ
         R5Zg==
X-Gm-Message-State: ANhLgQ03U20Si7VDMkFS5bc4IqLa5wKmkST9YB75KPkmOtidUFk8TD13
        FT2z2lmNqMzmu06TVQQg7CFUUAFG
X-Google-Smtp-Source: ADFU+vvy/KWa7oPVHaFt50kQ9CZQJE1H7Hd/WupMvRUf7ZtwVluOvwgMZlIIfGULtoi9dFqzyUrfWQ==
X-Received: by 2002:a50:b905:: with SMTP id m5mr16951332ede.154.1584169899852;
        Sat, 14 Mar 2020 00:11:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm4283787ejb.34.2020.03.14.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:39 -0700 (PDT)
Message-Id: <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:33 +0000
Subject: [PATCH 7/7] sparse-checkout: provide a new update subcommand
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
index c0342e53938..27f4392489f 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,6 +70,16 @@ C-style quoted strings.
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
+'update'::
+	Update the sparseness of paths in the working tree based on the
+	existing patterns.  Commands like merge or rebase can materialize
+	paths to do their work (e.g. in order to show you a conflict), and
+	other sparse-checkout commands might fail to sparsify an individual
+	file (e.g. because it has unstaged changes or conflicts).  In such
+	cases, it can make sense to run `git sparse-checkout update` later
+	after cleaning up affected paths (e.g. resolving conflicts, undoing
+	or committing changes, etc.).
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5d3ec2e6be9..2ae21011dfd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -18,7 +18,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
+	N_("git sparse-checkout (init|list|set|add|update|disable) <options>"),
 	NULL
 };
 
@@ -552,6 +552,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	return modify_pattern_list(argc, argv, m);
 }
 
+static int sparse_checkout_update(int argc, const char **argv)
+{
+	repo_read_index(the_repository);
+	return update_working_directory(NULL);
+}
+
 static int sparse_checkout_disable(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -601,6 +607,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_set(argc, argv, prefix, REPLACE);
 		if (!strcmp(argv[0], "add"))
 			return sparse_checkout_set(argc, argv, prefix, ADD);
+		if (!strcmp(argv[0], "update"))
+			return sparse_checkout_update(argc, argv);
 		if (!strcmp(argv[0], "disable"))
 			return sparse_checkout_disable(argc, argv);
 	}
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8FC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FFB206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL4gip38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUWFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfKUWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so5449810wmi.4
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kuc6H/vkYHxrEsGSG2uEwneropQ9h+GKXu7xTBk9qmg=;
        b=GL4gip38cSqYk55TaJ4fI6TuIFyQq4nlkYe/w43gBkqWGjUJPGaZFpqyPO2+liiP2k
         ELnwrsKJNKCOqqGTmgTWpxZ1CTyaVM5esaQQ1mQSdhVcC4A+y0zW5hlqRKXpClrZN3sa
         /mgTJJThNriFQkhZXLiCvQFrEmB9qqusHjmHrcEpcNNoyKH7fxlOFck4SrSvUyHupfVd
         YRqHvvSXcxZPhNy84V8Qwx438bNpoFd99uFwt3L3r72paUeDaScI10bHPJuD419ORwgV
         4mYe0IspMM+gPf9j5bryF6kkvpcgrAKYQqOt34vVY7bSzNpmp5HRUtiS+2Rd5b/rQ934
         qV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kuc6H/vkYHxrEsGSG2uEwneropQ9h+GKXu7xTBk9qmg=;
        b=O7Q7g+OiON88UvmTkLr6PzZU2ib4glXIow12UYqtyLMllI/uOoQCwPjLYeegRCCdlM
         38C4jIBMyGMP023Gc/95i0yOfm0TWrN3GQvyVSZgUl8pei0/Rn7IWRb44LJ1XUwp62XI
         Jj7p64gZSRznHluIP4F0Ckd5y3ruZZmwPaeMEh+ZqO8N4OdYdRek+ZcJQt9WHTiFmwPA
         uS1rVZcr9hhrt15mqZyWmcFfxbkCJl0t47xvIpmlhfeFO07osiB7bCX254fvhIgkYAWB
         1WOLZckmK66TdB5a1u42+rICbPEbF167Z6Q3oQ4uXSkND6CVE5QwBu+vJiNAv7fojj7T
         Y8gA==
X-Gm-Message-State: APjAAAXVyHxBUfrxwATj+vb+X+I0uOSJfrZXwXLU5EdSmVdnHGbfwnxU
        6JHObTGe+yILfnsw74eiuiIlGZS2
X-Google-Smtp-Source: APXvYqxMoiC8WTeQGTMo49NcQZMTuKHc7AoXlULyoM4hSaBf/hHk6sN4xHgPr0lbu0E4NF3Q77i59g==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr1026239wml.65.1574373916516;
        Thu, 21 Nov 2019 14:05:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm1158743wmd.33.2019.11.21.14.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:16 -0800 (PST)
Message-Id: <7577ffc034be90bd60da17e8f3189d999e7f8149.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:51 +0000
Subject: [PATCH v6 19/19] sparse-checkout: check for dirty status
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

The index-merge performed by 'git sparse-checkout' will erase any staged
changes, which can lead to data loss. Prevent these attempts by requiring
a clean 'git status' output.

Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 13 +++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 15 ++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5dbfb2a7e0..a542d617a5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -12,6 +12,7 @@
 #include "lockfile.h"
 #include "resolve-undo.h"
 #include "unpack-trees.h"
+#include "wt-status.h"
 
 static const char *empty_base = "";
 
@@ -256,6 +257,10 @@ static int sparse_checkout_init(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("initialize sparse-checkout"), NULL, 1, 0);
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
@@ -368,6 +373,10 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("set sparse-checkout patterns"), NULL, 1, 0);
+
 	memset(&pl, 0, sizeof(pl));
 
 	argc = parse_options(argc, argv, prefix,
@@ -427,6 +436,10 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("disable sparse-checkout"), NULL, 1, 0);
+
 	memset(&pl, 0, sizeof(pl));
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e61ddb4ad5..d5e2892526 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -250,10 +250,11 @@ test_expect_success 'cone mode: set with nested folders' '
 '
 
 test_expect_success 'revert to old sparse-checkout on bad update' '
+	test_when_finished git -C repo reset --hard &&
 	echo update >repo/deep/deeper2/a &&
 	cp repo/.git/info/sparse-checkout expect &&
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "cannot set sparse-checkout patterns" err &&
 	test_cmp repo/.git/info/sparse-checkout expect &&
 	ls repo/deep >dir &&
 	cat >expect <<-EOF &&
@@ -291,4 +292,16 @@ test_expect_success '.gitignore should not warn about cone mode' '
 	test_i18ngrep ! "disabling cone patterns" err
 '
 
+test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
+	git clone repo dirty &&
+	echo dirty >dirty/folder1/a &&
+	test_must_fail git -C dirty sparse-checkout init &&
+	test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
+	test_must_fail git -C dirty sparse-checkout disable &&
+	git -C dirty reset --hard &&
+	git -C dirty sparse-checkout init &&
+	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
+	git -C dirty sparse-checkout disable
+'
+
 test_done
-- 
gitgitgadget

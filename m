Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E4C2D0D0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049812073A
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaSptI32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLWSuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38105 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWSuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so16119021edr.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mI8fjeSdKsXqLIxIijlISP0IXKZR1ghClmld4gvxCyc=;
        b=MaSptI32BRN+ieHqEQw2+Cg9nfYy5i8A+a94+LNs64Nw/H6gDuoTO8c8q5D87VimDD
         e+sQly/Y6H1bctYXjU9Mm5pJlT1b8Eem4Gi8+mt551LtIZTYNodb0M2PrCki9JojbpZy
         I5GN+d3y4QnFXeps2Qwwd5vaP6CSayAeGnbqwaEq+f5dCZTzPOM1V92AyFALJgO4Zped
         zQbM5bxK38uHhWX5gSpVpaNvxrrF88SP3xJIvytMIyI8W9zQeaVTvR1Egojp6tl4nXha
         QHDz/fFbCzFO1zodYFXLNMd3n1KvQYXkSDORqAF/iR3A+fQ7CXLBpiyjArJS3XFlojyu
         ZOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mI8fjeSdKsXqLIxIijlISP0IXKZR1ghClmld4gvxCyc=;
        b=mbbM+a5O/s/Qu4jo4nSAjbiz1e+JWHHmRAfUPQp73iAA67POYP8/hZIvrbpCHY2cr8
         97+oAcWiU3DZ+F4m45xXwzDIRWFoeHXlqBhaOsHVg+kbViGdf2utksxWW5l7aMKknVX+
         POttbtUwmylasrjOJMIdgBLQRAX5F2cx0YO1sMfGkfBzwIE2FkH28Z9wqTZhvoc+dq3Z
         StxMB3SRYsLJ79oc2k4i9PrPT79b/7yX0ZQizWJpOhaO/cfVWJYYJZOyNjVN5KTsecAH
         3EQxMk/PygeDCaPXKFVEIxiU9A6l0TFYqM2IuPMjzVMVg9p3pVj+DynEKXE+XROPQrtH
         dJXg==
X-Gm-Message-State: APjAAAVhz2tcB0KiMNdG6K39sVUBGW1VPml7J7F1udwt86ltjkF76rT5
        ua2ckPNTkJJ5Q99eVPrXceyq536X
X-Google-Smtp-Source: APXvYqxruSLG8HxO5Ce+rujlXFHe+DSyEjBpOYOLFYjgN6ojWAOtmWoWsxlRBozMQXBNJKEIQ7tyBg==
X-Received: by 2002:a05:6402:22cf:: with SMTP id dm15mr34867667edb.233.1577127004885;
        Mon, 23 Dec 2019 10:50:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29sm2329186edb.47.2019.12.23.10.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:04 -0800 (PST)
Message-Id: <ee26f5a161c2e21ee9a1723bd2851f323f93cb05.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:49 +0000
Subject: [PATCH v2 05/15] rebase: fix handling of restrict_revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

restrict_revision in the original shell script was an excluded revision
range.  It is also treated that way by the am-backend.  In the
conversion from shell to C (see commit 6ab54d17be3f ("rebase -i:
implement the logic to initialize $revisions in C", 2018-08-28)), the
interactive-backend accidentally treated it as a positive revision
rather than a negated one.

This was missed as there were no tests in the testsuite that tested an
interactive rebase with fork-point behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  |  4 ++--
 t/t3400-rebase.sh | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5014c9a437..f1de5c8186 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -364,8 +364,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
-		argv_array_push(&make_script_args,
-				oid_to_hex(&opts->restrict_revision->object.oid));
+		argv_array_pushf(&make_script_args, "^%s",
+				 oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 79762b989a..71fd6396cd 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -165,11 +165,29 @@ test_expect_success 'rebase works with format.useAutoBase' '
 	git rebase master
 '
 
-test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--merge)' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual &&
+	git checkout default-base &&
+	git reset --hard HEAD^ &&
+	git checkout default &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+	git checkout -B default-base master &&
+	git checkout -B default topic &&
+	git config branch.default.remote . &&
+	git config branch.default.merge refs/heads/default-base &&
 	git rebase &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
-- 
gitgitgadget


Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71285C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5C207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV+b/If/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgAPGOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgAPGOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so17900559wrr.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tiRfU/x6Tk+xmQS9vI+5zMy7btglgQelEfjNUbEmnWE=;
        b=aV+b/If/fbdLfVoH+h3DjgRAYWok/Z6E3sy9o8UJouP4qfe+lr+mwuY3iYcyuLI3ZS
         /7XZB1gFpq9Au6+Is0JTKFIWJs28O6XZbTd3jrtShTw/TR4yGVcIOmysVA/yqzxUkJ7s
         yrGD6bGWR1nbbTWZMFvtz9E1Vfl5lSX7fo8yV9KA3w0UDXXZpGM6Ws8C4ONTP750ytg4
         6eoaLnMnZcby3TpKMVJwiPHufqREi2YkfongHFHe6VNciXwTDv4/nZxiGRQljBK579Xa
         RnETyLVvqw+id9+MOXHxkmKWIBxDaLRGZ05gT9W+xoSQsz/yve4mlLKwNjJl+mtAYDz6
         6ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tiRfU/x6Tk+xmQS9vI+5zMy7btglgQelEfjNUbEmnWE=;
        b=VhWTwFFesZC6V5KlmnHR4kESoiNPpTNWTcA5SYay8EnaRKJBLgwAXW7yaNbFalD8ew
         CDSg8PGBSGQyyKi5Enrko6XQwUjx+nU7I/wCikH3bSt8DQAH7hr6XGiZZZqQypZm4tZx
         MW4EqckMo6tYJbe1G0YBNN/y8+F2yWDt5F09pM14mEzr+r1ZzVsfY7kV3yWCfzFHh9E9
         3mkmc/EHxukfJH7UVX1fEOApnwVCelqTWmxBhh4zzSoUqN5L5DocnWWdv6csTwWXIxR7
         yl8nAVmX+a05CjMadLaUazeouyQeN2ULhZvJ/A7u0Qjlb0d6zjbhLkrNrFrLGr0FIC/a
         WmFw==
X-Gm-Message-State: APjAAAWaLrvBSj8Ywj5yOBzchCAA0t5z5WXXcZRfm81EmQbG/BZ11a1P
        sMtY/g3POIY82hR9M4RGB9NpRR7z
X-Google-Smtp-Source: APXvYqzWSSEhM31FvgoAfKbw10fc1KKwLY/7FQu+u/KQWa3cxkhXGAM4UAwJJ7DEC5yMZSnRkxI7Fg==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr1328395wre.156.1579155281552;
        Wed, 15 Jan 2020 22:14:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm3196734wmb.9.2020.01.15.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:41 -0800 (PST)
Message-Id: <0acefa988b14ca24966b31a4a7c0bb7bb31f10ba.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:22 +0000
Subject: [PATCH v4 08/19] rebase: fix handling of restrict_revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
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
index e8d518ac8d..fe1175af32 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -348,8 +348,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
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


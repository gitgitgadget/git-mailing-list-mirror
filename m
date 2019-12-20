Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE84C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66F221D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBlgkbnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLTRJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42333 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfLTRJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so8935142edv.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8CBJvG4wzRLjfBCPon2U1WRggvX4ia5WDIt+aDz58W8=;
        b=IBlgkbnWv2Xj88MPi1Vp5K2N2uxHpft7EMQs8wXJF/sgXriRdbXNZvKC4QK1Z4FlHv
         DZeBGZbK+6gPusPQwrFPhd2dKEaSF6cfsJ5S6PwzG+z4giYTIBr/JB9fra8zIw8WAmM2
         0LB/WkNXWwzoQyZ5zqAQ+jcKWnaxJEKj+rUoceqp5OUiNosdM4bsy3YvHkoItQB5vAOx
         CPakAUujGSjfsBCMpmeZBYofG4IsSF8SAyVziSrXNkSUCmKKiMoWo8kiusXbSRwUocgG
         h1AL9JP5TPYZJkfOz0p9n64/W1g0G7PxePUh705rhXVOnjhU6us2/jQDoCJ7gqyBJmZ9
         Tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8CBJvG4wzRLjfBCPon2U1WRggvX4ia5WDIt+aDz58W8=;
        b=fkK9RTxxl5K9G1LDZhx8Yv1hMWgTKCbKL8M7qKPbyaa3sDE6Ts4bDpPnid2qtyoMNm
         LK9TlL4vZFr7Da214aUL2Ni/vv/1/aymX2oU92/F2ecMMJ0tSWUtXBJkzeIkoag9Zhjb
         bByXfBoxWkwsxvn5IoSm7CRqXCbil5J8BcLc4GDJH+vjtUqNzMCtysneJH9HMGagqvs3
         pIjzPS9lT3DscAP/1crMMDF2StLOre1q40vVq6PwHuz6SqeV72/VivmzHA8Sm+kZ1cqS
         z94xPvL1Lk9RElnCXWxF+D867F4kCrYggd5Ct/ynPlVU3IzCZlb/54Rc2PqIofDZqbve
         WY0g==
X-Gm-Message-State: APjAAAXcF0s1pepo12MjkiexMubaPV1hGCGb2OhKGcG6vbh4zpS3iITm
        dHjmRYRI36UR2FlCDEqQ7qoUtoRO
X-Google-Smtp-Source: APXvYqxzhaJhrm5lR07XgBRqWGZdrHkfyLwll7TkZwU0g4ke4nUY/alGFrTnifdxDpFrF9CXBmjUvg==
X-Received: by 2002:aa7:d343:: with SMTP id m3mr17154480edr.285.1576861793976;
        Fri, 20 Dec 2019 09:09:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm1020978edw.73.2019.12.20.09.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:53 -0800 (PST)
Message-Id: <b84faa86846cba6fb3f4bfa1d4f216fbce3867eb.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:38 +0000
Subject: [PATCH 05/15] rebase: fix handling of restrict_revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
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
index cc8f3f008f..b320bb3a30 100644
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0AD1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbdBPPOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:14:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34084 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbdBPPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:14:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so2233104pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBcldLJmSJ7TxlDUlScZLMZC1sJzl/bgTVuBP7dDJY0=;
        b=sJMAH7hSMRT8XKwh0a9vS0qBDyGT94Nl6ydqvC1tAU3wvNdMF1u7QCZMCcB3kyPuut
         ol58OOehpTQINAveAlxITbpCXpUn4xh8hXQQd1ziD+e/KftC7n6Bqe/KJbWcXWqA158K
         POo6cIhYGn0erxP7Q+qqXDGDm6SUNDpDDCnoGj9bsQcUyzICIH7xE7o6f0UgZZmuJ6Ou
         q6XEFSUsb0TONECCLaO5JqQ6pPJtYWeyeDHVuPfm+mUQx8rBaKD8SKTfL5W1JNdBd17i
         lpYJLC3KoeT98vUzrRu1JjgewYiTOSgyCksbI23JKXOHFzt6rm5icu1Kq9ASKZXHFq0+
         pzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBcldLJmSJ7TxlDUlScZLMZC1sJzl/bgTVuBP7dDJY0=;
        b=qGyyCFyzC28g/T0Wmh8+rhrkWg0aQj2E7cDpo9vNyDRBbj791frdap5xeoYeT4YFIu
         +SVHyObnhq5k410ss0/8CBwSY6kpNfzeCt8Zkbu9ImlPO1l8/yGQK5aXsJM7Db836taq
         QYTwfGxthyyS1pPprlOLQ6fpjV4Q5dI2+kQK0wdqI2ntBneDxbrvMBuD9XI2Uu5sTzUs
         VTSOUDQhk3+MvNuW97d8U2FA1XWQbtN/C/nbqVx3RLENtzj56ZFc4+kRn2QS4arcCqvr
         sbzg09v/xnPD/XPWhQ39hpdF5Pg++uP/RROqKtT0C21BzpYuPSCjJP/kf5XhkdBOwkbj
         Dz1Q==
X-Gm-Message-State: AMke39nKtwiejeHH0WJn6psyCUJZ1scYAl14dajieCUiPHZ1+fZjAzzNkgXbuiEyXfjtlA==
X-Received: by 10.98.157.83 with SMTP id i80mr3149782pfd.177.1487258088222;
        Thu, 16 Feb 2017 07:14:48 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id k78sm14315866pfb.93.2017.02.16.07.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:14:47 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 4/4 v4] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
Date:   Thu, 16 Feb 2017 15:14:14 +0000
Message-Id: <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces "-" as a method to refer to a revision, and adds tests to
test that git-log works with this shorthand.

This change will touch the following commands (through
revision.c:setup_revisions):

* builtin/blame.c
* builtin/diff.c
* builtin/diff-files.c
* builtin/diff-index.c
* builtin/diff-tree.c
* builtin/log.c
* builtin/rev-list.c
* builtin/shortlog.c
* builtin/fast-export.c
* builtin/fmt-merge-msg.c
builtin/add.c
builtin/checkout.c
builtin/commit.c
builtin/merge.c
builtin/pack-objects.c
builtin/revert.c

* marked commands are information-only.

As most commands in this list are not of the rm-variety, (i.e a command that
would delete something), this change does not make it easier for people to
delete. (eg: "git branch -d -" is *not* enabled by this patch)

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---

Instead of replacing the whole string, we would expand it accordingly using:

if (*name == '-') {
  if (len == 1) {
    name = "@{-1}";
    len = 5;
  } else {
    struct strbuf changed_argument = STRBUF_INIT;

    strbuf_addstr(&changed_argument, "@{-1}");
    strbuf_addstr(&changed_argument, name + 1);

    strbuf_setlen(&changed_argument, strlen(name) + 4);

    name = strbuf_detach(&changed_argument, NULL);
  }
}

Junio's comments on a previous version of the patch which used this same
approach but inside setup_revisions [1]

[1]: <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>

 sha1_name.c              |   5 +++
 t/t4214-log-shorthand.sh | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 t/t4214-log-shorthand.sh

diff --git a/sha1_name.c b/sha1_name.c
index 73a915f..2f86bc9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -947,6 +947,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
+	if (*name == '-' && len == 1) {
+		name = "@{-1}";
+		len = 5;
+	}
+
 	ret = get_sha1_basic(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
diff --git a/t/t4214-log-shorthand.sh b/t/t4214-log-shorthand.sh
new file mode 100755
index 0000000..659b100
--- /dev/null
+++ b/t/t4214-log-shorthand.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='log can show previous branch using shorthand - for @{-1}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	test_commit second &&
+	test_commit third &&
+	test_commit fourth &&
+	test_commit fifth &&
+	test_commit sixth &&
+	test_commit seventh
+'
+
+test_expect_success '"log -" should not work initially' '
+	test_must_fail git log -
+'
+
+test_expect_success 'setup branches for testing' '
+	git checkout -b testing-1 master^ &&
+	git checkout -b testing-2 master~2 &&
+	git checkout master
+'
+
+test_expect_success '"log -" should work' '
+	git log testing-2 >expect &&
+	git log - >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symmetric revision range should work when one end is left empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log ...@{-1} >expect.first_empty &&
+	git log @{-1}... >expect.last_empty &&
+	git log ...- >actual.first_empty &&
+	git log -... >actual.last_empty &&
+	test_cmp expect.first_empty actual.first_empty &&
+	test_cmp expect.last_empty actual.last_empty
+'
+
+test_expect_success 'asymmetric revision range should work when one end is left empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log ..@{-1} >expect.first_empty &&
+	git log @{-1}.. >expect.last_empty &&
+	git log ..- >actual.first_empty &&
+	git log -.. >actual.last_empty &&
+	test_cmp expect.first_empty actual.first_empty &&
+	test_cmp expect.last_empty actual.last_empty
+'
+
+test_expect_success 'symmetric revision range should work when both ends are given' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log -...testing-1 >expect &&
+	git log testing-2...testing-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'asymmetric revision range should work when both ends are given' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log -..testing-1 >expect &&
+	git log testing-2..testing-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple separate arguments should be handled properly' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log - - >expect.1 &&
+	git log @{-1} @{-1} >actual.1 &&
+	git log - HEAD >expect.2 &&
+	git log @{-1} HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'revision ranges with same start and end should be empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	test 0 -eq $(git log -...- | wc -l) &&
+	test 0 -eq $(git log -..- | wc -l)
+'
+
+test_expect_success 'suffixes to - should work' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log -~ >expect.1 &&
+	git log @{-1}~ >actual.1 &&
+	git log -~2 >expect.2 &&
+	git log @{-1}~2 >actual.2 &&
+	git log -^ >expect.3 &&
+	git log @{-1}^ >actual.3 &&
+	git log -@{yesterday} >expect.4 &&
+	git log @{-1}@{yesterday} >actual.4 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2 &&
+	test_cmp expect.3 actual.3 &&
+	test_cmp expect.4 actual.4
+'
+
+test_done
-- 
2.1.4


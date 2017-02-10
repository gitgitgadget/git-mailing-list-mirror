Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAAD1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbdBJS4y (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:56:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36716 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdBJS4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:56:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so3021502pfo.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZHaNV7aFt+Y2eUDEyofIYXqzcKi+CF+JtAg7aoqD1U=;
        b=qggSxdciEDIWm61H4i5RGRrPwd+YfEKi4M8rIsBmwRe6Z8AwGW/F+1ufxT/F0BQnuD
         c/Pf55TqDv8z5NGNFeboBDtT6VrfG0HzUgqhxEfxU5YS1ZQGud9DP4YkwO1ILfw9o5wa
         3T04f3o/fl36oyulFWFRfEcUA6wS+oNnfHMeQgl7DiGeBsIxJwLq31IYXxu0cpMeBOre
         OY38B1R0hZ1NZ8E7NhPAKW7mdNC/0h3GhlcoaPzF/oK//8SPFqXSOZiFnbH9lReXUEbj
         h7IlpgTc5AnbrRiA4qVs573+FYUjERTLi4pY+nfw9p2958djCM3m4YqYNkD2zmlA1Iaq
         +teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZHaNV7aFt+Y2eUDEyofIYXqzcKi+CF+JtAg7aoqD1U=;
        b=OlRCiw+pVzkoCyc3Juthq09S/QbXXJ48hw50YnrmL2qKiH2rtCNtFU6juGR/AlpG9X
         y7kMbSUWHyDkRLMWkRqRs6Hn7daLKR0dtfC4pqxnTxFzlsOrnaBuR5ZnGIYl00Wi4xUB
         bORJpsFALT0tfPvDl7Gt9EFgz0VBN7b/t+01HbNuZRV9bfgrLlJG0gUcTpS8y2QvnGRN
         r4LElij1sdCj2tmM9o3TpWHkyo2XgWR2AOWU++l0GaouW/m/J7VxF7boPT3UlpusbmU0
         6d8bUbi5cXdxQN1e/jiOnVzHv1z9lDkmQb7YkBrOpclcWKEbAHDUu37gqIpdhmyJ/vl+
         XZPQ==
X-Gm-Message-State: AMke39lo9Wsg2KqioMZVKW9ChuZJ2weK7MXwUMUdIv6gBwRYpMLuanMdgVltPHDxQFItyg==
X-Received: by 10.99.174.4 with SMTP id q4mr12582905pgf.186.1486752980935;
        Fri, 10 Feb 2017 10:56:20 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id m12sm7074444pgc.46.2017.02.10.10.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 10:56:20 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 2/2 v3] sha1_name: teach get_sha1_1 "-" shorthand for "@{-1}"
Date:   Fri, 10 Feb 2017 18:55:26 +0000
Message-Id: <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
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
 sha1_name.c              |  5 ++++
 t/t4214-log-shorthand.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 t/t4214-log-shorthand.sh

diff --git a/sha1_name.c b/sha1_name.c
index 73a915f..d774e46 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -947,6 +947,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
+	if (!strcmp(name, "-")) {
+		name = "@{-1}";
+		len = 5;
+	}
+
 	ret = get_sha1_basic(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
diff --git a/t/t4214-log-shorthand.sh b/t/t4214-log-shorthand.sh
new file mode 100755
index 0000000..dec966c
--- /dev/null
+++ b/t/t4214-log-shorthand.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='log can show previous branch using shorthand - for @{-1}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	echo "hello second time" >>world &&
+	git add world &&
+	git commit -m second &&
+	echo "hello other file" >>planet &&
+	git add planet &&
+	git commit -m third &&
+	echo "hello yet another file" >>city &&
+	git add city &&
+	git commit -m fourth
+'
+
+test_expect_success '"log -" should not work initially' '
+	test_must_fail git log -
+'
+
+test_expect_success '"log -" should work' '
+	git checkout -b testing-1 master^ &&
+	git checkout -b testing-2 master~2 &&
+	git checkout master &&
+
+	git log testing-2 >expect &&
+	git log - >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symmetric revision range should work when one end is left empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log ...@{-1} > expect.first_empty &&
+	git log @{-1}... > expect.last_empty &&
+	git log ...- > actual.first_empty &&
+	git log -... > actual.last_empty &&
+	test_cmp expect.first_empty actual.first_empty &&
+	test_cmp expect.last_empty actual.last_empty
+'
+
+test_expect_success 'asymmetric revision range should work when one end is left empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log ..@{-1} > expect.first_empty &&
+	git log @{-1}.. > expect.last_empty &&
+	git log ..- > actual.first_empty &&
+	git log -.. > actual.last_empty &&
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
+test_done
-- 
2.1.4


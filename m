Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46BA2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdBYHZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:25:23 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35420 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdBYHZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:25:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id o78so376914pfj.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=88bHxAQBrENy0qDkuxrfvV3EGPyd6GOGbf0GmuyegWo=;
        b=LreJrlnpOqKz1Lx3NozKQeSio3KoZxMBTcLMIooPrIvXCQLoEb81npVzGETIYxjc4D
         mj5Knm37TJftuAzIYTfiEslWZ26dtZv7c7YMGEexo2OdssuygY76HVMgZ/56v7wzEdSe
         hZtHm3OAc925Z3+9xfx9ONYPsgxIJbOiIA0WfbqLJ4HAdI2o6CnjvuPvW7SOD0zzBfbd
         LWD0j/X9X/kdSH9jRGVDSyqxaxAdv2tONfDXrM77mNtXgDUUjKhbJSlKbGwW4pf9bBME
         G6oun42I/49TNtZhq9V55hJp7uLZuOg6irC/VbbVHVnz8UdSlRKTq8G49yJCeyEeEb2J
         zy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=88bHxAQBrENy0qDkuxrfvV3EGPyd6GOGbf0GmuyegWo=;
        b=eDAEs0Ig4uMKmwFyaLZtt5cgf4DoS8AkrFfrE/6Ycmzg0IySrI2dNWnScuJ5OVi3zz
         Akgu3SoZs7LjTF7kmTr2SrVk14JN5zBVNAQ+q4UAzgsIYq/F8S4H/QXoATxrbhqzcDYE
         lJSfdUusDsF+eNKA5ClpUsoe2ic2UbxI8bmgF5YJmjyaW5/ONxpGPCuTvoWuNdHCzP0N
         eB910Xw3IEhnYiTeuwCZoIbPozZqTUqGTW4dokz8oSa4t+RZFEWkfUQ2bitjXoNYnRN6
         U84q19ffoSEbBxDKv5k+9XiaZAIBSlMpocly6of8BXPmGXJBSAqMIMcBYDi6mPH3kmKI
         Pc/w==
X-Gm-Message-State: AMke39koBQ98Lo9hvlmvajxh4SI55QG8IDZ1qz1FlqQM/YhQhUweK9sn9IuvIBYwrWs11A==
X-Received: by 10.98.97.68 with SMTP id v65mr8425477pfb.124.1488007516702;
        Fri, 24 Feb 2017 23:25:16 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id r71sm11914836pfa.104.2017.02.24.23.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:16 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 4/6 v5] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
Date:   Sat, 25 Feb 2017 07:24:45 +0000
Message-Id: <1488007487-12965-5-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
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

Suffixes like "-@{yesterday}" and "-@{2.days.ago}" are not enabled by this
patch. This is something that needs to be fixed later by making changes deeper
down the callchain.

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
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
index 0000000..8be2de1
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
+	# git log -@{yesterday} >expect.4 &&
+	# git log @{-1}@{yesterday} >actual.4 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2 &&
+	test_cmp expect.3 actual.3
+	# test_cmp expect.4 actual.4
+'
+
+test_done
-- 
2.1.4


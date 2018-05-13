Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DD11F51A
	for <e@80x24.org>; Sun, 13 May 2018 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEMRy7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 13:54:59 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32914 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeEMRy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 13:54:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id h9-v6so13695462lfi.0
        for <git@vger.kernel.org>; Sun, 13 May 2018 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o61/R/xmhKJpKdwZ0d3glEnG6lFR0xpc4OsW3Po0lbQ=;
        b=hbsqgg43dE/ZU0kl37gSSrddW7Jw/Am/mstDoMN2Jm1yPMmqL6/GOYN/hpe1kQbqRT
         o6jWrR0ZRMgt8D+nLEQyXS/beyKUbpoj4OkUncAQcNdc6b6Eo7mz/yHGJbKZRi5JTCY7
         o56UBCb/csS4cjXo8rZz5lMFnbkBmXFS3IForUrBOtkT0o+E9SvkSCHX88pFd4plu8b8
         dgzoqsA0w8rbtc/MhdBZHxjqGmWvATEudjZ0PafRaPBk3X+8UajejKvpJ4VTVvUaE14W
         E5zUEf1eOipFSUcq4xvI8tKUgNjjZDhfZgdsdB2Uo2vtB2MjaFFW4vvJqsZa/J6aEIzA
         LwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o61/R/xmhKJpKdwZ0d3glEnG6lFR0xpc4OsW3Po0lbQ=;
        b=DaV1fI/+sKEG7R8Kou6wgHpI8U/RmERzaDm67c4oAXYqAhkWEByp0/fbRAob2x5vym
         fLSomurPXgq7422DvHBmEhKAjSF1EWcr6enLdCKp9ZJf5MxtgDMUPkFLO6f/qN1ijHbI
         wqSUaRdTMfT3NfmsRO1L5ZY8r3Z7GUzwOlS15MlhnuI3cvYUS6ik5hdG589sLobIlcrz
         phrlyjiztMzzel7Wqybe5FZvsdCvgkweRLDMGE+e3fXDsVpdWNGlDPeq8YhAqtYsOMLQ
         cUjSrIX28WlWCQx7digTC56WnFebeJiZxp1U939ie3MzmV/jCyA53RGTU8pjNLQvliKP
         QSwQ==
X-Gm-Message-State: ALKqPweX9vjsGAyZMdcVWDT7EyVyxLKxv/ZMMo0e0qgUH3Pc9IhoWezs
        tY+vJPlR/lnx2bOdRwyOXs7oRQ==
X-Google-Smtp-Source: AB8JxZq3B2big7oYgI9kewMvpiIZVNo4AKh8G97ggJzxCG97/xn9ZAaJbSUfPDP/PmfiJl25e/bKrg==
X-Received: by 2002:a2e:8858:: with SMTP id z24-v6mr3049863ljj.106.1526234096265;
        Sun, 13 May 2018 10:54:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b79-v6sm1887970lfe.28.2018.05.13.10.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 10:54:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] diff: turn --ita-invisible-in-index on by default
Date:   Sun, 13 May 2018 19:54:37 +0200
Message-Id: <20180513175438.32152-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the implementation detail of intent-to-add entries. The current
"git diff" (i.e. no treeish or --cached argument) would show the
changes in the i-t-a file, but it does not mark the file as new, while
"diff --cached" would mark the file as new while showing its content
as empty.

One evidence of the current output being wrong is that, the output
from "git diff" (with ita entries) cannot be applied because it
assumes empty files exist before applying.

Turning on --ita-invisible-in-index [1] [2] would fix this.

This option is on by default in git-status [1] but we need more fixup
in rename detection code [3]. Luckily we don't need to do anything
else for the rename detection code in diff.c (wt-status.c uses a
customized one).

[1] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
    in index" - 2016-10-24)
[2] b42b451919 (diff: add --ita-[in]visible-in-index - 2016-10-24)
[3] bc3dca07f4 (Merge branch 'nd/ita-wt-renames-in-status' - 2018-01-23)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/diff.c          |  7 +++++++
 t/t2203-add-intent.sh   | 37 ++++++++++++++++++++++++++++++-------
 t/t4011-diff-symlink.sh | 10 ++++++----
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f73..00424c296d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -352,6 +352,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
 
+	/*
+	 * Default to intent-to-add entries invisible in the
+	 * index. This makes them show up as new files in diff-files
+	 * and not at all in diff-cached.
+	 */
+	rev.diffopt.ita_invisible_in_index = 1;
+
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 78236dc7d8..31bf50082f 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -69,9 +69,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
-	test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only --ita-invisible-in-index -- nitfol | wc -l) = 1
+	test $(git diff --name-only --ita-visible-in-index HEAD -- nitfol | wc -l) = 1 &&
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
@@ -99,13 +99,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 
 	: >dir/bar &&
 	git add -N dir/bar &&
-	git diff --cached --name-only >actual &&
+	git diff --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual &&
 
 	git write-tree >/dev/null &&
 
-	git diff --cached --name-only >actual &&
+	git diff --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual
 '
@@ -186,7 +186,19 @@ test_expect_success 'rename detection finds the right names' '
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
-		test_cmp expected.3 actual.3
+		test_cmp expected.3 actual.3 &&
+
+		git diff --stat >actual.4 &&
+		cat >expected.4 <<-EOF &&
+		 first => third | 0
+		 1 file changed, 0 insertions(+), 0 deletions(-)
+		EOF
+		test_cmp expected.4 actual.4 &&
+
+		git diff --cached --stat >actual.5 &&
+		: >expected.5 &&
+		test_cmp expected.5 actual.5
+
 	)
 '
 
@@ -222,5 +234,16 @@ test_expect_success 'double rename detection in status' '
 	)
 '
 
-test_done
+test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
+	git reset --hard &&
+	echo new >new-ita &&
+	git add -N new-ita &&
+	git diff --summary >actual &&
+	echo " create mode 100644 new-ita" >expected &&
+	test_cmp expected actual &&
+	git diff --cached --summary >actual2 &&
+	: >expected2 &&
+	test_cmp expected2 actual2
+'
 
+test_done
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index cf0f3a1ee7..108c012a3a 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	index e69de29..d95f3ad 100644
-	Binary files a/file.bin and b/file.bin differ
+	new file mode 100644
+	index 0000000..d95f3ad
+	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	index e69de29..dce41ec 120000
-	--- a/link.bin
+	new file mode 120000
+	index 0000000..dce41ec
+	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
-- 
2.17.0.705.g3525833791


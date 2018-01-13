Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E28B1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754906AbeAMMK4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 07:10:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33983 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754851AbeAMMKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 07:10:54 -0500
Received: by mail-pg0-f67.google.com with SMTP id r19so310211pgn.1
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 04:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFQxClBBG7p4RXCd6cw7nGe+syCFFhpp0CgOMASSTyI=;
        b=qMkdwYFFpMbYDg9el4kfts+uJCc3cd1dbJd9MzETUoFNYcoV+gqZmccdsc4mztSNtu
         iejq+kqzMq1ahJTmUqK40QtM054JLumqNZ1qfv+V4AMy8PdzyQuvVQQIZSPtVZ2e913y
         dtzA1BPvV81dKI/MpCC3ydxAAOd5Bp4X4I+wIZ3+2lapzigKOPajh7GT4qPhNLnCPaiA
         gxh6xAyFe3M2P9nqCDsJ990vim6yF7kp5XVdxB4MISfjBG6hBXDRXi1+jxfdg1ahyNnV
         NGDbGI2mD6T+liIkVBSIbV0L0bYqbuSSSPywZ1XnzTY84TFCmsszZC1hq1ZhvgVI7xWh
         41eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFQxClBBG7p4RXCd6cw7nGe+syCFFhpp0CgOMASSTyI=;
        b=AVcwoQvps0kjXyutERgxGmwcHsDQt4cjZ3r6CYMJBW4QvOdUS7q2xVIWwXAN5sFp/o
         SEwEiC05WRQNKD5QrDj/7MpMc7ay3Ut7vAi+PV2c8lCtkQPeTa9grxg+HRP/uOLWlcmF
         LvPvlwGG/nvsApdIsGq0HFrGae8XE8Q+iRaM9HG8HxbLL47uO/nhFcN0qPbptyyx528x
         veHAT9rkb90Fe9L3MwTVtTLs6HWS/HrlCNcrKasoTxJGza22rUje4QLZ0FcmjotRucDQ
         V9wcToKC0Nxx8OZxN7OaaUDfFFRAvqlwpjNVEQ0t0nsmrGjrntNQak5weuSyNXpHz9tU
         SHxA==
X-Gm-Message-State: AKGB3mJABGf3x/t6fw1Z57VvsxGCm5TTi8qE6YkMbQhsq3Ru5/ZQXhkd
        J+SfkWb8q2aQ3ek+kSgN2XFGAA==
X-Google-Smtp-Source: ACJfBoumvZNSloB5T+UAlnI4+FGnEXKZuz1mfpONiOlS81TlL/+T4E7N0kSGwSOFrp1SwLsqkfMdZw==
X-Received: by 10.101.68.138 with SMTP id l10mr23158249pgq.166.1515845454069;
        Sat, 13 Jan 2018 04:10:54 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id v88sm56422880pfk.31.2018.01.13.04.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jan 2018 04:10:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 19:10:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] add--interactive: ignore submodule changes except HEAD
Date:   Sat, 13 Jan 2018 19:10:38 +0700
Message-Id: <20180113121038.26984-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180110110643.21465-1-pclouds@gmail.com>
References: <20180110110643.21465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For 'add -i' and 'add -p', the only action we can take on a dirty
submodule entry is update the index with a new value from its HEAD. The
content changes inside (from its own index, untracked files...) do not
matter, at least until 'git add -i' learns about launching a new
interactive add session inside a submodule.

Ignore all other submodules changes except HEAD. This reduces the number
of entries the user has to check through in 'git add -i', and the number
of 'no' they have to answer to 'git add -p' when dirty submodules are
present.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 now has some tests. The commit message is rephrased a bit.

 git-add--interactive.perl  |  2 +-
 t/t3701-add-interactive.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28b325d754..964c3a7542 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -262,7 +262,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @ARGV)) {
+	for (run_cmd_pipe(qw(git diff-files --ignore-submodules=dirty --numstat --summary --raw --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index a49c12c79b..058698df6a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -493,4 +493,52 @@ test_expect_success 'add -p works even with color.ui=always' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup different kinds of dirty submodules' '
+	test_create_repo for-submodules &&
+	(
+		cd for-submodules &&
+		test_commit initial &&
+		test_create_repo dirty-head &&
+		(
+			cd dirty-head &&
+			test_commit initial
+		) &&
+		cp -R dirty-head dirty-otherwise &&
+		cp -R dirty-head dirty-both-ways &&
+		git add dirty-head &&
+		git add dirty-otherwise dirty-both-ways &&
+		git commit -m initial &&
+
+		cd dirty-head &&
+		test_commit updated &&
+		cd ../dirty-both-ways &&
+		test_commit updated &&
+		echo dirty >>initial &&
+		: >untracked &&
+		cd ../dirty-otherwise &&
+		echo dirty >>initial &&
+		: >untracked
+	) &&
+	git -C for-submodules diff-files --name-only >actual &&
+	cat >expected <<-\EOF &&
+	dirty-both-ways
+	dirty-head
+	dirty-otherwise
+	EOF
+	test_cmp expected actual &&
+	git -C for-submodules diff-files --name-only --ignore-submodules=dirty >actual &&
+	cat >expected <<-\EOF &&
+	dirty-both-ways
+	dirty-head
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'status ignores dirty submodules (except HEAD)' '
+	git -C for-submodules add -i </dev/null >output &&
+	grep dirty-head output &&
+	grep dirty-both-ways output &&
+	! grep dirty-otherwise output
+'
+
 test_done
-- 
2.15.1.600.g899a5f85c6


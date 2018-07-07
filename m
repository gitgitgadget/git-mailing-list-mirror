Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AE71F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeGGUoQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 16:44:16 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35154 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeGGUoO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 16:44:14 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so5846548ybm.2
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C797ksKMsWH0K1ItIy7acOIE5bJbQA6m74d6li8kfqY=;
        b=LrVQkA04oXnF0v/7w5StCpFL2yKyi9EqsXUAXYSsxtsmMoxIrveALsdZ42+YP4PrEz
         O+G4ruVjAz/86XULx/ByGg0cQBQ4m+eKKkZheAz2ati+b/xrFETIhukdsg2iXznsXFI4
         wMrWZbineTzbCc8jyMhRYA0g2r3tYz+8QxEKHIEdTSxQo9CouZ3+sJKTR8CXyMvr51ei
         wGmgjS/csOt76zb5mmIHyB4OU8YR67g4gFHwahTlSF9SURYtvStTwToCS76d2k7QXuri
         4KR90zmnH9rmB8B0ebkmBEVM1M+IjdaSTtqR+mZiyxK+egjw2PTUOUi1+VAnW878VNaV
         VPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C797ksKMsWH0K1ItIy7acOIE5bJbQA6m74d6li8kfqY=;
        b=qMhinAdu7h91A8BHkKKynf0Aq4eAej4tCo8WmSvZxrb6T5skr3VZpq5Sblgm/nSDGk
         /BGFPhF3X/AelpTGioTXYuxEgDUc7wpFAfheHJ/twejpRJeTT4/u9MViS6KDJYg20DsY
         oeEX676ZsfIXk8rP1xyykym1XsP1fHcbdBffoI5JVTBJZwfVRXAe3mIiIYORgTTZqryM
         GEmo70YlihVwC91LpQu2+XihgYFxsZ4BJpddG1JfcmejVj8eiWeMrKLFZV8UIEiX0y1O
         jAFLmi2DztZR9YW0BYxbv6Xp6VByqe08mLNmX3X+UonsHml/aTdbF8iYqkn/ght1AOez
         ajvQ==
X-Gm-Message-State: APt69E3Gib0ROY6tWoCUhlNjMr54eMIvFWD1IxtFMN543m79asyHa4MN
        dJTFf910gqLcAVBMa+sJ5fCiag==
X-Google-Smtp-Source: AAOMgpeu7rXvA6kRyOFvIckbNipIPuQ8Szk2EtXuE8cVxA3ZfEKI00IQ9NFJYcbqgSgc6o2bzVnxJw==
X-Received: by 2002:a25:8e10:: with SMTP id p16-v6mr7737945ybl.121.1530996253537;
        Sat, 07 Jul 2018 13:44:13 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4535058ywd.21.2018.07.07.13.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 13:44:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t7405: add a file/submodule conflict
Date:   Sat,  7 Jul 2018 13:44:02 -0700
Message-Id: <20180707204404.7208-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.134.gafc206209.dirty
In-Reply-To: <20180707204404.7208-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of a file/submodule conflict, although both cannot exist at
the same path, we expect both to be present somewhere for the user to be
able to resolve the conflict with.  Add a testcase for this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 7bfb2f498..95fd05d83 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -279,4 +279,60 @@ test_expect_success 'recursive merge with submodule' '
 	 grep "$(cat expect3)" actual > /dev/null)
 '
 
+# File/submodule conflict
+#   Commit O: <empty>
+#   Commit A: path (submodule)
+#   Commit B: path
+#   Expected: path/ is submodule and file contents for B's path are somewhere
+
+test_expect_success 'setup file/submodule conflict' '
+	test_create_repo file-submodule &&
+	(
+		cd file-submodule &&
+
+		git commit --allow-empty -m O &&
+
+		git branch A &&
+		git branch B &&
+
+		git checkout B &&
+		echo contents >path &&
+		git add path &&
+		git commit -m B &&
+
+		git checkout A &&
+		test_create_repo path &&
+		(
+			cd path &&
+
+			echo hello >world &&
+			git add world &&
+			git commit -m "submodule"
+		) &&
+		git add path &&
+		git commit -m A
+	)
+'
+
+test_expect_failure 'file/submodule conflict' '
+	test_when_finished "git -C file-submodule reset --hard" &&
+	(
+		cd file-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B^0 >out 2>err &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+
+		# path/ is still a submodule
+		test_path_is_dir path/.git &&
+
+		echo Checking if contents from B:path showed up anywhere &&
+		grep -q content * 2>/dev/null
+	)
+'
+
 test_done
-- 
2.18.0.134.gafc206209.dirty


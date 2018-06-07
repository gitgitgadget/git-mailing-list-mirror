Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C57F1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFGFFD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:05:03 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41499 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeFGFFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:05:02 -0400
Received: by mail-oi0-f65.google.com with SMTP id a141-v6so7413312oii.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IoICaFLaINWHFfu78ThIwHB6uv8YDDbTjt+HqeUHnXM=;
        b=TNA6wYQM5V+lMhH9u5UvwqpWseTnxuQieRJTiyG5+lUy9390lkqPRAMxmdokCXrdvp
         ijZD6Vq9GLdbvlYrwKtWdOoFBFtujgcuzwxCVU1ZTBjGK6YDViO4DySZA5qjSoK0AqBX
         bEwvzBHRI/cmo/5S3YN3E20ZVk/20eYxfr/cWdN1MZ4yolzEfkJNWW/zar0eLvXro1x8
         5AAp00tX8DGwbNcSeqm/+F/cXbnXzJfo/Hk0IsAF0jRe5OMCLYq5WvJXKW+q8ac9DEHv
         oxZFbrfe6f1tfOmSroumJQYQfqBjSoLs6qWcpzBmgZowLP9T6jQB0Lk9bWZIuK++IDOt
         tO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IoICaFLaINWHFfu78ThIwHB6uv8YDDbTjt+HqeUHnXM=;
        b=IF9Py4Sv0mLd1bjWv6gQiC0vw30yu7ggnGl53RtVn85PMEfQqlE+p8NCSsutzqDIn9
         +2jprLa2VJyODiWFSt+0LFmphT4mNMDJQuN2Ts/ZJs64DA4bW8XZ2y0DHlpGcNn45sEp
         xTyFdVNbJsOetg6sWdZdZ/LgB8RBkjKmons7szJOn5mrWzYND4Dl6gEAdr+lpZ8nwgZI
         1JiPnaO4dw44vKvdTIZ9jY7eGeVp1mH52aUxTnajgojyshlbIqNuvO+aXSzTfaqLtpdH
         VA+CSC7mcdv7Dlccu5MsMjrnTWL4ceFVpNORbZRVASrYsI5O0buOP19UwS/kxr3B/GhK
         uy+Q==
X-Gm-Message-State: APt69E16SPBoS3vX0l8Vq1tNV4P9NbTRG7g3y2apPDkq7FmXGeM2DykX
        Kw21N67joQ9T2YhnO1AR9U0P4w==
X-Google-Smtp-Source: ADUXVKIUfvRz1utZo/e8aefJTC1XBl9QUca8PhCWXgAEbb9cA/7WGRNs6det0Z5zdu64CYEvUHsEuA==
X-Received: by 2002:aca:e6c3:: with SMTP id d186-v6mr165196oih.133.1528347901896;
        Wed, 06 Jun 2018 22:05:01 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h10-v6sm18448249otf.81.2018.06.06.22.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:05:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] t3401: add directory rename testcases for rebase and am
Date:   Wed,  6 Jun 2018 22:04:54 -0700
Message-Id: <20180607050454.19438-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a simple directory rename testcase, in conjunction with each of the
types of rebases:
  git-rebase--interactive
  git-rebase--am
  git-rebase--merge
and also use the same testcase for
  git am --3way

This demonstrates an inconsistency between the different rebase backends
and which can detect the directory rename.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3401-rebase-and-am-rename.sh | 105 ++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100755 t/t3401-rebase-and-am-rename.sh

diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
new file mode 100755
index 0000000000..8f832957fc
--- /dev/null
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='git rebase + directory rename tests'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup testcase' '
+	test_create_repo dir-rename &&
+	(
+		cd dir-rename &&
+
+		mkdir x &&
+		test_seq  1 10 >x/a &&
+		test_seq 11 20 >x/b &&
+		test_seq 21 30 >x/c &&
+		test_write_lines a b c d e f g h i >l &&
+		git add x l &&
+		git commit -m "Initial" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv x y &&
+		git mv l letters &&
+		git commit -m "Rename x to y, l to letters" &&
+
+		git checkout B &&
+		echo j >>l &&
+		test_seq 31 40 >x/d &&
+		git add l x/d &&
+		git commit -m "Modify l, add x/d"
+	)
+'
+
+test_expect_success 'rebase --interactive: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		set_fake_editor &&
+		FAKE_LINES="1" git rebase --interactive A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_failure 'rebase (am): directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		git rebase A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_success 'rebase --merge: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		git rebase --merge A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_expect_failure 'am: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout A^0 &&
+
+		git format-patch -1 B &&
+
+		git am --3way 0001*.patch &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
+test_done
-- 
2.18.0.rc0.46.g9cee8fce43


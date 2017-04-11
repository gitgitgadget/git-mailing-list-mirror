Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2E220970
	for <e@80x24.org>; Tue, 11 Apr 2017 21:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbdDKVHh (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 17:07:37 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35370 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbdDKVHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 17:07:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id 81so4188145pgh.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5tmTnR08sQWoGrFJhjVN/lCzG/tT/gJZIzMRPixsFPM=;
        b=kK+jm0giV47Zdv4ZiRtyFPVAdSZWD5/I0hnYxfd2TwpFjRfKsl6O0fDtfBMm7CniI3
         QJgh6FzHszF9oRr8QeKepfJEYMgdp1IjDh0+ZT7w6B6xN+e5GPm8AcU6YOmT9hNcJyjz
         9ey8F+bs4TnIENOJnmlG+ovKfzlS9C5Dn5q4H0AwDCEJOk1C3OxjH3hQVekIPUnzWgAQ
         ymxduRxzj1Tj/YFRZrPVbjGiMoXjxW4gl9pF9dOXxfZ+BXRfAMFiq0N7OsiOgmfZ+yBA
         30KTjQt1eT0cNbLc7Dg6hGLJzOsKCIWjbLultUIiGXW9WBnLRu/3b8C240sRY5LnqF+V
         o6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5tmTnR08sQWoGrFJhjVN/lCzG/tT/gJZIzMRPixsFPM=;
        b=uLayYlXgzdEYr1dOovgsXTgZQWIyQ95WlTHqk22HYyG4ghw9vLFq664/8k7GrncswJ
         PoRvIRY3kWd+MkyYEb+o+FgNWKcXJA1QNT55/HaPW/5VaaBas/NdvuAUa7yZNOn67NfL
         TuHYRvnKhQ4u48rUieQac3iF2YRYO1IBnRdY6baKS3ztWw2UgsCvDu2gk/RzvJ8k0rgm
         RzhnB6iIbASphGrZRqXWaW2psYvyCdAdEraDQ5ltooW9gdNUn9MnSfUuTfXw8Z8seG//
         33T2tYAtc3rhgWIz9rsJ5U8kIteainsVrGOpGuRrDbMnzsJbz7y3c05LdLS4y1Lm+0ul
         OXgA==
X-Gm-Message-State: AN3rC/6PkoR41hDiRaYrrXrkXCrFSXtZD4DqwDoHOnQHT9H9eMEctHo2T8Klq+33hYpjmVp0
X-Received: by 10.84.238.141 with SMTP id v13mr29643770plk.13.1491944854958;
        Tue, 11 Apr 2017 14:07:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8428:a428:cb31:88df])
        by smtp.gmail.com with ESMTPSA id u22sm32302314pgo.67.2017.04.11.14.07.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 14:07:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] diff: recurse into nested submodules for inline diff
Date:   Tue, 11 Apr 2017 14:07:26 -0700
Message-Id: <20170411210726.29977-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fd47ae6a5b (diff: teach diff to display submodule difference with an
inline diff, 2016-08-31) was introduced, we did not think of recursing
into nested submodules.

When showing the inline diff for submodules, automatically recurse
into nested submodules as well with inline submodule diffs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 I would think this goes on top of origin/sb/show-diff-for-submodule-in-diff-fix.
 
 Thanks,
 Stefan

 submodule.c                                  |  3 +-
 t/t4060-diff-submodule-option-diff-format.sh | 41 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 17de8e8358..a93ec2cb66 100644
--- a/submodule.c
+++ b/submodule.c
@@ -453,7 +453,8 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
-	argv_array_push(&cp.args, "diff");
+	argv_array_pushl(&cp.args, "diff", "--submodule=diff", NULL);
+
 	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index d4a3ffa69c..33ec26d755 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -775,4 +775,45 @@ test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 	test_cmp expected actual
 '
 
+test_expect_success 'diff --submodule=diff recurses into nested submodules' '
+	cat >expected <<-EOF &&
+	Submodule sm2 contains modified content
+	Submodule sm2 a5a65c9..280969a:
+	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
+	new file mode 100644
+	index 0000000..3a816b8
+	--- /dev/null
+	+++ b/sm2/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "nested"]
+	+	path = nested
+	+	url = ../sm2
+	Submodule nested 0000000...b55928c (new submodule)
+	diff --git a/sm2/nested/file b/sm2/nested/file
+	new file mode 100644
+	index 0000000..ca281f5
+	--- /dev/null
+	+++ b/sm2/nested/file
+	@@ -0,0 +1 @@
+	+nested content
+	diff --git a/sm2/nested/foo8 b/sm2/nested/foo8
+	new file mode 100644
+	index 0000000..db9916b
+	--- /dev/null
+	+++ b/sm2/nested/foo8
+	@@ -0,0 +1 @@
+	+foo8
+	diff --git a/sm2/nested/foo9 b/sm2/nested/foo9
+	new file mode 100644
+	index 0000000..9c3b4f6
+	--- /dev/null
+	+++ b/sm2/nested/foo9
+	@@ -0,0 +1 @@
+	+foo9
+	EOF
+	git diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.12.2.575.gb14f27f917


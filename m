Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE571F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGPXfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:31 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:42565 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:31 -0400
Received: by mail-qk0-f201.google.com with SMTP id d25-v6so45139807qkj.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PZ+3uxYVhvEVz9ohDhj6uebx2UODiUrHGv0mDKmIP4k=;
        b=L6BCPfJTHwideq6SiAjSwSlosVB9okgBk78gf7Mt17i17dZBaQfhJkG25mPW0St1F8
         sAj2oFYfekFdidcvzeQMfmS+DUw/T4riww1D6V2BhW4os5uf/u0TuEcmJW80WbUh2nBi
         TUn5GxGID54E1mkRTV6hGxCps/oprh7/O6eG+8fnWAt25kyNGUXdPaPe+9UXJUOL4J0+
         Ow53JxcrXsxD3emhTXIc/c8Qnmyh6MIxRzXtY/icLMjUL4f4Pb1mS8vuay/scy0Pt2O9
         aETHYL+qZF1FNKaI/fUNLnkl31p65ePWfzHSqfzGsfK26wK6xMOMJIzvNGL46C1SitnT
         DT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PZ+3uxYVhvEVz9ohDhj6uebx2UODiUrHGv0mDKmIP4k=;
        b=jsaf9pRJGacY4XzjS9zNonWvjLbVtZKMUJbMLAPZ8OeD2PHV7lfexTuc/UP9YD0hcv
         SoVRvrwOvH0lO88uP61hIRcpIJIC4T/Sbn34sZLyXORaTQEXikPeikAfks5LCE/bBuvr
         ovWm85a3srUgNU3uQD3PB2y/g4TvO+XPBLuknHHT0BncsQUMmFoa2ZvW4cVwRGRAFqIf
         aH5tHUDU05a2OVb1WqXuejmrBbc/dkwZkArVK3r/jAhw6UgYRCPwA55Uj50KIShrSlSZ
         DEJ6jt0C87nRhMeEsW7Nj6YQ+V3iPNAC8sP2Iv7zJI7qH2eS8g6pcS6KdU7cgoDSl0hC
         Akpw==
X-Gm-Message-State: AOUpUlHy0MGQU7zwK8Lr1Z2PZbmr95dgudGUxbAc7/9/bp+uqJA9uL9/
        QahIK90UK0437yxA1HsNpqmjt1ZiPaRp9dmgZVyCYb6laXo7/WR60+uozV/k26SSddq570gD1C7
        8E+bBfJXJLJwWgCSzlbY1WVFDgEX8vu5P3yfiGqVE7rqYVuqWXAzpnrt0BXJR
X-Google-Smtp-Source: AAOMgpdA5Y9KZdoZ8ihUOAQXmQ1LBhlW3TKh1bRLkKno3uQlQ0Utc8brrqI1KERV38gw+00aW6Cm6HFqKRvY
MIME-Version: 1.0
X-Received: by 2002:a0c:b488:: with SMTP id c8-v6mr11790434qve.19.1531782354936;
 Mon, 16 Jul 2018 16:05:54 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:36 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-4-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 3/9] t4015: avoid git as a pipe input
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t4015 we have a pattern of

    git diff [<options, related to color>] |
        grep -v "index" |
        test_decode_color >actual &&

to produce output that we want to test against. This pattern was introduced
in 86b452e2769 (diff.c: add dimming to moved line detection, 2017-06-30)
as then the focus on getting the colors right. However the pattern used
is not best practice as we do care about the exit code of Git. So let's
not have Git as the upstream of a pipe. Piping the output of grep to
some function is fine as we assume grep to be un-flawed in our test suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4015-diff-whitespace.sh | 50 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3ab..ddbc3901385 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1271,9 +1271,8 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=dimmed_zebra --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1315,9 +1314,8 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	test_config diff.colorMoved zebra &&
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1395,9 +1393,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	line 4
 	line 5
 	EOF
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1419,9 +1416,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1459,9 +1455,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	line 5
 	EOF
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1483,9 +1478,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1526,9 +1520,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	# avoid cluttering the output with complaints about our eol whitespace
 	test_config core.whitespace -blank-at-eol &&
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1550,9 +1543,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1597,9 +1589,8 @@ test_expect_success '--color-moved block at end of diff output respects MIN_ALNU
 	irrelevant_line
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
@@ -1636,9 +1627,8 @@ test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
 	nineteen chars 456789
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
-- 
2.18.0.203.gfac676dfb9-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707B11F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbdL1EOD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:03 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:37214 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbdL1EOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:01 -0500
Received: by mail-it0-f68.google.com with SMTP id d137so27463683itc.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v59hJeX/tHww5nUI0GdW2wKiQJJtw/q3l1Zg0cCqUHo=;
        b=rUi9SUZPHRBiDlzkvHtzWuA6IGdXNVvZcL+14cSaH47aeaGBKojqz8xTJdq3LEb3Cy
         8Vvh55xGbRHZId78m4SNmPz8R8TNGJbDkxvSrUBl7urHIzBGaT/ZCOFg1ML+Z11dnBUF
         ih44lpfue0YPJ0lTM0oaze1/l90tIuEAEF0ILulbTYtQo8HxSsrVreVsUWACsxL0KLwU
         cPer7+YUJ07aqSUWdpbvRHIODSGt+j7affVnA1BOucwSW35/PaFeWaDxYN2kq5mPOtbE
         aJXdngc2ODe3wtXviQSP3gmgu3Tc2l7Fj3HUTmbp1nLS34USCKudw/tEQ9C7wfx4zX27
         9L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v59hJeX/tHww5nUI0GdW2wKiQJJtw/q3l1Zg0cCqUHo=;
        b=AJLkp/wI2T1LHlvAbJQ5V1Z3jAEXgSEs2868TIGX+PIMdWI7tgFHHZzCs6AziiaFLu
         fuWRb89jEbDL1vfHqTbY6VkMoi1S4ZvnYS3BlZPf37NLR6DlnOp5nhTcPYsRa9riZF//
         7WyD1ydj4Mu2znPFo1EPJOgAFYxFZ+cJBHXtgXWIhmxBhozfXNIuF9Gu9bID8ocVdJIQ
         MPO8kyam/ze0LcOTcOk/JwRprIXVkqvxjwWx5GdlTUyBh+JQL5Isb+KQhwpGCM4YZm7Z
         YQ4TsPxlWA8NDil9RDwHroO0FGy94O98KXjCOPAfDFJtDGv/5HFO5icAaACKyNXF8m5q
         vddw==
X-Gm-Message-State: AKGB3mLgb0msI82XGOXEvAjGu26FJR94hzh6cTh528aBtplU9DeOiMlE
        jqj9aWDYOytP4NUmmje8wOVMcQ==
X-Google-Smtp-Source: ACJfBovQxf0g6oE8SVSOUKrjWLm1ubRuM99Wh92KjHxv5HiA1+OLDU1coQrc0kLKain4RXUz8ETELg==
X-Received: by 10.36.222.68 with SMTP id d65mr42211262itg.67.1514434440408;
        Wed, 27 Dec 2017 20:14:00 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:13:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 01/34] Tighten and correct a few testcases for merging and cherry-picking
Date:   Wed, 27 Dec 2017 20:13:19 -0800
Message-Id: <20171228041352.27880-2-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t3501 had a testcase originally added in 05f2dfb965 (cherry-pick:
demonstrate a segmentation fault, 2016-11-26) to ensure cherry-pick
wouldn't segfault when working with a dirty file involved in a rename.
While the segfault was fixed, there was another problem this test
demonstrated: namely, that git would overwrite a dirty file involved in a
rename.  Further, the test encoded a "successful merge" and overwriting of
this file as correct behavior.  Modify the test so that it would still
catch the segfault, but to require the correct behavior.  Mark it as
test_expect_failure for now too, since this second bug is not yet fixed.

t7607 had a test added in 30fd3a5425 (merge overwrites unstaged changes in
renamed file, 2012-04-15) specific to looking for a merge overwriting a
dirty file involved in a rename, but it too actually encoded what I would
term incorrect behavior: it expected the merge to succeed.  Fix that, and
add a few more checks to make sure that the merge really does produce the
expected results.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 7 +++++--
 t/t7607-merge-overwrite.sh    | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 4f2a263b6..783bdbf59 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick works with dirty renamed file' '
+test_expect_failure 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
@@ -150,7 +150,10 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_tick &&
 	git commit -m renamed &&
 	echo modified >renamed &&
-	git cherry-pick refs/heads/unrelated
+	test_must_fail git cherry-pick refs/heads/unrelated >out &&
+	test_i18ngrep "Refusing to lose dirty file at renamed" out &&
+	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD^:to-rename.t) &&
+	grep -q "^modified$" renamed
 '
 
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 9444d6a9b..00617dadf 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -97,7 +97,10 @@ test_expect_failure 'will not overwrite unstaged changes in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	git merge c1a &&
+	test_must_fail git merge c1a >out &&
+	test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+	test -f other.c~HEAD &&
+	test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
 	test_cmp important other.c
 '
 
-- 
2.15.0.408.g8e199d483


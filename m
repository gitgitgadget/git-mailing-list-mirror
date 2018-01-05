Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C6A1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeAEUVZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:21:25 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35063 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeAEUVX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:21:23 -0500
Received: by mail-it0-f66.google.com with SMTP id f143so2972280itb.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9M7pYUwVD7TE4hab6+ulYtRa3gHfxR9SRGI/VmT+IM=;
        b=YeJUSF4meYcA/sY8tJFlWialn2CRZ7LSLldG6g0v7/8xbcKfp51EG7/XurRgY7rKmT
         UhfQ6NVaqxUX+C3erdOvoVrMFTjZXK6MQ72UuKVCuUdrcnTl1HOZZ2iTcLmt9ICg6VRd
         JDidi3mw5cM0TW87D1xYFcAQmYG02qr6Ya71QtfQIHd43K0e0ypg2nxiUJZ11WXnkwn7
         5khabIMrLnhtsaeZH6NZ4D3BKdyP55M9EgDaWMhjftlB7Dq9Q43+2cjHX5H9IRuoht0G
         Fn+vg13xgaMPYqrXFOn4lLA6+eNAyUJFiURU5D7+xCqOCTCK05ztZg6mN0RqJxoY6lHk
         BRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9M7pYUwVD7TE4hab6+ulYtRa3gHfxR9SRGI/VmT+IM=;
        b=DdKNF6E7s7R4v07Ur3o099vnQFOD3C+Ye9DSyqwdu3wwkrh5FGNGh9nV7OLJsmaGUI
         xtZ0tekV7fLN55xP4FFRuIgO+xXOGnOx0I3d7/MFTs0YnoZKoIMQo5z5e6pCpaXmnYFe
         lEo5qCL6k3vS+dD1u3RlboAsSu37MDzNv2L1hzuDkSFf5Y5Qou427rR1Z2vtQREPX1WI
         aJ4ZJmJN/Q6+glpWiIKYuF68TL0EUG9T2XGJ0Nx82/i1qnba4Zkxi0akqLmM2isYMS3E
         roh9oLL+jbTeeVWPzihDi2GJEkfkA+eG881QJfLJcR6rAlaNlFAiro8iT9adpMxK1x7l
         b86g==
X-Gm-Message-State: AKGB3mK3RzCrhXTpZBq9FmRkp0MWqk82eYbQW0k5h1F37Q4OmVss6O3v
        DhUNW74ndXBDvJuFfhqNfGE=
X-Google-Smtp-Source: ACJfBos4hcb8K0s13iF01dDRG+zbU762nOPvJHNu5NE/P+uItdS/6F7p3D16trJkJcrxWY52HDnSGQ==
X-Received: by 10.36.249.68 with SMTP id l65mr4115375ith.4.1515183682897;
        Fri, 05 Jan 2018 12:21:22 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id p68sm3876894itc.26.2018.01.05.12.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:21:22 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] Tighten and correct a few testcases for merging and cherry-picking
Date:   Fri,  5 Jan 2018 12:19:59 -0800
Message-Id: <20180105202001.24218-2-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202001.24218-1-newren@gmail.com>
References: <20180105202001.24218-1-newren@gmail.com>
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

Reviewed-By: Stefan Beller <sbeller@google.com>
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
index 9444d6a9b..9c422bcd7 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -97,7 +97,10 @@ test_expect_failure 'will not overwrite unstaged changes in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	git merge c1a &&
+	test_must_fail git merge c1a >out &&
+	test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+	test_path_is_file other.c~HEAD &&
+	test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
 	test_cmp important other.c
 '
 
-- 
2.14.2


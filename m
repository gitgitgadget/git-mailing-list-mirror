Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC891F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeAEU2j (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:39 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34718 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeAEU22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:28 -0500
Received: by mail-it0-f65.google.com with SMTP id m11so5546048iti.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oyGUp6IJtHfr7sCQ7y43TCt5GM1RivgTtKoYilZEb5A=;
        b=VOftoTnpMpqeleW5Lki4Xl7/ax6dsYVEMwzOLgPmGRHCYXMHEyye/Y1TvzJzKBXRfn
         /58fW+v6/X30/dZ9pOKOD7o5ar4nzQGTbwq7GjBEzEC94HKBNiZHLwqyDrsaBS6vP+Bv
         snrz0MOyy6WuoW4s52Oe7ZcejZNi1oJ50au5g04kuoNXNIKVIGs417IVpYTGp2xHG+Y3
         IzzKQ+Gi8MhD+smbCzEyLoSKzcSWaTYJ8zgF7ctBcRGWcyZ0IhD7oG5EhMncB3kNtIsW
         ZCxIrf6OghY6zhl6YY3OXuy0vvNKhW/QzNtZdXbTf8xqf73qt/u0XY/hrQ+kGom7mj7m
         bS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oyGUp6IJtHfr7sCQ7y43TCt5GM1RivgTtKoYilZEb5A=;
        b=ZD6VNrXxvoNcZjhKvZ73O27prOxjuxZSdieMQF0Xu2A27hVf2bltx6i8K26f9UmCdw
         IEt/7hN/h8j8PuOneEChyoiWWG4u/65KM/Z/XNaU5pNM5ywBO4Bz7o39pY0pDThy58kR
         y1XBtwIzrNtKMYkvfQKEE3X5nMOpJMXWZT723BzsHBn4oRnKut5Om/Kv4ImqPal18XhJ
         ufjqBEdjqXm8tO73xMQtJCwjKZYj3dV5BnOmdoXZQd0qr/hFGx9HhENB3J592lKYBadj
         eL4sIOZfUt+EsO4xIdG91Yuh9mE4XiVx1uoYKg4C2NtaRaPeDFC7TW4Zx+PSwJI5UgNG
         /iCg==
X-Gm-Message-State: AKGB3mL6DwgnSOp8bgDLC/2+cC4YPXamc+wX6s3fO8PHrjygHxnk+KKQ
        9HjI7eiERtIryKG+tIzRi43AMo8V
X-Google-Smtp-Source: ACJfBov6XNPwEy0y6PxQnCRsK+rutUYkN3U5dnTv5zA0wlGc3VDC+dKKBLme93pnT1+6BgpArvR1hg==
X-Received: by 10.36.225.139 with SMTP id n133mr4009370ith.57.1515184107399;
        Fri, 05 Jan 2018 12:28:27 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 06/31] directory rename detection: testcases checking which side did the rename
Date:   Fri,  5 Jan 2018 12:26:46 -0800
Message-Id: <20180105202711.24311-7-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 336 ++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index f9d75c83c..dc3fc66e5 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1172,4 +1172,340 @@ test_expect_failure '5d-check: Directory/file/file conflict due to directory ren
 #   back to old handling.  But, sadly, see testcases 8a and 8b.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 6: Same side of the merge was the one that did the rename
+#
+# It may sound obvious that you only want to apply implicit directory
+# renames to directories if the _other_ side of history did the renaming.
+# If you did make an implementation that didn't explicitly enforce this
+# rule, the majority of cases that would fall under this section would
+# also be solved by following the rules from the above sections.  But
+# there are still a few that stick out, so this section covers them just
+# to make sure we also get them right.
+###########################################################################
+
+# Testcase 6a, Tricky rename/delete
+#   Commit O: z/{b,c,d}
+#   Commit A: z/b
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/b, CONFLICT(rename/delete, z/c -> y/c vs. NULL)
+#   Note: We're just checking here that the rename of z/b and z/c to put
+#         them under y/ doesn't accidentally catch z/d and make it look like
+#         it is also involved in a rename/delete conflict.
+
+test_expect_success '6a-setup: Tricky rename/delete' '
+	test_create_repo 6a &&
+	(
+		cd 6a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/c &&
+		git rm z/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6a-check: Tricky rename/delete' '
+	(
+		cd 6a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :3:y/c &&
+		git rev-parse >expect \
+			O:z/b O:z/c &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6b, Same rename done on both sides
+#   (Related to testcases 6c and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c}
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   Note: If we did directory rename detection here, we'd move z/d into y/,
+#         but B did that rename and still decided to put the file into z/,
+#         so we probably shouldn't apply directory rename detection for it.
+
+test_expect_success '6b-setup: Same rename done on both sides' '
+	test_create_repo 6b &&
+	(
+		cd 6b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6b-check: Same rename done on both sides' '
+	(
+		cd 6b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6c, Rename only done on same side
+#   (Related to testcases 6b and 8e)
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Seems obvious, but just checking that the implementation doesn't
+#         "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6c-setup: Rename only done on same side' '
+	test_create_repo 6c &&
+	(
+		cd 6c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		mkdir z &&
+		echo d >z/d &&
+		git add z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6c-check: Rename only done on same side' '
+	(
+		cd 6c &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6d, We don't always want transitive renaming
+#   (Related to testcase 1c)
+#   Commit O: z/{b,c}, x/d
+#   Commit A: z/{b,c}, x/d (no change)
+#   Commit B: y/{b,c}, z/d
+#   Expected: y/{b,c}, z/d
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c,d}.
+
+test_expect_success '6d-setup: We do not always want transitive renaming' '
+	test_create_repo 6d &&
+	(
+		cd 6d &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		echo d >x/d &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		git mv x z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6d-check: We do not always want transitive renaming' '
+	(
+		cd 6d &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:x/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 6e, Add/add from one-side
+#   Commit O: z/{b,c}
+#   Commit A: z/{b,c} (no change)
+#   Commit B: y/{b,c,d_1}, z/d_2
+#   Expected: y/{b,c,d_1}, z/d_2
+#   NOTE: Again, this seems obvious but just checking that the implementation
+#         doesn't "accidentally detect a rename" and give us y/{b,c} +
+#         add/add conflict on y/d_1 vs y/d_2.
+
+test_expect_success '6e-setup: Add/add from one side' '
+	test_create_repo 6e &&
+	(
+		cd 6e &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		git mv z y &&
+		echo d1 > y/d &&
+		mkdir z &&
+		echo d2 > z/d &&
+		git add y/d z/d &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '6e-check: Add/add from one side' '
+	(
+		cd 6e &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:y/d B:z/d &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 6:
+#
+#   Only apply implicit directory renames to directories if the other
+#   side of history is the one doing the renaming.
+###########################################################################
+
 test_done
-- 
2.14.2


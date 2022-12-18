Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB0C4167B
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiLRRWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 12:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRRWW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 12:22:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0E32B85
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 08:29:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kw15so16552677ejc.10
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/t025ZUJCqBGgsBVUhcg9KFBighl1ZTP6nR6JQpdzU=;
        b=P8V/4HF5BU3bzSWjsIhNi2rjZJ7kIRCpMAYrFe1mMIb+ZizHth+20Mef4ILLyx5tbU
         g8DZI5k/tk19VDpkkAOCWHMTbLT8BAqrsO32YOYIzFO/K93dlxddOg9VmiSeV/fjifnr
         hMyrT1mQjL9ydlBDWQircJKQBtCKMWMWMs5Zp2vZVvoYS/2Wg4YhK59+W4qVHBxpxSj0
         W2YALyaiHx4pYXy+VSE5eS3S4QNud5rPGZ/U+r5AApe4M13m90n3/VE759Al9+BvZ5U0
         ecjdJiVz5oNXg8+EQ8NJ2Q4TD69tsTdwJJ2zByB1+w4Pr9yHX40CHHKZwvd4TfGROyv3
         Hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/t025ZUJCqBGgsBVUhcg9KFBighl1ZTP6nR6JQpdzU=;
        b=YGQOEWictjPbqduJcBWKtq1unXEVjTCVFHiwiAJElsZSo+iK8vuxqBP/X+LAzmXYGj
         zynIVDSkogvgC9h/oAhFWcK9qTNo1oHAjlTJpTONamBrVf5bV53/bcn9IThli4UH8nze
         vqmtOQx3KFBfzhHPygpxLvuXLCHl2ozDkJIeSylAuBB4TTK+kz+98hc4EfD8E0syeFfu
         m1o6Nv7cyrfM1PnLa8+aATWK0dkNkBo8fl1VxNEhVm4EQDK0mlqM/nCc4UqLxbEccOAo
         NT61kUJjypldR74oa8LwDBOaBkFLMqhIW6TZub3Dx2LBvwsMFC1aWlPeqsToyotOdKE+
         WBZw==
X-Gm-Message-State: ANoB5pnYPYFf7b0NjLumsuFyb1HBiFJpTdOphrSRZm+0ddPIDNI6l/fH
        T1vQ3yOgr3hI+esSSIm0K7v7+K5DMWY3kg==
X-Google-Smtp-Source: AA0mqf5qWG85uJWgF1TfPPNlzoV2w6YAlbR6Xd7olMgp1SVn6DD0XljfIA9FnOS2aVxcYWHMm3B8iw==
X-Received: by 2002:a17:906:80c2:b0:7c1:5019:50c6 with SMTP id a2-20020a17090680c200b007c1501950c6mr42084964ejx.72.1671380958011;
        Sun, 18 Dec 2022 08:29:18 -0800 (PST)
Received: from localhost (78-131-14-113.pool.digikabel.hu. [78.131.14.113])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090676d600b0080c433a9eeesm1430489ejn.182.2022.12.18.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 08:29:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] tests: make 'test_oid' print trailing newline
Date:   Sun, 18 Dec 2022 17:29:05 +0100
Message-Id: <20221218162905.3508164-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.39.0.269.g5ff869c7c0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other test helper functions, 'test_oid' doesn't terminate its
output with a LF, but, alas, the reason for this, if any, is not
mentioned in 2c02b110da (t: add test functions to translate
hash-related values, 2018-09-13)).

Now, in the vast majority of cases 'test_oid' is invoked in a command
substitution that is part of a heredoc or supplies an argument to a
command or the value to a variable, and the command substitution would
chop off any trailing LFs, so in these cases the lack or presence of a
trailing LF in its output doesn't matter.  However:

  - There appear to be only three cases where 'test_oid' is not
    invoked in a command substitution:

      $ git grep '\stest_oid ' -- ':/t/*.sh'
      t0000-basic.sh:  test_oid zero >actual &&
      t0000-basic.sh:  test_oid zero >actual &&
      t0000-basic.sh:  test_oid zero >actual &&

    These are all in test cases checking that 'test_oid' actually
    works, and that the size of its output matches the size of the
    corresponding hash function with conditions like

      test $(wc -c <actual) -eq 40

    In these cases the lack of trailing LF does actually matter,
    though they could be trivially updated to account for the presence
    of a trailing LF.

  - There are also a few cases where the lack of trailing LF in
    'test_oid's output actually hurts, because tests need to compare
    its output with LF terminated file contents, forcing developers to
    invoke it as 'echo $(test_oid ...)' to append the missing LF:

      $ git grep 'echo "\?$(test_oid ' -- ':/t/*.sh'
      t1302-repo-version.sh:  echo $(test_oid version) >expect &&
      t1500-rev-parse.sh:     echo "$(test_oid algo)" >expect &&
      t4044-diff-index-unique-abbrev.sh:      echo "$(test_oid val1)" > foo &&
      t4044-diff-index-unique-abbrev.sh:      echo "$(test_oid val2)" > foo &&
      t5313-pack-bounds-checks.sh:    echo $(test_oid oidfff) >file &&

    And there is yet another similar case in an in-flight topic at:

      https://public-inbox.org/git/813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com/

Arguably we would be better off if 'test_oid' terminated its output
with a LF.  So let's update 'test_oid' accordingly, update its tests
in t0000 to account for the extra character in those size tests, and
remove the now unnecessary 'echo $(...)' command substitutions around
'test_oid' invocations as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0000-basic.sh                    | 7 ++++---
 t/t1302-repo-version.sh             | 2 +-
 t/t1500-rev-parse.sh                | 2 +-
 t/t4044-diff-index-unique-abbrev.sh | 4 ++--
 t/t5313-pack-bounds-checks.sh       | 2 +-
 t/test-lib-functions.sh             | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 502b4bcf9e..8ea31d187a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -815,7 +815,8 @@ test_expect_success 'test_oid provides sane info by default' '
 	grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
-	test "$hexsz" -eq $(wc -c <actual) &&
+	# +1 accounts for the trailing newline
+	test $(( $hexsz + 1)) -eq $(wc -c <actual) &&
 	test $(( $rawsz * 2)) -eq "$hexsz"
 '
 
@@ -826,7 +827,7 @@ test_expect_success 'test_oid can look up data for SHA-1' '
 	grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
-	test $(wc -c <actual) -eq 40 &&
+	test $(wc -c <actual) -eq 41 &&
 	test "$rawsz" -eq 20 &&
 	test "$hexsz" -eq 40
 '
@@ -838,7 +839,7 @@ test_expect_success 'test_oid can look up data for SHA-256' '
 	grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
-	test $(wc -c <actual) -eq 64 &&
+	test $(wc -c <actual) -eq 65 &&
 	test "$rawsz" -eq 32 &&
 	test "$hexsz" -eq 64
 '
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 0acabb6d11..7cf80bf66a 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'gitdir selection on normal repos' '
-	echo $(test_oid version) >expect &&
+	test_oid version >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 81de584ea2..37ee5091b5 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -195,7 +195,7 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 '
 
 test_expect_success 'rev-parse --show-object-format in repo' '
-	echo "$(test_oid algo)" >expect &&
+	test_oid algo >expect &&
 	git rev-parse --show-object-format >actual &&
 	test_cmp expect actual &&
 	git rev-parse --show-object-format=storage >actual &&
diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index 29e49d2290..9f6043daba 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -34,12 +34,12 @@ test_expect_success 'setup' '
 	100644 blob $(test_oid hash2)	foo
 	EOF
 
-	echo "$(test_oid val1)" > foo &&
+	test_oid val1 > foo &&
 	git add foo &&
 	git commit -m "initial" &&
 	git cat-file -p HEAD: > actual &&
 	test_cmp expect_initial actual &&
-	echo "$(test_oid val2)" > foo &&
+	test_oid val2 > foo &&
 	git commit -a -m "update" &&
 	git cat-file -p HEAD: > actual &&
 	test_cmp expect_update actual
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index cc4cfaa9d3..ceaa6700a2 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' '
 test_expect_success 'set up base packfile and variables' '
 	# the hash of this content starts with ff, which
 	# makes some later computations much simpler
-	echo $(test_oid oidfff) >file &&
+	test_oid oidfff >file &&
 	git add file &&
 	git commit -m base &&
 	git repack -ad &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b3..f51b97663f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1682,7 +1682,7 @@ test_oid () {
 	then
 		BUG "undefined key '$1'"
 	fi &&
-	eval "printf '%s' \"\${$var}\""
+	eval "printf '%s\n' \"\${$var}\""
 }
 
 # Insert a slash into an object ID so it can be used to reference a location
-- 
2.39.0.269.g5ff869c7c0


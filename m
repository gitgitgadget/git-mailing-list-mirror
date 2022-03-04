Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E8C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiCDA65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiCDA6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:55 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB04F1EB1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x6-20020a1709029a4600b0014efe26b04fso3752245plv.21
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OmedMzQwk2A+2KKPR+3WZqRF/VcgdnACdWhsY0RDGWg=;
        b=l6FRu+3SN0mfdnT2JMxqdd/mbCbYPGj0O9MSRKRWNnlgIGkTkFSOnUugxXymDd2H1p
         P403BOsktxZBlAIM2e8Rf9W9/LE8f1sMuJ9peeSdA8khLGRXDkw8BiN8OodPJ0vKAAde
         bAyxTbcu6MjziHWHEY7DV3+ZIyuGXFBBbzpRO4bRvaKSRq0lTaXxGoYuSeVIlmLUFeRN
         YqYTI2Zb0z7CuJ7XxTK0fZg7UttHYv7oogwOQL+kx5CilyeoAcDS5xUYe/Snz8tJklHk
         poej7XXNmH2B+Bn4gIibhVI81d1Hncxct6X6MpmBsx2BITomSu67Ac9ten0TGEpHGMuZ
         jE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OmedMzQwk2A+2KKPR+3WZqRF/VcgdnACdWhsY0RDGWg=;
        b=hVKFvq7NfSqVloJY6mHUm3ArfRwWMz1Snc+qrU9p8yHZSLTAVskLTAhdmfgwvdqirL
         ytRsm/d2Nc2ZobuQiQI4hgWIjaA6KWz21l1Icwguq79iHuqtzcn7EMe5ALuPgwI42jS/
         na1HPJYTXMfpgizLtcHmUQHyKbo0HTxDrmal2k4EmCFQ8XoYcJqhBZqcKfWQs+Ds92q+
         nNfk1PIQ8Zb1pDQO6WjjtEm283uAC4U/PiNvJkwqK+kr/01Ea67oj3iGmTyBR3izaFxF
         fu/X3IZqi5zzSN3VGfuBiZrORto3KokW+drkBGpnNwdS9MgSt/VLeIXmXzph1l/BEwaS
         ZxgQ==
X-Gm-Message-State: AOAM533FY8pOwrTGq7PDY96eJv085ASg4NtpKfAOUHF3bz89vFDizM9H
        ph8iw8YqatOn4D/dQPAri/DXb3GgszjCy6EvZLCIGE/zKEA2wanhpjcLZnDzWiFCqtILY0H/VCs
        a7tLps20suavu4GZXSOGV1v80QDf+0OQbqg/2ZrWswD+0V8Ct3octSvSMeu+jXdU=
X-Google-Smtp-Source: ABdhPJwXILvI2IjVee1nSwn8q4IikKn1jigcWxmKR+mc4H0kdUzGIPli371lAbMa7V8fbmx2Rcvuy66p8yFJFA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:26c1:b0:4e1:3135:97a9 with SMTP
 id p1-20020a056a0026c100b004e1313597a9mr40985916pfw.13.1646355487231; Thu, 03
 Mar 2022 16:58:07 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:48 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 01/10] t5526: introduce test helper to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t/t5526-fetch-submodules.sh are unnecessarily noisy:

* The tests have extra logic in order to reproduce the expected stderr
  literally, but not all of these details (e.g. the head of the
  remote-tracking branch before the fetch) are relevant to the test.

* The expect.err file is constructed by the add_upstream_commit() helper
  as input into test_cmp, but most tests fetch a different combination
  of repos from expect.err. This results in noisy tests that modify
  parts of that expect.err to generate the expected output.

To address both of these issues, introduce a verify_fetch_result()
helper to t/t5526-fetch-submodules.sh that asserts on the output of "git
fetch --recurse-submodules" and handles the ordering of expect.err.

As a result, the tests no longer construct expect.err manually. Tests
still consider the old head of the remote-tracking branch ("$head1"),
but that will be fixed in a later commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 139 ++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 55 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 840c89cc8b..dff7a4b90b 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -10,6 +10,10 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
+# For each submodule in the test setup, this creates a commit and writes
+# a file that contains the expected err if that new commit were fetched.
+# These output files get concatenated in the right order by
+# verify_fetch_result().
 add_upstream_commit() {
 	(
 		cd submodule &&
@@ -19,9 +23,9 @@ add_upstream_commit() {
 		git add subfile &&
 		git commit -m new subfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err &&
-		echo "From $pwd/submodule" >> ../expect.err &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err
+		echo "Fetching submodule submodule" > ../expect.err.sub &&
+		echo "From $pwd/submodule" >> ../expect.err.sub &&
+		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
 	) &&
 	(
 		cd deepsubmodule &&
@@ -31,12 +35,36 @@ add_upstream_commit() {
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
-		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err
+		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
+		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
+		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
 	)
 }
 
+# Verifies that the expected repositories were fetched. This is done by
+# concatenating the files expect.err.[super|sub|deep] in the correct
+# order and comparing it to the actual stderr.
+#
+# If a repo should not be fetched in the test, its corresponding
+# expect.err file should be rm-ed.
+verify_fetch_result() {
+	ACTUAL_ERR=$1 &&
+	rm -f expect.err.combined &&
+	if test -f expect.err.super
+	then
+		cat expect.err.super >>expect.err.combined
+	fi &&
+	if test -f expect.err.sub
+	then
+		cat expect.err.sub >>expect.err.combined
+	fi &&
+	if test -f expect.err.deep
+	then
+		cat expect.err.deep >>expect.err.combined
+	fi &&
+	test_cmp expect.err.combined $ACTUAL_ERR
+}
+
 test_expect_success setup '
 	mkdir deepsubmodule &&
 	(
@@ -74,7 +102,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
@@ -84,7 +112,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
@@ -94,7 +122,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err &&
+	verify_fetch_result actual.err &&
 	grep "2 tasks" trace.out
 '
 
@@ -124,7 +152,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
@@ -155,7 +183,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--quiet propagates to submodules" '
@@ -183,7 +211,7 @@ test_expect_success "--dry-run propagates to submodules" '
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "Without --dry-run propagates to submodules" '
@@ -192,7 +220,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
@@ -203,7 +231,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
@@ -217,7 +245,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
@@ -250,14 +278,14 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.sub &&
-	head -3 expect.err >> expect.err.sub &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.sub actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -268,14 +296,16 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 	git add file &&
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.file actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "Recursion picks up config in submodule" '
@@ -292,9 +322,8 @@ test_expect_success "Recursion picks up config in submodule" '
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.sub &&
-	cat expect.err >> expect.err.sub &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -303,7 +332,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config --unset fetch.recurseSubmodules
 		)
 	) &&
-	test_cmp expect.err.sub actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -328,15 +357,13 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.2 &&
-	cat expect.err.sub >> expect.err.2 &&
-	tail -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.2 actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -372,11 +399,8 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	tail -3 expect.err > expect.err.deepsub &&
-	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err &&
-	cat expect.err.sub >> expect.err &&
-	cat expect.err.deepsub >> expect.err &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -392,7 +416,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 		)
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
@@ -402,14 +426,16 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	git add file &&
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.file actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
@@ -423,9 +449,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules on-demand &&
@@ -437,7 +463,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		git config --unset fetch.recurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
@@ -451,9 +477,9 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
@@ -465,7 +491,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "don't fetch submodule when newly recorded commits are already present" '
@@ -477,14 +503,17 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	git add submodule &&
 	git commit -m "submodule rewound" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	# This file does not exist, but rm -f for readability
+	rm -f expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err &&
+	verify_fetch_result actual.err &&
 	(
 		cd submodule &&
 		git checkout -q sub
@@ -502,9 +531,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >>expect.err.2 &&
+	echo "From $pwd/." >expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		rm .gitmodules &&
@@ -520,7 +549,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git reset --hard
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err &&
+	verify_fetch_result actual.err &&
 	git checkout HEAD^ -- .gitmodules &&
 	git add .gitmodules &&
 	git commit -m "new submodule restored .gitmodules"
-- 
2.33.GIT


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB6C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiCGMpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiCGMoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD436682
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j26so12697170wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rTg6KeLnE3978EIXXioykAkOW+2pCwRuxEgrauMkM0=;
        b=DTXVNYzm/+ghJBO7qrxJrDvKauqoTFsHYtiFjNbgLbFDZ8AlMkhEKgMpl4A39rKPAf
         gvIz3tszmj2qOCPbNeWKjtd2U/3Y9ZyrLl63x4bQJiNDwmU0W4UIXzJWtxWKlnrF85c4
         cX8OMPToRPO3B+dNOBdA1llPbdufpgoB5zFUW0x2MscQOao2ckG3FUMSY/ogSsNDGg8T
         C0rLu3cvtuzPDy2yDrhumEyHyFxJF4MnAJ3+VTmBLs7cq1/6ZCE5qBNPpKFKldIjeYel
         QQF35p8HhlzzFF9R74N4V6LzZwZsggPhH+bON53YkKV5uzA1lrkC+OUuuD9Mnhr1GXK0
         hG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rTg6KeLnE3978EIXXioykAkOW+2pCwRuxEgrauMkM0=;
        b=XKn1uC9WBuw1UUuOyPJLGm2f0RxsN5vctwx6CD+fuR1jkKhsHwJr8ASDUS68PI5o1R
         BQ+5gtAf5vFUUiZZqYScQWcQf/A174bU6IAK/ACjfCr0fTXYl7L5VP+5EF59AvZlMLEl
         6gdCKU8JMXlloV+sJfOGm0rG0OB/G8be00eGnl02tYK/4LeHzMrN6bpUryW++zZV7FCI
         5LvzUpyO2idGX8j0uWRDcBMpNBkJhPsX2cwWzjl+Y+miIFuqRa/Z5g1dEtdlOM7A/rsw
         q8CgD/OoWa2kS8Dmb2BsDbZbHgaW0tpB++Qux8wpX2L7j0tftQErhBMzWkdT7wb/+GS6
         0A/Q==
X-Gm-Message-State: AOAM533mP4OCnX3G7uMoPZDik6dlT5speVs94bDsQScBhEu+325vlZYm
        x/2uqPJSJH+khF4F5YEy51Qjx8eut9FO9A==
X-Google-Smtp-Source: ABdhPJxdmPOx1RSsaejmhyoy8Akg+U69hhy12MuDRZlH1a1yohgWcZVTSUHqDRkCKFDTjXEqAQaXtA==
X-Received: by 2002:a05:6000:1863:b0:1f1:fa18:5d70 with SMTP id d3-20020a056000186300b001f1fa185d70mr2625315wri.141.1646657034678;
        Mon, 07 Mar 2022 04:43:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] fetch+push tests: have tests clean up their own mess
Date:   Mon,  7 Mar 2022 13:43:38 +0100
Message-Id: <patch-v2-07.10-0ac75ed062f-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "t5516-fetch-push.sh" test code to make use of
"test_when_finished" to remove data instead of having tests clean up
leftover data from earlier tests, which may or may not be
there (e.g. depending on the --run=* option).

Before this each test would have been responsible for cleaning up
after a preceding test (which may or may not have run, e.g. if --run
or "GIT_SKIP_TESTS" was used), now each test will instead clean up
after itself.

When doing this split up the "push with negotiation" test, now the
middle of the test doesn't need to "rm event", and since it delimited
two halves that were testing two different things the end-state is
easier to read and reason about.

While changing these lines make the minor change from "-fr" to "-rf"
as the "rm" argument, some of them used it already, it's more common
in the test suite, and it leaves the end-state of the file with more
consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e4bb7581568..fbe0a72b0b2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -23,7 +23,8 @@ D=$(pwd)
 
 mk_empty () {
 	repo_name="$1"
-	rm -fr "$repo_name" &&
+	test_when_finished "rm -rf \"$repo_name\"" &&
+	test_path_is_missing "$repo_name" &&
 	git init "$repo_name" &&
 	git -C "$repo_name" config receive.denyCurrentBranch warn
 }
@@ -86,7 +87,7 @@ mk_test_with_hooks() {
 }
 
 mk_child() {
-	rm -rf "$2" &&
+	test_when_finished "rm -rf \"$2\"" &&
 	git clone "$1" "$2"
 }
 
@@ -191,32 +192,32 @@ grep_wrote () {
 	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
 }
 
-test_expect_success 'push with negotiation' '
-	# Without negotiation
+test_expect_success 'push without negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
-	echo now pushing without negotiation &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
-	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+	grep_wrote 5 event # 2 commits, 2 trees, 1 blob
+'
 
-	# Same commands, but with negotiation
-	rm event &&
+test_expect_success 'push with negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
 	grep_wrote 2 event # 1 commit, 1 tree
 '
 
 test_expect_success 'push with negotiation proceeds anyway even if negotiation fails' '
-	rm event &&
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
 		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
 	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
@@ -1323,7 +1324,7 @@ done
 
 test_expect_success 'fetch follows tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
 	(
 		cd src &&
@@ -1333,6 +1334,7 @@ test_expect_success 'fetch follows tags by default' '
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sort -k 3 >../expect
 	) &&
+	test_when_finished "rm -rf dst" &&
 	git init dst &&
 	(
 		cd dst &&
@@ -1358,8 +1360,9 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 
 test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1382,8 +1385,9 @@ test_expect_success 'pushing a specific ref applies remote.$name.push as refmap'
 
 test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1404,8 +1408,9 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 
 test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1433,8 +1438,9 @@ test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 
 test_expect_success 'push does not follow tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1456,8 +1462,9 @@ test_expect_success 'push does not follow tags by default' '
 
 test_expect_success 'push --follow-tags only pushes relevant tags' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1495,9 +1502,9 @@ EOF
 '
 
 test_expect_success 'pushing a tag pushes the tagged object' '
-	rm -rf dst.git &&
 	blob=$(echo unreferenced | git hash-object -w --stdin) &&
 	git tag -m foo tag-of-blob $blob &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git push dst.git tag-of-blob &&
 	# the receiving index-pack should have noticed
@@ -1508,7 +1515,7 @@ test_expect_success 'pushing a tag pushes the tagged object' '
 '
 
 test_expect_success 'push into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git -C dst.git config core.logallrefupdates true &&
 
@@ -1526,7 +1533,7 @@ test_expect_success 'push into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'fetch into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	(
 		cd dst.git &&
@@ -1547,6 +1554,7 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'receive.denyCurrentBranch = updateInstead' '
+	mk_empty testrepo &&
 	git push testrepo main &&
 	(
 		cd testrepo &&
@@ -1649,7 +1657,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	) &&
 
 	# (5) push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
 	git init void &&
 	(
 		cd void &&
@@ -1671,7 +1679,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 '
 
 test_expect_success 'updateInstead with push-to-checkout hook' '
-	rm -fr testrepo &&
+	test_when_finished "rm -rf testrepo" &&
 	git init testrepo &&
 	git -C testrepo pull .. main &&
 	git -C testrepo reset --hard HEAD^^ &&
@@ -1730,7 +1738,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	) &&
 
 	# push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
 	git init void &&
 	git -C void config receive.denyCurrentBranch updateInstead &&
 	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
-- 
2.35.1.1242.gfeba0eae32b


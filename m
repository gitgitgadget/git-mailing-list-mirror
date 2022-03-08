Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B5C4332F
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiCHAP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiCHAPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ACA2B19E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:14:55 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id c10-20020a170902d48a00b00151cf8ca3c7so2883697plg.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WV1bpQi/w5DHGXoIF+VLCC3s/jsIRvAvr/b5FOoa7fA=;
        b=gM/Hy6WUnLzkQeeMbJ4aSi/DX+Iv/pQsW0j1EJJJuHiEfdIqGTivSvgYwCg5ZAkc8I
         asLhw6hTC/hydihm3LdynhG98DSQv47rVHHcUsJ47UW3oIvDIoW+WFUHVqJr8KyWmvZP
         PcTSBUPY6esQLQKzMqFFh4nvcVvLWg+01OTqumSqL8pk2DcCP/mcNUUJk+DR2UljTFjv
         INheyJHnyj0G2S6QBJId9gYGXaHEegx8s0zGZIJSqezKyiQNu1F6jFRzpD+WnOQW7iJl
         UzMYqh2q93MZ6nV+UWSAhUK+HzeTtM3Xl+AYMprL+w8GxpVpptbcmIO8uMLESVfNhoKM
         y8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WV1bpQi/w5DHGXoIF+VLCC3s/jsIRvAvr/b5FOoa7fA=;
        b=npDlT33U5boGRMa0RJgc1xCROMkjd8ii74Ww0moX2ECa/4GWj6YP0XPKSBeOy2kFnD
         24ytUMMr37tEIh9MyNdpo9QFrHiwUyhPZd2CL7i3hHOr+gqwK3f+Yvaz2vdN0OHYkPwG
         rG0Bg69c7AzNVvodCP24mQrjhP7G2xOCX+2dSM6CjxWPSq1P5GeZfZRoWUHgXj2JGErz
         U4yqQ5m9aJRGmSPUEkACtP0haYTPNM4/CnoJxvOysYVUvJwXeD+NCgCxBrdAXIZRv1vV
         vs2WU+h30EEBcx4DpRn5TZXvkTj71XC39a17qBhN7UJrCl/Q/B8fXM+Gse89OjYP3hmz
         OZag==
X-Gm-Message-State: AOAM531griynPNaoAEuOyu/JHHQyHQhM4eCD+eNbKwUHIKYwe+aXW8ik
        x2+LrrlrwE07U7KD6ItaB41elhkmmA24dgZTl6V5Mc6yOGK6n/nxm9S+Rnr0HZKashaFjL7oe48
        fXalxRKw2vbyBqbyuk+BF6o9fm78Nwfac6p0CFTdIXLHiseU/+brn4boTnvIU8GI=
X-Google-Smtp-Source: ABdhPJyVG8PE/GaRa4eudul1VrJr4lMN1t1oa6zeFYcj/Q8xPZaLY30828dmqtEDT64KiEh7RpAxIO9A/s+sbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1801:b0:1bf:2854:dd46 with SMTP
 id lw1-20020a17090b180100b001bf2854dd46mr1662797pjb.230.1646698494662; Mon,
 07 Mar 2022 16:14:54 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:25 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 02/10] t5526: stop asserting on stderr literally
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

In the previous commit message, we noted that not all of the "git fetch"
stderr is relevant to the tests. Most of the test setup lines are
dedicated to these details of the stderr:

1. which repos (super/sub/deep) are involved in the fetch
2. the head of the remote-tracking branch before the fetch (i.e. $head1)
3. the head of the remote-tracking branch after the fetch (i.e. $head2)

1. and 3. are relevant because they tell us that the expected commit is
fetched by the expected repo, but 2. is completely irrelevant.

Stop asserting on $head1 by replacing it with a dummy value in the
actual and expected output. Do this by introducing test
helpers (write_expected_*()) that make it easier to construct the
expected output, and use sed to munge the actual output.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 117 +++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 61 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index c3a67270b1..e7136b68ba 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -10,6 +10,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
+write_expected_sub () {
+	NEW_HEAD=$1 &&
+	cat >"$pwd/expect.err.sub" <<-EOF
+	Fetching submodule submodule
+	From $pwd/submodule
+	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
+	EOF
+}
+
+write_expected_deep () {
+	NEW_HEAD=$1 &&
+	cat >"$pwd/expect.err.deep" <<-EOF
+	Fetching submodule submodule/subdir/deepsubmodule
+	From $pwd/deepsubmodule
+	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
+	EOF
+}
+
+write_expected_super () {
+	NEW_HEAD=$1 &&
+	cat >"$pwd/expect.err.super" <<-EOF
+	From $pwd/.
+	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
+	EOF
+}
+
 # For each submodule in the test setup, this creates a commit and writes
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
@@ -17,27 +43,21 @@ pwd=$(pwd)
 add_upstream_commit() {
 	(
 		cd submodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> subfile &&
 		test_tick &&
 		git add subfile &&
 		git commit -m new subfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_sub $new_head
 	) &&
 	(
 		cd deepsubmodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> deepsubfile &&
 		test_tick &&
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
-		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_deep $new_head
 	)
 }
 
@@ -62,7 +82,8 @@ verify_fetch_result () {
 	then
 		cat expect.err.deep >>expect.err.combined
 	fi &&
-	test_cmp expect.err.combined $ACTUAL_ERR
+	sed -e 's/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./' "$ACTUAL_ERR" >actual.err.cmp &&
+	test_cmp expect.err.combined actual.err.cmp
 }
 
 test_expect_success setup '
@@ -274,12 +295,10 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 '
 
 test_expect_success "Recursion stops when no new submodule commits are fetched" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -291,13 +310,11 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -318,12 +335,10 @@ test_expect_success "Recursion picks up config in submodule" '
 		)
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -345,20 +360,15 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_sub $new_head
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -376,13 +386,10 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo Fetching submodule submodule > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_sub $new_head
 	) &&
 	(
 		cd downstream &&
@@ -395,12 +402,10 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -421,13 +426,11 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -445,12 +448,10 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	) &&
 	add_upstream_commit &&
 	git config --global fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -473,12 +474,10 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	) &&
 	add_upstream_commit &&
 	git config fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -499,12 +498,10 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		cd submodule &&
 		git checkout -q HEAD^^
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "submodule rewound" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.sub &&
 	# This file does not exist, but rm -f for readability
 	rm -f expect.err.deep &&
@@ -526,13 +523,11 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	new_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
-- 
2.33.GIT


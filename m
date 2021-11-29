Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE6C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 15:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbhK2Po1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhK2Pm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 10:42:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5288CC06137A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so14659361wms.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U0lCvIlLwdimjOUyxDjpipe79OvK/WADTE68Gfk88tk=;
        b=ZLvzhQMu9KPkcnYZQIHm7+60vqOeni2QIh7Iufb0q+nZWUSd3TGXWIcDeceTOS4ySw
         CIUXks0P4pCKTgdrNhfvm5W0GuKDyCQ0KIORJ/MAlgo9HnnJsAYXAJI3U5qY2y0RgntQ
         I86s0P43vi32lyjkhiLue50minfEZHnMItCu+To9s7UbNfS+UNEd8yxUEZhyOsR4iY70
         Izk3DCzBrodUzxvOGgTmsSQRAYSNAnj7bLXttZsNisZBBGPzZgM9K+1ynRYgt5+AFhmo
         Obf4Yx/kEp1t++S22p6u4pT+U+sS3C0cP2E+uVe6y0LNDaIWElH1O5y2hcHgF51+5up/
         QT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U0lCvIlLwdimjOUyxDjpipe79OvK/WADTE68Gfk88tk=;
        b=UB0WD9Q9XGoMb8vhpn/gmBb1EInga3li03QnLJKuMmXDjPfsMxz7hxg42229Qj6pR5
         8ugUiUmafJr0mm3L6UhZfjZrUMArwOujmF32Ek3KTIkrrR0QJ4d69Ykku6uO2FczO5nq
         1FxgJTQ1/uumCs2I8Yd/GhnhQYlNUtT9X8MTiUThQJpR7+rSnOkLfzxz+B2X+oDX4fkw
         fuubZhCGnCJ282THxooXbWagzK8aDcNRDtDF+G4f8/VSZyAJxmv7EZeHvT/A3tO1j0qO
         hyjMU/Pi2KIP50S2kuD4LTOr8FDipZ8USA+2goR8p8zw9BOL3BsixIQl4L9Pxh4L02YW
         mB3A==
X-Gm-Message-State: AOAM533AxrcldgTjAzAWl8vTq8xZ7uOmRGDXyAdeYxBu4r22iw60DcYd
        H9MVPHZWRNuHPHt8n7+aas63N/VMV2M=
X-Google-Smtp-Source: ABdhPJwUUnqSj4cF8vzR8jkdIbWDBqUEyLnATy4KxSa7TUXigtZznJyzTYgDiuYhPg6GnMkPWB4aYQ==
X-Received: by 2002:a1c:e918:: with SMTP id q24mr37272800wmc.108.1638193669715;
        Mon, 29 Nov 2021 05:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm14452593wmc.7.2021.11.29.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:47:49 -0800 (PST)
Message-Id: <d5ecfca9d2ccf820ac21823bec490e901ff1fa08.1638193666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 13:47:46 +0000
Subject: [PATCH 2/2] t/t*: remove custom GIT_TRACE2_EVENT_NESTING
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change modified GIT_TRACE2_EVENT_NESTING by default within
test-lib.sh. These custom assignments throughout the test suite are no
longer necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 t/t4216-log-bloom.sh                     | 2 --
 t/t5310-pack-bitmaps.sh                  | 2 +-
 t/t5705-session-id-in-capabilities.sh    | 2 --
 t/t7519-status-fsmonitor.sh              | 2 +-
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 16fbd2c6db9..2de957905b0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -688,7 +688,7 @@ test_expect_success 'submodule handling' '
 test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -C sparse-index -c core.fsmonitor="" reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
@@ -702,10 +702,10 @@ ensure_not_expanded () {
 	then
 		shift &&
 		test_must_fail env \
-			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 			git -C sparse-index "$@" || return 1
 	else
-		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 			git -C sparse-index "$@" || return 1
 	fi &&
 	test_region ! index ensure_full_index trace2.txt
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 50f206db550..8018c12a6a4 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -175,13 +175,11 @@ test_expect_success 'persist filter settings' '
 	test_when_finished rm -rf .git/objects/info/commit-graph* &&
 	rm -rf .git/objects/info/commit-graph* &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
-		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
 	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
-		GIT_TRACE2_EVENT_NESTING=5 \
 		git commit-graph write --reachable --changed-paths &&
 	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index dcf03d324a2..9104e842621 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup writing bitmaps during repack' '
 '
 
 test_expect_success 'full repack creates bitmaps' '
-	GIT_TRACE2_EVENT_NESTING=4 GIT_TRACE2_EVENT="$(pwd)/trace" \
+	GIT_TRACE2_EVENT="$(pwd)/trace" \
 		git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
 	test_line_count = 1 output &&
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index eb8c79aafdd..ed38c76c290 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -32,7 +32,6 @@ do
 		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
-		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
 		git -c protocol.version=$PROTO -C local push \
 			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
@@ -65,7 +64,6 @@ do
 		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
-		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
 		git -c protocol.version=$PROTO -C local push \
 			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index f488d930dfd..a5e2233cb19 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -390,7 +390,7 @@ test_expect_success 'status succeeds after staging/unstaging' '
 # during a call to 'git status'. Otherwise, we verify that we _do_ call it.
 check_sparse_index_behavior () {
 	git -C full status --porcelain=v2 >expect &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -C sparse status --porcelain=v2 >actual &&
 	test_region $1 index ensure_full_index trace2.txt &&
 	test_region fsm_hook query trace2.txt &&
-- 
gitgitgadget

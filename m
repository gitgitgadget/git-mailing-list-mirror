Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E7C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjAaNaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjAaN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD604B76D
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12459438wma.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foPdSOP1k+3PLwuXXDyn4B/taHtg4WPtOdzuqttAkSY=;
        b=lhxQ/bDE+f513zwtcb1nIsm0cFLiRln/IQN1m74JKbsSs8RxIsN+EG/RSus4q9zZT/
         MTxQ/F5iksnS3npa5kpPsBGLZ8/UJahS3brmwm5iAGwMFa7A0PY0aWpfvAN8hY3jgjZE
         PQ5wkj4plgNRGU+ZGKHMxFWrKcLN2SiR0uzEcoOTkdZy20aAe4+fT9l0i5y7admLQg2l
         FtktbNS/UXrc0T1FEv8PsjyhIo4uJ841q6UURd07QJwEt4C4F8ACo2VP+zNTeCx2KdAQ
         wlTaKnnXsmYHZMyzC32JrKKexmIPQJ2GXi21G/evwFYmFRawkqSjOXHFR6c7Rvj0GPjH
         GvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foPdSOP1k+3PLwuXXDyn4B/taHtg4WPtOdzuqttAkSY=;
        b=E7h90SqHaJd8JfiAtNq9agpz6cre8QoOihSrd9dC1ma+JFeTuFYik3TW8I/HkxAR1M
         rnLtF7K1Uw79wuMKYbisWUkgkUWHe9zxm0AbW01LKdWOXkUyQDbUuDQW93/gCo8npf3w
         fdwnOgFPyROTFVI6u/Dp9pfodI+KQRrRN3dp3fBiVA41WdZ8wCVRtjvns2409cHVFd7i
         ODlhG01eGOAs+n4694PpFEd02tzU2TkdSyeofAbASOCvdcFF0IljwFk0wRODRWfPOJWh
         vpNnM9GHmUMhpNGTqv1fjRT46ifIVD8yVnPNcwxWLRsl1KU9h5cgoJIaWKTzlOIP2oCh
         K9xA==
X-Gm-Message-State: AFqh2koo9LZ61ynv6nNVWyWXUSKV9iabLIfgQjq8WLXib9EAwWLMFZ1I
        IjudFmRJ8EENFVbSof8irlhqtggsBBU=
X-Google-Smtp-Source: AMrXdXs1SaRd5GnhksVYE9SQS65n2icyCx4fSesZjIUJkhTpJwJoLdfJElLEupuzAEpvh8UIoTz1bQ==
X-Received: by 2002:a05:600c:1c9d:b0:3da:db4:6105 with SMTP id k29-20020a05600c1c9d00b003da0db46105mr54537562wms.37.1675171770821;
        Tue, 31 Jan 2023 05:29:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003dc49e0132asm10470109wmr.1.2023.01.31.05.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:30 -0800 (PST)
Message-Id: <c968b63febab41f1f665910a103fcec56fac0a59.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:19 +0000
Subject: [PATCH v3 11/11] bundle-uri: test missing bundles with heuristic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The creationToken heuristic uses a different mechanism for downloading
bundles from the "standard" approach. Specifically: it uses a concrete
order based on the creationToken values and attempts to download as few
bundles as possible. It also modifies local config to store a value for
future fetches to avoid downloading bundles, if possible.

However, if any of the individual bundles has a failed download, then
the logic for the ordering comes into question. It is important to avoid
infinite loops, assigning invalid creation token values in config, but
also to be opportunistic as possible when downloading as many bundles as
seem appropriate.

These tests were used to inform the implementation of
fetch_bundles_by_token() in bundle-uri.c, but are being added
independently here to allow focusing on faulty downloads. There may be
more cases that could be added that result in modifications to
fetch_bundles_by_token() as interesting data shapes reveal themselves in
real scenarios.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5558-clone-bundle-uri.sh | 400 ++++++++++++++++++++++++++++++++++++
 1 file changed, 400 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 9c2b7934b9b..afd56926c53 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -618,6 +618,406 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual
 '
 
+test_expect_success 'creationToken heuristic with failed downloads (clone)' '
+	test_when_finished rm -rf download-* trace*.txt &&
+
+	# Case 1: base bundle does not exist, nothing can unbundle
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = fake.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone-1.txt" \
+	git clone --single-branch --branch=base \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" download-1 &&
+
+	# Bundle failure does not set these configs.
+	test_must_fail git -C download-1 config fetch.bundleuri &&
+	test_must_fail git -C download-1 config fetch.bundlecreationtoken &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-2.bundle
+	$HTTPD_URL/fake.bundle
+	EOF
+	test_remote_https_urls <trace-clone-1.txt >actual &&
+	test_cmp expect actual &&
+
+	# All bundles failed to unbundle
+	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	test_must_be_empty refs &&
+
+	# Case 2: middle bundle does not exist, only two bundles can unbundle
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = fake.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone-2.txt" \
+	git clone --single-branch --branch=base \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" download-2 &&
+
+	# Bundle failure does not set these configs.
+	test_must_fail git -C download-2 config fetch.bundleuri &&
+	test_must_fail git -C download-2 config fetch.bundlecreationtoken &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-4.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/fake.bundle
+	$HTTPD_URL/bundle-1.bundle
+	EOF
+	test_remote_https_urls <trace-clone-2.txt >actual &&
+	test_cmp expect actual &&
+
+	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
+	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-EOF &&
+	refs/bundles/base
+	refs/bundles/right
+	EOF
+	test_cmp expect refs &&
+
+	# Case 3: top bundle does not exist, rest unbundle fine.
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = fake.bundle
+		creationToken = 4
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-clone-3.txt" \
+	git clone --single-branch --branch=base \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" download-3 &&
+
+	# As long as we have continguous successful downloads,
+	# we _do_ set these configs.
+	test_cmp_config -C download-3 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
+	test_cmp_config -C download-3 3 fetch.bundlecreationtoken &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/fake.bundle
+	$HTTPD_URL/bundle-3.bundle
+	$HTTPD_URL/bundle-2.bundle
+	$HTTPD_URL/bundle-1.bundle
+	EOF
+	test_remote_https_urls <trace-clone-3.txt >actual &&
+	test_cmp expect actual &&
+
+	# fake.bundle did not unbundle, but the others did.
+	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/right
+	EOF
+	test_cmp expect refs
+'
+
+# Expand the bundle list to include other interesting shapes, specifically
+# interesting for use when fetching from a previous state.
+#
+# ---------------- bundle-7
+#       7
+#     _/|\_
+# ---/--|--\------ bundle-6
+#   5   |   6
+# --|---|---|----- bundle-4
+#   |   4   |
+#   |  / \  /
+# --|-|---|/------ bundle-3 (the client will be caught up to this point.)
+#   \ |   3
+# ---\|---|------- bundle-2
+#     2   |
+# ----|---|------- bundle-1
+#      \ /
+#       1
+#       |
+# (previous commits)
+test_expect_success 'expand incremental bundle list' '
+	(
+		cd clone-from &&
+		git checkout -b lefter left &&
+		test_commit 5 &&
+		git checkout -b righter right &&
+		test_commit 6 &&
+		git checkout -b top lefter &&
+		git merge -m "7" merge righter &&
+
+		git bundle create bundle-6.bundle lefter righter --not left right &&
+		git bundle create bundle-7.bundle top --not lefter merge righter &&
+
+		cp bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/"
+	) &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" fetch origin +refs/heads/*:refs/heads/*
+'
+
+test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
+	test_when_finished rm -rf download-* trace*.txt &&
+
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+	EOF
+
+	git clone --single-branch --branch=left \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" fetch-base &&
+	test_cmp_config -C fetch-base "$HTTPD_URL/bundle-list" fetch.bundleURI &&
+	test_cmp_config -C fetch-base 3 fetch.bundleCreationToken &&
+
+	# Case 1: all bundles exist: successful unbundling of all bundles
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+
+	[bundle "bundle-6"]
+		uri = bundle-6.bundle
+		creationToken = 6
+
+	[bundle "bundle-7"]
+		uri = bundle-7.bundle
+		creationToken = 7
+	EOF
+
+	cp -r fetch-base fetch-1 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-fetch-1.txt" \
+		git -C fetch-1 fetch origin &&
+	test_cmp_config -C fetch-1 7 fetch.bundlecreationtoken &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-7.bundle
+	$HTTPD_URL/bundle-6.bundle
+	$HTTPD_URL/bundle-4.bundle
+	EOF
+	test_remote_https_urls <trace-fetch-1.txt >actual &&
+	test_cmp expect actual &&
+
+	# Check which bundles have unbundled by refs
+	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/lefter
+	refs/bundles/merge
+	refs/bundles/right
+	refs/bundles/righter
+	refs/bundles/top
+	EOF
+	test_cmp expect refs &&
+
+	# Case 2: middle bundle does not exist, only bundle-4 can unbundle
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+
+	[bundle "bundle-6"]
+		uri = fake.bundle
+		creationToken = 6
+
+	[bundle "bundle-7"]
+		uri = bundle-7.bundle
+		creationToken = 7
+	EOF
+
+	cp -r fetch-base fetch-2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-fetch-2.txt" \
+		git -C fetch-2 fetch origin &&
+
+	# Since bundle-7 fails to unbundle, do not update creation token.
+	test_cmp_config -C fetch-2 3 fetch.bundlecreationtoken &&
+
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/bundle-7.bundle
+	$HTTPD_URL/fake.bundle
+	$HTTPD_URL/bundle-4.bundle
+	EOF
+	test_remote_https_urls <trace-fetch-2.txt >actual &&
+	test_cmp expect actual &&
+
+	# Check which bundles have unbundled by refs
+	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	refs/bundles/right
+	EOF
+	test_cmp expect refs &&
+
+	# Case 3: top bundle does not exist, rest unbundle fine.
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+
+	[bundle "bundle-4"]
+		uri = bundle-4.bundle
+		creationToken = 4
+
+	[bundle "bundle-6"]
+		uri = bundle-6.bundle
+		creationToken = 6
+
+	[bundle "bundle-7"]
+		uri = fake.bundle
+		creationToken = 7
+	EOF
+
+	cp -r fetch-base fetch-3 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-fetch-3.txt" \
+		git -C fetch-3 fetch origin &&
+
+	# As long as we have continguous successful downloads,
+	# we _do_ set the maximum creation token.
+	test_cmp_config -C fetch-3 6 fetch.bundlecreationtoken &&
+
+	# NOTE: the fetch skips bundle-4 since bundle-6 successfully
+	# unbundles itself and bundle-7 failed to download.
+	cat >expect <<-EOF &&
+	$HTTPD_URL/bundle-list
+	$HTTPD_URL/fake.bundle
+	$HTTPD_URL/bundle-6.bundle
+	EOF
+	test_remote_https_urls <trace-fetch-3.txt >actual &&
+	test_cmp expect actual &&
+
+	# Check which bundles have unbundled by refs
+	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	cat >expect <<-EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/lefter
+	refs/bundles/right
+	refs/bundles/righter
+	EOF
+	test_cmp expect refs
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3042C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiKPTwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiKPTvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869185986F
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso2262413wmp.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DehlC/Za5CApBqVxDQr2OvqcFiarvPgr2QlY3Yv5sQI=;
        b=hk9jWIxih9UXPsC50p0E9YpgnOW53TNbgH/5x55oXkrTUok6/GhFipqtIuxw7cWO/P
         sQdOIZGxJQzeQ6J3f0CD62kX+8uL3tlf/x3FuHx6ThTtPTkWHU/k+bjGTRrRoYhxcpJf
         9XLwCieMyPaBUiaO9Y7BQH52TDBspzAsqK9CSDRnKdM1qamiDvaWf+ohKgtIBQsxTUUy
         fxEjc1JUdDYRxBI7O7BYzG6njaxjUS9Aljc0eNTcKE8bHCkaYRUmqPXjw2Gubq1pS2Wq
         7tqdF5mKGEz6YkndmR5nt9p/NCoz5esvkAQheceWhuKBLs+ZxqHVaw1yrrgK85pd7wA0
         GTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DehlC/Za5CApBqVxDQr2OvqcFiarvPgr2QlY3Yv5sQI=;
        b=puEe9eV7tesL2tcNG09OOm8qV6K78KSKG2Yk5XlvcM3OtaVoof/ISCJ4BwDeoAj9NX
         KsvUSL3OTA2A5CSaL4mY5HYwxYGcv/BAy8g1vaxY/4Buwxcb6e+oHrA1Dz/lZSvp8HSg
         O9TlgFsWsqOwvGeSwLkMIjciio5aFXjFbpPMMbmKukJjOK+x/Kb5u99I+MVXVXux2h8f
         R0LXPJ9vEmXyKrJfHmDzAzkIteapj9euT0D3R2tK4L3LaNQSjMoL2EQE/mQlh7puEnTU
         0g8e0SyJm/SPtCITc7c0d7IbgUgb4jBebn55F6Vd2MzZ0aoIPXTASc5vfp+kC5NcASoR
         JNug==
X-Gm-Message-State: ANoB5pky8DmJoRqW6wpwtxyEQo4drONTqPVAqJCj9vPuua1QMfIF6iIg
        hDVKkEtzC8v3LpQMuuGYNIdIzrLeQMo=
X-Google-Smtp-Source: AA0mqf4HpLa/4f3LD4BbXjSbD3piEt315rn3ubWu2txlyMrjuj44o8QNsRJCKteqd4ONaxDOyabGdg==
X-Received: by 2002:a05:600c:1e85:b0:3cf:84be:aaf9 with SMTP id be5-20020a05600c1e8500b003cf84beaaf9mr3125551wmb.111.1668628311832;
        Wed, 16 Nov 2022 11:51:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm15872505wrf.55.2022.11.16.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:51 -0800 (PST)
Message-Id: <b62b4b1748194f0c7b81536701f15aa0df8e1d9b.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:42 +0000
Subject: [PATCH v2 9/9] clone: unbundle the advertised bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change introduced the transport methods to acquire a bundle
list from the 'bundle-uri' protocol v2 command, when advertised _and_
when the client has chosen to enable the feature.

Teach Git to download and unbundle the data advertised by those bundles
during 'git clone'.

Also, since the --bundle-uri option exists, we do not want to mix the
advertised bundles with the user-specified bundles.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c  | 26 +++++++++++++++++----
 t/t5601-clone.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 22b1e506452..09f10477ed6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1267,11 +1267,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-	/*
-	 * Populate transport->got_remote_bundle_uri and
-	 * transport->bundle_uri. We might get nothing.
-	 */
-	transport_get_remote_bundle_uri(transport, 1);
+	if (!bundle_uri) {
+		/*
+		* Populate transport->got_remote_bundle_uri and
+		* transport->bundle_uri. We might get nothing.
+		*/
+		transport_get_remote_bundle_uri(transport, 1);
+
+		if (transport->bundles &&
+		    hashmap_get_size(&transport->bundles->bundles)) {
+			/* At this point, we need the_repository to match the cloned repo. */
+			if (repo_init(the_repository, git_dir, work_tree))
+				warning(_("failed to initialize the repo, skipping bundle URI"));
+			if (fetch_bundle_list(the_repository,
+					      remote->url[0],
+					      transport->bundles))
+				warning(_("failed to fetch advertised bundles"));
+		} else {
+			clear_bundle_list(transport->bundles);
+			FREE_AND_NULL(transport->bundles);
+		}
+	}
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..d1d8139751e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -795,6 +795,65 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
 
+test_expect_success 'auto-discover bundle URI from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo2 "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo2.git repo2 &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
+test_expect_success 'auto-discover multiple bundles from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo3 "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	test_commit -C src new &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/new.bundle" HEAD~1..HEAD &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.mode all &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.new.uri "$HTTPD_URL/new.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo3.git repo3 &&
+
+	# We should fetch _both_ bundles
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/new.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget

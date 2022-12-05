Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819EBC47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLERwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiLERvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033E657B
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n7so9345020wms.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGfncvEIZ1IJH1viufNLa/kn8K2n+QVCVUQHa5ASzVU=;
        b=e0bX4kSgvzNpeZHLAyHP0dtVCkbpNaGexhfzAUMBloO2kcYC1JSyGBfMbP1ZIwZxm4
         ZiXmYR3+//89Nvkzzr3Y20pMcq7csta7EvmlTLIaPHXk8KOR5DYRS6WHo18+8ehGjXgS
         ES9FC2o2uEdNQzvyX4fMl895O/+N0t3D4IZFltQ09zBznpK3dZFtqPeQ7/ft7iuoL/0Y
         0GuN8BpJL0fj+NziA7L72xE9symqZvD48m97qtkQosBuUeWEks9LMpTKyhjt8vEOP1OO
         fRi+w2z2B75RyW2bgYaeTPe6/3tOMQeRMMu+i7LryPRTWehLEMhXpoZRRELXknSz1LzC
         ocXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGfncvEIZ1IJH1viufNLa/kn8K2n+QVCVUQHa5ASzVU=;
        b=Gi+hyOtJs+Z1M9B6FNw1sFNjmfNgrY1bPE9u3+TcEnZPgqSJx4/2lt6788piinOECm
         hKCqxO9teRT4Ri8DX46ynP1YFjuvjWRDeAccgWgCYHd6HzG5Yk57NJWTJNlVDwLCtJmj
         kOsXzUoRM1bTO5u15m4RnaE6a2+59ujSAHCRANNviH8Li0sfW3No5D70fjN3rQDl1ETI
         WfZ4x1eM0f7e3FKqHrPEB5Y0NUmkElro8uDLXRtcVr5UBKFAXCT6KOIF7X9FZAOdo6rI
         VDEsbg45Q0xQjlTrypjwSZyJr7JSzbGHmMOmB1yj8JuV0xr8yYTlZhbcKTFBZ/TDLsbZ
         Fimg==
X-Gm-Message-State: ANoB5pmk8kOdWoJ94GOQmAewVFeFxPtgpbdAhHheD7oD0Li1UEaq5Fg3
        TcTITsDj8HpUCYvYHUnxVntSYBtZAM4=
X-Google-Smtp-Source: AA0mqf6ewFrPMqhHcUo1zTEGJ4iSLwnsvJzQXt2u5klt2N5/j+/wf9DDyTaPnG0HTU60CqCtQNoFOA==
X-Received: by 2002:a05:600c:1c1b:b0:3d1:f04:d1db with SMTP id j27-20020a05600c1c1b00b003d10f04d1dbmr6073073wms.44.1670262650857;
        Mon, 05 Dec 2022 09:50:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c424800b003c5571c27a1sm21468011wmm.32.2022.12.05.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:50 -0800 (PST)
Message-Id: <7e1819162b6129371168d89dd60a1bd3cb7de299.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:39 +0000
Subject: [PATCH v3 11/11] clone: unbundle the advertised bundles
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
 builtin/clone.c              | 26 +++++++++++++---
 t/lib-bundle-uri-protocol.sh | 21 +++++++++++--
 t/t5601-clone.sh             | 59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 39364c25b15..af8b2a4df66 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,11 +1266,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-	/*
-	 * Populate transport->got_remote_bundle_uri and
-	 * transport->bundle_uri. We might get nothing.
-	 */
-	transport_get_remote_bundle_uri(transport);
+	if (!bundle_uri) {
+		/*
+		* Populate transport->got_remote_bundle_uri and
+		* transport->bundle_uri. We might get nothing.
+		*/
+		transport_get_remote_bundle_uri(transport);
+
+		if (transport->bundles &&
+		    hashmap_get_size(&transport->bundles->bundles)) {
+			/* At this point, we need the_repository to match the cloned repo. */
+			if (repo_init(the_repository, git_dir, work_tree))
+				warning(_("failed to initialize the repo, skipping bundle URI"));
+			else if (fetch_bundle_list(the_repository,
+						   remote->url[0],
+						   transport->bundles))
+				warning(_("failed to fetch advertised bundles"));
+		} else {
+			clear_bundle_list(transport->bundles);
+			FREE_AND_NULL(transport->bundles);
+		}
+	}
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 6d3f871fa0f..73e2d45bc8b 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -85,7 +85,7 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 '
 
 test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
-	test_when_finished "rm -rf log cloned cloned2" &&
+	test_when_finished "rm -rf log* cloned*" &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
 	GIT_TEST_BUNDLE_URI=0 \
@@ -117,7 +117,24 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	grep "< bundle-uri" log &&
 
 	# Client issued bundle-uri command
-	grep "> command=bundle-uri" log
+	grep "> command=bundle-uri" log &&
+
+	GIT_TRACE_PACKET="$PWD/log3" \
+	git \
+		-c transfer.bundleURI=true \
+		-c protocol.version=2 \
+		clone --bundle-uri="$BUNDLE_URI_BUNDLE_URI" \
+		"$BUNDLE_URI_REPO_URI" cloned3 \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log3 &&
+
+	# Server advertised bundle-uri capability
+	grep "< bundle-uri" log3 &&
+
+	# Client did not issue bundle-uri command (--bundle-uri override)
+	! grep "> command=bundle-uri" log3
 '
 
 test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
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

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857CAC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiLVPPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiLVPOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4838A7
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so1954247wrh.7
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St9c68m1U2pVma0sTvdcQQataF+S+J7SYqQBoIWNBDw=;
        b=dlLYd+dwQKZnLvrUPcbTAXeGXl6oyMs64jzTrfllSbJAts7Zz6UjPTixy4piBFAgvB
         0cps7OfMUgcV2w34ntOF2z/aPlqvnntxzHPsHWUD/v8fOgjOBQ1Qm2eqh6CVfUmTwUL4
         jR3SbtnMR4ZsSlCwQKIDuAJCSJE6rz9fOJFvCMv+xSAj2gPYcK0rCWKYdPUnguNc/9Ag
         +C0yRomDqeFw/WKIwI55nXUkFjFZp+eOsxbsu2QxU5k1OY0Rchhvq18PNKsJRDUxvaGH
         2ACypQhX8YiMd4Ej0fKBLzF67BBtZko7+A5j/Paqbrh00J8S+g0VkY9NwH/FWocTuIMx
         opbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St9c68m1U2pVma0sTvdcQQataF+S+J7SYqQBoIWNBDw=;
        b=nFEQ9PeTVuH59thjq+BTdIwEB/IrGXclqPkA+oejEMFqyT/Y6tRNzXHh5c73lP1aCF
         WbxGy1Wv39olydYRhtxYUxM5qxpORCv7ieQMWLdfKLuPz/Nfm51tckqdSkL5a8bV9EGG
         Qp2iM4uHTiN2srEdGfd+JJMAXz7zzlmkTtu0g/w0UvONuXGDPXJLx1lveD1dVB280+/X
         w4bpJQgcm/UMApEWjvhVCyQDdE4QtEQJcG2wGodaD/BRstUa03jrhzL3LCWo0VM5D/fQ
         PTo18lI/EsFsImmfXvG342mwA3YIZxjFzGpK6sAKO3oacWJFJygJ53vzFk2o//jpd4iq
         FXXg==
X-Gm-Message-State: AFqh2koB00qHnbxxY5Ix7IlJHCZtGv4arZERzU5O5d8b+Lq7EUPqDbZc
        AAvUIPZEJzVhD+Ls/Fzs256yq6rX7wE=
X-Google-Smtp-Source: AMrXdXtJ4JxuUKqzgy1W6G8EXzROv0/F45l1OLr167D5C+3Il4TnD8WmdohrBYRLdAqr1t+i1qzcww==
X-Received: by 2002:a05:6000:1e0a:b0:242:67f2:9af7 with SMTP id bj10-20020a0560001e0a00b0024267f29af7mr4080495wrb.69.1671722068755;
        Thu, 22 Dec 2022 07:14:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020adfec02000000b0025e86026866sm1070035wrn.0.2022.12.22.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:28 -0800 (PST)
Message-Id: <46ab2b05b1559bf289d28ab3353ea9cecf84875d.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:17 +0000
Subject: [PATCH v4 11/11] clone: unbundle the advertised bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change introduced the transport methods to acquire a bundle
list from the 'bundle-uri' protocol v2 command, when advertised _and_
when the client has chosen to enable the feature.

Teach Git to download and unbundle the data advertised by those bundles
during 'git clone'. This takes place between the ref advertisement and
the object data download, and stateful connections will linger while
the client downloads bundles. In the future, we should consider closing
the remote connection during this process.

Also, since the --bundle-uri option exists, we do not want to mix the
advertised bundles with the user-specified bundles.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c              | 25 ++++++++++++---
 t/lib-bundle-uri-protocol.sh | 21 +++++++++++--
 t/t5601-clone.sh             | 59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 39364c25b15..527839662b0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,11 +1266,26 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
index 3022ea4a95b..a4a1af8d029 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -85,7 +85,7 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 '
 
 test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
-	test_when_finished "rm -rf log cloned cloned2" &&
+	test_when_finished "rm -rf log* cloned*" &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
 	git \
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
 
 # The remaining tests will all assume transfer.bundleURI=true
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..00d4fae5136 100755
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
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 \
+		    -c transfer.bundleURI=true clone \
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
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 \
+		    -c transfer.bundleURI=true clone \
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

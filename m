Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8111AC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLERwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiLERvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8DB55A3
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l26so3118465wms.4
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9sGu4mNVPiGzjCsbbEkFX5eqQNP2vNJY/ftRlETupo=;
        b=PpTJDRAvDEAQ6yBbAbYxrrCiwJax6lRBp3zCGeOQb0axs+jwpZy+ycBSe2E+Z9f9Zl
         NN5ujuzYh6SRGfbpJvGg9+qYq84cwBt0ao5Ook0fOK9TXmX708M60d8JrJELl5qct028
         3FAaGfGhISE37y0NFCZMaPZsDk3iBQJ0aqRMNNP8WN2mjoc094G//M11FmXGOjWN+Osq
         rKX+LvWuSA77p9ycLLgA/s7ST2g93gRY1yB8Dxbq4oh3gI3cN+dsAAEVT1MyFqxoUkUu
         MLPw2eyNZ/3QZ8MPLl6mD/W+07ivTIfpP2+8po168pB65Wohc4uXkcFuKZNMPCn//L1e
         j2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9sGu4mNVPiGzjCsbbEkFX5eqQNP2vNJY/ftRlETupo=;
        b=CLRwsyxiWle0ic3VLe33MShdG0AJQ13/8RQceXbzIzw4UwzNCSKWtKM5KQEBsNdoTR
         LAe2Al/glEVlkbGaS7zZo8ffXJIQfzhyQu68bQu3j2MCVRa20OvahDNBJEDEaWNS2RcL
         gPm4S/LImHPgeHFliflmCaAFolRZRE1YeKxj71JOVw0xZ3TB58GD+05MkBDDHRfDbOLQ
         0xPByYsu1KM5+QH9nBWDG2Mg0WJklZtjkj06EKuzE5BA67bYgtlXystffrKcCZgUIZUI
         hRq1QQqYA9TK6ZYBvC5/j1MxZhogBDwrpQbwB3oxGOSOuAlEgNh4yPpc45fpm2amnIhR
         4Rkg==
X-Gm-Message-State: ANoB5pkYDlmsQFpH3Hu4pySrJfzEW8gvxp41P6fuSrSpR4RvhAAokRLG
        nIrQO7zSDiHkoMaaBlL7OdE1MlGcADI=
X-Google-Smtp-Source: AA0mqf7YTN3rj+1XmprmN4S2Z0wZlgzzVjRr8T5wtviO+np6xzRlSkbZw3xHcudZxE9hWZVbeMgkfg==
X-Received: by 2002:a05:600c:1e0f:b0:3cf:e9a4:3261 with SMTP id ay15-20020a05600c1e0f00b003cfe9a43261mr65589428wmb.41.1670262644634;
        Mon, 05 Dec 2022 09:50:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d424b000000b00241cfe6e286sm15186020wrr.98.2022.12.05.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:44 -0800 (PST)
Message-Id: <e46118e60f7a59ef25edf5f1378b4ef0c007cce8.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:32 +0000
Subject: [PATCH v3 04/11] bundle-uri client: add boolean transfer.bundleURI
 setting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

The yet-to-be introduced client support for bundle-uri will always
fall back on a full clone, but we'd still like to be able to ignore a
server's bundle-uri advertisement entirely.

The new transfer.bundleURI config option defaults to 'false', but a user
can set it to 'true' to enable checking for bundle URIs from the origin
Git server using protocol v2.

To enable this setting by default in the correct tests, add a
GIT_TEST_BUNDLE_URI environment variable.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/transfer.txt |  6 ++++++
 t/lib-bundle-uri-protocol.sh      | 19 ++++++++++++++++++-
 transport.c                       |  9 +++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index 264812cca4d..c3ac767d1e4 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -115,3 +115,9 @@ transfer.unpackLimit::
 transfer.advertiseSID::
 	Boolean. When true, client and server processes will advertise their
 	unique session IDs to their remote counterpart. Defaults to false.
+
+transfer.bundleURI::
+	When `true`, local `git clone` commands will request bundle
+	information from the remote server (if advertised) and download
+	bundles before continuing the clone through the Git protocol.
+	Defaults to `false`.
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index d44c6e10f9e..77bfd4f0119 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -85,9 +85,10 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 '
 
 test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
-	test_when_finished "rm -rf log cloned" &&
+	test_when_finished "rm -rf log cloned cloned2" &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
+	GIT_TEST_BUNDLE_URI=0 \
 	git \
 		-c protocol.version=2 \
 		clone "$BUNDLE_URI_REPO_URI" cloned \
@@ -99,6 +100,22 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	# Server advertised bundle-uri capability
 	grep "< bundle-uri" log &&
 
+	# Client did not issue bundle-uri command
+	! grep "> command=bundle-uri" log &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c transfer.bundleURI=true \
+		-c protocol.version=2 \
+		clone "$BUNDLE_URI_REPO_URI" cloned2 \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep "< bundle-uri" log &&
+
 	# Client issued bundle-uri command
 	grep "> command=bundle-uri" log
 '
diff --git a/transport.c b/transport.c
index b6f279e92cb..9f9e38d66dd 100644
--- a/transport.c
+++ b/transport.c
@@ -1516,6 +1516,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 int transport_get_remote_bundle_uri(struct transport *transport)
 {
+	int value = 0;
 	const struct transport_vtable *vtable = transport->vtable;
 
 	/* Check config only once. */
@@ -1523,6 +1524,14 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 		return 0;
 	transport->got_remote_bundle_uri = 1;
 
+	/*
+	 * Don't request bundle-uri from the server unless configured to
+	 * do so by GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
+	 */
+	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
+	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
+		return 0;
+
 	if (!vtable->get_bundle_uri)
 		return error(_("bundle-uri operation not supported by protocol"));
 
-- 
gitgitgadget


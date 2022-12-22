Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3996C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiLVPOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiLVPO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27494FE2
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so1626648wmb.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U8zfWN47or1CWj7YTDiNX6qhV2CR343X60qq8TUyW4=;
        b=Kr7G1DMLEsCV7Aa2Uyg/xKYc/YEqY5FNKQbKNA0MpHYPsr0LBjy4oxrg97Sc4uJDlR
         NzdgN/enNWyMWO37vz2D8GXwYLVhNV6EwGSGa2IdwO/CSqq4XC+AoU+Hq0MD+Kltha6Z
         SmSnRnQdxpAsoq1oEAgmhR+hOUZVHitY6INJcglX2VixLNpLd/wmheQPwRP1pjFiGm9h
         rG3siwGpQAvdNfIb/hIYZxh0dSfg3EWTA6BYpIXGY1u59ov1Jq6bDHLjbljHXttT+Scd
         +uQfWPfq5o9ukqBIN2XrfWFUjPvuKBuZhwiCAYBabvwadYIRxkHOmIqIxQiDbWT0HsF/
         f8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U8zfWN47or1CWj7YTDiNX6qhV2CR343X60qq8TUyW4=;
        b=s52geKItygIYC51T+va0wRi+c7PJZ4zYCb7zK0HSEcUeI6F59SotrlYxunx6zFIQaT
         FK+SZyDUplZOoJKGMYEPWQu0i0HhpzBriOwrnzCNDk8e3bYaJn8Z5mGDZfcJoLR8eYjo
         KH0H3ipZSPbzatT6YlYLqYhKNT1dLWmaR0u3N5XkTD37ejqmBnqezSCfwfC5T4UnXZQG
         BZY3LVSamqjjepODOT5pe4sB9l+D0P1rlOkFpLJ+/0aMEzt+PbLjGizgsDU8M/hwBgHC
         A0GwuJP7yaN7cMGMH58Q7EMM2LzkSBuwNEFg+WvCi4eSqeLETrhpGgJGd+IAc8CbAp2F
         5gaA==
X-Gm-Message-State: AFqh2kpUyC0s8tp5VEOcyD3+QZLtYOr6BXUQfLBHhweOUCsesoqrtX9C
        dHrpr7J8eFGv6tC5scj4UcI/ESdGQf0=
X-Google-Smtp-Source: AMrXdXvK6XfhauN0xjiF8blgQdwEsoXI6WKRmzGy+PTbS0ySGvni/MtyuKbAedvKqkaziN0o3D0YUw==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr4679516wms.3.1671722063385;
        Thu, 22 Dec 2022 07:14:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003c6f3f6675bsm6770532wmq.26.2022.12.22.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:23 -0800 (PST)
Message-Id: <876dd3f221fe575dc0407983e15280de4e9e18e0.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:10 +0000
Subject: [PATCH v4 04/11] bundle-uri client: add boolean transfer.bundleURI
 setting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
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

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/transfer.txt |  6 ++++++
 t/lib-bundle-uri-protocol.sh      | 19 ++++++++++++++++++-
 transport.c                       |  8 ++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

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
index d44c6e10f9e..75ea8c4418f 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -85,10 +85,11 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 '
 
 test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
-	test_when_finished "rm -rf log cloned" &&
+	test_when_finished "rm -rf log cloned cloned2" &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
 	git \
+		-c transfer.bundleURI=false \
 		-c protocol.version=2 \
 		clone "$BUNDLE_URI_REPO_URI" cloned \
 		>actual 2>err &&
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
index b6f279e92cb..b4cf2c0252e 100644
--- a/transport.c
+++ b/transport.c
@@ -1516,6 +1516,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 int transport_get_remote_bundle_uri(struct transport *transport)
 {
+	int value = 0;
 	const struct transport_vtable *vtable = transport->vtable;
 
 	/* Check config only once. */
@@ -1523,6 +1524,13 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 		return 0;
 	transport->got_remote_bundle_uri = 1;
 
+	/*
+	 * Don't request bundle-uri from the server unless configured to
+	 * do so by the transfer.bundleURI=true config option.
+	 */
+	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
+		return 0;
+
 	if (!vtable->get_bundle_uri)
 		return error(_("bundle-uri operation not supported by protocol"));
 
-- 
gitgitgadget


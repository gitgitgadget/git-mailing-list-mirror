Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A13FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKABH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKABHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF31659C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso9078330wmq.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLooz02+SsovFOZcXwMGlFj9MxU6sRX+bGtaH84Oqg8=;
        b=OrKSGtCa3mJBYad3UE0XGbzkR8zDjwk/Je+7tO6MXsiGbfvtyJxfVRucocaUeoBWAF
         rKJIc7BeFXe/xVjkEA2ACSiynOCivE1KDA1flG+Wi9L0cNuYew2GTQ1l9Ho64VWjVxc+
         /XIWjJtZNtnbwX4gAVuV1UxFMVJ1z/G7fAXGdR8/JOAh6Fc9yMSjn65HfSO5WdTXPcDo
         KEu/QnnTeWTNqZqP63MlLMxYzpLj9ArtqdDuVg1S8RUjfRSFnuKTS1bFdJmdrYihzrDZ
         BOAG7DLl6LHgs7PycCGiCsuDaCJZNutUtNoyL0zVEMQx0IO5ffYTmPdbDMipDssUaKTV
         +MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLooz02+SsovFOZcXwMGlFj9MxU6sRX+bGtaH84Oqg8=;
        b=QWsUqntBtcXDo0ytGIkp8igzPBPpSeEnnqYjlLXTcrPAhf2qBQsohdyaPdxb4rDEme
         TduB7TX2wdmeD/rKLX7Ql1yVjheRO7QjQhiaXdqrMjTbaymfuOKP0z3rC7cNztNjOi4O
         7PekNjO3Ir0wGY6SLhO10XL9swRD9rdR8+qtyx/9cBh/rg0H34gNHi+Lw7XciekLPFSY
         y4b1xIBu60CqSrQe/VibHutZwU79NV2t3xszcGfcWVLJTeRtKxC3vztNXDaf/4M+VuHL
         DQ8ox2GVzjAOsNxpdOqGQd6QPexUCaFhFC2kOHb52I+Dzr/H/vzZPCzaQMNSXEznVYAF
         /sSw==
X-Gm-Message-State: ACrzQf1zcb+3bKzfzL79xCujDjFl/k+y/Iei27BiVL2OfysHRQU+fuRQ
        f6dGI5vtE6jWvi7E/pkwaYhRPCYYcvM=
X-Google-Smtp-Source: AMsMyM4fVlqjvMT38TewIMkx9HAagxSzwEAEsmjIm+SH1TheijpIcgBGB7PlZiuAV9nU0VxtAUMmmQ==
X-Received: by 2002:a05:600c:15c9:b0:3cf:6054:3b3b with SMTP id v9-20020a05600c15c900b003cf60543b3bmr12495092wmf.167.1667264860139;
        Mon, 31 Oct 2022 18:07:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b0023657e1b97esm8544447wru.11.2022.10.31.18.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:39 -0700 (PDT)
Message-Id: <c877f7c033decc857bb58aff411faf6a27aa96d7.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:30 +0000
Subject: [PATCH 5/9] bundle-uri client: add boolean transfer.bundleURI setting
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
 Documentation/config/transfer.txt     |  6 ++++++
 t/lib-t5730-protocol-v2-bundle-uri.sh |  3 +++
 transport.c                           | 10 +++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

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
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index 000fcc5e20b..872bc39ad1b 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -1,5 +1,8 @@
 # Included from t573*-protocol-v2-bundle-uri-*.sh
 
+GIT_TEST_BUNDLE_URI=1
+export GIT_TEST_BUNDLE_URI
+
 T5730_PARENT=
 T5730_URI=
 T5730_BUNDLE_URI=
diff --git a/transport.c b/transport.c
index 86460f5be28..b33180226ae 100644
--- a/transport.c
+++ b/transport.c
@@ -1538,6 +1538,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
+	int value = 0;
 	const struct transport_vtable *vtable = transport->vtable;
 
 	/* Check config only once. */
@@ -1545,10 +1546,13 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 		return 0;
 
 	/*
-	 * This is intentionally below the transport.injectBundleURI,
-	 * we want to be able to inject into protocol v0, or into the
-	 * dialog of a server who doesn't support this.
+	 * Don't use bundle-uri at all, if configured not to. Only proceed
+	 * if GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
 	 */
+	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
+	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
+		return 0;
+
 	if (!vtable->get_bundle_uri) {
 		if (quiet)
 			return -1;
-- 
gitgitgadget


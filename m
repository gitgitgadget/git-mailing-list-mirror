Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BFC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiKPTwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiKPTvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54445A02
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2511272wma.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLooz02+SsovFOZcXwMGlFj9MxU6sRX+bGtaH84Oqg8=;
        b=NWu4c95hTtpch0AVcBh0BxDnu9geOIHT8h9XzymMBHDxjoOtNWiWmFW3lL8rhA/IkH
         +TuJTy2CVEGg4y7mCS3ai181t9L7/XwDZEsk60Eitxy82GMjhzJX5K0KI4TgQhpfz5hI
         OMkvzOrkrtwk6lAtlNez98lvph3JhdpoS8qWamt2YyGYUdGlbkUYwkMm1W+c6/vVdP3q
         frabDJfcLyR/nqKPI7ONumGeaSEPvCMBp/lzi4wvYDoHaUKY2eWOBDF+Xt1CqxDwvTRk
         int0po+RgB3FJc9R+lAjlfsVCTriG3iT8vIVmky8XWOCnzEiBYd2KQvaBJp87X+QuYcc
         /IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLooz02+SsovFOZcXwMGlFj9MxU6sRX+bGtaH84Oqg8=;
        b=6HdwyFDZgEiCNkcRvcdeZF0JPFRFJ8F6+DM6GcgeV9XHWMuf5fIl8NCGiaV1cux8Yd
         QzJ7M3VoXnRvaBAyPyTSErjL+lB+VfGj7QKQ1PTBFYjNR9eouMdc+a0yXuASPAoFf5vf
         YeOsdlHaW30THTvzxpUwPGPtuhAbN6Bl53Rm4ow/+MLzdjQdEPW3CzgZHThmkke9mM/R
         aJP97uJjmhcYvgSqOobh0Ihd63LVFZhzzmfOyCaHdGDG1lVTpl+AsZ3F3bqjv7Hn0qW0
         z0xuLBN1FaPDoVrH2rA1UTr4iBuBX4D0VdGET+ekcPtZfTkdLweg/up/eGfXYNlPY0zy
         ODNQ==
X-Gm-Message-State: ANoB5pmAy8rZuOoHiVq3gnKNlozllu3JKgG+yISSvbdmqC4eZY9rei5I
        2ttbJiITd/q+d+8K/eT2KNede/SlAgg=
X-Google-Smtp-Source: AA0mqf4PdQi7luWSTnUXxyW0olQrrvvSsISe6LaiYSPtPD/WWDheLcmp/bbfSuydRgEjpxojfRebwA==
X-Received: by 2002:a1c:7504:0:b0:3cf:6b10:ca8d with SMTP id o4-20020a1c7504000000b003cf6b10ca8dmr3316695wmc.44.1668628308834;
        Wed, 16 Nov 2022 11:51:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a1c1907000000b003cfbe1da539sm3130191wmz.36.2022.11.16.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:48 -0800 (PST)
Message-Id: <933974689312bbb130236c81550ee3467f295a43.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:38 +0000
Subject: [PATCH v2 5/9] bundle-uri client: add boolean transfer.bundleURI
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


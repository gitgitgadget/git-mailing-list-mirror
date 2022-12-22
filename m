Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A53C10F1D
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiLVPPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiLVPO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A822B0A
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so4123414wma.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qP5ArxwgVVOvZLxFNIjuay1SnGTTd27mCoyuwFDBro=;
        b=auAYIsjaLEpMIMcGr/fm8B2xrddwK7W/Nh6JGYCmhWctbtyuxTrcS/alJjJnsrL0zw
         /c9aUwCKFWmaoWKbZXfaULcJFx1v2339TU3TtEpW+E2M5A5B9pgynQ0zUB3jUzPFQudd
         wUjF+YOxELZqjT6Cun1xKsfB3R551u4vw+0MwqfqjKjfKXzXxEGgdbFVXx1mBMBpgqFd
         0733ngVnPYvz/Ik3dyuqPWLj1z6Pm2vy9nHUhFc3teLKFpCs8pYwwpybuHA3PacbxFB7
         heqL2bml/Zb2ygPn1q0T5eU4Mn7YNOy/dB7l2kbDUMaCjFbtagmir0PMMhVkTN9FkWTK
         SM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qP5ArxwgVVOvZLxFNIjuay1SnGTTd27mCoyuwFDBro=;
        b=4WX/4AzrqGjO+pUPpypcVHPmkAG5Ats2ao+3vnT1fsKsPvJc1MriWYhzrDHu3I57YS
         qXeGEGQ2zX5PAtQeWq+WMwnJuSwioREWHzXDAvMa6mN0GN4MMyegq7W8whZ1jmsSnscW
         yWQx15h0fegJTJoh54rxhg2w1CNzg4LKp6yG/waIYs1Ga9OFofT7Gn7exHbYk8+mg0PA
         gVGN5/FD2F7L9w/pI7a7L9HxG32W3cknzMmPTWxY7iTnObbbHXqKqhr1/bhQRkXr2/8n
         td6TjeReFMT65be0r/SKvVk6lqdLEk3PLDvQHjtN5qZpIlKOqA7FgHOBFjyfl+MoYOIb
         8FAA==
X-Gm-Message-State: AFqh2krI8stmqyXXEEclS7RTJPrp9cxBhh6v554uo3C88dmjyDFNXD3H
        3IrtjsIl2MGtE9BmCoxgovWId/+Hw1g=
X-Google-Smtp-Source: AMrXdXtXeC/j5gp1tuEdX+ZvqmcEziPnmGrzv41mMyV5I4PeUq3g4qALcr3MHZUdqRPOSSvdmTjd6A==
X-Received: by 2002:a05:600c:3d86:b0:3d1:e04f:9bfa with SMTP id bi6-20020a05600c3d8600b003d1e04f9bfamr4853970wmb.28.1671722064953;
        Thu, 22 Dec 2022 07:14:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003d1b4d957aasm1548253wmq.36.2022.12.22.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:24 -0800 (PST)
Message-Id: <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:12 +0000
Subject: [PATCH v4 06/11] bundle-uri client: add helper for testing server
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

Add a 'test-tool bundle-uri ls-remote' command. This is a thin wrapper
for issuing protocol v2 "bundle-uri" commands to a server, and to the
parsing routines in bundle-uri.c.

In the "git clone" case we'll have already done the handshake(),
but not here. Add an extra case to check for this handshake in
get_bundle_uri() for ease of use for future callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/helper/test-bundle-uri.c   | 46 ++++++++++++++++++++++++++++++++++++
 t/lib-bundle-uri-protocol.sh | 46 ++++++++++++++++++++++++++++++++++++
 transport.c                  |  7 ++++++
 3 files changed, 99 insertions(+)

diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 25afd393428..f8159187014 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -3,6 +3,10 @@
 #include "bundle-uri.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "transport.h"
+#include "ref-filter.h"
+#include "remote.h"
+#include "refs.h"
 
 enum input_mode {
 	KEY_VALUE_PAIRS,
@@ -68,6 +72,46 @@ usage:
 	usage_with_options(usage, options);
 }
 
+static int cmd_ls_remote(int argc, const char **argv)
+{
+	const char *uploadpack = NULL;
+	struct string_list server_options = STRING_LIST_INIT_DUP;
+	const char *dest;
+	struct remote *remote;
+	struct transport *transport;
+	int status = 0;
+
+	dest = argc > 1 ? argv[1] : NULL;
+
+	remote = remote_get(dest);
+	if (!remote) {
+		if (dest)
+			die(_("bad repository '%s'"), dest);
+		die(_("no remote configured to get bundle URIs from"));
+	}
+	if (!remote->url_nr)
+		die(_("remote '%s' has no configured URL"), dest);
+
+	transport = transport_get(remote, NULL);
+	if (uploadpack)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
+	if (transport_get_remote_bundle_uri(transport) < 0) {
+		error(_("could not get the bundle-uri list"));
+		status = 1;
+		goto cleanup;
+	}
+
+	print_bundle_list(stdout, transport->bundles);
+
+cleanup:
+	if (transport_disconnect(transport))
+		return 1;
+	return status;
+}
+
 int cmd__bundle_uri(int argc, const char **argv)
 {
 	const char *usage[] = {
@@ -88,6 +132,8 @@ int cmd__bundle_uri(int argc, const char **argv)
 		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
 	if (!strcmp(argv[1], "parse-config"))
 		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
+	if (!strcmp(argv[1], "ls-remote"))
+		return cmd_ls_remote(argc - 1, argv + 1);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 75ea8c4418f..5620e230387 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -119,3 +119,49 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	# Client issued bundle-uri command
 	grep "> command=bundle-uri" log
 '
+
+# The remaining tests will all assume transfer.bundleURI=true
+#
+# This test can be removed when transfer.bundleURI is enabled by default.
+test_expect_success 'enable transfer.bundleURI for remaining tests' '
+	git config --global transfer.bundleURI true
+'
+
+test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2" '
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	EOF
+
+	test-tool bundle-uri \
+		ls-remote \
+		"$BUNDLE_URI_REPO_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2 and extra data" '
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.only.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED" &&
+
+	# Extra data should be ignored
+	test_config -C "$BUNDLE_URI_PARENT" bundle.only.extra bogus &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	EOF
+
+	test-tool bundle-uri \
+		ls-remote \
+		"$BUNDLE_URI_REPO_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
diff --git a/transport.c b/transport.c
index 757ad552bf3..0f35114a13e 100644
--- a/transport.c
+++ b/transport.c
@@ -371,6 +371,13 @@ static int get_bundle_uri(struct transport *transport)
 		init_bundle_list(transport->bundles);
 	}
 
+	if (!data->finished_handshake) {
+		struct ref *refs = handshake(transport, 0, NULL, 0);
+
+		if (refs)
+			free_refs(refs);
+	}
+
 	/*
 	 * "Support" protocol v0 and v2 without bundle-uri support by
 	 * silently degrading to a NOOP.
-- 
gitgitgadget


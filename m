Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC8C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiLERwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiLERvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C260D4
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i131-20020a1c3b89000000b003d1cb516ce0so2915192wma.4
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJx+nKCpe9ZLXTw+nG9R54gmSIYf+jjrN1a4A9Y4e08=;
        b=nFKQeLNnwE+KkIt98kdDRhpspIZuoNtpM3biFBeO7uSdEmBAhIkhE1ZIqjIOD5d0oX
         9OP72mV+mN2I8fIjpWDk8PxFbNOG7HzcSfmxwjaYdc9VRrpUgm/l13QDOK0Oxi5bmQxD
         RLjGnG1xvqrAIL33qRYGBrP6QLi4i+5y/PV3bQ7dIcozCTQpE0zFIIAKIHm9ZbF6y+bw
         WYNuiuWG8s8jUVLN2R/B6iqMyMQpnhqRSEx8PXj3sqfuVmn8wxA4HGA70jmxQAIwUad5
         gD5WQ3Ir48e54OmjShG8ze9zhF03LbaE11XST2I1nTr5n2861V1pXooTs2HuyAcJemxT
         PZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJx+nKCpe9ZLXTw+nG9R54gmSIYf+jjrN1a4A9Y4e08=;
        b=UwSt1GmTTLXY6RaJmH1uKxca4LRk7k+/NWhMZQrJ13ZtJAEA8APMSyzKacl3o3DVMb
         98gY8L1lA/serruFrFUdxT9UrYNBgpUrzh/mlwJJQqPglI4LFhl8MCAvfndjZbAU7f6e
         DFV8tItj4KhuvASFw5x0L4F1r2vhlhKLMHoFxQYjRAVFlt1XfW2d4qXwkuJSQpIBknFq
         Ogsb1v1Nu/EMvpcfolexFsUlAZ234Qg6YDSr9znwkZmQ+n9JMp5iey3QbRXU85aYv03U
         hMBmyqQIdOFousq3OxfzQbOmeu7uAM0p3feBe2JgBlQBR1C4WduMHF7eps7C+iRRLMCA
         Ll+w==
X-Gm-Message-State: ANoB5pke3a8yDmru164UzFtOJLDiYs3sjLWTHZVXL6nlkb6AyozHazmi
        MiyVnUBvUCjySvcK8qA3+5eFTLlbPIo=
X-Google-Smtp-Source: AA0mqf7bQ7jKcOFR8zjqPEoKJiC0EIWeJqhIB2TNL0ssddh4EAzUDWndVKjKeVtu+dHGQ03SldvUHQ==
X-Received: by 2002:a05:600c:35c8:b0:3cf:cf89:2f02 with SMTP id r8-20020a05600c35c800b003cfcf892f02mr49961763wmq.2.1670262646196;
        Mon, 05 Dec 2022 09:50:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d638f000000b0024207478de3sm14409685wru.93.2022.12.05.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:45 -0800 (PST)
Message-Id: <46a58e83caf6d37e5a62b39d3c2e35e278211297.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:34 +0000
Subject: [PATCH v3 06/11] bundle-uri client: add helper for testing server
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

Add a 'test-tool bundle-uri ls-remote' command. This is a thin wrapper
for issuing protocol v2 "bundle-uri" commands to a server, and to the
parsing routines in bundle-uri.c.

In the "git clone" case we'll have already done the handshake(),
but not here. Add an extra case to check for this handshake in
get_bundle_uri() for ease of use for future callers. Rename the existing
'got_remote_heads' to 'finished_handshake' to make it more clear what
that bit represents.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/helper/test-bundle-uri.c   | 46 ++++++++++++++++++++++++++++++++++++
 t/lib-bundle-uri-protocol.sh | 39 ++++++++++++++++++++++++++++++
 transport.c                  |  7 ++++++
 3 files changed, 92 insertions(+)

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
index 77bfd4f0119..88e339ae9ad 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -119,3 +119,42 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 	# Client issued bundle-uri command
 	grep "> command=bundle-uri" log
 '
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
index a2281d95262..97d395e10a3 100644
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39DC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLVPO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiLVPO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E892DD5
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h7so1957811wrs.6
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwCw5MWgk/AvEUrGuGpC4uxSq9gDladWOjROHmwfeS4=;
        b=WQ03jQOW/sUrvFX3zeDOCExVqpPzTojgkVuy6EbmwbHjo9ca2Y/I1s6+Foi5rHNkZq
         DaMPcAUQwDFHyZ2t4xzCWeM9XOSO1X8P/chntMgrrXlJPTx1ztNsSsDU4wO0ifoEJNHf
         ay8lzsQ5P89pzgPUYUyyrTAacpkxUWziByTHeIvtcoQ6F+IG+ynGQE1xeg/45SJ2cMmE
         +Nlmoeo75a4MxhyQqA9wGkSmQLTsToYwBQd5nfX9F/0X0tp5+JGvZoKJS1y5bVSFI+sb
         /whCUyT+nze//zu8ppcK7xY/kzNOZ+X7KGTS6hdiHdPJj+ZZNOxYZGQBsto1BlW8k9Ew
         IBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwCw5MWgk/AvEUrGuGpC4uxSq9gDladWOjROHmwfeS4=;
        b=HZTacapGLzaPN7QVAeiL/jEDwhxLe8QTT1pF+XaDdBEN/iRPju2I3HnU5gtde7HOIg
         mkpk7ymkbherAHyjk4A5Y1FND5oOjUA7R4nIrWql7i5AaUh1dCCcnsy27c5pmxgE1pjb
         h/U1OKqzLN3v3mjxhaWGvdcjM91mGTCUM1Zq31XHczfw0iI/PhsnsHWzJ7MX9sbFclit
         jFGdomuz74p3pc2YERCZ0HjggdTUYXpsmyvZ2PuOyakOrqGH3QHRrr2lCkIIFaBHQOi9
         K00Yr313dmBkVlVuhlGzCzEbOz3Ju0NZoHMpj0JAZbO7luKukQFEu38+r6QOQG1lPBoZ
         9bAg==
X-Gm-Message-State: AFqh2kpqxB5+QBv4+qhk8daeP/VcZ1171JiFkzd/DSbvIT2jGw5VrXns
        KalmvGKYGBIHCmh5R8AEVBrsZrV1yb4=
X-Google-Smtp-Source: AMrXdXsh1v2U0Hd8bzlVtgqxlve7IZ7l9btMb6fS1tJST5f3r22884m9xzTqoDEpI9YWwLcGbfAA6g==
X-Received: by 2002:a5d:58e6:0:b0:26f:aaff:e98c with SMTP id f6-20020a5d58e6000000b0026faaffe98cmr1842742wrd.27.1671722065781;
        Thu, 22 Dec 2022 07:14:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b0024194bba380sm787405wrt.22.2022.12.22.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:25 -0800 (PST)
Message-Id: <c9b7d8779e44f9633c4abfc5588d61c0b87d9b78.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:13 +0000
Subject: [PATCH v4 07/11] bundle-uri: serve bundle.* keys from config
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

Implement the "bundle-uri" protocol v2 capability by populating the
key=value packet lines from the local Git config. The list of bundles is
provided from the keys beginning with "bundle.".

In the future, we may want to filter this list to be more specific to
the exact known keys that the server intends to share, but for
flexibility at the moment we will assume that the config values are
well-formed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                 | 16 +++++++++++++++-
 t/lib-bundle-uri-protocol.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 28d8966005e..26ff4b062d7 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -581,6 +581,16 @@ cached:
 	return advertise_bundle_uri;
 }
 
+static int config_to_packet_line(const char *key, const char *value, void *data)
+{
+	struct packet_reader *writer = data;
+
+	if (!strncmp(key, "bundle.", 7))
+		packet_write_fmt(writer->fd, "%s=%s", key, value);
+
+	return 0;
+}
+
 int bundle_uri_command(struct repository *r,
 		       struct packet_reader *request)
 {
@@ -592,7 +602,11 @@ int bundle_uri_command(struct repository *r,
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("bundle-uri: expected flush after arguments"));
 
-	/* TODO: Implement the communication */
+	/*
+	 * Read all "bundle.*" config lines to the client as key=value
+	 * packet lines.
+	 */
+	git_config(config_to_packet_line, &writer);
 
 	packet_writer_flush(&writer);
 
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index 5620e230387..3022ea4a95b 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -136,6 +136,8 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
 	EOF
 
 	test-tool bundle-uri \
@@ -157,6 +159,36 @@ test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED
+	EOF
+
+	test-tool bundle-uri \
+		ls-remote \
+		"$BUNDLE_URI_REPO_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success "test bundle-uri with $BUNDLE_URI_PROTOCOL:// using protocol v2 with list" '
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.bundle1.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl" &&
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.bundle2.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-2.bdl" &&
+	test_config -C "$BUNDLE_URI_PARENT" \
+		bundle.bundle3.uri "$BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "bundle1"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-1.bdl
+	[bundle "bundle2"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-2.bdl
+	[bundle "bundle3"]
+		uri = $BUNDLE_URI_BUNDLE_URI_ESCAPED-3.bdl
 	EOF
 
 	test-tool bundle-uri \
-- 
gitgitgadget


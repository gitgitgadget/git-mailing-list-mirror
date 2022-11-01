Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B40FA3744
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKABH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKABHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5211658D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so18259292wrq.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC4MklC4EotCdkubgLTySzDpazds/cBLtZSjsLhluuw=;
        b=jFj/oobU+Ea475WPUcASevBTkI5tHEalNRAwtjMNVwRsuIpFxRiO7OIKTUqZWuSlnd
         IqDxM2keWy9/hQhCL9KWo16tdnZ+LpbpRAR1206i7ScDYtnk/hJiJkLqTE2uR4mQMvpw
         beWmiFbcXzm02UGU/e5/12hDJ4pFXFjJI6iJ8kVuQvASnNZM3TIJb3rHQ+fGQKKR+y0Q
         uGQYuHrxyJW2GTwiL23lb2FLfsNZDYPtHoQpEn8vsJityWdacF8vx6k/iv4Tifr1ARWn
         Sm7yR4WC+pxtwWDtyqyQdzzX6eHOvo+1SaND/fCFHrb3QKQ8o6si/VeFuPm1okTrtM1N
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC4MklC4EotCdkubgLTySzDpazds/cBLtZSjsLhluuw=;
        b=OFQX+3yp03tPCJEdZGTnfgj9wQECpRRXIoGhDPapGwor6xc1UJV/4fWH+Kf8DK+a7q
         VEc1i0CjeeYXy+jE4ydpaStcPG+FDpi27SqSQTATQr51/FSq4jCMX4CXlLdOjokgWfLE
         nKE41RIBujuVr0yL8YH+qpyskfK/TZOxRH/op7VzHh6Hl0Ztz9EzZVegDMr48q3ursJm
         csUU2IqwCAHqhtxXLD940kJGqrTfsVcZJ1GXsVlVrfRkpttwwpB11YYicYuHp6MChRZD
         7T5adRV3BhNOOhqHvwGZQJu17rp93epa4lvyibrF1BKTXumNpR9/t/Jl1gXz85Bqa/Ck
         AD1w==
X-Gm-Message-State: ACrzQf1Hy+5d8ZH2i9w1X2OMTWFFDuIgTJhOv7o3r/W/Ag1Q6szU85Gq
        5Cnp1NO5GE83CiGvRdMws/LaIcPEMYo=
X-Google-Smtp-Source: AMsMyM4ywJhYgP+F7zu+pnA4EMDfDlXSq8b5OlIDXHvPBGGrEb70sMSUn7j5S8STbKS1mf+jA9GkfQ==
X-Received: by 2002:a5d:47c7:0:b0:236:64a4:6d5a with SMTP id o7-20020a5d47c7000000b0023664a46d5amr9649209wrc.666.1667264859334;
        Mon, 31 Oct 2022 18:07:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d45c9000000b0022e36c1113fsm8168864wrs.13.2022.10.31.18.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:38 -0700 (PDT)
Message-Id: <431cd585184b29f981247a6fa298c5a555937728.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:29 +0000
Subject: [PATCH 4/9] bundle-uri: serve bundle.* keys from config
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

Implement the "bundle-uri" protocol v2 capability by populating the
key=value packet lines from the local Git config. The list of bundles is
provided from the keys beginning with "bundle.".

In the future, we may want to filter this list to be more specific to
the exact known keys that the server intends to share, but for
flexibility at the moment we will assume that the config values are
well-formed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                          | 16 +++++++++++-
 t/lib-t5730-protocol-v2-bundle-uri.sh | 35 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2201b604b11..3469f1aaa98 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -585,6 +585,16 @@ cached:
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
@@ -596,7 +606,11 @@ int bundle_uri_command(struct repository *r,
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("bundle-uri: expected flush after arguments"));
 
-	/* TODO: Implement the communication */
+	/*
+	 * Read all "bundle.*" config lines to the client as key=value
+	 * packet lines.
+	 */
+	git_config(config_to_packet_line, &writer);
 
 	packet_writer_flush(&writer);
 
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index c327544641b..000fcc5e20b 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -158,6 +158,8 @@ test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2" '
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
 	EOF
 	GIT_TRACE_PACKET="$PWD/log" \
 	test-tool bundle-uri \
@@ -181,6 +183,39 @@ test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 and ext
 	[bundle]
 		version = 1
 		mode = all
+	[bundle "only"]
+		uri = $T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	test-tool bundle-uri \
+		ls-remote \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp_config_output expect actual
+'
+
+
+test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2 with list" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle1.uri "$T5730_BUNDLE_URI_ESCAPED-1.bdl" &&
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle2.uri "$T5730_BUNDLE_URI_ESCAPED-2.bdl" &&
+	test_config -C "$T5730_PARENT" \
+		bundle.bundle3.uri "$T5730_BUNDLE_URI_ESCAPED-3.bdl" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "bundle1"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-1.bdl
+	[bundle "bundle2"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-2.bdl
+	[bundle "bundle3"]
+		uri = $T5730_BUNDLE_URI_ESCAPED-3.bdl
 	EOF
 	GIT_TRACE_PACKET="$PWD/log" \
 	test-tool bundle-uri \
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1464FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKABID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKABHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53B165AC
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso9078363wmq.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIT1c16Xd/NJcClYTegONT4v1Q64EvFWgUorOXXJwK0=;
        b=PYyr0/hCi6/CA3l6EpU6HJRRKFqI0L8YeRXlGD9zN12VizEhuamSL6ibvgVvLNFj0c
         rQNgiIQF3uMvJy8v94cD16QHP0Q2KNr3ivLZedUu7LBIN9KNHtOe/1wWtoeYm7wY7y2l
         EPuMKx3rAhTRsaBf9FKFs5F1cedwNVhgP2xQXtSYLUJqCc9R9Qiv9hEKDrzu2NZuL3pT
         /dPoxR7fI2qAxUMqTVwA7jY71D1ZfXw7uxLThrCwtcIUc4Lt2RCqFj8d8cyMiLbm33Iu
         L4VGk5z6DCPLwps3GpazPI7QkmxmXAH2WfT01Z9yaa2zBluL/kjlatezbLywAcr8xGpP
         c9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIT1c16Xd/NJcClYTegONT4v1Q64EvFWgUorOXXJwK0=;
        b=M/TGXOP4rXrDSUueQZN2FcRJ1jPP+CR4+A4NLeIhRNpyuz+LvmiytK4z61ybKc/Gt7
         5VU3s38d/OkJ7pXLFViUUzS9siaJvq4RgErtRIBNf3ErspUiipPSrcg5lQtby7NZdYMZ
         NUeok6pm1BrHSAnZEVVXKK9Civ0TMtvHY30TbBohi7+Xxh51kYu/IGwm8IGU6UfokFcj
         P6m1ddku6LRQX2qsXzgiPVc9R4zKWVc8sdY0+6PWhuX0Cq+tprw5EbCkaeHHZtAYBbby
         xBgPNaVH11ospcouYHHzW5gTFY9QuVegLf4x0v9xhBRhIY0LAMYtpOE4RD31lwVtt0oT
         94SQ==
X-Gm-Message-State: ACrzQf23YoW7Yx1lgrNKGnXLcB37OaKYVX78VdgvWkwnuB3dRFq1S7Yt
        /RxlVgJeekRTYQRWbRh5L3UyeMOIA3M=
X-Google-Smtp-Source: AMsMyM4r5VVBhdm0F/72emil3asKxBrNVRBcVUA/kEzaJsWskSpMYu3993HPihIlIEPEf7BryApDOA==
X-Received: by 2002:a05:600c:5119:b0:3c6:cae1:1512 with SMTP id o25-20020a05600c511900b003c6cae11512mr20682008wms.80.1667264861830;
        Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay16-20020a05600c1e1000b003cf537ec2efsm10176657wmb.36.2022.10.31.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:41 -0700 (PDT)
Message-Id: <3550f6fb91b0214c459cbc0dd9bb8c6d7c677f85.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:32 +0000
Subject: [PATCH 7/9] bundle-uri: allow relative URLs in bundle lists
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

Bundle providers may want to distribute that data across multiple CDNs.
This might require a change in the base URI, all the way to the domain
name. If all bundles require an absolute URI in their 'uri' value, then
every push to a CDN would require altering the table of contents to
match the expected domain and exact location within it.

Allow a bundle list to specify a relative URI for the bundles.
This allows easier distribution of bundle data.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 16 ++++++++++-
 bundle-uri.h                |  9 +++++++
 t/helper/test-bundle-uri.c  |  2 ++
 t/t5750-bundle-uri-parse.sh | 54 +++++++++++++++++++++++++++++++++++++
 transport.c                 |  3 +++
 5 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 3469f1aaa98..0f3902bbd2b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -7,6 +7,7 @@
 #include "hashmap.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "remote.h"
 
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
@@ -49,6 +50,7 @@ void clear_bundle_list(struct bundle_list *list)
 
 	for_all_bundles_in_list(list, clear_remote_bundle_info, NULL);
 	hashmap_clear_and_free(&list->bundles, struct remote_bundle_info, ent);
+	free(list->baseURI);
 }
 
 int for_all_bundles_in_list(struct bundle_list *list,
@@ -163,7 +165,7 @@ static int bundle_list_update(const char *key, const char *value,
 	if (!strcmp(subkey, "uri")) {
 		if (bundle->uri)
 			return -1;
-		bundle->uri = xstrdup(value);
+		bundle->uri = relative_url(list->baseURI, value, NULL);
 		return 0;
 	}
 
@@ -190,6 +192,18 @@ int bundle_uri_parse_config_format(const char *uri,
 		.error_action = CONFIG_ERROR_ERROR,
 	};
 
+	if (!list->baseURI) {
+		struct strbuf baseURI = STRBUF_INIT;
+		strbuf_addstr(&baseURI, uri);
+
+		/*
+		 * If the URI does not end with a trailing slash, then
+		 * remove the filename portion of the path. This is
+		 * important for relative URIs.
+		 */
+		strbuf_parent_directory(&baseURI);
+		list->baseURI = strbuf_detach(&baseURI, NULL);
+	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
 						   &opts);
diff --git a/bundle-uri.h b/bundle-uri.h
index 357111ecce8..7905e56732c 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -61,6 +61,15 @@ struct bundle_list {
 	int version;
 	enum bundle_list_mode mode;
 	struct hashmap bundles;
+
+	/**
+	 * The baseURI of a bundle_list is used as the base for any
+	 * relative URIs advertised by the bundle list at that location.
+	 *
+	 * When the list is generated from a Git server, then use that
+	 * server's location.
+	 */
+	char *baseURI;
 };
 
 void init_bundle_list(struct bundle_list *list);
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index ffb975b7b4f..5aa0b494ce3 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -40,6 +40,8 @@ static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mo
 
 	init_bundle_list(&list);
 
+	list.baseURI = xstrdup("<uri>");
+
 	switch (mode) {
 	case KEY_VALUE_PAIRS:
 		if (argc != 1)
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index c2fe3f9c5a5..ed5262a8d2b 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -30,6 +30,30 @@ test_expect_success 'bundle_uri_parse_line() just URIs' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'bundle_uri_parse_line(): relative URIs' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=bundle.bdl
+	bundle.two.uri=../bundle.bdl
+	bundle.three.uri=sub/dir/bundle.bdl
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = <uri>/bundle.bdl
+	[bundle "two"]
+		uri = bundle.bdl
+	[bundle "three"]
+		uri = <uri>/sub/dir/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-key-values in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
 	cat >in <<-\EOF &&
 	=bogus-value
@@ -136,6 +160,36 @@ test_expect_success 'parse config format: just URIs' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: relative URIs' '
+	cat >in <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = bundle.bdl
+	[bundle "two"]
+		uri = ../bundle.bdl
+	[bundle "three"]
+		uri = sub/dir/bundle.bdl
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = <uri>/bundle.bdl
+	[bundle "two"]
+		uri = bundle.bdl
+	[bundle "three"]
+		uri = <uri>/sub/dir/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-config in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
 test_expect_success 'parse config format edge cases: empty key or value' '
 	cat >in1 <<-\EOF &&
 	= bogus-value
diff --git a/transport.c b/transport.c
index b33180226ae..2c4ff0c2023 100644
--- a/transport.c
+++ b/transport.c
@@ -1553,6 +1553,9 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
 		return 0;
 
+	if (!transport->bundles->baseURI)
+		transport->bundles->baseURI = xstrdup(transport->url);
+
 	if (!vtable->get_bundle_uri) {
 		if (quiet)
 			return -1;
-- 
gitgitgadget


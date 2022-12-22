Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A16C4167B
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiLVPPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLVPOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDCF6324
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4209531wml.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKM5SMCqgoswVsdSQ/vi3+puAeU0kvN+GIO+4TQjQfw=;
        b=fBcBfSVA0uFTlfuYb6Bn45xKP51C9Bstfjq0DKchqI1t0M+pEOwk8CD6eV9u+vK/bp
         pecg78ZgAhFhK/GbHxaio2twMmd2t/Ac/OHOiMK1jZjfIxslU1mXcDdDxnf1BIm4SNlE
         NzlIdLtAsWqugqvNSORca3doNsHUpOiMdYZz23sR3DS4rqSEHSy2p7fERpqnc5ycrOpv
         A4VnFxl4MjhmHONwHNELzBqXVFKxV5vID197wEH7GE1ssoyAVpK94MX3RtnijnAN47F0
         wxQ5T5A2iDBD6gKtvvBmBaYOBv9HSmwq1s3Ft33YClGJ7Vs7Jtl8RSM4kMMP35kLRuBF
         T2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKM5SMCqgoswVsdSQ/vi3+puAeU0kvN+GIO+4TQjQfw=;
        b=cSzmj7OhcWXNyM8ScJykLWpg4NPOS/tYjO2703NbO1Y9wKu+Q0J54gTYNpIupQYMxK
         0c4KUFHmZWyxBfYnqLbN+Lq+fRt9RRGXRXQc92zaGKV7KkVGX19q3ozCV3oeV6X+XXnD
         G8AMBTMZCkKAMXqbm+HDtUmIUX3clk8ZpdC5OvwLN3d8PuhF2U+ewUszFc17ycUyeEQi
         38NxtMHJiVf2XpuzhpY80S2r65Y6Rl66kXyfWbfMP/02uDqt7F1e1K1izIHKOFdZGB9i
         DBnOUvAWdqueM+W8W5oDubEUJ/mY/56MiuI2Luadg2qFQj6fR0/CmIe5JX970pGKQedG
         byUg==
X-Gm-Message-State: AFqh2krzzFofpttcyw9i6cLswoHJxAGoA1YTP4nanZ68R59mMR+33GPz
        6e1DTVZUcoGKeTdYLNUWJ3WWcfnejxA=
X-Google-Smtp-Source: AMrXdXsv1jCAIA4JjIzU8vNDZpSdTF/amOjx1ZaPLAlJ5CL9kC+MHdw3j38vPWSuk21inW3UnmuzwQ==
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id n16-20020a05600c3b9000b003d1f0f1ceb4mr4629875wms.19.1671722067194;
        Thu, 22 Dec 2022 07:14:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003cf5ec79bf9sm1412228wmq.40.2022.12.22.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Message-Id: <a188b38399d767f4fc55ff8955c24c249f694e94.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:15 +0000
Subject: [PATCH v4 09/11] bundle-uri: allow relative URLs in bundle lists
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

Bundle providers may want to distribute that data across multiple CDNs.
This might require a change in the base URI, all the way to the domain
name. If all bundles require an absolute URI in their 'uri' value, then
every push to a CDN would require altering the table of contents to
match the expected domain and exact location within it.

Allow a bundle list to specify a relative URI for the bundles. This URI
is based on where the client received the bundle list. For a list
provided in the 'bundle-uri' protocol v2 command, the Git remote URI is
the base URI. Otherwise, the bundle list was provided from an HTTP URI
not using the Git protocol, and that URI is the base URI. This allows
easier distribution of bundle data.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 16 +++++++-
 bundle-uri.h                | 14 +++++++
 t/helper/test-bundle-uri.c  |  2 +
 t/t5750-bundle-uri-parse.sh | 82 +++++++++++++++++++++++++++++++++++++
 transport.c                 |  3 ++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 26ff4b062d7..69929d363cc 100644
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
+		strbuf_strip_file_from_path(&baseURI);
+		list->baseURI = strbuf_detach(&baseURI, NULL);
+	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
 						   &opts);
diff --git a/bundle-uri.h b/bundle-uri.h
index 357111ecce8..c505444bc75 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -61,6 +61,20 @@ struct bundle_list {
 	int version;
 	enum bundle_list_mode mode;
 	struct hashmap bundles;
+
+	/**
+	 * The baseURI of a bundle_list is the URI that provided the list.
+	 *
+	 * In the case of the 'bundle-uri' protocol v2 command, the base
+	 * URI is the URI of the Git remote.
+	 *
+	 * Otherwise, the bundle list was downloaded over HTTP from some
+	 * known URI. 'baseURI' is set to that value.
+	 *
+	 * The baseURI is used as the base for any relative URIs
+	 * advertised by the bundle list at that location.
+	 */
+	char *baseURI;
 };
 
 void init_bundle_list(struct bundle_list *list);
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index f8159187014..5df5bc3b89e 100644
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
index c2fe3f9c5a5..7b4f930e532 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -30,6 +30,58 @@ test_expect_success 'bundle_uri_parse_line() just URIs' '
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
+test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=bundle.bdl
+	bundle.two.uri=../bundle.bdl
+	bundle.three.uri=../../bundle.bdl
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
+		uri = <uri>/../bundle.bdl
+	EOF
+
+	# TODO: We would prefer if parsing a bundle list would not cause
+	# a die() and instead would give a warning and allow the rest of
+	# a Git command to continue. This test_must_fail is necessary for
+	# now until the interface for relative_url() allows for reporting
+	# an error instead of die()ing.
+	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
+	grep "fatal: cannot strip one component off url" err
+'
+
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
 	cat >in <<-\EOF &&
 	=bogus-value
@@ -136,6 +188,36 @@ test_expect_success 'parse config format: just URIs' '
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
index 0f35114a13e..241f8a6ba2d 100644
--- a/transport.c
+++ b/transport.c
@@ -1538,6 +1538,9 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
 		return 0;
 
+	if (!transport->bundles->baseURI)
+		transport->bundles->baseURI = xstrdup(transport->url);
+
 	if (!vtable->get_bundle_uri)
 		return error(_("bundle-uri operation not supported by protocol"));
 
-- 
gitgitgadget


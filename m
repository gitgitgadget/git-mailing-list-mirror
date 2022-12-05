Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7545C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiLERwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiLERvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8D62C8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg10so9364629wmb.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CywwVsO/oG6poD1gJfQFbKhOmz6urWmUyEVt2g0nh7U=;
        b=iZnt3QPRU9Iao71/r6qTNU8y/iofDvBPV2AUOvKHzC3uTdkDO5oOJyGgA3kaXVpGVL
         fPzlWsJ+OKQwdppYlWDzZjqoy/yVJV/ptr2SEZvmC9/z67tb2k8bfONQBZIwbtL1/+is
         7ZL/2Fi+k4P4UkBWxLHb3cp8YRbFc4RxNYfXXyFNP6lnsqdSG6ct3QqXVr1xIj+lqm4g
         gfjzCvaw2a4x7MHYWtq/Cyl03syzWd2//yiG2kqAbBJNCdYcFwlCy1s6eWuhJ+B38YYR
         MKBCSIvGgb1PE5ykFfx5Q1Di34rW8bWHp6osjOWv5utqgl7FtWAK1aP1XIgs1l3zIAIL
         3r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CywwVsO/oG6poD1gJfQFbKhOmz6urWmUyEVt2g0nh7U=;
        b=28NNIWUpc55h+GOxd5TjcbSXRY42Q3F8kpcqjV+k3qnZcFCd8SG+mVKzt+pTPFbAWO
         YIDv8/xEvx0AeUZzlf/hueAmKRRh4lcYh4MmHJkqBEr9H6xDq/xRPn7RSojifj2MBFXg
         GbAVa8ct9qNvnhHKC34A2W2vRlv6xcjDavhwZlu0bb+Tzs0DMN3B1LCXmSl5RvuUCfl1
         8VgcxUrRDM9PnHmxEDZfoek5YrIoQC4cgDhP5UL3dcWdWdiwhoTdWOwGYFt9wKfjK8H6
         3quQ5E1ZesJjIq3qyThnt+OMuo1aAbvrnn0EuXhBkJlCSv3KRWWKYXadRf9ld32GQEJX
         6K0w==
X-Gm-Message-State: ANoB5plCkQL+g3QLClwd9SBHnnlbc2Yq0UKBsSFcMoDq806jp55h1T6d
        4dwa1sgO+G3qWsZnJP9OhjVXsi4CPSw=
X-Google-Smtp-Source: AA0mqf7/k3aPfXxQbriWqakBe62mIb04hfCUsnmTv/QM+VZfpgAPht7NS0pz3cL/yIc7hKuUNmg+5g==
X-Received: by 2002:a7b:c8c3:0:b0:3cf:b49e:1638 with SMTP id f3-20020a7bc8c3000000b003cfb49e1638mr50101922wml.50.1670262648476;
        Mon, 05 Dec 2022 09:50:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b002425787c5easm6270402wrj.96.2022.12.05.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:48 -0800 (PST)
Message-Id: <48731438d6a289129a5768b80af856fb49692426.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:37 +0000
Subject: [PATCH v3 09/11] bundle-uri: allow relative URLs in bundle lists
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
index 6919f541085..80370992773 100644
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
index 357111ecce8..e7e90a5f088 100644
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
+	 * Otherewise, the bundle list was downloaded over HTTP from some
+	 * known URI.
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
index 97d395e10a3..957dca4923c 100644
--- a/transport.c
+++ b/transport.c
@@ -1539,6 +1539,9 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
 		return 0;
 
+	if (!transport->bundles->baseURI)
+		transport->bundles->baseURI = xstrdup(transport->url);
+
 	if (!vtable->get_bundle_uri)
 		return error(_("bundle-uri operation not supported by protocol"));
 
-- 
gitgitgadget


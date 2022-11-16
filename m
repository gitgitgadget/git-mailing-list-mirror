Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A7BC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiKPTwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiKPTvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42744876C
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w14so31698060wru.8
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ikiRzeF6zm3KWpzMsAsHvlZOU4f/T44FQ8of3kKb7I=;
        b=OHkPMBUT0atw3R4+9kCzp9mnZQJqFGT7xjVKbZzT3+AylCsBY/IiZKpAejCl2UQvNS
         k9Lh6625mr5XJG11fR2aA9BOzq2eyYTPdbobf2H9vBBdRx3V/MAPY5mdQ9XtPAltvAxt
         92xWT2dA2HXZRkBU3XgJFh9qgUJm8BXD785JooOaubAbrC01OklT7rXIZPEQ9VmSu5fk
         HGNqnp/Twyax33Bxw5FxOeGvDdBz1Ot/slOF93oOKTIvWY8brtoCLqk92d5fca4QQSB2
         XdD3HLVCYCOBZJReG2bRPSr+IPuR3SbOJngjQzTCsWbvLZQt2mN6LHZezYRc0gvaEv+7
         heFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ikiRzeF6zm3KWpzMsAsHvlZOU4f/T44FQ8of3kKb7I=;
        b=WZDr7SWGjkdnDkrnpd3F8rceCgdb+YXZ4argE1uNm6xoQJqSEFmBrx+d+gnnbsqfob
         B1rd5sR8tpzREl6m0OIlFcM9TVFqWqI/8Wj5MOgHIUHw7b95YS2FpxyhT/SNCjvtfATD
         u950s+5tFfDMKVJOrd19mn4hsoilonxL/8uOauHDh2SmOteRVrYAoeG1RfKtRj8eKMMQ
         msJPSBAcNWZWdDK2E2edmC6k2AVMmcua8sYhgQMWGUHEmQx+Y8iTpWybz8FgLIDTDUtU
         olJeS6kEPMFvLRtx6t6sJKV4IUOG+6v8E2tXS78bSUQ/uQZdM7Oslh7hWpmI3T6gKI7u
         /WyA==
X-Gm-Message-State: ANoB5pnnz/EXkyEnuHbl95OED57Ch+DVzXSiW7evfJhE3LMTQD3Dmycw
        B7Cv6SCXjT5PzfBVtCYaTmm8NSF+adc=
X-Google-Smtp-Source: AA0mqf6symV2khvUUofwd3b8qlAqK9XT1cBipvhW7aUVbfBubrTh6yVf4aRqYbalAAk2a+u+rX0ULA==
X-Received: by 2002:a5d:58c3:0:b0:238:8896:7876 with SMTP id o3-20020a5d58c3000000b0023888967876mr14840395wrf.645.1668628310362;
        Wed, 16 Nov 2022 11:51:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003c6bd91caa5sm3442569wmq.17.2022.11.16.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:50 -0800 (PST)
Message-Id: <186e112d821d9a42ffbc3c8b46e24b2b4bb3dfe8.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:40 +0000
Subject: [PATCH v2 7/9] bundle-uri: allow relative URLs in bundle lists
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
index 3469f1aaa98..ab91bb32e9b 100644
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


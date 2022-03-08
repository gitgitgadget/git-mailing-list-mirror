Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A8C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbiCHOki (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347564AbiCHOk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8838DA5
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u10so27262770wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cODEiV4ork0dtdnF/SVv9/aBWdDEJq0vadf34r48t0g=;
        b=H2hXAzZ8I9Chgf0RM6rJQ2BVbAMzrPc7+Cwdbr2JrrEUlbmMoyD7gu8jCbo6pFW9BR
         8R6rOj2cetNjH/QG9pyGXD3n+mv08sxV2xnZn2muwYNXqxd7+ygs9ZGHZTwSpIP8qAo3
         Bu9Yq0fjtRIwhvPG6iCoMq4w434zU/8Ycv3GSSjCRv5+s3M/7nnQRaWEDsLH6TFYQODd
         N5Obp4hJFsjDR0jWVl3MZvokgQhcH5wQj+pz/Bkz9z7evs9TJdvJtP2FHa1wDUmmubd2
         fCwQPS9rm7aSOOHQweoEvucrY+ZH3i+qWUBVrrAoiORN2So/DIaQxGB26l5qvGDO+5M/
         YVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cODEiV4ork0dtdnF/SVv9/aBWdDEJq0vadf34r48t0g=;
        b=BJekvfDqlKhIolu2KxK/t5ckYDa40wzkj9HJzPfB++/kCSkRJVvc1Tp1kEPTy1lXoh
         s2Po97I4qnoog1UlNc2IfjqrLw8GyBhATpeYV91VAUpdqSwpEwoRvLhbZ3Txqkyl6m1E
         VlcE+FBpIpo+9BGi2KGgpjVrnCpbFNTYdZpOgC0P2xh2wJ1t0VlQkSAcTr8dVCamwWHT
         y6VOXJVgU73anBYNPuZLD2o+ZUY+LRK8B2U5bJq9nJ34NA2DzR2i5zKWZMgRyJe34Swy
         LhOy/a9lKPG6NPXZkrva7E3nO8/Bja4ScuHa56jmOserwrBOMka4eCjDGtIwEzc3kz+g
         BOow==
X-Gm-Message-State: AOAM530Nf32422vE1d/BwD1Jcq96eBq2cUbm6nZqKITSeIAvtw87prf5
        DxCTu8Vk8DsheN6UWBuvsdGCRuXNUt8=
X-Google-Smtp-Source: ABdhPJytXwUlGU4keWkhq5SelTiH5pKXDs1UaaFIgQntobn+LWjU7/vGANmRLnDIRrvJlWm40QbN5A==
X-Received: by 2002:adf:d210:0:b0:1f1:f999:b538 with SMTP id j16-20020adfd210000000b001f1f999b538mr6834682wrh.473.1646750368126;
        Tue, 08 Mar 2022 06:39:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n188-20020a1ca4c5000000b00389c692a3b5sm1592743wme.42.2022.03.08.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:27 -0800 (PST)
Message-Id: <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:15 +0000
Subject: [PATCH v3 08/12] bundle: parse filter capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The v3 bundle format has capabilities, allowing newer versions of Git to
create bundles with newer features. Older versions that do not
understand these new capabilities will fail with a helpful warning.

Create a new capability allowing Git to understand that the contained
pack-file is filtered according to some object filter. Typically, this
filter will be "blob:none" for a blobless partial clone.

This change teaches Git to parse this capability, place its value in the
bundle header, and demonstrate this understanding by adding a message to
'git bundle verify'.

Since we will use gently_parse_list_objects_filter() outside of
list-objects-filter-options.c, make it an external method and move its
API documentation to before its declaration.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-format.txt | 11 ++++++++---
 bundle.c                                  | 15 ++++++++++++++-
 bundle.h                                  |  2 ++
 list-objects-filter-options.c             | 17 +----------------
 list-objects-filter-options.h             | 20 ++++++++++++++++++++
 5 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
index bac558d049a..b9be8644cf5 100644
--- a/Documentation/technical/bundle-format.txt
+++ b/Documentation/technical/bundle-format.txt
@@ -71,6 +71,11 @@ and the Git bundle v2 format cannot represent a shallow clone repository.
 == Capabilities
 
 Because there is no opportunity for negotiation, unknown capabilities cause 'git
-bundle' to abort.  The only known capability is `object-format`, which specifies
-the hash algorithm in use, and can take the same values as the
-`extensions.objectFormat` configuration value.
+bundle' to abort.
+
+* `object-format` specifies the hash algorithm in use, and can take the same
+  values as the `extensions.objectFormat` configuration value.
+
+* `filter` specifies an object filter as in the `--filter` option in
+  linkgit:git-rev-list[1]. The resulting pack-file must be marked as a
+  `.promisor` pack-file after it is unbundled.
diff --git a/bundle.c b/bundle.c
index 7ba60a573d7..41922565627 100644
--- a/bundle.c
+++ b/bundle.c
@@ -11,7 +11,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "strvec.h"
-
+#include "list-objects-filter-options.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -33,6 +33,7 @@ void bundle_header_release(struct bundle_header *header)
 {
 	string_list_clear(&header->prerequisites, 1);
 	string_list_clear(&header->references, 1);
+	list_objects_filter_release(&header->filter);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -45,6 +46,10 @@ static int parse_capability(struct bundle_header *header, const char *capability
 		header->hash_algo = &hash_algos[algo];
 		return 0;
 	}
+	if (skip_prefix(capability, "filter=", &arg)) {
+		parse_list_objects_filter(&header->filter, arg);
+		return 0;
+	}
 	return error(_("unknown capability '%s'"), capability);
 }
 
@@ -220,6 +225,8 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
+	revs.filter = &header->filter;
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
@@ -259,6 +266,12 @@ int verify_bundle(struct repository *r,
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
+
+		if (header->filter.choice != LOFC_DISABLED) {
+			printf_ln("The bundle uses this filter: %s",
+				  list_objects_filter_spec(&header->filter));
+		}
+
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
diff --git a/bundle.h b/bundle.h
index 06009fe6b1f..7fef2108f43 100644
--- a/bundle.h
+++ b/bundle.h
@@ -4,12 +4,14 @@
 #include "strvec.h"
 #include "cache.h"
 #include "string-list.h"
+#include "list-objects-filter-options.h"
 
 struct bundle_header {
 	unsigned version;
 	struct string_list prerequisites;
 	struct string_list references;
 	const struct git_hash_algo *hash_algo;
+	struct list_objects_filter_options filter;
 };
 
 #define BUNDLE_HEADER_INIT \
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..d8597cdee36 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -40,22 +40,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 	BUG("list_object_filter_config_name: invalid argument '%d'", c);
 }
 
-/*
- * Parse value of the argument to the "filter" keyword.
- * On the command line this looks like:
- *       --filter=<arg>
- * and in the pack protocol as:
- *       "filter" SP <arg>
- *
- * The filter keyword will be used by many commands.
- * See Documentation/rev-list-options.txt for allowed values for <arg>.
- *
- * Capture the given arg as the "filter_spec".  This can be forwarded to
- * subordinate commands when necessary (although it's better to pass it through
- * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
- * convenience of the current command.
- */
-static int gently_parse_list_objects_filter(
+int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index da5b6737e27..f6fe6a3d2ca 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -72,6 +72,26 @@ struct list_objects_filter_options {
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
+/*
+ * Parse value of the argument to the "filter" keyword.
+ * On the command line this looks like:
+ *       --filter=<arg>
+ * and in the pack protocol as:
+ *       "filter" SP <arg>
+ *
+ * The filter keyword will be used by many commands.
+ * See Documentation/rev-list-options.txt for allowed values for <arg>.
+ *
+ * Capture the given arg as the "filter_spec".  This can be forwarded to
+ * subordinate commands when necessary (although it's better to pass it through
+ * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
+ * convenience of the current command.
+ */
+int gently_parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
+
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
 
-- 
gitgitgadget


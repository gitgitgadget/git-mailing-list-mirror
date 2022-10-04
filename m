Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8895EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJDMec (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJDMe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04732A99
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso701170wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=0yrgCoeY0AokBCk/7CF7non/FPEu/1rHXlEpUZhWD/s=;
        b=HTrYvlSwyDVXkK6h1sW0K54Gvn2lnumnt7TRi4bv2tPBakLey/qKpB4SNGUu6Oom9T
         /IskL1d2Ko7PslHkrBHE9mvJPRKCpMEMcuzpiMZdgz8XX5kzgWrTXRz+o1jt/Cz4RnL1
         MQjZLj1QWZZKldYETvsWzOfmxqhOSBEae6eyZgWuD2ipwup+jvl2NdjJOIv9og5irTvV
         6KrbbUZgezBEG+GGws87WMn9PHKLU1b/pihpKB3VEv2xnmpy0xk+yNtjb1jcX0nqDuD4
         TZsq8EjjiWPwKYDxLdD1yhz7qQRNcUZvdj+CtvIvHrZdPcoZ/JR0MGDvQFkal6SE1p9a
         aUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0yrgCoeY0AokBCk/7CF7non/FPEu/1rHXlEpUZhWD/s=;
        b=eh20rTBCz16D2j0lQK4Rwn9x3uJ5eJrmI1DAOtWG4tgXSZPTMht6ip7/5AdnP9uBls
         66ffuQ67JWYpTFrijxDUAPexfUf7E5au1g5NIKYQt7Cz6eHPm9TWJhduk5mNCVdschKg
         rXwXHjv7CW+DbtHKs+iaPVYogwUvuatY+2k6cPa7KQu4JKG+4uUXHxZP1ZJmHhlelonU
         meTb8PuAeg0Pxx6X5E7AzC/fBJiVoXmjnE0rZewB6AluiUairCRadlFd/0K0LaiDc4fS
         E2DKzaII5jc9BwKD8+yvzm4FHggkgfxWL7LN8IkA3TUT3fVrElTv6Ut1ziv2rs7rHZp7
         M6ew==
X-Gm-Message-State: ACrzQf2LWM/AAGR2yACN8Rc1gjNxwA8UBdJjJw+5KNNG9Pt/FZ47NWmF
        YRH8GX+WKZN9lr1dO+1XaeKO2yJrb/k=
X-Google-Smtp-Source: AMsMyM5AFCZbfbvkhfuumOgUv9926ytRT+tbfT6QAKFYfNv0XWXiWPVjD2kegfZ4jawzn93RMO8OCA==
X-Received: by 2002:a05:600c:4e0a:b0:3b4:91fe:80e3 with SMTP id b10-20020a05600c4e0a00b003b491fe80e3mr10024900wmq.91.1664886865488;
        Tue, 04 Oct 2022 05:34:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003b435c41103sm28589642wmb.0.2022.10.04.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:24 -0700 (PDT)
Message-Id: <f0c4457951ca5d052d10f401497917cddcbe2aa4.1664886860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:13 +0000
Subject: [PATCH v3 2/9] bundle-uri: create bundle_list struct and helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It will likely be rare where a user uses a single bundle URI and expects
that URI to point to a bundle. Instead, that URI will likely be a list
of bundles provided in some format. Alternatively, the Git server could
advertise a list of bundles.

In anticipation of these two ways of advertising multiple bundles,
create a data structure that represents such a list. This will be
populated using a common API, but for now focus on what data can be
represented.

Each list contains a number of remote_bundle_info structs. These contain
an 'id' that is used to uniquely identify them in the list, and also a
'uri' that contains the location of its data. Finally, there is a strbuf
containing the filename used when Git downloads the contents to disk.

The list itself stores these remote_bundle_info structs in a hashtable
using 'id' as the key. The order of the structs in the input is
considered unimportant, but future modifications to the format and these
data structures will place ordering possibilities on the set. The list
also has a few "global" properties, including the version (used when
parsing the list) and the mode. The mode is one of these two options:

1. BUNDLE_MODE_ALL: all listed URIs are intended to be combined
   together. The client should download all of the advertised data to
   have a complete copy of the data.

2. BUNDLE_MODE_ANY: any one listed item is sufficient to have a complete
   copy of the data. The client can choose arbitrarily from these
   options. In the future, the client may use pings to find the closest
   URI among geodistributed replicas, or use some other heuristic
   information added to the format.

This API is currently unused, but will soon be expanded with parsing
logic and then be consumed by the bundle URI download logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 8b2f4e08c9c..f9a8db221bc 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -4,6 +4,66 @@
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
+#include "hashmap.h"
+#include "pkt-line.h"
+
+static int compare_bundles(const void *hashmap_cmp_fn_data,
+			   const struct hashmap_entry *he1,
+			   const struct hashmap_entry *he2,
+			   const void *id)
+{
+	const struct remote_bundle_info *e1 =
+		container_of(he1, const struct remote_bundle_info, ent);
+	const struct remote_bundle_info *e2 =
+		container_of(he2, const struct remote_bundle_info, ent);
+
+	return strcmp(e1->id, id ? (const char *)id : e2->id);
+}
+
+void init_bundle_list(struct bundle_list *list)
+{
+	memset(list, 0, sizeof(*list));
+
+	/* Implied defaults. */
+	list->mode = BUNDLE_MODE_ALL;
+	list->version = 1;
+
+	hashmap_init(&list->bundles, compare_bundles, NULL, 0);
+}
+
+static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
+				    void *data)
+{
+	FREE_AND_NULL(bundle->id);
+	FREE_AND_NULL(bundle->uri);
+	return 0;
+}
+
+void clear_bundle_list(struct bundle_list *list)
+{
+	if (!list)
+		return;
+
+	for_all_bundles_in_list(list, clear_remote_bundle_info, NULL);
+	hashmap_clear_and_free(&list->bundles, struct remote_bundle_info, ent);
+}
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data)
+{
+	struct remote_bundle_info *info;
+	struct hashmap_iter i;
+
+	hashmap_for_each_entry(&list->bundles, &i, info, ent) {
+		int result = iter(info, data);
+
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
 
 static char *find_temp_filename(void)
 {
diff --git a/bundle-uri.h b/bundle-uri.h
index 8a152f1ef14..ff7e3fd3fb2 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -1,7 +1,63 @@
 #ifndef BUNDLE_URI_H
 #define BUNDLE_URI_H
 
+#include "hashmap.h"
+#include "strbuf.h"
+
 struct repository;
+struct string_list;
+
+/**
+ * The remote_bundle_info struct contains information for a single bundle
+ * URI. This may be initialized simply by a given URI or might have
+ * additional metadata associated with it if the bundle was advertised by
+ * a bundle list.
+ */
+struct remote_bundle_info {
+	struct hashmap_entry ent;
+
+	/**
+	 * The 'id' is a name given to the bundle for reference
+	 * by other bundle infos.
+	 */
+	char *id;
+
+	/**
+	 * The 'uri' is the location of the remote bundle so
+	 * it can be downloaded on-demand. This will be NULL
+	 * if there was no table of contents.
+	 */
+	char *uri;
+};
+
+#define REMOTE_BUNDLE_INFO_INIT { 0 }
+
+enum bundle_list_mode {
+	BUNDLE_MODE_NONE = 0,
+	BUNDLE_MODE_ALL,
+	BUNDLE_MODE_ANY
+};
+
+/**
+ * A bundle_list contains an unordered set of remote_bundle_info structs,
+ * as well as information about the bundle listing, such as version and
+ * mode.
+ */
+struct bundle_list {
+	int version;
+	enum bundle_list_mode mode;
+	struct hashmap bundles;
+};
+
+void init_bundle_list(struct bundle_list *list);
+void clear_bundle_list(struct bundle_list *list);
+
+typedef int (*bundle_iterator)(struct remote_bundle_info *bundle,
+			       void *data);
+
+int for_all_bundles_in_list(struct bundle_list *list,
+			    bundle_iterator iter,
+			    void *data);
 
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
-- 
gitgitgadget


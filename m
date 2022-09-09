Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B8ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiIIOdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiIIOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A9F2D78
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1461860wms.5
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=L9r7t9bcS3ByqCXgq8jwoUw8iGjCzuqWojuoM/pMy+k=;
        b=BGxMVX8aUMj55ZSQ1lhDstjqWdKrdwSMWRq4m8mBvYPOWYAi6MLCur+U+zf2d3zeRG
         0PNKZ4houXy+aSrM1E0HgbROEbsLHYrxFUETqmN/vn/8bvsIUhqmBFhpod42T/yuJa2n
         4A5GsdLOQmnd6X9Z5YJbnZlNpPUhuORs3F9c1Z4PuoW004djN4l0yh5wl1CaIGI9A+ww
         wx+40yVu8jyxgElgfbwr6qH6IhCS3+DtgGK0kkUsPHEFbDKx6709XsmXuMZrFRUfjFwH
         WkMcHC6V6CE0x7qdhZzP19AhBeORvwkUAsi2+QyJQh2+dPGMR+gsl/72hpt3FwkZ7+0A
         VzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L9r7t9bcS3ByqCXgq8jwoUw8iGjCzuqWojuoM/pMy+k=;
        b=3X8QJj9U/Am/9BhaBzw/BuCRG2g76HaZsCUEGPtbu5BxmgyfJSNVaLxLgYgZg+rTkp
         tJbr8e7vEw/NPOyvZRbpaftWkdQ3bxVA9bC6pwdLRPMjMAOZL3kV8S5hbUMf1ccUWP8U
         5e2cJJ93pwB1GVGBQrDlrOzws7bZOrSE9Wn3QaQdRPgVzdcxW9MUi+Vd3RmHyPtzEw7X
         ZiMwBhwsBe9AlDWdLw2I1ZNinb/6M7SD1IWerq/REWpkZ+zAwNoaIYiAFz4j/5k56GxO
         B+D+CIck+CDtPw0ZduQKXE5sqCZVXsBDJ/VrOWbq5zElXQD/HMdySdgdtJWqPizgmOti
         Z/hg==
X-Gm-Message-State: ACgBeo2NoKDQ+x3OrWI1bzZcESRp0WeuyOjmqWC1SEKQtetj09jwxS36
        4wO4O7eaDUNTi9gOb5G/KFyjygHbF3s=
X-Google-Smtp-Source: AA6agR7btAfXMf/ia0DCu1/njCC+G98mJNxo7p6U0k1DSS5hc4ORC6ReeAYvAv0z4XNcGebL4BLdRA==
X-Received: by 2002:a7b:c846:0:b0:3a8:5390:c3fe with SMTP id c6-20020a7bc846000000b003a85390c3femr5818444wml.7.1662734022023;
        Fri, 09 Sep 2022 07:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003a342933727sm1051832wmo.3.2022.09.09.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:41 -0700 (PDT)
Message-Id: <d981244059439372349c6c48c161fa989df2cce5.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:29 +0000
Subject: [PATCH v2 3/9] bundle-uri: create bundle_list struct and helpers
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
index c52b2a2a64a..7a0bada6eda 100644
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


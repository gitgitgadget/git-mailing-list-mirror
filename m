Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980BC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJLMwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJLMws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:52:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC225B2DAF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv10so22543018wrb.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yrgCoeY0AokBCk/7CF7non/FPEu/1rHXlEpUZhWD/s=;
        b=DpO26lbv2hm/QUW/1L73qG8QTE8uU3HlS2TUv9SNafckj4hjhrkpHAmyN4UfEx0Lnj
         pGSYiTC4r7XYfM1kEinwmPhUB8Dbx0lniqK/zHmD3YAhxvn4ra64GBf/mYJDNfBLQ+Sr
         rSjdMFa3llLusgdCrjvgG0OJcQebBvPk9B8rnZ7ccFeT/6l+JGUskNYwYTbwab9r1w5I
         FsW2aG4XjPigIf7xptK5ZSCs0CH9zaCqUpSZKF6VR8YToo/mswK4KT4bxEBaMb8pNRsP
         K7M1BqX9EWFpmSkwWqBFwBcUg7pcLXrSkpfW7Xci/LM6Byyo7FnXrM0bC5g3927XFdX2
         vVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yrgCoeY0AokBCk/7CF7non/FPEu/1rHXlEpUZhWD/s=;
        b=RzVriXfzn45IYmwsbAYR3bo1hcK7f+MBaM+jP5qP73I8mdird8LFrQ+toW09fOkFSg
         S5zLJtFpfymDj7ljSSrG/7S1yfgNtdOmk7AWWMyknmf6iPuMTPXwN5ykSk2hwSux80Yx
         QYTQfAamNxdtEfR74odaSna0W8UFzWkTUj4Sb4KpEdIm+qCmgjDEcPGM2/SWqp0ulxlQ
         qhqu/REZOmdx+jB9uc1zD2ed7uTsda8d3hRoMsSZzjAaQjlE1yhhpjhs3A2mcj2STtc3
         Ba6GaQ2f0G/cQI9Q5fXavsniuAmyBhjnyJ+9e666Nl1sk4NghFfHFGgdcfKp/496VyoD
         dUVg==
X-Gm-Message-State: ACrzQf2iSI0d9Huxax0MyCUu9/fwIfwVndlZNCXSAng92KTA/mH++mFL
        t/YuJCCmMJFDaflLA1sfZUIexKU8qTo=
X-Google-Smtp-Source: AMsMyM4oVI5iJn6Vgm34MHR1ZsAgZ2KJHF8UjbKqG7yQ0aCUBkAjJV/6RBdwlL548/aWGfC5aLUhNQ==
X-Received: by 2002:a5d:4fcb:0:b0:230:3f05:c18e with SMTP id h11-20020a5d4fcb000000b002303f05c18emr11315560wrw.530.1665579165159;
        Wed, 12 Oct 2022 05:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003c6b7f55673sm1846456wms.2.2022.10.12.05.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:44 -0700 (PDT)
Message-Id: <f0c4457951ca5d052d10f401497917cddcbe2aa4.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:29 +0000
Subject: [PATCH v5 02/12] bundle-uri: create bundle_list struct and helpers
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


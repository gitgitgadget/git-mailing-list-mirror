Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E5C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJLMxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJLMwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:52:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55ABB40DF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u10so26112137wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hj8uYxEbb7O8YWYr7EtPuF6YNvQZhm/4XCGYE1+v8Y=;
        b=PGjtDnHhVqK8h6fJyGVeLY5AACTk6XrOTKg+azbLZgCg2bY0ZFMsLgPe4lu86mwfR5
         McjGCBAFwD/qOLdnywCz+RzS4m4lyUN1aw6tvSM//eYRKr0RxeIdvVYLlNBQbWEgXSS6
         cCg7Xp0bk00RfzFNoiJsYfnEy9ldfXiq3GzamuMhYuHa9O6OX0M78mSpCMzgoDzRsAHA
         JTdgyO5E+XBP9DyVhxeatprddFUfWFBZcpoHAqGm/yXITX00V8NWf9A+GBb5wTWJXfNN
         rKR6sRILo8D9319R3WlQVtM1nEIJ6loXjLTUXL0nuoI2bLEOHwupxayw1M/EQZzLvkXH
         VZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hj8uYxEbb7O8YWYr7EtPuF6YNvQZhm/4XCGYE1+v8Y=;
        b=zOEPtMr8OShgQBl1e5rVtPlOx4KGESdx+5zOFNLTMCEc67DkHDeMpbkv/QjfG9NvdA
         Rq5yBpjzFmtb/eVarIR7QonrWvd69zoSb+MJZ9t7OsUvqsNVV8EWCRIzCtdM7LYT3puf
         m19fQzaN4YhxZp8vznewNSZ0uC4fyYnzNmH8fXf09V1ydiMtlGWyplaRGRO7szEbn/6W
         ciY9hfo69WDLuVEFdIIpiKaduRlEVImWmfzhlIQGWu259BcG+i8bcxhzdSAiIbqNnEzS
         BBhpF2csVerYUEWwx/QVspvz7G7rFTgna6QE3h6wSAmb5ARhTyS9iAqvCv4sX23WmpwM
         D44A==
X-Gm-Message-State: ACrzQf2OU26I7YsFGLEq7tkvulAynBbmCb3Z+dNE7X4NDdFlbadqFN3C
        cGXvuVyHWiBVV3iE0Met+/r91hoxvW8=
X-Google-Smtp-Source: AMsMyM57h/2qz5kzUXyUi8kWx2CjHssRfFaWMZTDeTGc4vyqm8th/i8vUI2wJ02vpbakDReMTJruQw==
X-Received: by 2002:adf:df8b:0:b0:230:5212:d364 with SMTP id z11-20020adfdf8b000000b002305212d364mr10386614wrl.124.1665579166116;
        Wed, 12 Oct 2022 05:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003a8434530bbsm1768939wma.13.2022.10.12.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:45 -0700 (PDT)
Message-Id: <430e01cd2a4127a17c4bfc1b0db7209964736de8.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:30 +0000
Subject: [PATCH v5 03/12] bundle-uri: create base key-value pair parsing
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

There will be two primary ways to advertise a bundle list: as a list of
packet lines in Git's protocol v2 and as a config file served from a
bundle URI. Both of these fundamentally use a list of key-value pairs.
We will use the same set of key-value pairs across these formats.

Create a new bundle_list_update() method that is currently unusued, but
will be used in the next change. It inspects each key to see if it is
understood and then applies it to the given bundle_list. Here are the
keys that we teach Git to understand:

* bundle.version: This value should be an integer. Git currently
  understands only version 1 and will ignore the list if the version is
  any other value. This version can be increased in the future if we
  need to add new keys that Git should not ignore. We can add new
  "heuristic" keys without incrementing the version.

* bundle.mode: This value should be one of "all" or "any". If this
  mode is not understood, then Git will ignore the list. This mode
  indicates whether Git needs all of the bundle list items to make a
  complete view of the content or if any single item is sufficient.

The rest of the keys use a bundle identifier "<id>" as part of the key
name. Keys using the same "<id>" describe a single bundle list item.

* bundle.<id>.uri: This stores the URI of the bundle item. This
  currently is expected to be an absolute URI, but will be relaxed to be
  a relative URI in the future.

While parsing, return an error if a URI key is repeated, since we can
make that restriction with bundle lists.

Make the git_parse_int() method global so we can parse the integer
version value carefully.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config.txt        |  2 +
 Documentation/config/bundle.txt | 24 +++++++++++
 bundle-uri.c                    | 76 +++++++++++++++++++++++++++++++++
 config.c                        |  2 +-
 config.h                        |  1 +
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/bundle.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..4280af6992e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,6 +387,8 @@ include::config/branch.txt[]
 
 include::config/browser.txt[]
 
+include::config/bundle.txt[]
+
 include::config/checkout.txt[]
 
 include::config/clean.txt[]
diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
new file mode 100644
index 00000000000..daa21eb674a
--- /dev/null
+++ b/Documentation/config/bundle.txt
@@ -0,0 +1,24 @@
+bundle.*::
+	The `bundle.*` keys may appear in a bundle list file found via the
+	`git clone --bundle-uri` option. These keys currently have no effect
+	if placed in a repository config file, though this will change in the
+	future. See link:technical/bundle-uri.html[the bundle URI design
+	document] for more details.
+
+bundle.version::
+	This integer value advertises the version of the bundle list format
+	used by the bundle list. Currently, the only accepted value is `1`.
+
+bundle.mode::
+	This string value should be either `all` or `any`. This value describes
+	whether all of the advertised bundles are required to unbundle a
+	complete understanding of the bundled information (`all`) or if any one
+	of the listed bundle URIs is sufficient (`any`).
+
+bundle.<id>.*::
+	The `bundle.<id>.*` keys are used to describe a single item in the
+	bundle list, grouped under `<id>` for identification purposes.
+
+bundle.<id>.uri::
+	This string value defines the URI by which Git can reach the contents
+	of this `<id>`. This URI may be a bundle file or another bundle list.
diff --git a/bundle-uri.c b/bundle-uri.c
index f9a8db221bc..0bc59dd9c34 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -6,6 +6,7 @@
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
+#include "config.h"
 
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
@@ -65,6 +66,81 @@ int for_all_bundles_in_list(struct bundle_list *list,
 	return 0;
 }
 
+/**
+ * Given a key-value pair, update the state of the given bundle list.
+ * Returns 0 if the key-value pair is understood. Returns -1 if the key
+ * is not understood or the value is malformed.
+ */
+MAYBE_UNUSED
+static int bundle_list_update(const char *key, const char *value,
+			      struct bundle_list *list)
+{
+	struct strbuf id = STRBUF_INIT;
+	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
+	struct remote_bundle_info *bundle;
+	const char *subsection, *subkey;
+	size_t subsection_len;
+
+	if (parse_config_key(key, "bundle", &subsection, &subsection_len, &subkey))
+		return -1;
+
+	if (!subsection_len) {
+		if (!strcmp(subkey, "version")) {
+			int version;
+			if (!git_parse_int(value, &version))
+				return -1;
+			if (version != 1)
+				return -1;
+
+			list->version = version;
+			return 0;
+		}
+
+		if (!strcmp(subkey, "mode")) {
+			if (!strcmp(value, "all"))
+				list->mode = BUNDLE_MODE_ALL;
+			else if (!strcmp(value, "any"))
+				list->mode = BUNDLE_MODE_ANY;
+			else
+				return -1;
+			return 0;
+		}
+
+		/* Ignore other unknown global keys. */
+		return 0;
+	}
+
+	strbuf_add(&id, subsection, subsection_len);
+
+	/*
+	 * Check for an existing bundle with this <id>, or create one
+	 * if necessary.
+	 */
+	lookup.id = id.buf;
+	hashmap_entry_init(&lookup.ent, strhash(lookup.id));
+	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
+		CALLOC_ARRAY(bundle, 1);
+		bundle->id = strbuf_detach(&id, NULL);
+		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
+		hashmap_add(&list->bundles, &bundle->ent);
+	}
+	strbuf_release(&id);
+
+	if (!strcmp(subkey, "uri")) {
+		if (bundle->uri)
+			return -1;
+		bundle->uri = xstrdup(value);
+		return 0;
+	}
+
+	/*
+	 * At this point, we ignore any information that we don't
+	 * understand, assuming it to be hints for a heuristic the client
+	 * does not currently understand.
+	 */
+	return 0;
+}
+
 static char *find_temp_filename(void)
 {
 	int fd;
diff --git a/config.c b/config.c
index 015bec360f5..e93101249f6 100644
--- a/config.c
+++ b/config.c
@@ -1214,7 +1214,7 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 	return 0;
 }
 
-static int git_parse_int(const char *value, int *ret)
+int git_parse_int(const char *value, int *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
diff --git a/config.h b/config.h
index ca994d77147..ef9eade6414 100644
--- a/config.h
+++ b/config.h
@@ -206,6 +206,7 @@ int config_with_options(config_fn_t fn, void *,
 
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_int(const char *value, int *ret);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
-- 
gitgitgadget


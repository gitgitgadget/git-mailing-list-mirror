Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677EC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbiETSlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352983AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF13B283
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so4803314wmr.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zFLb7xH9PiKSZE86tS5ml65+DzY46VoQeoqq43XzyOk=;
        b=qTKJps8plEwTAjy39IzqEyWFGkjAtwOJLiL53DVQZZXlTulgXWIELohlMFYXbwkyth
         Lopjd84N+ttaAVsGRpcat2bSLdc78EU3kF+yXXePtO3slDV2UIcUKTHWcAfME6tawSjR
         Y82HcUUS18TzSYBB4ACMprgobyz+RVYfuTX23DIoNvK/fGkKkBjS7BSx9BqUpAKX/XUQ
         jJens/Rct7HvIAQH3F1XrYzdTZiVpm/t+xKoAJNlph0Gh9hFNVzS8+80l9BIQKNXEeSO
         1JI/A+UXK39zmA7nFvo73H8iKL4zxwfsyTRWa6bAVjBPn4HCbM+hS0/vDLmc9fxC1l7b
         yonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zFLb7xH9PiKSZE86tS5ml65+DzY46VoQeoqq43XzyOk=;
        b=s6h9dh+8+U/JyOMLpZLfn6IylPMAN2WaUBhyxBnFqDaWL3ht3YRGFrLpY92nAsytW8
         WkxEES+F3XDAdj308rdeg8MhF4Ouj9Uz0Bc0/Ma36NUfgXvOCuuCQF/WQsnvovFNkRO+
         GBOzstYvtC8GEr+WWQUMpcMoqKypZ+pzKLFiKX7bW5XIfd0XLnwo+gO1keAHACY0b69x
         nOAt0KkcS+IMsfFaP4/5qR0wRndpKdGhz6cX9rYpbl6z+Gt9feKcWKHrFlL7V+pSXJvK
         QgU/cOBlOcrFqlF4b9oaG6Az6ZQVfC500kLlJz35siDirXE7A/B8iIPmcgT4AqUOBlIf
         IFCA==
X-Gm-Message-State: AOAM533Vs6ACi9ov3y6kOlDm7+Kc9NPiNHVN4So9krvwjjsgLIypwloo
        zUm1l3JrPXc9N7MnY40PTJS5DkEXP7M=
X-Google-Smtp-Source: ABdhPJzZakseo9T73ArdZiCR8cVqn4uzfQ/tiCjoUIjuX9IC7E/tsjoHZExHVbkVPn9SWjNaJ3826w==
X-Received: by 2002:a7b:c414:0:b0:394:21dd:e24f with SMTP id k20-20020a7bc414000000b0039421dde24fmr9490494wmi.133.1653072055936;
        Fri, 20 May 2022 11:40:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b0039429bfebebsm2846986wml.3.2022.05.20.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:55 -0700 (PDT)
Message-Id: <2c94a55553bffdf90df7f80c8e971bfe2887fa1d.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:28 +0000
Subject: [PATCH 10/24] bundle-uri: create base key-value pair parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

* bundle.list.version: This value should be an integer. Git currently
  understands only version 1 and will ignore the list if the version is
  any other value. This version can be increased in the future if we
  need to add new keys that Git should not ignore. We can add new
  "heuristic" keys without incrementing the version.

* bundle.list.mode: This value should be one of "all" or "any". If this
  mode is not understood, then Git will ignore the list. This mode
  indicates whether Git needs all of the bundle list items to make a
  complete view of the content or if any single item is sufficient.

The rest of the keys use a bundle identifier "<id>" as part of the key
name, and this cannot equal "list". Keys using the same "<id>" describe
a common bundle list item.

* bundle.<id>.uri: This stores the URI of the bundle item. This
  currently is expected to be an absolute URI, but will be relaxed to be
  a relative URI in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index b9a219d3202..f18bba7071d 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -67,6 +67,86 @@ int for_all_bundles_in_list(struct bundle_list *list,
 	return 0;
 }
 
+/**
+ * Given a key-value pair, update the state of the given bundle list.
+ * Returns 0 if the key-value pair is understood. Returns 1 if the key
+ * is not understood or the value is malformed.
+ */
+MAYBE_UNUSED
+static int bundle_list_update(const char *key, const char *value,
+			      struct bundle_list *list)
+{
+	const char *pkey, *dot;
+	struct strbuf id = STRBUF_INIT;
+	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
+	struct remote_bundle_info *bundle;
+
+	if (!skip_prefix(key, "bundle.", &pkey))
+		return 1;
+
+	if (!strcmp(pkey, "list.version")) {
+		int version = atoi(value);
+		if (version != 1)
+			return 1;
+
+		list->version = version;
+		return 0;
+	}
+
+	if (!strcmp(pkey, "list.mode")) {
+		if (!strcmp(value, "all"))
+			list->mode = BUNDLE_MODE_ALL;
+		else if (!strcmp(value, "any"))
+			list->mode = BUNDLE_MODE_ANY;
+		else
+			return 1;
+		return 0;
+	}
+
+	/*
+	 * All remaining keys must be of the form "bundle.<id>.*" where
+	 * <id> != "list"
+	 */
+
+	dot = strchr(pkey, '.');
+	if (!dot)
+		return 1;
+	if (dot - pkey == 4 &&
+	    !strncmp(pkey, "list", 4))
+		return 1;
+
+	strbuf_add(&id, pkey, dot - pkey);
+	dot++;
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
+		strbuf_init(&bundle->file, 0);
+		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
+		hashmap_add(&list->bundles, &bundle->ent);
+	}
+	strbuf_release(&id);
+
+	if (!strcmp(dot, "uri")) {
+		free(bundle->uri);
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
 static void find_temp_filename(struct strbuf *name)
 {
 	int fd;
-- 
gitgitgadget


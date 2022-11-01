Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA9FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKABIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKABHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C77165A9
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j15so18260822wrq.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0deZTLd7Q4hhlFR48unTZr9maHwfrTk4i/2Pp8BqAsQ=;
        b=iOw58SUwGpC4MN3Z4wGx2T7dmULAtF/DvxOxvQDOOobWhu/mbfKuUxOAqluYENCc9F
         sY/8+XC4bCqPR4YlSOv3HElrYedilV5KplKcYoq4BKsd6zYQ+Il1AW/uKuveLVwOYjRZ
         X5Es1Ywnu+KMnMDZqjRVIB/FKbflLK7MwLz1sLiPf2taL9PjDYMMlR/GwLKrpBja2OB8
         EFJf6L22b0STujSnEbGSH6vrVkBm1YMZZklaIZ6Cx8ufK/RRXvNDEsobcMFGuVErDJje
         TlXJ51dy+q0lBix/ayP5MI9D1CZyKitIKdJVfPZWOBFE8doi7duSvXdZW8C0Nq+ErkQ0
         HMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0deZTLd7Q4hhlFR48unTZr9maHwfrTk4i/2Pp8BqAsQ=;
        b=ixMlpNXdXfIfkdJ3DWeLtJInlvqnl90/FH57uCYtmaPKQG8rbPnikMC9N9ND+A6YX+
         LDlQNJOao3kUnIM5VzT8XhyW0yaa5GfZ1AUkCWKC1l5GGCWPjsL9xsW30Xz239P/tQ8S
         cddlV9yYiE21oJxcXl5UzD2nAY+YUlPIQd2jKWK+XiJ7J8l0Mvl58nzYYHo4eZyO1kXz
         mHgYE1VyCCFopmOu0EG+GzHwmdRB+P/7ukJPLEABsVmLPy0daQZ+qT7u7JYbZUsruScd
         sO6gNYbgjMzhmLgf+SdG37hYEM1NpICKYoubaGOwAB9qfMpZiYNV4ZXg3cCXrjNUCMH/
         Z0zg==
X-Gm-Message-State: ACrzQf0ChNfqdnMvu6enBO79IPZUjqEzqzNIsiMgGZuu/cPJUEWk3g9D
        C0984UVtELahR30VqnJ6FW54qby4H+w=
X-Google-Smtp-Source: AMsMyM7tYHcTbY6eugH8GVIY3v1IfUVz22NwQogM+CIrSWZ09i66CURbcyNW8zgVTx1aDaarDrN1WQ==
X-Received: by 2002:a5d:5710:0:b0:236:cdd4:4cf4 with SMTP id a16-20020a5d5710000000b00236cdd44cf4mr4548089wrv.376.1667264862512;
        Mon, 31 Oct 2022 18:07:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003c6b70a4d69sm1453491wmq.42.2022.10.31.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:42 -0700 (PDT)
Message-Id: <e002affe4bf1367b3397ca452900d6609280f248.1667264854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:33 +0000
Subject: [PATCH 8/9] bundle-uri: download bundles from an advertised list
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

The logic in fetch_bundle_uri() is useful for the --bundle-uri option of
'git clone', but is not helpful when the clone operation discovers a
list of URIs from the bundle-uri protocol v2 verb. To actually download
and unbundle the advertised bundles, we need a different mechanism.

Create the new fetch_bundle_list() method which is very similar to
fetch_bundle_uri() except that it relies on download_bundle_list()
instead of fetch_bundle_uri_internal(). The download_bundle_list()
method will recursively call fetch_bundle_uri_internal() if any of the
advertised URIs serve a bundle list instead of a bundle. This will also
follow the bundle.list.mode setting from the input list: "any" will
download only one such URI while "all" will download data from all of
the URIs.

In an identical way to fetch_bundle_uri(), the bundles are unbundled
after all of the bundle lists have been expanded and all necessary URIs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 21 +++++++++++++++++++++
 bundle-uri.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 0f3902bbd2b..0b0081ed269 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -577,6 +577,27 @@ cleanup:
 	return result;
 }
 
+int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
+{
+	int result;
+	struct bundle_list global_list;
+
+	init_bundle_list(&global_list);
+
+	/* If a bundle is added to this global list, then it is required. */
+	global_list.mode = BUNDLE_MODE_ALL;
+
+	if ((result = download_bundle_list(r, list, &global_list, 0)))
+		goto cleanup;
+
+	result = unbundle_all_bundles(r, &global_list);
+
+cleanup:
+	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
+	clear_bundle_list(&global_list);
+	return result;
+}
+
 /**
  * API for serve.c.
  */
diff --git a/bundle-uri.h b/bundle-uri.h
index 7905e56732c..a75b68d2f5a 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -102,6 +102,17 @@ int bundle_uri_parse_config_format(const char *uri,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * Given a bundle list that was already advertised (likely by the
+ * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
+ * bundles according to the bundle strategy of that list.
+ *
+ * Returns non-zero if no bundle information is found at the given 'uri'.
+ */
+int fetch_bundle_list(struct repository *r,
+		      const char *uri,
+		      struct bundle_list *list);
+
 /**
  * API for serve.c.
  */
-- 
gitgitgadget


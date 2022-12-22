Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8319CC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLVPPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiLVPOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523426ACE
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so1492639wms.4
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl+CWSiRwwdslFulwFO0CZwAJW3T7ygqWyaq3xDlAoo=;
        b=DQDKJ+GDyUnE5weLe1PnVc57bDpbsKzgimgg3M1pdfcXtwBjFLHVqltQYWRsvRLXtG
         GA/7h6cpjKDEJnn6oCSZG3qUMhYoTmKgz1x5lJtE9kuadyRfSnwGRqVsG6ry9nOrLPsG
         HM5X1v/CGojGjzN+OqyB/wqEiJcYcdsRdlVUoUnTzpjsqsq6A4iTP98/vbL2/VzJ3HPQ
         VHcg9k6kqNpC0uKvD9Lu6HKuJg8UNFa2bjM5a89/yHu2IuqMbMW2W4GQwnvJhQV/LJCL
         7sdtQkxn5UCs1MYOa7SPOov0kMGI3DWA57cwyY6wR5kS+1JBCOVeAkWRvkvECpqg6WAY
         4Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl+CWSiRwwdslFulwFO0CZwAJW3T7ygqWyaq3xDlAoo=;
        b=fQFk4Kbs3kxPaTHxWyjMGUHxma6BSBnbCUHzIpMwKpNAZ+Ec+fepg0kauQgjDANxUN
         MqA/0FUCVG6Y7DgqZ5Y15dZR3MYq6zdH7n/YWhA2371Et9hyGT63UMV9+W0WESfjKlOI
         VaKpnkgaQIMlnDH4VAbaY8X73hoYvK3fC0CrADrbXJ0sIe025ve0w7Ol2Od3f1ZgEGrP
         QhNq9bhjEnylbDpFH5Y0Cfue5UlkDtgL9MRRYg2DDkw5NDY+axWjHYxTq7XdOOBrrGV1
         GbFwxeL/ZyxHXrlKMLi/FqKkvvQU6MX6kRjLhHNGad6SDDwrHbXhXYcvZw9Q8f8xboyL
         y1Bw==
X-Gm-Message-State: AFqh2kpBDk7L+oN/4L1LbufJC5kQvX0sg3ni8tzKjGWdoG6g9e4473gF
        DwvCQnPaOgVrncPGOwg5VwpbYxcVcbM=
X-Google-Smtp-Source: AMrXdXuN1h1KImxrgub4BjEuaKyozzekQDyS8E4Rrgr3IGSk0/cTg20RgEupKZ2jicwh+VrogNs4lA==
X-Received: by 2002:a05:600c:3b21:b0:3d0:d177:cadf with SMTP id m33-20020a05600c3b2100b003d0d177cadfmr4447907wms.32.1671722067999;
        Thu, 22 Dec 2022 07:14:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b003d220ef3232sm1439844wmq.34.2022.12.22.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:27 -0800 (PST)
Message-Id: <72ca6f4254fd29edaba9f201324e22892b4dfb2d.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:16 +0000
Subject: [PATCH v4 10/11] bundle-uri: download bundles from an advertised list
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

The logic in fetch_bundle_uri() is useful for the --bundle-uri option of
'git clone', but is not helpful when the clone operation discovers a
list of URIs from the bundle-uri protocol v2 command. To actually
download and unbundle the advertised bundles, we need a different
mechanism.

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
 bundle-uri.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 69929d363cc..36268dda172 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -577,6 +577,27 @@ cleanup:
 	return result;
 }
 
+int fetch_bundle_list(struct repository *r, struct bundle_list *list)
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
index c505444bc75..d5e89f1671c 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -107,6 +107,20 @@ int bundle_uri_parse_config_format(const char *uri,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * Given a bundle list that was already advertised (likely by the
+ * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
+ * bundles according to the bundle strategy of that list.
+ *
+ * It is expected that the given 'list' is initialized, including its
+ * 'baseURI' value.
+ *
+ * Returns non-zero if there was an error trying to download the list
+ * or any of its advertised bundles.
+ */
+int fetch_bundle_list(struct repository *r,
+		      struct bundle_list *list);
+
 /**
  * API for serve.c.
  */
-- 
gitgitgadget


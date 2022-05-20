Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B362C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353079AbiETSm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353036AbiETSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E978735DDF
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so1001730wrc.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=22bNOx9iIfp5RrqM8Z2BuI64MfYb2vIbQ/DUGNPuv7E=;
        b=WNRwNgaZFa1+ZJXlCvLkxFYCJaKP75o2vpJ5lKUDW+R2MJBs1N0dBJloh9gBolsG0w
         HM03MxjAFFLrC2ZOXmPq7zFsOK4ECXwQN7GnbrdUIe/a36x4YFDYKwqB5CJLT8wHIjmH
         6DfOOL8P7/GeU8siR/gvdDCz54NOUChG8begKo46I/NVlNzoFXDGs/3xP8dGw2DsC1r+
         E83RYlYyQFS3uiHormX6oR2ZA8H2fIRLQdCGOpc7PI6sN/y6u7s/ILRISlz80MnrhEfv
         j+WAwv2oB33rm8KUKN3THah/rIT9mLATv3dj0x2107FVg1Qf56m25N6I0J0VTnAsT4Wd
         zp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=22bNOx9iIfp5RrqM8Z2BuI64MfYb2vIbQ/DUGNPuv7E=;
        b=KpNxvoR4wfGMjhprideiLGHFmJ4EiiTiRMf77kjzkFc5crAw/XZFVfRUbCvyUkPLni
         VFKoR8bKaKz09HMADn0tHdz6nT4PXtSJelRhx374y/GwGMrH0JxoH47lWlwmxI2xY9TR
         dyAYf9hR9sjVxtG1R3xAtpJSbGnDwixnf/8GzQ4vsUeCLxxCoZpYwuq7cPMEGj7DFbdf
         eVd954HINoq4FQcekGgZgnTOCRln65+qXFCsbStLgwagxV4m6ckqxy+kpXRiit2ibhXI
         0/9NlVyBf4sA9ttfji3HrnVcdgHfcuqPJUihC4uN/qWdrVpGEAX0nTFnNsRYShLZlH/Y
         A9lQ==
X-Gm-Message-State: AOAM531ILWapgzmUIl7rp+3e6sMH7o1LcDAWtSoZ4LDjIs2rlQTZibrv
        sXBpE8KIEzwtlQ9D1RV3NIuhvEaCrTw=
X-Google-Smtp-Source: ABdhPJwaRxZdGVFl7NhxqN6z+ezo1Bisyu3zrQE34rEXn/b10EAWOWSrvHXmEgr0mZqaW02uuXVQlw==
X-Received: by 2002:a5d:47ae:0:b0:20e:ee15:2482 with SMTP id 14-20020a5d47ae000000b0020eee152482mr3557126wrb.155.1653072069273;
        Fri, 20 May 2022 11:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17-20020adfaad1000000b0020d0c37b350sm3622115wrc.27.2022.05.20.11.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:08 -0700 (PDT)
Message-Id: <c0d6354388168c85fb7bb42824cdc8fd2879e898.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:40 +0000
Subject: [PATCH 22/24] bundle-uri: download bundles from an advertised list
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

In an identical way to the fetch_bundle_uri(), the bundles are unbundled
after all of the bundle lists have been expanded and all necessary URIs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 21 +++++++++++++++++++++
 bundle-uri.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 9e7dc0fb4ca..43815b3c5fd 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -561,6 +561,27 @@ cleanup:
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
index fdcaea048a8..1bcbd43320f 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -107,6 +107,17 @@ int parse_bundle_list_in_config_format(const char *uri,
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


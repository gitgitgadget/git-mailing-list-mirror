Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCDCC4708D
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiLERwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiLERvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F5263E1
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 09:50:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so19797665wrh.7
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHJA4BH3cwSREt24TlkbDVnBn5j0+GPdetbayNtBX+0=;
        b=Eb/2JHKlN5nTPLwoUaZQKvnneXpyuppfw9NlDnDgoWcrjbyd4v4qlIS17ItYux18co
         vZr9A81ZcpHPLdDG9HnNMszLkfP4mwuYCHr27brwg3KQdLo+YwFZpSiaCUGWS5g/rhBf
         UXhJk8yzMcS15oSb5SSHqt+Ghj9rcBUp4/sOWrp9zkf+QUd1nKJvePdOgKj/gOsNrrf6
         gxipNkXlmXyguMRa28PZ0ffHx1e7ghePR7vVTl200jQCz0Fnih6+gvFivqgur4FVuxKc
         /4o8axZwyiQTaQDLPP99mMHoCSDoLG+Vj0nCSGNdLQAM3yP6VsZ7zz/yKCU1KvxcfMW4
         soHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJA4BH3cwSREt24TlkbDVnBn5j0+GPdetbayNtBX+0=;
        b=iMEqxSK0vQQYp98QDJAARu8upuVw+O/9mEHeasgXavIrZNzt83y7b5P8n4r3mGYPLV
         YujW/Fyl0+kvca8UEgg0qt2CFC7L2W87heH1q+Kr6A1lxu6YSl5uNY0tuWWoDlVa9OU5
         TeOKyHDVaTMeUKXWbMKZHtQUm7tz65KwEXVvZfnTJfR6Nk6Nl5IY3dkchP0ppAMRf+Ld
         E7mcR+bIHLCnEeJOwy+pS0n8GyhdqF6kGJEX0M9QmFlMBuN8EQOQ/XCjHPvHw8ccvLva
         TPTvnEf4gQf0C2+XFA7u5Yb+Z3Sk7IdWWjBmWH0pgiaQVRQx94zbiVEXATVxoK9oARJS
         djFA==
X-Gm-Message-State: ANoB5pl4DAQbCFQthZoUsrJgNeVFEfLZlZq3j7a+solF5CqEZYkDil1O
        2pdMnsbkr4vC34a9ha1P7j0SeoFhUWk=
X-Google-Smtp-Source: AA0mqf6edIpKZEgPsMFFlniaObYwEI6Ll0/W6fwEd62tYQSSxDMFmci6YILenv8+YugNtg4ZAOAn+g==
X-Received: by 2002:adf:eb92:0:b0:236:80a8:485e with SMTP id t18-20020adfeb92000000b0023680a8485emr43539867wrn.362.1670262649187;
        Mon, 05 Dec 2022 09:50:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003cfbbd54178sm29564680wms.2.2022.12.05.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:48 -0800 (PST)
Message-Id: <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
        <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 17:50:38 +0000
Subject: [PATCH v3 10/11] bundle-uri: download bundles from an advertised list
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
 bundle-uri.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 80370992773..c411b871bdd 100644
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
index e7e90a5f088..b2c9c160a52 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -107,6 +107,17 @@ int bundle_uri_parse_config_format(const char *uri,
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69BC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352875AbiETSmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352993AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF935DDF
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r23so12659728wrr.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7jf/Qvs+YbZCVktwxZnFfMFTgKuzKOgMphX87ENTMW4=;
        b=SX4iHTld2C6a9KXcHg0YbrBqcne7oxM9Yt3L+ci3bRVRjyQvh3MjOtz4Wq39p/zLrN
         rPk1UgdpGR2e4YcxoJG6PZjG2mM4fRGUYkTJVHyxp984+vQPFOrbusexgUdIOQudr0yt
         ZM3Rixjr5kyh+HxekDsqjAv8GUYKk1HJggZuNF8TDlRkwfxN8W8g6S7F/tvprVuEa0rf
         S1NFJylHnSmVaJpQmITbfA0HG7xGtNpPIFxUvQNkfU2KTJnbFKSdq38ty+YphiRgGgI0
         mwNVQo1PNUERI49UcU/avWNu2SZj+16Kd12hbylQpTF6cVif1ONu1EoJhPKIqiL9EyCv
         KEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7jf/Qvs+YbZCVktwxZnFfMFTgKuzKOgMphX87ENTMW4=;
        b=pPPxqPYFl9or4iyjcdVkbHrx7SadljeTEvykr4BM5U8C3erL2yDE9aYZghHlzAMFWL
         /mOFMNU8RLlVuuajiX1/jvzRQTAI308VufLFgjpP99RsfafvbhJXjCZv+e9U6Daxd9D5
         4NhmrWLyaNCZrQ4VNdpp4m0bqilNe3lYFFSTRK3IByZF4dkXGv8a49PVSRVyFYuuKD0S
         /zEwVDfqBLxMfut+j1su46PzsprnRjyim6/7Es28OPRJ0h0CjTrYUuQuKEFKvWzXlqTD
         xDO794ytRDFx2ZU3YSbrIwBj6cmvaH83VgVQt0YjLdcOYg4ouc7CCk82lH8z6OQjqfyh
         qxSw==
X-Gm-Message-State: AOAM531Dtquxv1ReGOQC5UxqNM/7xD+fDtz/7BeVlvgEI44ymsEtrU1n
        7QZCImWEoSeJ1NlYHoD5fqTMRQT0z/E=
X-Google-Smtp-Source: ABdhPJxKtmkXSKN+il7NqlxPsjLtfZ3KdIjG1AB5uaS63+xavBRTFXhntC4oGOIuNNi+mG5eiKjReg==
X-Received: by 2002:a05:6000:1869:b0:20f:c1a4:111 with SMTP id d9-20020a056000186900b0020fc1a40111mr2282011wri.261.1653072059030;
        Fri, 20 May 2022 11:40:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcc14000000b00394351e35edsm2561094wmh.26.2022.05.20.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:58 -0700 (PDT)
Message-Id: <00dc67f5188b107d5ddaf8b32f03fa61f515a5ec.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:31 +0000
Subject: [PATCH 13/24] bundle-uri: limit recursion depth for bundle lists
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

The next change will start allowing us to parse bundle lists that are
downloaded from a provided bundle URI. Those lists might point to other
lists, which could proceed to an arbitrary depth (and even create
cycles). Restructure fetch_bundle_uri() to have an internal version that
has a recursion depth. Compare that to a new max_bundle_uri_depth
constant that is twice as high as we expect this depth to be for any
legitimate use of bundle list linking.

We can consider making max_bundle_uri_depth a configurable value if
there is demonstrated value in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index ff215422888..74a26ce6c00 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -308,11 +308,25 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	return result;
 }
 
-int fetch_bundle_uri(struct repository *r, const char *uri)
+/**
+ * This limits the recursion on fetch_bundle_uri_internal() when following
+ * bundle lists.
+ */
+static int max_bundle_uri_depth = 4;
+
+static int fetch_bundle_uri_internal(struct repository *r,
+				     const char *uri,
+				     int depth)
 {
 	int result = 0;
 	struct strbuf filename = STRBUF_INIT;
 
+	if (depth >= max_bundle_uri_depth) {
+		warning(_("exceeded bundle URI recursion limit (%d)"),
+			max_bundle_uri_depth);
+		return -1;
+	}
+
 	find_temp_filename(&filename);
 	if ((result = copy_uri_to_file(uri, filename.buf)))
 		goto cleanup;
@@ -335,6 +349,11 @@ cleanup:
 	return result;
 }
 
+int fetch_bundle_uri(struct repository *r, const char *uri)
+{
+	return fetch_bundle_uri_internal(r, uri, 0);
+}
+
 /**
  * General API for {transport,connect}.c etc.
  */
-- 
gitgitgadget


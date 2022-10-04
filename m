Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF7C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJDMey (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJDMek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BD1AF10
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w18so12368567wro.7
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=KMgYbctfP63LjeKie+sNTmH+1ki+aUmGYCxPXwNUpCTuQP8VWyAHVWVEEdyvO25LIN
         kgWI7YXlZLhY2dKwcfcXx+YLIckU7PeUEj95Vn2V3MDmKs6Q2CXAfRPTOH3nIn7pf36u
         Zv5XQTq5ht1bgYUyIuMjovs8AvRnKR+Os3ihQYhIsq2Y4PESDyO6qzGa11QwT7nZaSB2
         ymySGsFKccN8NNrZMTa3H2UcBYzPxW22sYRqgq4t9ABbRhI6wPS2dsMUcSjYIArhuCYF
         V6HfhpuqkO2iL3IYHjqKJwx7NHJ+6BwTtsWg85OmBzi7o4ap9YzLtaWgcrok8bpwf3up
         HtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=teVoB9akSDsjUQOibTWfp2pbErUC3rWfvdJfUaAcyAVlkVUQ7v6V9pYLSgcJEFytc4
         44Nk1kjpbE9M4pLUMo91mEfAUVmK9H5tia7rc8NX46ycMaZHOKXs7EiCPgad6x2xNoLa
         7+weUDSj4tCAx4LwpRaii+akLJjjPowfyMYae3rcSssOJiXy2o6HRaQsEumx+mYoG2VU
         HjFFlJrlPgtUgldF6uBpr5edeIfC13mI01X4/ZeWZ1hVJiJ5xOoMQWggJ8c7QvwTw40T
         mAhNIy+Wxopl0YFChHwYQYpXhuWY9hCUUwCsKmgJhgjjbFsUp2fYdbf9xlkcG+joLq8v
         EDbw==
X-Gm-Message-State: ACrzQf2DGAnakR+2pppsdmUHzVtKMePaHkGGIdZrSyj20TAqDJNIMoql
        gmsK3WsF3CIPF6L4XYOgAOSzIX2Ynjs=
X-Google-Smtp-Source: AMsMyM4o83nahrsQmcdgm6lZ/PThTmsR/9bHDEqQm7QRjNccuPe09VnbXxBdn59JtR8JoxcEeLm2yQ==
X-Received: by 2002:a5d:620c:0:b0:22b:e59:8d3a with SMTP id y12-20020a5d620c000000b0022b0e598d3amr15849279wru.28.1664886871237;
        Tue, 04 Oct 2022 05:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b0022ae0965a8asm12201479wro.24.2022.10.04.05.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:30 -0700 (PDT)
Message-Id: <7e6b32313b0f1922c0d0bfd104a288b8606306ec.1664886861.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:18 +0000
Subject: [PATCH v3 7/9] bundle-uri: limit recursion depth for bundle lists
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
index 3d44ec2b1e6..8a7c11c6393 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -334,11 +334,25 @@ static int unbundle_from_file(struct repository *r, const char *file)
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
 	char *filename;
 
+	if (depth >= max_bundle_uri_depth) {
+		warning(_("exceeded bundle URI recursion limit (%d)"),
+			max_bundle_uri_depth);
+		return -1;
+	}
+
 	if (!(filename = find_temp_filename())) {
 		result = -1;
 		goto cleanup;
@@ -366,6 +380,11 @@ cleanup:
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


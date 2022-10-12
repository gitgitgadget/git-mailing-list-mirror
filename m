Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168DEC43217
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJLMxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJLMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:53:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A31CC90E9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so26090220wrh.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=QwZQTfszRDPUbIs7iIb1XmhJe5Qz5zcW6LY7FtmmLC80U2OZIjLTKh64Doju6hcj7d
         5tRUDsi8LwSTzE1Ol8wQTAay3czxr6U+AyItr85Qz75WfMia05hnO9/I4ay4M1xyCNut
         8Xzhl8C/RmhsLkVQpqE1lh2t6hRYHG97ndv0kZGzsYHufjZqgxs78pJrtqvC4vVSEtLs
         I1Vc50JI+s5EDkO01m21to0zcpviKSy/8EZXbvrksoMv9cqMdf1Zfupm4mwtnFAbVMUl
         nDwO8RVtD8ndThOld86XrmoJWId3XlnOW00llrBlQlMoImL+2DQs3TdN7BijdeMtbKj2
         SwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=MIwC+KXcMrz2yRsdXQaI69LJptn/i8AWfbHiO0efBAlq4oqMCq2c1YFndY4jKDiDer
         AlGNRJ4kPKKQzGMOWClYp28Z+ze7UUYycbZuOneXJ09jLlIWRIpkY96AptkTIhJJDvEE
         /XJ2YUymFmPlbdRVvirRkW1w20O9cpipSaQuEl6YKoQj8N/M52/QaJIsEfdtr3KxW4kl
         d8pJLNFNrBYNyz3g7WB+iJHmVEbj3hDyjvcM01eZMBdWc1O+sjzdsA9dzQ0BzAZnFiho
         3F4BQ6VomkrJsQyTQhQWHx3N4HwSCYEWBncQOhK/x0O50P8isZiuUoICv9dnM3bejlaJ
         nPPg==
X-Gm-Message-State: ACrzQf0lgU985zlqRPcPUe0i2KUHjg3UEM64exhjdjV/Flo7xrzyWT39
        lrjFjVnA/+4bvpr0Vqxubpcil43D60M=
X-Google-Smtp-Source: AMsMyM5xiLAcEMuMobC/wf4+eLHUR2VBLUU+lrQflUh1+whlMujcQoNOBZrMRxAPS6Hivc9kHxwHdw==
X-Received: by 2002:adf:dd8d:0:b0:22e:4675:86c9 with SMTP id x13-20020adfdd8d000000b0022e467586c9mr17394136wrl.643.1665579170982;
        Wed, 12 Oct 2022 05:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003c6d896a17dsm599087wmo.32.2022.10.12.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:50 -0700 (PDT)
Message-Id: <7e6b32313b0f1922c0d0bfd104a288b8606306ec.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:34 +0000
Subject: [PATCH v5 07/12] bundle-uri: limit recursion depth for bundle lists
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE0C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJJQEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJJQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1A72FE5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6673891wmb.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=Fw7i/prZOHgHYY1SkwiDJk+xHNRmDLrhaUHTM90COmQ7lBHJwI2t7UVRfAoIrmarDz
         NvSGb+Q5KRUAZl0LWPoKXV56p0pP+nUMeUfDUcy3SS6F6vehL55wZJREvxp6N0fGvug5
         QP1oDrnfJYdR1TwQUa6R43xeHx+JGsZ2Uc1Hvo1AW+blsH6h4Kmfto0dd0str6kY7aAp
         6bO11GOa9um+2cYmai298g9ilu/6wHecbGjf9btSfH8S4L4uv9D9kJkOnNfzpoljuWfr
         f3WOik3yeB6U3YeuniJeLVjUK1JMpQu4H/bd6z1xnTT2+gqhV9Xh305t2PnGmaMmCKqg
         ht+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMNeldL6yVM+YKrj7w8lZD7yCcA2s/qR6KN4/yWumMc=;
        b=yZPFN1TnZmN1fvItBaeocR4Q12kCHL1+eupKmcUtuQzt57spXmeLatvGx7ege3o/W5
         5/rzbS7/BSiErV6kWDNBXkby0sY3WdDS1uQWrsRDb74GJOa5kJie1YC6QZ0WG2iPFJf0
         KYESV5DZKEi8JmS42/u9rJmp+3f0fyZfw7qEdlxeKPN9f91tLHEV9fOyxcTBYSM0PUgV
         iLWKz/VMYckOlEFhV2ke0hYYa6X2azHw+5U/rCeOvGROrLWUZHuXtJTEyRgn4UvC+6t5
         dwi+le5MpNruCC4aZsvFj9wRNVrJ0hnTKy75yMsMWNHcwvQCwzSOmVUy0x4saARxJmew
         9M/w==
X-Gm-Message-State: ACrzQf1eknx/lavLf64tw6DP2Buwe4fic2580ucOMiPj7h6mhSscGBsk
        yFaM7rWrStEDyQE4Z/yzQDcTj8+wuj0=
X-Google-Smtp-Source: AMsMyM5GeZAJeGy1tt8/jM79T4gR8V1/J6cFo9OEZt12VYDXNXlueFzda7NPLiBcuoN/ZemZj0qaSQ==
X-Received: by 2002:a05:600c:154e:b0:3b4:bf17:32fc with SMTP id f14-20020a05600c154e00b003b4bf1732fcmr20735824wmg.70.1665417870002;
        Mon, 10 Oct 2022 09:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05600c3d8a00b003b47ff307e1sm10389325wmb.31.2022.10.10.09.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:29 -0700 (PDT)
Message-Id: <7e6b32313b0f1922c0d0bfd104a288b8606306ec.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:15 +0000
Subject: [PATCH v4 07/11] bundle-uri: limit recursion depth for bundle lists
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


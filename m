Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F6ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiIIOeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiIIOdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F08F16CA
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h1so1533273wmd.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=JnsLUcB0ykBlbNUWKol07sfqMcsXd7medZlS/hujmw0=;
        b=GxzxCyIr+nqmojyMg40sgK9vN8QzEPkJh3kR37/81Qc7IzeA2w1O1kRbpISTgOb2dB
         5lYXlx62A8/kBT7uz6ivGaDF3ycFWG3XP7o54I7274Gs9PMzBvJnUSOKeJQ0wUmPjAjN
         n6DGb61ZmFYso0RCmF3WAJ81xhJKb4jswQqATr2SHhK/qMtWQhM/dqhZe6os7TpVkeRD
         y2gt/W+0EdwgHWbM4xTfbuzSV6RSeeKX7oFAOsCeyzS7KH4lJi+cbir4+EZn4NDaYBTU
         wSI/sjywpOL/xtlJWlyD9q0Vmlum1Og6zWGwzqIGyGjQ8Q63abW4ywP1Ccn4KrJcBrgd
         HCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JnsLUcB0ykBlbNUWKol07sfqMcsXd7medZlS/hujmw0=;
        b=Ft2UJmw52nCJe6EYzZsi3x9Yz1OJTk9noAl8H7szQ3QO5vKN+PmJi7GNEUuqf6oJoq
         jjKEOFFti4Ph+eauCT6zfPgmA8vDC63bcPatK6L6kZJsP07ckhFPPbsHMPINsqrDb/lw
         XrB4C+//gfOmOTUxrXSa7Q8hEyLWP5tOVqJhrkYKR+zd8gGdEKeW2L9SRkQ2yn9Pko5Y
         erTO8kYo0vaTdvPmNG+LjRWFTTEiKTWBuGyLXej97rCTnJrfRgHk5jzDpjafAfYdP2QI
         O6rctcvhbeBR2s83hzKSfOifsHH8/cdMwN7t8tkhh4Lh4T+zCziEkDT4zqba95FbBScM
         dSlA==
X-Gm-Message-State: ACgBeo04ebevvTjYgGrKeLDP+dCsdOSkCmIQPty1RzPGuG3ZeBsmiD01
        FFfUSHMuBWw1Tsh03YXWat/TA8KfxNU=
X-Google-Smtp-Source: AA6agR5aU4ARONbBSuWfG4k7hcunU2dsOCXPhVA8mm/7c3cbmUWzJJm8lWzTk1L6ROlrZLYzXMTweQ==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr5612278wmb.91.1662734027486;
        Fri, 09 Sep 2022 07:33:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c241100b003a5de95b105sm756368wmp.41.2022.09.09.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:46 -0700 (PDT)
Message-Id: <b5d570082fa7d63d97d3e96a48001e305700288d.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:34 +0000
Subject: [PATCH v2 8/9] bundle-uri: limit recursion depth for bundle lists
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
index 92354aa3bbd..b8ca6cd9493 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -336,11 +336,25 @@ static int unbundle_from_file(struct repository *r, const char *file)
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
@@ -368,6 +382,11 @@ cleanup:
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


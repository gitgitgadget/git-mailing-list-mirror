Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D0DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7C8610C9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352111AbhIHPdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352043AbhIHPdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDBC06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso1942521wms.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIH2ECZ28g/q3GopK7kpY3M8T4ZDJ2P0X0g1dFXaPC0=;
        b=mC4LnGgEJ0C7fR3cSFm4cvLEZxmgwI63ZTS53twrAiHyLrzjlVAelXz+i8j8BChr5b
         fy0DuQFDHxTACSl0Gy+xvyntGqvLwF9rP0r0kXMzctIFBbSF0NxJITYuG+tNSmVabccH
         TVLB05kIcbp1S2jBZHYScW23bOVRTWV6ActrZYZhzWt+VkI4eT1DVHAMTPsR7hQhgfVP
         JjdbVLhYgi6bQT8XSW0HYTeCwQCzmgEtK2O4fnc/PlQTkDPur9c9Mly7JFcK5vtdwMY9
         Ekoo18/aEG3S6MgnWLqDLhBYlyeTndGksNdiq/utPDzUzmhvAQ3jSTJoVdAu6ZoiEdyx
         u1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIH2ECZ28g/q3GopK7kpY3M8T4ZDJ2P0X0g1dFXaPC0=;
        b=4B3b8TfvZZmUU1/r4HpP1NhGIdDFCFvIKmYBq0aOJ1oxcPmgzGkCYKTKJo5D1i49Qk
         GPfVV9gncBh2JwRyQaT7F2trECWLoI43QAzN+wWMRZIHwyl3+AlYjc4CvnFjgJ7v1x+c
         UmQABCVIlNsfnreACsZqqRbIZeJdCVal6SNytWUSmmhBumqv7X8TTMcRSZhKJfZgUdgm
         o6DxzAc/zRJNEmXol+gDSAghknJ8UTAVc4ZtkERQIedd/W9jwqMUY7FKzY4CRqrtkGgw
         lVBYQCU2fBMSt98Q/HaDwU/aBcYS9FWbnvDib6lwV3gAqGPpUpD/hnSVf8vrmUhDO1bO
         eozA==
X-Gm-Message-State: AOAM530FFRxHnN1le3kE30+EhjVsYqLDqgq0zm31rkyGISOTxWC4iV2v
        lGB3LoJEIn2j/cCYLxxdU/92FwB4TJEYbg==
X-Google-Smtp-Source: ABdhPJwfHMwlbVn7uhKqqZN9LOrmHfpOLKFvvnlEHOuX2nyABpfKVwtqa7k514jdQqfUSg8EWbETiw==
X-Received: by 2002:a05:600c:2114:: with SMTP id u20mr4268783wml.65.1631115125693;
        Wed, 08 Sep 2021 08:32:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] http: don't hardcode the value of CURL_SOCKOPT_OK
Date:   Wed,  8 Sep 2021 17:31:56 +0200
Message-Id: <patch-5.5-4f42c0e48b0-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new git-curl-compat.h header to define CURL_SOCKOPT_OK to its
known value if we're on an older curl version that doesn't have it. It
was hardcoded in http.c in a15d069a198 (http: enable keepalive on TCP
sockets, 2013-10-12).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-curl-compat.h | 11 +++++++++++
 http.c            |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 2bba7adefa6..bfa85711511 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -17,6 +17,10 @@
  * GIT_CURL_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part
  * of the symbol name that "X" and "Y" don't have in common.
  *
+ * We may also define a missing CURL_* symbol to its known value, if
+ * doing so is sufficient to add support for it to older versions that
+ * don't have it.
+ *
  * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
  * distros have been known to backport symbols to their older curl
  * versions.
@@ -25,6 +29,13 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
+/**
+ * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
+ */
+#ifndef CURL_SOCKOPT_OK
+#define CURL_SOCKOPT_OK 0
+#endif
+
 /**
  * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
  */
diff --git a/http.c b/http.c
index e38fcc34d64..c40439d39ce 100644
--- a/http.c
+++ b/http.c
@@ -533,7 +533,7 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	if (rc < 0)
 		warning_errno("unable to set SO_KEEPALIVE on socket");
 
-	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
+	return CURL_SOCKOPT_OK;
 }
 
 static void set_curl_keepalive(CURL *c)
-- 
2.33.0.825.g2bf60429931


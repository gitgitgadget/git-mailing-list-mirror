Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCABC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BA20734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="a0ZlZzWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHJVe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E29C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so9847811qkb.8
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Fc2qv7QNbKAklvZ2pqqMAXUIQRikZ+en0/8xZepLBE=;
        b=a0ZlZzWJAI4j1RWcnl2Vumfg1j/NiqKp1DUWSmmx/MHeHpsyehN6c2u62b+f1UYJd5
         4w/Iho/Fxd1Jem8I9xfv8aU4sPXZ4hzn/ncTjfAAYaGHfAxgFB678Sx2smVuvLODkwYS
         FVBCagaqekiK6OeAnIqiI/Y9FvK8LOeju+Lkz/BkkTvXv8xV0FdF1AW/gFOIh31Hu+b3
         NAJWz+OF8nR08E5bDt+G343w7BH4cn42eHbRfH2flGmJzrfi1LadC5wD80wFqjtI2yzr
         oMJaWfNYU3YBicUa+EM0XI7/e0M+0IdkqdDfkA+8iGujGrMArLaF5GRVKlo3TkNH2pSp
         xFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Fc2qv7QNbKAklvZ2pqqMAXUIQRikZ+en0/8xZepLBE=;
        b=bgwtqf6L1HTGMRhvPASLLBmoUVwQT678gscw4qT8kXXHYoPTWNimJbreG4HYzgJK4e
         Kh+vwHH8pOUKQOJaZw6BylUiFg+Ag2N2wGXtPPAVI+Qy7MxS93p+DTSmRFJF0T7DY2de
         eM7Nk380Gvdc+F/9Zmf/iLIFgi/YayXNEIgnE/jJMkQktM9/nTnomuLCtPNu5c6LvZcf
         iumdqbG4oF5Zcr5sdA2+umqCPsT28ad6xzAve+kg7lPAMMtzLDq2JV4muzsgR5mHvenG
         ZcaG44B3SbsHHALHx2uwVxxP3H/pM1UmsmXhIFY3svt4ri4XDQXsFsKr2E+rejyBukv2
         E/Tg==
X-Gm-Message-State: AOAM532+8k3rpJG+KO0NGJIdu0UEnOWippInauOHEXNPAsY9m+XDmLJ4
        PxGxxWcw/N0sdlvhO13BETPG6t4Y6/s=
X-Google-Smtp-Source: ABdhPJyQ9LhnKI37ExBVUkVSt//QUEzCbCtEukc4+UGdlrgQW77EMHmPKsYiPYJoKdI4hjBDCk9NEg==
X-Received: by 2002:a05:620a:1105:: with SMTP id o5mr28652882qkk.434.1597095264160;
        Mon, 10 Aug 2020 14:34:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:23 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC PATCH 01/21] convert: make convert_attrs() and convert structs public
Date:   Mon, 10 Aug 2020 18:33:09 -0300
Message-Id: <b13165f10859b97412cb94828ea139136cdccfb2.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move convert_attrs() declaration from convert.c to convert.h, together
with the conv_attrs struct and the crlf_action enum. This function and
the data structures will be used outside convert.c in the upcoming
parallel checkout implementation.

[matheus.bernardino: squash and reword msg]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 23 ++---------------------
 convert.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 572449825c..9710d770dc 100644
--- a/convert.c
+++ b/convert.c
@@ -24,17 +24,6 @@
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
 
-enum crlf_action {
-	CRLF_UNDEFINED,
-	CRLF_BINARY,
-	CRLF_TEXT,
-	CRLF_TEXT_INPUT,
-	CRLF_TEXT_CRLF,
-	CRLF_AUTO,
-	CRLF_AUTO_INPUT,
-	CRLF_AUTO_CRLF
-};
-
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
 	unsigned nul, lonecr, lonelf, crlf;
@@ -1300,18 +1289,10 @@ static int git_path_check_ident(struct attr_check_item *check)
 	return !!ATTR_TRUE(value);
 }
 
-struct conv_attrs {
-	struct convert_driver *drv;
-	enum crlf_action attr_action; /* What attr says */
-	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
-	int ident;
-	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
-};
-
 static struct attr_check *check;
 
-static void convert_attrs(const struct index_state *istate,
-			  struct conv_attrs *ca, const char *path)
+void convert_attrs(const struct index_state *istate,
+		   struct conv_attrs *ca, const char *path)
 {
 	struct attr_check_item *ccheck = NULL;
 
diff --git a/convert.h b/convert.h
index e29d1026a6..aeb4a1be9a 100644
--- a/convert.h
+++ b/convert.h
@@ -37,6 +37,27 @@ enum eol {
 #endif
 };
 
+enum crlf_action {
+	CRLF_UNDEFINED,
+	CRLF_BINARY,
+	CRLF_TEXT,
+	CRLF_TEXT_INPUT,
+	CRLF_TEXT_CRLF,
+	CRLF_AUTO,
+	CRLF_AUTO_INPUT,
+	CRLF_AUTO_CRLF
+};
+
+struct convert_driver;
+
+struct conv_attrs {
+	struct convert_driver *drv;
+	enum crlf_action attr_action; /* What attr says */
+	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
+	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
+};
+
 enum ce_delay_state {
 	CE_NO_DELAY = 0,
 	CE_CAN_DELAY = 1,
@@ -102,6 +123,9 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 int would_convert_to_git_filter_fd(const struct index_state *istate,
 				   const char *path);
 
+void convert_attrs(const struct index_state *istate,
+		   struct conv_attrs *ca, const char *path);
+
 /*
  * Initialize the checkout metadata with the given values.  Any argument may be
  * NULL if it is not applicable.  The treeish should be a commit if that is
-- 
2.27.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED7EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFZSLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFZSLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F88130
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313f59cd193so942985f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803090; x=1690395090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=h0c2nEa0Zx7ldDaDd35NNdwoOmuS62+zivqtYU6TT8bYP2lHNaDzwjDXfy29+9pFll
         +HDMgVuGpAyJtp4lI/79GP1KM3Ywn9j+EFeqdYnyQjKS8yFbxmRd8y9UbLVz29ILvspm
         5G1yaUK2f0yjx+xHwhiOcw56JhPEzNuG68pAn8fkFCA4YlXRw6uPycSNNucVqfThQu6k
         FgEeSpB4rjUgTndKDUIeyw3cQytkaQThCQKZWUR+KIF3Uj8BCtIb//hu2FPHYl+f6ZTT
         Z/QIezkSqlHO8dUDOEO/KJqg7NhFAB+5wWMBVGeW98Y1V1RincHln/Pv4jxZLM/W0e5i
         ZDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803090; x=1690395090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=BLraszfUcymFjTVFPn9xxWUz4Qc4GiGb7KbiWGHq2vtN0LKdvd1VZbVy/HAGOG/j5D
         sY7B9/jxJOF+Y1WRXIj9uEvBArtu6MTkBkZMcFDNOKKduwfPmkpZvsE2bItfIlsDVYYm
         uUaJjEQyU49UJ8WpOhplq/XdB4esHmVgGTALVeXyUaxogb6ZYVMi4yc+Pz8mlmJa0i55
         CoBEg212Oj+dFjNG6mXnAMjzEsyvGP9uZn1dG73Te8hsZcqbI/uZhcx53PCbgbooRZMu
         DVvoDLAs8fD+ayTaDMB8gMAC4+hz16Gv6aUALAPF2wUR4jJ5MEjsZYvyJm3n4aagoXRV
         IBVA==
X-Gm-Message-State: AC+VfDxwKDKqJDEv5a5poBzoFLoD13HV/sSWOZkTy+g2ebq29LMIDEMS
        JFEw0fGYxf6QYbF9sPuY3z4s3x9BeuI=
X-Google-Smtp-Source: ACHHUZ4j/Dv95V9RuJ8L+ffou/92TP0weWlhFW9FoF+/6enbBoxnldPvtASshX5KTOoy/vw2NFT14A==
X-Received: by 2002:adf:d4d0:0:b0:313:f85f:6eac with SMTP id w16-20020adfd4d0000000b00313f85f6eacmr913416wrk.12.1687803090334;
        Mon, 26 Jun 2023 11:11:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b0030af15d7e41sm8188701wrm.4.2023.06.26.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:30 -0700 (PDT)
Message-Id: <739c519ce625caa0fe5d0758b707ec2828c37ac3.1687803085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:13 +0000
Subject: [PATCH v4 02/12] urlmatch.h: use config_fn_t type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

These are actually used as config callbacks, so use the typedef-ed type
and make future refactors easier.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 urlmatch.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/urlmatch.h b/urlmatch.h
index 9f40b00bfb8..bee374a642c 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -2,6 +2,7 @@
 #define URL_MATCH_H
 
 #include "string-list.h"
+#include "config.h"
 
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
@@ -48,8 +49,8 @@ struct urlmatch_config {
 	const char *key;
 
 	void *cb;
-	int (*collect_fn)(const char *var, const char *value, void *cb);
-	int (*cascade_fn)(const char *var, const char *value, void *cb);
+	config_fn_t collect_fn;
+	config_fn_t cascade_fn;
 	/*
 	 * Compare the two matches, the one just discovered and the existing
 	 * best match and return a negative value if the found item is to be
-- 
gitgitgadget


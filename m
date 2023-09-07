Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5544EEC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjIGWUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbjIGWUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3A1BC8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f615afa52so1486685f8f.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125214; x=1694730014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oQmft0cjVhwbiWKvOpOPZ4GHmuR71V36XV/wh8G53w=;
        b=lSizjL+Rw5Zy/IOBY2uAZPlDs72al+qAAxFnIaPeMCKY8M2oxYYmlSgu2suliLYAIv
         hCmV6BP1imI+NWkJqwgVW6tnnE/tvg4CTE7Q2WX2mD0GWSUUZYYqeybzShAKKXhY1Fwo
         jHYgSEiroBmv2snIDM4J1x5nD6HQwNzIjdx1ZNS5huO6cPhVpDIF0PViT5VWsrKdbJOT
         TMdBXfR774dLjPsPQ3V/BVs95zWJWnEYN1ZcypLWYxcPP1d9f2YNfdRMP9+m+rYo+AEb
         76IYNsVU0AxkVVJGV78pI1xqaZ7aeHrSfYZNXnEriEuQ9XZYTnic4ld+TeqaP9Ni8p5L
         QZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125214; x=1694730014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oQmft0cjVhwbiWKvOpOPZ4GHmuR71V36XV/wh8G53w=;
        b=lWxshDKNVQ9pzKeRYbnrIPvEvJmUgwa1Zm9gwFbozZJTWSsh71hG2TDJL9TzoqOYG6
         fYmXWx3cxzb/rovkhYTC7wnYy/aiqcDWs/Hr0b1rGghOW1WrCgSxE4Tp+WfxKOlvWkUr
         ZZmUhertPgiqeyKnYz9t7QGLAnWLuXi2Vb2YrdhGNw6ZoAjJnaT284iyVofomTWlKGEu
         Vr5PxBSQEVLLuAYHMIKr3dTLG8VVtO0Ns1kG8zMGS1SMOTXdefNPyo9AXIblNBr7W6z6
         VwiFYskyNopoVBqKju+ZgxSa4hGXypJENYF+NamH6luHqieFh1fXuneIVLw94UwGOpUt
         11EA==
X-Gm-Message-State: AOJu0YxT007j9LOMILQOT5bwMzFMJieslIPHCyXS6hofDM4cqw7LBrRN
        RtuZ7Bi+KndhwDldxneB7Wtx5Ey6l94=
X-Google-Smtp-Source: AGHT+IHluwoHb3zM8tZysla9SPvruVYtJyhaQydRb2O83oaa/3zvZyoBYkTMAdtFhoCj1U7snnyAPA==
X-Received: by 2002:a5d:4d4b:0:b0:31a:d2b2:f29d with SMTP id a11-20020a5d4d4b000000b0031ad2b2f29dmr550763wru.8.1694125214608;
        Thu, 07 Sep 2023 15:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10-20020adfea0a000000b0031ae2a7adb5sm429485wrm.85.2023.09.07.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:14 -0700 (PDT)
Message-ID: <0df12c5c2dda5799074f0dcea696df0a63ca1145.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:00 +0000
Subject: [PATCH v3 04/13] trailer doc: narrow down scope of --where and
 related flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The wording "all configuration variables" is misleading (the same could
be said to the descriptions of the "--[no-]if-exists" and the
"--[no-]if-missing" options).  Specifying --where=value overrides only
the trailer.where variable and applicable trailer.<token>.where
variables, and --no-where stops the overriding of these variables.
Ditto for the other two with their relevant configuration variables.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 91a4dbc9a72..72f5bdb652f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -112,7 +112,8 @@ OPTIONS
 --where <placement>::
 --no-where::
 	Specify where all new trailers will be added.  A setting
-	provided with '--where' overrides all configuration variables
+	provided with '--where' overrides the `trailer.where` and any
+	applicable `trailer.<token>.where` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--where' or '--no-where'. Upon encountering '--no-where', clear the
 	effect of any previous use of '--where', such that the relevant configuration
@@ -123,7 +124,8 @@ OPTIONS
 --no-if-exists::
 	Specify what action will be performed when there is already at
 	least one trailer with the same <token> in the input.  A setting
-	provided with '--if-exists' overrides all configuration variables
+	provided with '--if-exists' overrides the `trailer.ifExists` and any
+	applicable `trailer.<token>.ifExists` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists, clear the
 	effect of any previous use of '--if-exists, such that the relevant configuration
@@ -134,7 +136,8 @@ OPTIONS
 --no-if-missing::
 	Specify what action will be performed when there is no other
 	trailer with the same <token> in the input.  A setting
-	provided with '--if-missing' overrides all configuration variables
+	provided with '--if-missing' overrides the `trailer.ifMissing` and any
+	applicable `trailer.<token>.ifMissing` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing,
 	clear the effect of any previous use of '--if-missing, such that the relevant
-- 
gitgitgadget


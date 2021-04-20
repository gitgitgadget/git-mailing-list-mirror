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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C1C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D193D613C8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhDTNBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhDTNBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88BC06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so13113880wma.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3g6vI/ZPg6wQhdRoeDAMk51M4joP2bdaANeMr/2D4s=;
        b=hNkRrz6KOnOSSSp8mdulwYWrlGBx1rhdHRS+uvZjxW2s+qD1utMdpD3jnT9FH2x4Kj
         2JGBXTK2ownDL1YmsjYs0dXng2HY4Y/n13pd0IFdhtbXCdbWo1R2mNByb8Vp/+58eecM
         yP9IWguy8tfslLPEQ7Q0CxY+Xv5keZo37bxcthhy6NKpEKt3j8EYJE3eIJWreBNGo5c9
         0r6eiQ8yB4+ExOETY25hgI+Cj+Fb3b803Wb0vEU61aYLe5cyPNC1BonV3H7NJyqjBFCw
         k5VGY2kNOF4aIM++3ZSMz0p1JpuIWMatO83lZdlKr85wGnjTyGUpggTann6JMrZT03fZ
         EyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3g6vI/ZPg6wQhdRoeDAMk51M4joP2bdaANeMr/2D4s=;
        b=iRfPxFl+maHT38b/pTrlhtSHesgfVqKw+RAxtTOhUW3RjFgTSYDg6ennhZ+JiG3jwf
         2L6pAHciQ2XHnmE6h1ObHuJP64LGMEuBMUMqG2cjCHAFpD1Ryf/pIYi4tAONPPsuhIW/
         DxHSBk1VKFJu0P+LpOcMc09gGGCJDcliZoOyXeAJ9XcQiC5aHf4aNbZUl+xsK4Wj61nh
         3nuexeOkk17hOKzuwOgaldBQ+QnSA3n1A8fAnA+3Eo3qz1eCN9+BguuV7bF3uKX+tzUx
         XwYd4thqoSTOJm0M71Z7iUHxPg1Z3/+DpZj3rRj0ItEeSZWKH1M5pysun32rqIdEo4sf
         7hVQ==
X-Gm-Message-State: AOAM533/Q+FUk0dTqr1UevkeQGa2jyswTrz1Z8Audm/aZ/UXPeuo6OAu
        oBUFAAicUWfGBvQhEsIGwpycSprBhZwM5Q==
X-Google-Smtp-Source: ABdhPJwDrr2gzq7es633/fwH5BauWhSZGQJnv/F99r3iThZ0AXGsbRYe1fHwyIpzGNGpcSiHSHODBA==
X-Received: by 2002:a1c:8091:: with SMTP id b139mr4343420wmd.132.1618923628694;
        Tue, 20 Apr 2021 06:00:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] object.c: stop supporting len == -1 in type_from_string_gently()
Date:   Tue, 20 Apr 2021 15:00:07 +0200
Message-Id: <patch-01.10-0ff9c653c3-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the type_from_string() macro into a function and drop the
support for passing len < 0.

Support for len < 0 was added in fe8e3b71805 (Refactor
type_from_string() to allow continuing after detecting an error,
2014-09-10), but no callers use that form. Let's drop it to simplify
this, and in preparation for simplifying these even further.

Even though the argument was changed from ssize_t to the unsigned
size_t C is by design forgiving about passing -1 as an unsigned
type (it's just an alias for "set all bits)", let's detect any
outstanding in-flight callers passing a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 13 ++++++++++---
 object.h |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/object.c b/object.c
index bad9e17f25..aae2a27e55 100644
--- a/object.c
+++ b/object.c
@@ -35,12 +35,12 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len, int gentle)
+int type_from_string_gently(const char *str, size_t len, int gentle)
 {
 	int i;
 
-	if (len < 0)
-		len = strlen(str);
+	if (len == ~(size_t)0)
+		BUG("type-from-string-gently no longer allows unspecified length");
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
@@ -53,6 +53,13 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	die(_("invalid object type \"%.*s\""), (int)len, str);
 }
 
+int type_from_string(const char *str)
+{
+	size_t len = strlen(str);
+	int ret = type_from_string_gently(str, len, 0);
+	return ret;
+}
+
 /*
  * Return a numerical hash value between 0 and n-1 for the object with
  * the specified sha1.  n must be a power of 2.  Please note that the
diff --git a/object.h b/object.h
index 59daadce21..f9d8f4d22b 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t, int gentle);
-#define type_from_string(str) type_from_string_gently(str, -1, 0)
+int type_from_string_gently(const char *str, size_t, int gentle);
+int type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.723.ga5d7868e4a


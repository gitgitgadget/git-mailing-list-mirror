Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFAC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8178B650FD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhCPQAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhCPP7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1742340wmi.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuL5vFrDsrmofO5AuZuro3NY90A+CfLbL3gAFSAuuYo=;
        b=uTZcBrRJCssqJvMcKU8tvjDaMjQWY+OaPH141Br736MQk1zpQjlWsiDLHNdUX1sT26
         oRNgxRdVdntiHphzPgi0ELuS1oQBxJfUPCiad9gJeaE+zasMbv8840zW8Be+Ci5hvS5u
         dnzJQ9Tza7ZezJtIs8jnlvAtVKAUcrPcXcojG0govzP+vRK1+KgjqRrsbDovPFZUj8DX
         kSrPQqYQ2z/aT+A5WooVuogih6ob/hOWh7o+VYYi81n3LxJRJtSKrWtBz9Y8axVj9WVr
         1XbcOIq4fwnBEYjC3omR2KgcR0uczfeiQjWq6Cg/dFcLCuF2e/BrYHC/fONRUCHJ2/3T
         tWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuL5vFrDsrmofO5AuZuro3NY90A+CfLbL3gAFSAuuYo=;
        b=M//vbjXhVo1W4n3sYs7J87nY0/0LVGbFwROLJCWWMOyXVr3MEGyLK1lVCOjHmCRnYl
         yjwps8JpIPc29b1yKKmqIrXeN+LJRs1/g/iiC73ZoyyfVRUHCGeMEmLY2je5/v1g1XC3
         akSTDyC+mBlUNvHiy/0/kyVMqzoRMwdaxkZkpBW53VkjxXou6kqFv2D5RxxuTzZnk3w/
         8j+2k2xpD5rBYDQS6e3XcisNM6wVvmoBfQTPDt0rEh64y3OLTIfjHoP9jmJLix7A/c/5
         0LjnNebIbezvlj9G8pan0YOgM50vTzsiE7/s8vNN5uf4cG1Z9Li10qBTtGi9bNA9DwDm
         yrPA==
X-Gm-Message-State: AOAM532eVHaWSCBSykY/Ta1T687IPYZtTz5RmGr/Ykmjk/8QT8iKUttg
        lmWeRfSg5JUv54IVEuZcZgtpGUZ7YJ/uGw==
X-Google-Smtp-Source: ABdhPJwCMzAHxS+gnWPprevmlBVNMfFjhUkMFhlMvC3ElAE7MpAB9fBz5lXNHiZzN7jd8I4M/zhVJA==
X-Received: by 2002:a05:600c:4f4f:: with SMTP id m15mr303893wmq.29.1615910341194;
        Tue, 16 Mar 2021 08:59:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 26/32] tree-walk.h API: document and format tree_entry_extract()
Date:   Tue, 16 Mar 2021 16:58:23 +0100
Message-Id: <20210316155829.31242-27-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document and format the argument list of the tree_entry_extract()
function in preparation for adding a sister function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index f569960c6f..f51485250f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,11 +40,17 @@ struct tree_desc {
 
 /**
  * Decode the entry currently being visited (the one pointed to by
- * `tree_desc's` `entry` member) and return the sha1 of the entry. The
- * `pathp` and `modep` arguments are set to the entry's pathname and mode
- * respectively.
+ * `tree_desc's` `entry` member) and return the OID of the entry.
+ *
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need a pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
+							 const char **pathp,
+							 unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.256.gf0ddda3145


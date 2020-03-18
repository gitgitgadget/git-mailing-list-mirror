Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D19C5ACD9
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 09:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A82076F
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 09:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJITnZ5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCRJ7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:59:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34306 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRJ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 05:58:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so13647551pfj.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBhnJmaoOq1pzkV/CShWUWY8Xz/rwdEBtxSSCwz7gqk=;
        b=XJITnZ5AZ7t5eK1SJLTDtYaHR7cMSfSfiM8eUcPCDyGB/BUFHkmujpqgomSWH2M7qQ
         5dzhxOv8K/UzBrmhjQCbi+H589bAoJ+CFDOmpCCfE99Xbe5shNfjgioge9DzGMLzKprw
         4K5KhYrKQiTBlLUyJa77dFYlUGiA5N/rwa1p+j6WpyZKw7YWiX04E3usqjBmJ+Rt0S0z
         o4+qL/V7x8dIhIJvy3eH2S9DxwCM/KOyZy4WqTKKh3UUTHIns4aKvFbD51MZZNbhTEMG
         lh7A0SCEY0y7XuIaYnTaUqlOihsTASnhqRZrNLba2KtiMc5o5q6kK3i3TpiFekC93wEX
         sTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBhnJmaoOq1pzkV/CShWUWY8Xz/rwdEBtxSSCwz7gqk=;
        b=knybw5tPrjdoPyd14n+w5fkB4Uz1VpWYVluRP8JeGnLSb+NCLpiSu/d0ZGP+JNMDOl
         g1L4H2Tmw1zvDHj1c0L068Kqre8G3NXuFECVdlxWn+kM4G2/xMjLJ3JEQJPnK6Pdu1da
         m2hX6IIGTSPe8J5QX6hwXSQdi0yu0MFOnUZ/cdA7k7LdyKd5hz/Z8yDMAf1cNQDX8auw
         VOthhhq3g/j1YGbisQdrkbJ5t7eLcI/JJt3oEC+giFZvDe3T7Un3sv5sUPWHHj8yASs+
         kWuEdRmbp1tfQ8V9asURmHfUwwrbKQkQ7ayDuO4lo176aLTH39V0K/dj4vv37Xm1/5qj
         VKmA==
X-Gm-Message-State: ANhLgQ1f3xfpyXYP9rzT1N741tCLZ6KWa4oZL1dWVjBZudfPEBRoWyoO
        9aitiSHBpqAB3RwN9a8YI/Cb940NHZUJqQ==
X-Google-Smtp-Source: ADFU+vs6v7BWRIKscFM47eWLk5kYDCtEFlUOSoTc62X0qNfouUAt/AoZnb95OiHSjSu505lNtV4gPg==
X-Received: by 2002:a63:195a:: with SMTP id 26mr3497857pgz.400.1584525537770;
        Wed, 18 Mar 2020 02:58:57 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id h19sm5856645pfn.205.2020.03.18.02.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:58:57 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Wed, 18 Mar 2020 15:28:42 +0530
Message-Id: <20200318095842.27679-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
References: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'submodule--helper.c', the structures and macros for callbacks belonging
to any subcommand are named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

This was an exception for the subcommand 'foreach' of the command
'submodule'. Rename the aforementioned structures and macros:
'struct foreach_cb' to 'struct cb_foreach' and 'CB_FOREACH_INIT'
to 'FOREACH_CB_INIT'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 86a608eec1..1a4b391c88 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,19 +444,19 @@ static void for_each_listed_submodule(const struct module_list *list,
 		fn(list->entries[i], cb_data);
 }
 
-struct cb_foreach {
+struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
 	int quiet;
 	int recursive;
 };
-#define CB_FOREACH_INIT { 0 }
+#define FOREACH_CB_INIT { 0 }
 
 static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 				       void *cb_data)
 {
-	struct cb_foreach *info = cb_data;
+	struct foreach_cb *info = cb_data;
 	const char *path = list_item->name;
 	const struct object_id *ce_oid = &list_item->oid;
 
@@ -557,7 +557,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
-	struct cb_foreach info = CB_FOREACH_INIT;
+	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
-- 
2.20.1


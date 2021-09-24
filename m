Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6CC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A2B61038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348407AbhIXUOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbhIXUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAFC0614ED
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so30675438wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1quqjzj3unJsCwpkyV0syS23SZ3/Jt3uBM3z5xQXaE=;
        b=CuZlD8Zf4bvztKYJcIMKrJ9x+KmfIb92c64NCkTXMNnSkxzp04E+iMMhHbw/PuyLN2
         0poJo/ELibq0+cTJSvVC+ZHsLm+dXhiRnX0Zfu9VjNjjNzrswynBOSF0JguHsHsMydj5
         MIexohUzBZvP/LPfEUJlz6RXM4YFRX51XU2NvbCPtehVDXcI2k+zDv5tQtigpbus0t8p
         sSOCHEJcCaOB6Y9f69HkMuEPbSWxUvGYVOPaZO2rZh4EGNLvDCG1v1kXn5spjLtfLskt
         XNdssjasa0CNxpo/FCcmq+Z3N55DKrx2mYMVjjyCHijeNEQJwWipic+kHfgPRt73EZkx
         rLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c1quqjzj3unJsCwpkyV0syS23SZ3/Jt3uBM3z5xQXaE=;
        b=I232Mx6PBs2SAGS7TNZfgziSyUiJhoqg7O8bYFKGA9Csfs/DgWEQdAgQ62boTLIfdd
         HqdKKuJ2CFvyWaoBOXqCJtWGQRiG67AntyQVEYPlwjPLaydRo7stgmOOKeJbRJgapRZl
         WG4FdsSeRY9NcrWsr27CK9fkMK5GeHWxX1Syupwi4T8qggWwxefkq1V5nzigrMdJZj3z
         7y0+3VczaWj4sUpHce/6+jlGwjVsQfISiU6vNH4UPMmgDKwPoH4ryeQqk8uL8v/PRg0y
         jqzV0DMWsc0G0u8kY/BM1lAg1ovYVXFgDB6klOketHiW7dx2e2eo2fdCSzFcsDutjRUD
         b/+w==
X-Gm-Message-State: AOAM530pnhTlX1F6L91ya5Ti0OhxdPkZQmnd3n3MUU663A+gCyjqJDUN
        0MNw3TvjoeHW9Qh7zkT1yEGMzQAhvAw=
X-Google-Smtp-Source: ABdhPJx0u60Eig1bKYNn5q43lPEKDZpW8Hr8BNqhqwsIuus5EAEHyQzF22NFjaPnVnstsS4zv+K0EA==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr4020064wmi.122.1632514335636;
        Fri, 24 Sep 2021 13:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25sm10599860wmm.5.2021.09.24.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:15 -0700 (PDT)
Message-Id: <485b4a767dfa54729c40b32b7fea033aedc870d1.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:08 +0000
Subject: [PATCH v5 4/7] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
pack functionality and the new bulk-fsync functionality. This mode
is enabled when passing paths to update-index via the --stdin flag,
as is done by 'git stash'.

There is some risk with this change, since under batch fsync, the object
files will not be available until the update-index is entirely complete.
This usage is unlikely, since any tool invoking update-index and
expecting to see objects would have to synchronize with the update-index
process after passing it a file path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..dc7368bb1ee 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1088,6 +1089,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	the_index.updated_skipworktree = 1;
 
+	/* we might be adding many objects to the object database */
+	plug_bulk_checkin();
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
@@ -1168,6 +1172,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/* by now we must have added all of the new objects */
+	unplug_bulk_checkin();
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget


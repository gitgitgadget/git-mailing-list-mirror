Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C08C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B0C60E75
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343605AbhIXXzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhIXXzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A3C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so32108011wrb.3
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=bPtp8drKnn22+eXxachA8rMm7K+kHTNS2XH2nnwkZrcDjoWnTuibT6eV/Bcz4gATRB
         nun+Lg/st2ONj1zcPnlsN0K2l1vtxD+XDYdJjYSQz71i1URAOd5yKAia8w2yj+lopjkJ
         n1FUtlE5j7Zsi/fItrpTmjr4rYJtDlcZSyqCN6grft9aZJgQggz6cVJycsB4GM0l+xin
         WSq23++zX8QdSeHUhAfZw9ImDsMhvODgALvfVkN/TURLRTga3mEeSqIjHbGJi7ONpHW3
         bWV/+AH3tGTh8V9VxIo9tKZfDmXw8KT5y2ph6oiWGIdBev+miCqLGc027sygJNXSyb/s
         h8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJTprmd6l9eGdcrH8bWYEQJ64Pw67KrU1jFu1jkOkoM=;
        b=fbwHKd9zfpV0eazy8LFSkBJJVGudWgfyglktKne1LB5eDqZET2llnZdBGEEai7YVJU
         1KaEzPefVJBHoEyRijM2Q4yw5A7i60CJgjmXhjKSQJRl++q9X522nAJCwHHugRYazAKa
         l51uewrnA8BVv90TNv/5lDqw0+PTCLf2jaRFNbtFVEAibzTOZ9k7CkHYlPF83jv9aAPD
         fA3t3/Lyc4DRuuve/fGig1zXwkNT0pLlfIGIsrtyPp2i0TOYh0tNNv/iTSUujJXtiz5F
         7ft84NbE/VRwwCIzprTTqv1t1MYC6Hx99zGRxgqbTVhezJte1BGs5fdSc+I6PeoTowss
         wuyg==
X-Gm-Message-State: AOAM5328ypdUusZGsrSAbg0Dx6EdPf/jiMcAQMo95Tdw90F/GNVLSExt
        gg9+G9IpxfkgDt5Q9ku+sga+IRmMyN4=
X-Google-Smtp-Source: ABdhPJzAhn95MrucTcAcQENl43NqOWyai/jt6vvJd7Qvw6KjfSGorWxjI8axFxG5d8i2c0eMUZT54Q==
X-Received: by 2002:adf:d233:: with SMTP id k19mr3816611wrh.414.1632527613082;
        Fri, 24 Sep 2021 16:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm9487138wra.37.2021.09.24.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:32 -0700 (PDT)
Message-Id: <92e18cedab0f9dccb6d64ab93c779d72be4d4cf1.1632527609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:26 +0000
Subject: [PATCH v6 5/8] update-index: use the bulk-checkin infrastructure
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
pack functionality and the new bulk-fsync functionality.

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


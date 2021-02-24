Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E3C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258B764F0C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhBXTL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhBXTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:10:17 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38096C061788
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:37 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 204so3231033qke.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=cIpA37NO3puKgAdnziqS7Hp8RKBHNrRXshWBF53nmbvhtgwEZoxnvSbOhpGXhuYW1+
         JdjGQ5TPSIi3KYr2F/cP789nzqWbLFo+u5nE/qSNbIQMBMbwwIETSxN/oA4ujKwAabCI
         erPxNEzZtJmUtvaNDFJdanmZsJ8l5lX/uIm/Eu12TFECZxnaWL8PTdOmKT2vmGIkuHnk
         KdRhfce6DsvwVAneGXUVKQZ6oJ8hXev+A9SlhMlIwqaGOhvu+QyWbhE2k1lMsrLG2L4a
         kiO8JxoaY9NRWDOjOFCrybRNYk5G5ZDIbrreBXCBMBbod6paFO/PnX37aS7OINdOHhCR
         REqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=b3NbJUmC5kW/J3zi0J8eXmHOhFPILMS8xHSLdVOItZR1KQvn51aTA8r4q0MbVx7qbe
         IvO8E3E2fapOqJNejzdmWkMUr5GUn1QVqH/PZhDTOZaG2Zk5GL8QvE1pvpvWkX8jIyZF
         a2tzsIgnyGksl21R6kQXyfAXPoCiJja4NSsZRksgCbqYVw2Dr8/3Em2vu+DUrLzGusw5
         pf28uaB07/PMJKcZO5huTC4CamRmt5IhByoVGTo3LR8/Kvs+dXTSMoFClhaldhODeo5k
         4P5hlKHAk3boMEY2kOG7wDQvajYLN7Eow9HoilKZ2OXlr+465gR72vZrdKiwPJgaf29K
         SZ8w==
X-Gm-Message-State: AOAM532qcD6FkcDPihiQxm19iucm00SxzrU07bW5TWEFOYpxo+zNC86O
        ve3SKmAJWlVL618FwvVldZNVBzUR48/+oHUM
X-Google-Smtp-Source: ABdhPJxW0M8QwB8Reax/bpuqEOJGdrX04vWkfUgdzN7X0xcE0DsLX+KEzx9XF+TQ42WXFHW08lG9Ew==
X-Received: by 2002:a37:7044:: with SMTP id l65mr32561474qkc.417.1614193776252;
        Wed, 24 Feb 2021 11:09:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id 6sm2198271qkv.24.2021.02.24.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:35 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 03/15] builtin/multi-pack-index.c: define common usage
 with a macro
Message-ID: <8679dfd2121cbc75818e97eb40a27dd3af021e38.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the usage message into pieces corresponding to each mode.
This avoids options specific to one sub-command from being shared with
another in the usage.

A subsequent commit will use these #define macros to have usage
variables for each sub-command without duplicating their contents.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index c70f020d8f..eea498e026 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,8 +5,23 @@
 #include "midx.h"
 #include "trace2.h"
 
+#define BUILTIN_MIDX_WRITE_USAGE \
+	N_("git multi-pack-index [<options>] write")
+
+#define BUILTIN_MIDX_VERIFY_USAGE \
+	N_("git multi-pack-index [<options>] verify")
+
+#define BUILTIN_MIDX_EXPIRE_USAGE \
+	N_("git multi-pack-index [<options>] expire")
+
+#define BUILTIN_MIDX_REPACK_USAGE \
+	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
+
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
+	BUILTIN_MIDX_WRITE_USAGE,
+	BUILTIN_MIDX_VERIFY_USAGE,
+	BUILTIN_MIDX_EXPIRE_USAGE,
+	BUILTIN_MIDX_REPACK_USAGE,
 	NULL
 };
 
-- 
2.30.0.667.g81c0cbc6fd


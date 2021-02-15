Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768CC43381
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C63C64DEC
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBOVCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhBOVC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:02:28 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB71C06178A
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:48 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h8so7628612qkk.6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=aQudvNzIYSlWhFxd+Rp04v2iLIAI9Cqu/UjeUezHsdzNM/XAWHk1vnsnyloAeicX24
         MPGn8+9Eq8QrJODVNmUqwNq/kaZNu6J13bMzmMhtVOsilu9unYPfniOcLM/p9ET7tDtn
         KfZSPFyTjyGlOBimu6s/K0eDRjJG0P59hmVlrL/5V46lWB6YfchuOycABa9jL7zc85Qj
         cVNrZgx4kETZBuhV79LcBB2R83WmM42oNYsv7jdwehnLva5cEFUp9eDrKP89fT4TveUm
         Hr0TI8guDJgNKrA6oZ0j3MgLdAbzvReZyog6EHjqdSmDzY2STu/CcA4trbAN+Aw97NQy
         U1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By4ZDw+6iwX13Ip2dovM5NjuD4lu7Lq1pVXXR7wZA+M=;
        b=jIAw1nvjP1cX3TFYovN8wnurEhhNVLAIDbDDonwgS5hP6MeIFkAVFYle8O3ozylfos
         IrvuvVRBJs4zHxkgvP49igaOT8drhXSmBOvHxy4QathHqy8VQN28o/SaEajeEiV8vnTR
         5xvIE8SHY9ywZ2PNMTMtBU6sELUtuEJAxksA8eqhcW92rUThQWGTtIyygaKm3OPv2thP
         hgIntw9Ei/4tjgdPvFkdJRT7KgtLRapM3raIQo5Nqgq1QvBbQ3OxCpb7WxFQcPGTQ5Op
         OG/+ed1aJe1oxhlpA4UVKmjK41MV6ZOnIiKCTrtHrpA7z8UxGAjSdO+iCbLBEuBHEoCq
         NGyQ==
X-Gm-Message-State: AOAM530ubTEi6Qsit2sCZPR+o/VSK+gENQmNus22n6vAzRfCtMM7Xy6C
        aLq+Wx69TRmVjspMd6NMK5O41lEqi4IDCDjx
X-Google-Smtp-Source: ABdhPJySLrYCPaZqasxhAeLunbqWLUSkbDbk48A2V57pp6xKCgPfwsKVcJ04Kk+NzBVnqY65ZGtnZQ==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr16246694qke.151.1613422907617;
        Mon, 15 Feb 2021 13:01:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id d1sm11618242qtq.94.2021.02.15.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:01:47 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:01:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: [PATCH v2 3/4] builtin/multi-pack-index.c: define common usage with
 a macro
Message-ID: <b369262cf9a49454d2c9c9dd809fac2314e041c7.1613422804.git.me@ttaylorr.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613422804.git.me@ttaylorr.com>
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


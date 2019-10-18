Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2981F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 11:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442550AbfJRLmK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 07:42:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42965 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407807AbfJRLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 07:42:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so5894281wrw.9
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDQ8iWh+Jf8Is+lfNhRDt/PEQlTxVWFknRIWeaJI324=;
        b=Cf6tOuwsD9TbR+OmnXwcALFIxXxAJcR0ATra85pI5NHPSYrIeUHAR+pBWwsGy+mZ86
         +kwe611MxXKj4kWn+PxsmTIV/Z/Epx8pUYY+zTTmazXCVUXeNPvtDaL9a3w9Rw72Q2SB
         0zb5i3ZpxWj9i6SqI7FH2N79XdNCDD7shsykV5V1C2+1wZUn31agMDeQZ8DMc3kEIOPo
         gwonsoie670582mBAriC8+H8DYrIs3kPg1yFFg9X2X1HXRVBkOnyyCH9mHfytOfIn0Fz
         0xRqhBCDHYgK9CT8FASOW8d1/pWCF9epShfbLs094ttoKg2i32dWJSPBVwVegxOkmV2c
         pMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDQ8iWh+Jf8Is+lfNhRDt/PEQlTxVWFknRIWeaJI324=;
        b=bZgfe/7b1Zt4f/xN06X4/DtQZlDPUiFbwR/PPObyT415G2OKjvrFp8U4vcKm0+d7JA
         8wWVu+lo9ohbk6xLTrDi0VZUiJJGikb5XF+7ZjjrPeQLWa6tAr/x1p56MSD18XR41sqy
         CUlju1V009DMnNgu28YpYO4OzA66GN+NPZCKMcO3BSFydK10M32NNohsDZWvx/CTDjv4
         XzRZnk0Q7IgU2dxkfWe+pHaStIwJAgAfFDBrkSvgZiXcm1W6UADa6GnvBBFUsZU7/lhU
         bxBPJZkOpgqZGpF8RzEhzmDEuDHMWYdjjbDSHjSRQaLg7NrdvjGbB8E7hqdvhkeXQo2z
         2nTw==
X-Gm-Message-State: APjAAAWv53I3nmoG1RjXEMwvHCAs/gQC/diUBDhi9AUyd+ybEZ6rw393
        lcXbDDSFy8oa0rIXVxp8vf0=
X-Google-Smtp-Source: APXvYqxt6e0nNpRygzNId85K3/2yfjaV/tW6LpMq89tG+wiJSHpCDCAymJHjrUTQkbPqidO0ixSAZQ==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr7979647wrq.9.1571398928410;
        Fri, 18 Oct 2019 04:42:08 -0700 (PDT)
Received: from localhost.localdomain (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id e9sm14611523wme.3.2019.10.18.04.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 04:42:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] path.c: mark 'logs/HEAD' in 'common_list' as file
Date:   Fri, 18 Oct 2019 13:42:02 +0200
Message-Id: <20191018114202.5452-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191018114202.5452-1-szeder.dev@gmail.com>
References: <20191018110618.GZ29845@szeder.dev>
 <20191018114202.5452-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'logs/HEAD', i.e. HEAD's reflog, is a file, but its entry in
'common_list' has the 'is_dir' bit set.

Unset that bit to make it consistent with what 'logs/HEAD' is supposed
to be.

This doesn't make a difference in behavior: check_common() is the only
function that looks at the 'is_dir' bit, and that function either
returns 0, or '!exclude', which for 'logs/HEAD' results in 0 as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index eeb43e1d25..04b69b9feb 100644
--- a/path.c
+++ b/path.c
@@ -113,7 +113,7 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "info" },
 	{ 0, 0, 1, "info/sparse-checkout" },
 	{ 1, 1, 0, "logs" },
-	{ 1, 1, 1, "logs/HEAD" },
+	{ 1, 0, 1, "logs/HEAD" },
 	{ 0, 1, 1, "logs/refs/bisect" },
 	{ 0, 1, 1, "logs/refs/rewritten" },
 	{ 0, 1, 1, "logs/refs/worktree" },
-- 
2.23.0.1084.gae250eaa40


Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3BC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4672469C
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKSitADD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgB1QZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:25:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40080 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1QZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 11:25:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id r17so3606130wrj.7
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR2xErhven7ZjJqNePcOOgqppDzixgneOi+2/9fOWRc=;
        b=XKSitADDro21aPRsq0scC7/xrilRKGEq2+UOLDrEpfEkV3CRfczYksuudqsX+jgLBp
         YZRzkLFOW5j+bjP6W3kjaXWE6hOU03e45ukrLakJqkzwOe+e/XuX07tx20++hf3PhsD3
         W3oy5Don4bkCa21Uuy1BrLUqR3kDqiesEmLJkwUCbX918+OJ1RJCU25HcPBDt7tZAWc9
         bEkXV2sXSNQXafE69VdVPQS2SUGxHj7YSY9dAsPNQVSRHjW3fm2o0IN26elh+DMX3QBO
         8Bmoq3NJzMUJRD7rO8L+SOSvvWCFigeKdkeP06yH59IfgnFxV2XWqlLvGE2kRmZwIKgH
         sBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR2xErhven7ZjJqNePcOOgqppDzixgneOi+2/9fOWRc=;
        b=Pl/EXDEWowEkXyVF+SFmRIPnMPwFC4BhW9XemjRF00gTRWx2fHmnHvOO4to+44NSRF
         hfi733pdUcRLWdYmoUevz577ri/laf6ak6pmsbA6/w7wyNolclQMWOdfQSyUZBs5P77c
         l3jCeKZKbK3lb5/hyrfz3zvB4MSZGCm30KMZcvzfvLQWAaJQ0gVBul4VcmnKuQZNV37Z
         pUp99qK0wUd2Jit+dldRyjCxDinDwh9eEHKKIsQPLwuz6w4TlTPPykWvVn+i5EHSrFvq
         VXPPeIZT6krE1n4g9n0NS9hfjcK4gs9oDt+fIfKWm4J9ViFX3rGwHJoOxCkkNQZpsKWm
         Q/FA==
X-Gm-Message-State: APjAAAVk8chRVV6z1R2ynYQ7f6OzQ/s1d7TY2v1BvQOEHkYbc2Ok93mN
        ukMeo7Ssz+67EPAy6PK/II2MPpuQXRIxJA==
X-Google-Smtp-Source: APXvYqwleuLeioPBmcBJ+RErbqvG1vRE7Ls5I2J2JLWoT/2bmbUa+3AJs5rr+ITyNH+S0g5+4Ei3zQ==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr5589242wrn.239.1582907154133;
        Fri, 28 Feb 2020 08:25:54 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id a62sm2869230wmh.33.2020.02.28.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:25:53 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: [PATCH 1/1] midx.c: fix an integer overflow
Date:   Fri, 28 Feb 2020 17:24:49 +0100
Message-Id: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When verifying a midx index with 0 objects, the
    m->num_objects - 1
overflows to 4294967295.

Fix this.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 37ec28623a..6ffe013089 100644
--- a/midx.c
+++ b/midx.c
@@ -1127,7 +1127,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
 						 m->num_objects - 1);
-	for (i = 0; i < m->num_objects - 1; i++) {
+	for (i = 0; i + 1 < m->num_objects; i++) {
 		struct object_id oid1, oid2;
 
 		nth_midxed_object_oid(&oid1, m, i);
-- 
Patched on top of v2.25.1-379-gd22418c625 (git version 2.25.1)


Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74018C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CD20657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Kf3/w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgERPrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERPrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F62C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb16so4884690qvb.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=I2Kf3/w8eWt9TSLTXnrYqD+80+xw8zD00j5KUDs/gHkn9+Y+i/edUxLgtHMUtahCd7
         BOCx8bSz0yMv77a288dqXFEjHz9o3AqO+d1ClRgRPN7twUrZ5WMHXSI7hGwfUlcqC69B
         n2qzKono2Y7P3Bouax1TnyKEXTruRwg5S9nyNfdRPs2TY7m4Cs+jEJhcWiXomNs2x0EA
         2QJkssoX03g+G0fgvcYqNR//xU1TKTvHrJsi3zYUTn+fcMhgsTd1jR2nodXbvk6PigRh
         vcJfaj9G9TJByWPPMfND4tqz63rPEgJFJZrCkq1RRlM7O4ODWnHHbdOjYv7Tf2dK8Xhk
         937A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=GVb2dVfQtGA/zqRF5/ka5UnJloVp25pn+GhNItLg13VwdlhK14foS1zJtLyy7scolJ
         f0QfyrMa6QrJqLJLDmEZ+UNDe0+nYcKhBxJn2yBY3+F5YBIKosBWuYcmBSBRv2WgmrCD
         ck29Wv86FlSe4dTtOOZGQb6X8NAa0pwonMhIjb1I1FeirPead9qZVZ+q0sjTfUg/piXz
         Y9LN8XDyVm9qWn7szBLXVnF4s+JCs5w4QLF3p10r4YUWDokmHkeLNGgRYqEwvYzBavdI
         HcD/NtW0ohyBzXpyRocaycDJdHeLWwerrZ8CcpVFyFvPH0TrnZ09eOopGWY1BDMVh4Bw
         8SYA==
X-Gm-Message-State: AOAM53246kS49mpyEPCnvab08ZNrDmmMiA4qZB3yiDFNIip7gfOoANdd
        gVoRkjfzDd6FmcGUKtSnfn+jZPre
X-Google-Smtp-Source: ABdhPJwn+ns+6TiX+TjtrfSMEr2HjDrvaoOQn21ceISQw18gUvbsZ2Qn0V5+/oo9KQu1R7zj7WMTcg==
X-Received: by 2002:a0c:e947:: with SMTP id n7mr17334498qvo.165.1589816855204;
        Mon, 18 May 2020 08:47:35 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/7] remote-curl: fix typo
Date:   Mon, 18 May 2020 11:47:18 -0400
Message-Id: <b390875f87dbf5f3f48909ce40f5a5749b32f5d4.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1c9aa3d0ab..6844708f38 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -643,7 +643,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 			return 0;
 		}
 		/*
-		 * If avail is non-zerp, the line length for the flush still
+		 * If avail is non-zero, the line length for the flush still
 		 * hasn't been fully sent. Proceed with sending the line
 		 * length.
 		 */
-- 
2.26.2.706.g87896c9627


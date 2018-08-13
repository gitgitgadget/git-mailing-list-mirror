Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2131F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbeHMS60 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34273 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so13056480ljk.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=td/O8vHni4zEsGp7DEI++JxIF1H/OhwqfnCvMe0dUtg=;
        b=vbkPqFDeqtdrPbM2fX2sWWQquEeVbOGxJRLilf8dP2O/aW2O4/BbBPwc4a1POgImF9
         OA5UtX02aMREuqoC/APYNPM8+zo3bLNdoBDWI+loLyg63v5x/p7gXCrXmDOYJfmMoBvx
         NstWnwsYoz9ulrg+V1YUi6wPt6kIouvd6onRmoiML77hJJK3rnIiY5OFaaVfx2PU9Mg5
         29B+LYWZaii8hVRPLlWFb6HGhoFcOyZuro4JRTGVANNpEJZGnrG+ycql0v5+/g2a5V7T
         8Pl1FYHY4xlCsGlyESM4nWq5P8iJ5TwMfqM+MmrmSqfOZDbhj/qhmnI3GYH+rahbTn01
         gawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=td/O8vHni4zEsGp7DEI++JxIF1H/OhwqfnCvMe0dUtg=;
        b=MbxnMG7oZnaCDbOxQiJPEMnxwgcl1DDtdQzjBpH7ZcRDgI7AizdRsyWxJSLnFonhiP
         huNgxzvKQEU+qb1TBCC6hBHlk/wxB5/tyTnEejtet/u36Sjr4Bqr+duIQUGM9zrfWW43
         7s7ctPvL6X4y62taA792ekOWYebl6+tsJooXXPTzaMOFtaBF8Avtzxl3S+31w6DVpDHk
         y+8W1N6luAPXotpJIVH+HStrODmM4pWxXMZNkdYcLbvvrj9jd4gatX9vV+KKDiORqysz
         a0zOMvk5g/daxpXgemPrm+MptnrKJaMpyh99OdRALch5MyJcMfTTQitwQ3v66f7kkINl
         45xw==
X-Gm-Message-State: AOUpUlH9ysHAi7yRmycnR3LNKBMizhzQXe7b8j+KXxYzCQji5XKPDO0m
        L4PEci1x6HiE6U9u5te6oKr7Ux2O
X-Google-Smtp-Source: AA+uWPz0w6Vwr/VDOCFpzpLW2cjLFWpkaBaTf07MrHr12wCqbZSExeN9UmQSpBriXV6hujsaPG1giw==
X-Received: by 2002:a2e:144f:: with SMTP id 15-v6mr13348305lju.122.1534176929308;
        Mon, 13 Aug 2018 09:15:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/24] unpack-trees: add a note about path invalidation
Date:   Mon, 13 Aug 2018 18:14:26 +0200
Message-Id: <20180813161441.16824-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index f9efee0836..c07a6cd646 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1552,6 +1552,17 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
+/*
+ * TODO: We should actually invalidate o->result, not src_index [1].
+ * But since cache tree and untracked cache both are not copied to
+ * o->result until unpacking is complete, we invalidate them on
+ * src_index instead with the assumption that they will be copied to
+ * dst_index at the end.
+ *
+ * [1] src_index->cache_tree is also used in unpack_callback() so if
+ * we invalidate o->result, we need to update it to use
+ * o->result.cache_tree as well.
+ */
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-- 
2.18.0.1004.g6639190530


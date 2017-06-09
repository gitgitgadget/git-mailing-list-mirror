Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D816F1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdFISSE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:04 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33761 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdFISSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id v104so8411073wrb.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYgXn8wuaLfOaIBqKLn9+EMadj3h8Unp90UV7Wp+ivk=;
        b=ay/dMM8i6bpVdelRPAZXcF4/eTpUESwOH7JnaO3Ebsf/Na0mlhnfkFPeG4+kzukhnX
         ipuHekwXwYD5CtTupxDARrkJaeB8T6OsrkPQ6+6AB673gCMbXxpOTGOy7uqMDapSjpq0
         zHdwytxBTtR12g2LllthkINrnfazZSktGedpeh/XukIwZpKBd+vLUWGOcst2Zmxun/YL
         zH7ILRvd0SyV5fJVleTppSJ1aWT/YKwnGimPtkuUTu61KDLivgyt2EJzR02Ft8KgQpGs
         6Qsz3ZPr4iLsTPEDWD460YWEWRHe81x9qtUy8oxw2c2gXKWYikVgaaa6nqZC0L0uos0z
         S36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYgXn8wuaLfOaIBqKLn9+EMadj3h8Unp90UV7Wp+ivk=;
        b=Ci2TR6181rZh+FrI1+RZEbiUK5MXU0YJSHzvGxnlOcp+cku07e9kt61Ya6wUzVJ2HS
         Da4MszpNDZ5VcqFkLSUnGomnEK2vQDMtHqnwtKBSvbSSQbPpOi23PROF7UFM3Q187Cj/
         FYkkz21WQYIG2MOv51AImjQ9mZWmQUyTwim6ynATX4OYUFCJLCx6RXXcUt0qq+yTxNXf
         K5BzrzAr22wCKRjdqkYKjMrWofmPzqW9LXOHjWQqtCIQNyXif2C+3/gSebUld7VaVNUZ
         /tXCjjKffjusCX/h8Ra4ptkGHm4CcwD+37zLativUiE2yChVYbxyPFUD1/7nerbxZkAj
         zwxA==
X-Gm-Message-State: AODbwcAO7DZyL62a62WawKwcxezDgN3pMB0/9EhC/Soa+RDph3AMbnL5
        HVMw+rCubC4G6g==
X-Received: by 10.28.137.206 with SMTP id l197mr816626wmd.41.1497032281385;
        Fri, 09 Jun 2017 11:18:01 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:18:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 1/5] revision.h: turn rev_info.early_output back into an unsigned int
Date:   Fri,  9 Jun 2017 20:17:29 +0200
Message-Id: <20170609181733.6793-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev_info.early_output started out as an unsigned int in cdcefbc97 (Add
"--early-output" log flag for interactive GUI use, 2007-11-03), but
later it was turned into a single bit in a bit field in cc243c3ce
(show: --ignore-missing, 2011-05-18) without explanation, though its
users still expect it to be a regular integer type.  Consequently, any
even number given via '--early-output=<N>' effectively disabled the
feature.

Turn it back into an unsigned int, restoring its original data type.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.h b/revision.h
index a91dd3d5d..f96e7f7f4 100644
--- a/revision.h
+++ b/revision.h
@@ -74,8 +74,9 @@ struct rev_info {
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-	unsigned int	early_output:1,
-			ignore_missing:1,
+	unsigned int early_output;
+
+	unsigned int	ignore_missing:1,
 			ignore_missing_links:1;
 
 	/* Traversal flags */
-- 
2.13.0.420.g54001f015


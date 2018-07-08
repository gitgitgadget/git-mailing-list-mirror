Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA241F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeGHOoJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 10:44:09 -0400
Received: from s019.cyon.net ([149.126.4.28]:51602 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754064AbeGHOoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j+OXx3bDFcryvN8O2IX67TFMxEU1dfcuPtx/nGdA9GE=; b=HtYydx3+FE+HYGINxWQSs5+Ubd
        vf3lDIkB5mzqkKw1sfEwzlw97eyqmASgEltDFx7IdrWRvs3r/pPd/MyUpS5J8PKGDxnf01QTAgXxY
        S/8tK/bAEIA7dFnhl/qDzJFB1gI8eijy//dn7mfpxeK3mnKDm2SJT8lZR+vKdVMNAuFYAcGHyFg/v
        IgLD4qgwtIGtnk+xpcl0+k7ms8z2t7UBHGcRIAiZbzRqnP/Uw+AX1IMe4hur0O5ERALdi7h5Qxl86
        YQwbAEZ+OD1CGX5hp5vcTl/4vGt0Fq6WNgIpGf15q9tvvcE5yyNQOkrh3rMdWY5e+Xi2JRXSStvYT
        4/vb3/rA==;
Received: from [10.20.10.233] (port=6768 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcAuz-004haC-1j; Sun, 08 Jul 2018 16:44:06 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id CD49F2051F; Sun,  8 Jul 2018 16:44:04 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [RFC PATCH 3/6] convert.c: replace "\e" escapes with "\033".
Date:   Sun,  8 Jul 2018 16:43:39 +0200
Message-Id: <20180708144342.11922-4-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "\e" escape is not defined in ISO C.

While on this line, add a missing space after the comma.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 64d0d30e08..edebb946f5 100644
--- a/convert.c
+++ b/convert.c
@@ -334,7 +334,7 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(
-			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
 			i,
 			(unsigned char) buf[i],
 			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
-- 
2.15.0.rc1.299.gda03b47c3


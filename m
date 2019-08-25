Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887AC1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfHYTmQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 15:42:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41383 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfHYTmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 15:42:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so15988543qtj.8
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n6L8MSAMrCh2btCD2urlOiwBUDItgWrtLZQwO6ogouY=;
        b=dP75epYj4F1Ad+QgQLPiTmhbFTYTc8XoeJLXhImqmYSDrFpk/2wpZfp2oYvuiPSL+7
         m5iDEPTq+fFHkQtMXwWsmZFLxzrnjuLqnhmsL40VRnzGhz9ymehUZAJ0vsqgxcgJEli9
         WCXlm6FgmzLwHeN9w25YqDDfgNPoPduqN2dykJ3CfWYzfMZAJafhqHV4dLnDB/ayBBLp
         Tr7DyVOKRrEeOLwHiRQHPhbAWT9hdUmcYRkGmgWJd11e/G4ngkQRcOqRg/rzn8KSPs9J
         x553arRouJPgkGmstyNgFfSDWy2yp5NQzxiYBj58oEwtRnaQM1lLNEW21iPv3nKCEDgR
         vy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n6L8MSAMrCh2btCD2urlOiwBUDItgWrtLZQwO6ogouY=;
        b=lzxlfrc0c0M5BL0VDJsMREICh1PeiLSCdcLGqxqqtFQ5oyp2eV5Eqk+xoNN6Ap+bpH
         +NLSZHSOd2Q2ZS6K7HCZxeOUGhD8hgNeWU9YPphOUDViMaP2QPQDk2YObCyV/Ex3nVf+
         jFRLkwtydNkp2Af19mZh4wdqN5mgLBaQCodF5qhv41AC8pSIxLzZhd95pgSF2lNtlled
         HeS6Ec0SunG1ueBXLacgxrnBfa3R0rXbWX1thiySrumH+2OPYM7nXi/785oFkwJl1PJ7
         lGA+Y6UMpP7f27zpOp2nyeNaWjj71NBWU2nEi72chpjH/y676aXLU9DRolY1SPv2031G
         ocEw==
X-Gm-Message-State: APjAAAXdWC/jZ0ZhgaAydvc5ejCvDn4S+CpFk1yCSRJD/x7z7NZES9u5
        bRp/eU0z/8OIAZUH21PCXiwh9W55OKPhNg==
X-Google-Smtp-Source: APXvYqxczggOPqYFU/14UpuzN0X08mZilAhdSZqxUrP+HaaRkhLivsb1SRbp+LQZKDPpVLxqWE4kCQ==
X-Received: by 2002:a05:6214:11e2:: with SMTP id e2mr12718168qvu.82.1566762134874;
        Sun, 25 Aug 2019 12:42:14 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:a0a9:f082:44f:1f74])
        by smtp.gmail.com with ESMTPSA id o43sm9500518qto.63.2019.08.25.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 12:42:14 -0700 (PDT)
Date:   Sun, 25 Aug 2019 15:42:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH] banned.h: fix vsprintf()'s ban message
Message-ID: <cab687db8315dd4245e1703402a8c76218ee1115.1566762128.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cc8fdaee1e (banned.h: mark sprintf() as banned, 2018-07-24), both
'sprintf()' and 'vsprintf()' were marked as banned functions. The
non-variadic macro to ban 'vsprintf' has a typo which says that
'sprintf', not 'vsprintf' is banned. The variadic version does not have
the same typo.

Fix this by updating the explicit form of 'vsprintf' as the banned
version of itself, not 'sprintf'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 banned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/banned.h b/banned.h
index 447af24807..60a18d4403 100644
--- a/banned.h
+++ b/banned.h
@@ -26,7 +26,7 @@
 #define vsprintf(...) BANNED(vsprintf)
 #else
 #define sprintf(buf,fmt,arg) BANNED(sprintf)
-#define vsprintf(buf,fmt,arg) BANNED(sprintf)
+#define vsprintf(buf,fmt,arg) BANNED(vsprintf)
 #endif
 
 #endif /* BANNED_H */
-- 
2.22.0

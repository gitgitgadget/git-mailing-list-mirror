X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Include -lz when linking git-daemon.
Date: Sun, 5 Nov 2006 00:36:15 -0500
Message-ID: <20061105053615.GB4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 05:36:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30947>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgagA-0004MX-9v for gcvg-git@gmane.org; Sun, 05 Nov
 2006 06:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030257AbWKEFgT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 00:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWKEFgT
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 00:36:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39876 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1030257AbWKEFgS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 00:36:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggag4-0003ZT-RY; Sun, 05 Nov 2006 00:36:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C30C920E491; Sun,  5 Nov 2006 00:36:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Some platforms (Solaris in particular) appear to require -lz as
part of the link line for git-daemon, due to it linking against
sha1_file.o and that module requiring inflate/deflate support.

This wasn't made platform-specific in the Makefile as the existing
use of -lz in every other (non git-daemon) application is also
not platform-specific.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1cc9f58..9f10054 100644
--- a/Makefile
+++ b/Makefile
@@ -317,6 +317,7 @@ BUILTIN_OBJS = \
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
+SIMPLE_LIB = -lz
 
 #
 # Platform specific tweaks
-- 
1.4.3.3.g9621

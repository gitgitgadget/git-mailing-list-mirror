X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Apply obvious numerical cast for stupid C compilers.
Date: Sun, 5 Nov 2006 00:35:44 -0500
Message-ID: <20061105053544.GA4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 05:36:07 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30946>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggafi-0004Gw-VA for gcvg-git@gmane.org; Sun, 05 Nov
 2006 06:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030254AbWKEFfv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 00:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWKEFfu
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 00:35:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33988 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1030254AbWKEFfu
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 00:35:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggafa-0003X0-3e; Sun, 05 Nov 2006 00:35:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B199020E491; Sun,  5 Nov 2006 00:35:44 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

At least one (older) version of the Solaris C compiler won't allow
'unsigned long x = -1' without explicitly casting -1 to a type of
unsigned long.  As annoying as it may be to explicitly perform the
cast the compiler is right; -1 is not an unsigned value.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index db7cdce..d7b3cea 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -43,7 +43,7 @@ static int apply_verbosely;
 static int no_add;
 static int show_index_info;
 static int line_termination = '\n';
-static unsigned long p_context = -1;
+static unsigned long p_context = (unsigned long)-1;
 static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
-- 
1.4.3.3.g9621

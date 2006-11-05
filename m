X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Use ULONG_MAX rather than implicit cast of -1.
Date: Sun, 5 Nov 2006 02:27:07 -0500
Message-ID: <20061105072707.GA4579@spearce.org>
References: <20061105071805.GA4506@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:27:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061105071805.GA4506@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30954>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcPS-0007P1-L4 for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161202AbWKEH1M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWKEH1M
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:27:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38866 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161202AbWKEH1K
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:27:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgcPL-0002CD-JL; Sun, 05 Nov 2006 02:27:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 58D7420E491; Sun,  5 Nov 2006 02:27:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

At least one (older) version of the Solaris C compiler won't allow
'unsigned long x = -1' without explicitly casting -1 to a type of
unsigned long.  So instead use ULONG_MAX, which is really the
correct constant anyway.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This is a resend of my earlier patch in in this same thread...

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index db7cdce..aad5526 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -43,7 +43,7 @@ static int apply_verbosely;
 static int no_add;
 static int show_index_info;
 static int line_termination = '\n';
-static unsigned long p_context = -1;
+static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
-- 
1.4.3.3.g9621

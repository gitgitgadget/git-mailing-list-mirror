X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] xdl_merge(): set mode to 0 when refining conflicts
Date: Thu, 30 Nov 2006 00:23:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300021490.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 23:23:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32674>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpYm9-0004Ib-LF for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758957AbWK2XXe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 18:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758974AbWK2XXe
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:23:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:55961 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758957AbWK2XXd (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 18:23:33 -0500
Received: (qmail invoked by alias); 29 Nov 2006 23:23:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 30 Nov 2006 00:23:32 +0100
To: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org,
 junkio@cox.net
Sender: git-owner@vger.kernel.org


mode == 0 means "conflict", and just because a conflict has been
split does not mean that the latter half is no conflict.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---
 xdiff/xmerge.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 04f2795..7b85aa5 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -228,6 +228,7 @@ static int xdl_refine_conflicts(xdfenv_t
 			m2->next = m->next;
 			m->next = m2;
 			m = m2;
+			m->mode = 0;
 			m->i1 = xscr->i1 + i1;
 			m->chg1 = xscr->chg1;
 			m->i2 = xscr->i2 + i2;
-- 
1.4.4.g5aac-dirty

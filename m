X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow an alias to start with "-p"
Date: Wed, 19 Jul 2006 01:25:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 18 Jul 2006 23:26:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1G2yxC-0002ON-3K for gcvg-git@gmane.org; Wed, 19 Jul
 2006 01:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932413AbWGRXZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 18 Jul 2006
 19:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGRXZ7
 (ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 19:25:59 -0400
Received: from mail.gmx.de ([213.165.64.21]:51874 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S932413AbWGRXZ7 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 18 Jul 2006 19:25:59 -0400
Received: (qmail invoked by alias); 18 Jul 2006 23:25:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 19 Jul 2006 01:25:57 +0200
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Now, something like

	[alias]
		pd = -p diff

works as expected.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 537af3a..a969b1b 100644
--- a/git.c
+++ b/git.c
@@ -115,6 +115,12 @@ static int handle_alias(int *argcp, cons
 
 			count = split_cmdline(alias_string, &new_argv);
 
+			if (count > 0 && !strcmp(new_argv[0], "-p")) {
+				setup_pager();
+				count--;
+				new_argv++;
+			}
+
 			if (count < 1)
 				die("empty alias for %s", alias_command);
 
-- 
1.4.1.g3c58e

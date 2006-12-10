X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Sat, 09 Dec 2006 19:58:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 10 Dec 2006 00:58:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33860>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtD1X-0006Zj-UC for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758738AbWLJA6d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbWLJA6d
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:58:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29178 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758738AbWLJA6c (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 19:58:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA100ISQ9DKS4I0@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Sat,
 09 Dec 2006 19:58:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This doesn't convey much information in the shortlog context.
And the perl version did strip it as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 7a2ddfe..6c4606b 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -146,6 +146,11 @@ static void insert_author_oneline(struct path_list *list,
 	while (onelinelen > 0 && isspace(oneline[onelinelen - 1]))
 		onelinelen--;
 
+	if (onelinelen > 8 && !strncasecmp(oneline, "[PATCH] ", 8)) {
+		oneline += 8;
+		onelinelen -= 8;
+	}
+
 	buffer = xmalloc(onelinelen + 1);
 	memcpy(buffer, oneline, onelinelen);

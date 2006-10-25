X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines
Date: Wed, 25 Oct 2006 02:28:55 +0200
Message-ID: <20061025002855.4738.1088.stgit@machine.or.cz>
References: <7vmz7lfdwj.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Wed, 25 Oct 2006 00:29:09 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vmz7lfdwj.fsf@assigned-by-dhcp.cox.net>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30022>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWdg-00086r-UJ for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422866AbWJYA25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 20:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWJYA25
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:28:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5510 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1422866AbWJYA25 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:28:57 -0400
Received: (qmail 4748 invoked from network); 25 Oct 2006 02:28:55 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 25 Oct 2006 02:28:55 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This removes the '#' and '(' tests and adds a '$' test instead although I have
no idea what it is actually good for - but hey, if that's what GNU diff does...

Pasky only went and did as Junio sayeth.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 xdiff/xemit.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 714c563..4139d55 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -86,8 +86,7 @@ static void xdl_find_func(xdfile_t *xf, 
 		if (len > 0 &&
 		    (isalpha((unsigned char)*rec) || /* identifier? */
 		     *rec == '_' ||	/* also identifier? */
-		     *rec == '(' ||	/* lisp defun? */
-		     *rec == '#')) {	/* #define? */
+		     *rec == '$')) {	/* mysterious GNU diff's invention */
 			if (len > sz)
 				len = sz;

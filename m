From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: [PATCH] Revert "Stop starting pager recursively"
Date: Mon, 21 Apr 2014 16:46:22 -0400
Message-ID: <20140421204622.GA9532@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:24:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLhp-0001sU-4x
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaDUVYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:24:45 -0400
Received: from longford.logfs.org ([213.229.74.203]:43182 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbaDUVYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:24:43 -0400
X-Greylist: delayed 2253 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Apr 2014 17:24:43 EDT
Received: from joern by longford.logfs.org with local (Exim 4.72)
	(envelope-from <joern@logfs.org>)
	id 1WcL6c-0002cy-1o
	for git@vger.kernel.org; Mon, 21 Apr 2014 16:46:22 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246644>

This reverts commit 88e8f908f2b0c56f9ccf8134d8ff9f689af9cc84.

Caused a usability regression for me and foul language for my coworkers.

In particular, I commonly do a "git log", with results going through
less, find a potentially interesting commit and execute "git show
<commit>" from less.  This used to show the patch in less and no longer
does.

Manually typing "git show <commit> | less" works, but is annoying,
wasting time and usually only done after seeing the mess from the simple
invocation.
---
 pager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index 0cc75a8eee32..53670a63a7ae 100644
--- a/pager.c
+++ b/pager.c
@@ -64,7 +64,7 @@ void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
 
-	if (!pager || pager_in_use())
+	if (!pager)
 		return;
 
 	/*
-- 
1.9.1

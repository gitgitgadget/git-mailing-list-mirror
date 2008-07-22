From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] In perforce, RCS keywords are case-sensitive
Date: Tue, 22 Jul 2008 12:48:57 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807221235000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 18:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLL47-0002Kq-Mh
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbYGVQtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbYGVQtA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:49:00 -0400
Received: from iabervon.org ([66.92.72.58]:35730 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223AbYGVQs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:48:59 -0400
Received: (qmail 2304 invoked by uid 1000); 22 Jul 2008 16:48:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2008 16:48:57 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89497>

At least, this is true in 2007.2, according to the documentation.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

A line of perl with the variable $file in a string followed by a different 
variable not in the string, for example, doesn't get mangled by p4 and may 
therefore appear in a p4 depot.

I don't know if the "old-style keyword expansion" is case-sensitive, 
though, so I'm leaving that alone.

 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d8de9f6..1ee612e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -902,7 +902,7 @@ class P4Sync(Command):
             if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
                 text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
             elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-                text = re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
+                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
 
             contents[stat['depotFile']] = text
 
-- 
1.5.6.rc2.26.g8c37.dirty

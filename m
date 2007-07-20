From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] builtin-tag: fix uninitialized variables
Date: Fri, 20 Jul 2007 13:07:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201306340.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 20 14:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBrGj-0002xg-Os
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 14:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759591AbXGTMHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 08:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759139AbXGTMHe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 08:07:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758139AbXGTMHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 08:07:33 -0400
Received: (qmail invoked by alias); 20 Jul 2007 12:07:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 20 Jul 2007 14:07:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aZcNOMx6aYU4mBCBvHHJBEABO+K5eu4gKQz4+wx
	GH7e8haYCP9/1S
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53087>


The function launch_editor() expects the variables 'buffer' and 'size'
to be initialized, either to an existing buffer, or to NULL and 0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	This is only called 2/2, because I found this error by testing 
	1/2...

 builtin-tag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index cf36def..81d37ce 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -253,9 +253,9 @@ static void create_tag(const unsigned char *object, const char *tag,
 		       char *message, int sign, unsigned char *result)
 {
 	enum object_type type;
-	char header_buf[1024], *buffer;
+	char header_buf[1024], *buffer = NULL;
 	int header_len, max_size;
-	unsigned long size;
+	unsigned long size = 0;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= 0)
-- 
1.5.3.rc1.16.g9d6f-dirty

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Add uploadpack configuration info to remote.
Date: Wed, 11 Jul 2007 21:37:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112107180.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ncJ-0000Ct-EJ
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763931AbXGLBhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761347AbXGLBhF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:37:05 -0400
Received: from iabervon.org ([66.92.72.58]:1584 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763931AbXGLBhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:37:04 -0400
Received: (qmail 31926 invoked by uid 1000); 12 Jul 2007 01:37:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:37:01 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52229>

Read remote.<name>.uploadpack, just like receivepack.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |    5 +++++
 remote.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 500ca4d..793681a 100644
--- a/remote.c
+++ b/remote.c
@@ -196,6 +196,11 @@ static int handle_config(const char *key, const char *value)
 			remote->receivepack = xstrdup(value);
 		else
 			error("more than one receivepack given, using the first");
+	} else if (!strcmp(subkey, ".uploadpack")) {
+		if (!remote->uploadpack)
+			remote->uploadpack = xstrdup(value);
+		else
+			error("more than one uploadpack given, using the first");
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 01dbcef..f50105c 100644
--- a/remote.h
+++ b/remote.h
@@ -16,6 +16,7 @@ struct remote {
 	int fetch_refspec_nr;
 
 	const char *receivepack;
+	const char *uploadpack;
 };
 
 struct remote *remote_get(const char *name);
-- 
1.5.2.2.1600.ga4e5

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] http-push: fix missing "#ifdef USE_CURL_MULTI" around
	"is_running_queue"
Date: Sun, 10 May 2009 18:44:30 +0200
Message-ID: <20090510164431.3526.47427.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 18:50:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3CEU-0000v7-8I
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 18:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbZEJQuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZEJQuZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 12:50:25 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:58781 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbZEJQuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 12:50:24 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2D6FF4C8057;
	Sun, 10 May 2009 18:50:18 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 379FB4C80B9;
	Sun, 10 May 2009 18:50:16 +0200 (CEST)
X-git-sha1: 14dffff7ee277e9cd26fe879f94ed084988b6589 
X-Mailer: git-mail-commits v0.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118728>

As it is breaking the build when USE_CURL_MULTI is not defined.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 http-push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

This patch applies to pu.

diff --git a/http-push.c b/http-push.c
index ef1a9f3..14f3996 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2291,7 +2291,9 @@ int main(int argc, char **argv)
 		repo->url = rewritten_url;
 	}
 
+#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
+#endif
 
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
-- 
1.6.3.rc1.112.g17e25

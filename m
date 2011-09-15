From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Un-static gitmkstemps
Date: Thu, 15 Sep 2011 08:21:00 -0400
Message-ID: <1316089260-76049-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 14:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4AwR-0000a0-6p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457Ab1IOMVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 08:21:04 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43183 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388Ab1IOMVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 08:21:03 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CF7EA1FFC166; Thu, 15 Sep 2011 12:20:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (unknown [129.21.210.224])
	by silverinsanity.com (Postfix) with ESMTPA id 1F0691FFC100;
	Thu, 15 Sep 2011 12:20:59 +0000 (UTC)
X-Mailer: git-send-email 1.7.7.rc0.309.g13ed2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181463>

It may not be used in most builds, but it's used via a #ifdef in
git-compat-util.h  Also, making it static makes a -Wall compile fail
since it's not used in the file without NO_MKSTEMPS.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Either this, or it should be removed from git-compat-util and wrapped in
 an #ifdef.  (The only current user is git_mkstemps), but since it's
 referenced in a header file, I figured it shouldn't be static.

 wrapper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 390a7ae..1c41488 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -310,7 +310,7 @@ int git_mkstemp_mode(char *pattern, int mode)
 	return git_mkstemps_mode(pattern, 0, mode);
 }
 
-static int gitmkstemps(char *pattern, int suffix_len)
+int gitmkstemps(char *pattern, int suffix_len)
 {
 	return git_mkstemps_mode(pattern, suffix_len, 0600);
 }
-- 
1.7.7.rc0.309.g13ed2.dirty

From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] test-parse-options: use appropriate cast in length_callback
Date: Wed, 13 Aug 2008 19:48:57 -0500
Message-ID: <u9kSfvaPV5O7E74203zUsAGug_d6ifoE65miBrOTQbXuuqogK67SOA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTR2l-00023i-Ep
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbYHNAtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYHNAtU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:49:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46586 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbYHNAtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:49:19 -0400
Received: by mail.nrlssc.navy.mil id m7E0mwci000423; Wed, 13 Aug 2008 19:48:58 -0500
X-OriginalArrivalTime: 14 Aug 2008 00:48:58.0426 (UTC) FILETIME=[894279A0:01C8FDA7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92299>

OPT_CALLBACK() is passed &integer which is now an "int" rather than
"unsigned long". Update the length_callback function.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 test-parse-options.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 6e18083..61d2c39 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -15,7 +15,7 @@ int length_callback(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		return 1; /* do not support unset */
 
-	*(unsigned long *)opt->value = strlen(arg);
+	*(int *)opt->value = strlen(arg);
 	return 0;
 }
 
-- 
1.6.0.rc2.51.g0dc95

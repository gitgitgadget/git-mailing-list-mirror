From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Make format-patch --suffix="" not add any suffix
Date: Wed, 17 Jan 2007 15:22:21 -0500
Message-ID: <20070117202221.GA14042@176.242.249.10.in-addr.arpa>
References: <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 17 21:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7HIj-0007p9-TC
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbXAQUW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 15:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbXAQUW0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:22:26 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:52148 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737AbXAQUW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 15:22:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id B2E431FFC02B
	for <git@vger.kernel.org>; Wed, 17 Jan 2007 20:22:25 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37039>

Having a suffix of "." when the user explicitly asked for none is
somewhat confusing.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 builtin-log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 04e3144..a60a987 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -276,7 +276,8 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 		while (filename[len - 1] == '.' || filename[len - 1] == '-')
 			len--;
 	}
-	sprintf(filename + len, ".%s", fmt_patch_suffix);
+	if (fmt_patch_suffix[0] != '\0')
+		sprintf(filename + len, ".%s", fmt_patch_suffix);
 	fprintf(realstdout, "%s\n", filename);
 	freopen(filename, "w", stdout);
 }
-- 
1.5.0.rc1.gfb138

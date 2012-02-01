From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: format_tracking_info "Your branch is behind" message
Date: Thu,  2 Feb 2012 01:21:54 +0800
Message-ID: <1328116914-61381-1-git-send-email-worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 01 18:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsdt4-00021m-7U
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab2BARWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:22:21 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64580 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab2BARWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 12:22:20 -0500
Received: by ghrr11 with SMTP id r11so689452ghr.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mMix4qxpYamkPn/uFkjVUZ0WGcNHvyD6XqgGt74vA+8=;
        b=kXrP+zxH5n/hKbX2m5AJSS9l1UZgWNvb+r+aU4LP02kz128u5GMnV3IUnDIrxQZEnH
         F5c7fKzGLsSPJAfavfFH1XvNwzo/BJhJNgPI70HexLuFq/egABFs3M6ZRuqDbSFRz7CQ
         U5ERAtBpgnlWP+f0GZtTV6VssGmwSKahmfgAU=
Received: by 10.50.6.138 with SMTP id b10mr27892504iga.21.1328116939831;
        Wed, 01 Feb 2012 09:22:19 -0800 (PST)
Received: from localhost.foo.bar ([123.116.240.29])
        by mx.google.com with ESMTPS id h9sm27515782ibh.11.2012.02.01.09.22.07
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 09:22:16 -0800 (PST)
X-Mailer: git-send-email 1.7.9.3.g1fbd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189524>

Function format_tracking_info in remote.c is called by
wt_status_print_tracking in wt-status.c, which will print
branch tracking message in git-status. git-checkout also
show these messages through it's report_tracking function.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 73a38..51853 100644
--- a/remote.c
+++ b/remote.c
@@ -1572,18 +1572,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs)
-		strbuf_addf(sb, "Your branch is ahead of '%s' "
-			    "by %d commit%s.\n",
-			    base, num_ours, (num_ours == 1) ? "" : "s");
+		strbuf_addf(sb, _("Your branch is ahead of '%s' "
+			    "by %d %s.\n"),
+			    base, num_ours, Q_("commit", "commits", num_ours));
 	else if (!num_ours)
-		strbuf_addf(sb, "Your branch is behind '%s' "
-			    "by %d commit%s, "
-			    "and can be fast-forwarded.\n",
-			    base, num_theirs, (num_theirs == 1) ? "" : "s");
+		strbuf_addf(sb, _("Your branch is behind '%s' "
+			    "by %d %s, "
+			    "and can be fast-forwarded.\n"),
+			    base, num_theirs, Q_("commit", "commits", num_theirs));
 	else
-		strbuf_addf(sb, "Your branch and '%s' have diverged,\n"
+		strbuf_addf(sb, _("Your branch and '%s' have diverged,\n"
 			    "and have %d and %d different commit(s) each, "
-			    "respectively.\n",
+			    "respectively.\n"),
 			    base, num_ours, num_theirs);
 	return 1;
 }
-- 
1.7.9.3.g1fbd7

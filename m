From: Christian Hammerl <info@christian-hammerl.de>
Subject: [PATCH] completion: Allow dash as the first character for __git_ps1
Date: Mon, 20 Feb 2012 13:17:53 +0100
Message-ID: <1329740273-5580-1-git-send-email-info@christian-hammerl.de>
Cc: Christian Hammerl <info@christian-hammerl.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 13:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzSVw-0005IN-94
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 13:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab2BTMij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 07:38:39 -0500
Received: from w3variance.de ([85.197.82.140]:50813 "EHLO w3variance.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab2BTMij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 07:38:39 -0500
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2012 07:38:39 EST
Received: from ip-95-222-99-150.unitymediagroup.de ([95.222.99.150] helo=minas-tirith.fritz.box)
	by w3variance.de with esmtpa (Exim 4.75)
	(envelope-from <info@christian-hammerl.de>)
	id 1RzSBc-0007QE-Qn; Mon, 20 Feb 2012 13:17:44 +0100
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191065>

If the argument for `__git_ps1` begins with a dash, `printf` tries to
interpret it as an option which results in an error message.
The problem is solved by adding '--' before the argument to tell
`printf` to not interpret the following argument as an option.
Adding '--' directly to the argument does not help because the argument
is enclosed by double quotes.

Signed-off-by: Christian Hammerl <info@christian-hammerl.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 91c7acb..61ff152 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -313,7 +313,7 @@ __git_ps1 ()
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 	fi
 }
 
-- 
1.7.9

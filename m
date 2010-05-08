From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Makefile: Fix 'clean' target to remove all gitweb build files
Date: Sat, 08 May 2010 18:36:15 +0100
Message-ID: <4BE5A10F.6040401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 19:37:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAnyQ-00026N-TA
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 19:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0EHRhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 13:37:19 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:38152 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610Ab0EHRhS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 13:37:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1OAnxk-0007Kx-Y8; Sat, 08 May 2010 17:37:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146667>


In particular the gitweb/GITWEB-BUILD-OPTIONS file was not being
removed by the main Makefile. However, the gitweb/Makefile has a
'clean' target that correctly removes all the build products.
In order to fix the problem, rather than duplicate the clean-up
instructions, we change the main Makefile so that it delegates
the clean-up actions to the gitweb Makefile.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..eb1d162 100644
--- a/Makefile
+++ b/Makefile
@@ -2098,7 +2098,7 @@ clean:
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
-	$(RM) gitweb/gitweb.cgi gitweb/gitweb.min.*
+	$(MAKE) -C gitweb clean
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-- 
1.7.1

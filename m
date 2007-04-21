From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] perl: install private Error.pm if the site version is older than our own
Date: Sat, 21 Apr 2007 00:55:00 -0700
Message-ID: <11771421002228-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 09:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfARN-0006Ho-U0
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 09:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbXDUHzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbXDUHzE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 03:55:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58106 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965085AbXDUHzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 03:55:03 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 346F22DC01A;
	Sat, 21 Apr 2007 00:55:01 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 21 Apr 2007 00:55:00 -0700
X-Mailer: git-send-email 1.5.1.1.139.g3b0e-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45153>

bdash (on IRC) had a problem with Git.pm (via git-svn) when his
site installation of Error.pm was older than the version we
package.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Makefile.PL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 9b117fd..4375161 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -13,7 +13,7 @@ my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
 eval { require Error };
-if ($@) {
+if ($@ || $Error::VERSION < 0.15009) {
 	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
 
-- 
1.5.1.1.139.g3b0e-dirty

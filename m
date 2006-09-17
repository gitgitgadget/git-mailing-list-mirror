From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb fix validating pg (page) parameter
Date: Sun, 17 Sep 2006 13:52:45 +0200
Message-ID: <20060917115245.GA15658@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 17 13:53:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOvCg-0001xI-NB
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 13:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWIQLws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 07:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWIQLws
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 07:52:48 -0400
Received: from moooo.ath.cx ([85.116.203.178]:33713 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964945AbWIQLwr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 07:52:47 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27187>

Currently it is possible to give any string ending with a number as
page.  -1 for example is quite bad (error log shows probably 100
warnings).
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 497129a..346c15c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -259,7 +259,7 @@ if (defined $hash_parent_base) {
 
 our $page = $cgi->param('pg');
 if (defined $page) {
-	if ($page =~ m/[^0-9]$/) {
+	if ($page =~ m/[^0-9]/) {
 		die_error(undef, "Invalid page parameter");
 	}
 }
-- 
1.4.2.1.ge767

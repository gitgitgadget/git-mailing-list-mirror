From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hooks--update: fix test for properly set up project description file
Date: Tue, 6 Nov 2007 13:47:49 +0000
Message-ID: <20071106134749.24233.qmail@809f27f669039a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOmP-0004CO-8I
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXKFNra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXKFNra
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:47:30 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:37002 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751312AbXKFNra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:47:30 -0500
Received: (qmail 24234 invoked by uid 1000); 6 Nov 2007 13:47:49 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63676>

The update hook template intends to abort if the project description file
hasn't been adjusted or is empty.  This patch fixes the check for 'being
adjusted'.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index d8c7626..65e8c32 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -34,8 +34,8 @@ fi
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # check for no description
-projectdesc=$(sed -e '1p' "$GIT_DIR/description")
-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
+projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
 fi
-- 
1.5.3.5

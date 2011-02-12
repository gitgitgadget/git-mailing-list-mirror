From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/2] git-gui: fix deleting item from all_remotes variable
Date: Sat, 12 Feb 2011 17:43:44 +0100
Message-ID: <20110212164344.GA19433@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 17:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoIZk-0007na-R2
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 17:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab1BLQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 11:43:48 -0500
Received: from darksea.de ([83.133.111.250]:34034 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751040Ab1BLQnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 11:43:46 -0500
Received: (qmail 11062 invoked from network); 12 Feb 2011 17:43:44 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 Feb 2011 17:43:44 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166616>

lsearch and lreplace both take the variable content as argument and not
just their name.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 lib/remote.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index b92b429..1383e97 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -264,8 +264,8 @@ proc remove_remote {name} {
 		unset repo_config(remote.$name.push)
 	}
 
-	set i [lsearch -exact all_remotes $name]
-	lreplace all_remotes $i $i
+	set i [lsearch -exact $all_remotes $name]
+	set all_remotes [lreplace $all_remotes $i $i]
 
 	set remote_m .mbar.remote
 	delete_from_menu $remote_m.fetch $name
-- 
1.7.4.34.gd2cb1

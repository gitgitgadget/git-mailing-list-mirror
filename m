From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Date: Thu, 24 Jul 2008 18:58:53 +0530
Message-ID: <20080724132853.GA25313@toroid.org>
References: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM0tI-000490-K8
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbYGXN24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYGXN24
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:28:56 -0400
Received: from fugue.toroid.org ([85.10.196.113]:58736 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYGXN2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 09:28:55 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id A77E7558516;
	Thu, 24 Jul 2008 15:28:54 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 82F95ADC368; Thu, 24 Jul 2008 18:58:53 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89878>

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-07-24 09:01:48 -0400, john.murphy@bankofamerica.com wrote:
>
> I presume this was just an oversight when git- commands were removed
> from the bin directory.

Looks like it. The following patch fixes it for me. Does it work for
you on Windows?

-- ams

 git-gui/git-gui.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 940677c..a70fa67 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1670,10 +1670,10 @@ proc do_gitk {revs} {
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
-	set exe [file join [file dirname $::_git] gitk]
+	set exe [_which gitk]
 	set cmd [list [info nameofexecutable] $exe]
-	if {! [file exists $exe]} {
-		error_popup [mc "Unable to start gitk:\n\n%s does not exist" $exe]
+	if {$exe eq {}} {
+		error_popup [mc "Couldn't find gitk in PATH"]
 	} else {
 		global env
 
-- 
1.5.6.GIT

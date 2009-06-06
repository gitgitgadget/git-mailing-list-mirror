From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] gitk: disable checkout of remote branch
Date: Sat, 6 Jun 2009 04:06:51 +0000 (UTC)
Message-ID: <slrnh2jqqr.64k.sitaramc@sitaramc.homelinux.net>
References: <slrnh2ie05.8mr.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 06:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCnBl-00086A-4W
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbZFFEHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 00:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbZFFEHD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:07:03 -0400
Received: from main.gmane.org ([80.91.229.2]:48944 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbZFFEHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 00:07:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MCnBO-0004TI-PQ
	for git@vger.kernel.org; Sat, 06 Jun 2009 04:07:02 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 04:07:02 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 04:07:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120866>

At the command line, this gives you a detailed warning message, but the
GUI currently allows it without any fuss.

Since the GUI is often used by people much less familiar with git, it
seems reasonable to make the GUI more restrictive than the command line,
not less.

This prevents a lot of detached HEAD commits by new users.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

I have a lot of new users, and I'd really appreciate it if
someone could review (hey it's my first Tcl code in all my
life!) and approve; this will save me a whole boatload of
trouble :-)

If someone disagrees with the logic that the GUI should be
more "safe" than the command line please do let me know.

 gitk-git/gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 gitk-git/gitk

diff --git a/gitk-git/gitk b/gitk-git/gitk
old mode 100644
new mode 100755
index 8c66d17..411bc52
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8770,6 +8770,9 @@ proc headmenu {x y id head} {
     set headmenuid $id
     set headmenuhead $head
     set state normal
+    if {[string match "remotes/*" $head]} {
+	set state disabled
+    }
     if {$head eq $mainhead} {
 	set state disabled
     }
-- 
1.6.3.2

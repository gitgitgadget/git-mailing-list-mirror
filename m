From: David Fries <david@fries.net>
Subject: [PATCH 2/2] git-gui blame add more common search hotkeys
Date: Sat, 16 Jul 2011 11:59:45 -0500
Message-ID: <20110716165945.GA9722@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 19:00:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi8Dt-0006E6-14
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 19:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab1GPRAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 13:00:08 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:52628 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1GPRAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 13:00:07 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p6GGxjjH009899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jul 2011 11:59:45 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p6GGxj3g009898;
	Sat, 16 Jul 2011 11:59:45 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Sat, 16 Jul 2011 11:59:45 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177280>

add slash and Control-S to bring up search
enter, n, Shift-Enter, Shift-n to to go the next and previous entries

search hotkey return is find_next shift prev

Signed-off-by: David Fries <David@Fries.net>

---
 git-gui/lib/blame.tcl  |    4 ++++
 git-gui/lib/search.tcl |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 062091b..cc8c0ba 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -352,9 +352,13 @@ constructor new {i_commit i_path i_jump} {
 	bind $w_cviewer <Button-1>   [list focus $w_cviewer]
 	bind $w_file    <Visibility> [cb _focus_search $w_file]
 	bind $top       <F7>         [list searchbar::show $finder]
+	bind $top       <Key-slash>  [list searchbar::show $finder]
+	bind $top    <Control-Key-s> [list searchbar::show $finder]
 	bind $top       <Escape>     [list searchbar::hide $finder]
 	bind $top       <F3>         [list searchbar::find_next $finder]
+	bind $top       <Key-n>      [list searchbar::find_next $finder]
 	bind $top       <Shift-F3>   [list searchbar::find_prev $finder]
+	bind $top    <Shift-Key-n>   [list searchbar::find_prev $finder]
 	bind $top    <Control-Key-g> [list linebar::show $gotoline]
 	catch { bind $top <Shift-Key-XF86_Switch_VT_3> [list searchbar::find_prev $finder] }
 
diff --git a/git-gui/lib/search.tcl b/git-gui/lib/search.tcl
index 7fdbf87..ef3486f 100644
--- a/git-gui/lib/search.tcl
+++ b/git-gui/lib/search.tcl
@@ -35,6 +35,8 @@ constructor new {i_w i_text args} {
 	grid remove $w
 
 	trace add variable searchstring write [cb _incrsearch_cb]
+	bind $w.ent <Return> [cb find_next]
+	bind $w.ent <Shift-Return> [cb find_prev]
 	
 	bind $w <Destroy> [list delete_this $this]
 	return $this
@@ -196,4 +198,4 @@ method scrolled {} {
 	}
 }
 
-}
\ No newline at end of file
+}
-- 
1.7.2.5

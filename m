From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/2] git-gui: fetch/prune all entry appears last
Date: Tue, 22 Feb 2011 20:30:21 +0100
Message-ID: <20110222193021.GB28519@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net> <4D640227.9090206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrxwK-0007d1-PP
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab1BVTaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:30:23 -0500
Received: from darksea.de ([83.133.111.250]:37015 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985Ab1BVTaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:30:23 -0500
Received: (qmail 12130 invoked from network); 22 Feb 2011 20:30:21 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Feb 2011 20:30:21 +0100
Content-Disposition: inline
In-Reply-To: <4D640227.9090206@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167578>

The user might have got used to the order the remotes appeared previously.
Lets add the all entry last so the all entry does not confuse previous
users.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Tue, Feb 22, 2011 at 07:36:23PM +0100, Jens Lehmann wrote:
> 2) I would rather like to see it at the *end* of the submenu, not at the
>    beginning. Being used to always click on the first menu entry only
>    to learn that the remote that used to be there got with something
>    else is kind of surprising ;-)

And this? Disclaimer: Also only superficially tested on OSX.

 lib/remote.tcl |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index 18d3d06..5e4e7f4 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -245,29 +245,27 @@ proc update_all_remotes_menu_entry {} {
 	set prune_m $remote_m.prune
 	if {$have_remote > 1} {
 		make_sure_remote_submenues_exist $remote_m
-		set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
-		if {[$fetch_m entrycget $index -label] ne "All"} {
+		if {[$fetch_m entrycget end -label] ne "All"} {
 
-			$fetch_m insert $index separator
-			$fetch_m insert $index command \
+			$fetch_m insert end separator
+			$fetch_m insert end command \
 				-label "All" \
 				-command fetch_from_all
 
-			$prune_m insert $index separator
-			$prune_m insert $index command \
+			$prune_m insert end separator
+			$prune_m insert end command \
 				-label "All" \
 				-command prune_from_all
 		}
 	} else {
 		if {[winfo exists $fetch_m]} {
-			set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
-			if {[$fetch_m type end] eq "separator"} {
+			if {[$fetch_m entrycget end -label] eq "All"} {
 
-				delete_from_menu $fetch_m $index
-				delete_from_menu $fetch_m $index
+				delete_from_menu $fetch_m end
+				delete_from_menu $fetch_m end
 
-				delete_from_menu $prune_m $index
-				delete_from_menu $prune_m $index
+				delete_from_menu $prune_m end
+				delete_from_menu $prune_m end
 			}
 		}
 	}
-- 
1.7.4.1.30.gd0a3

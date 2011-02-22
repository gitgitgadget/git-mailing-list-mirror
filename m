From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/2] git-gui: fetch/prune all entry only for more than one
	entry
Date: Tue, 22 Feb 2011 20:28:36 +0100
Message-ID: <20110222192835.GA28519@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net> <4D640227.9090206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prxue-0006cJ-32
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab1BVT2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:28:39 -0500
Received: from darksea.de ([83.133.111.250]:37010 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863Ab1BVT2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:28:38 -0500
Received: (qmail 12117 invoked from network); 22 Feb 2011 20:28:36 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Feb 2011 20:28:36 +0100
Content-Disposition: inline
In-Reply-To: <4D640227.9090206@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167577>

In case there is only one remote a fetch/prune all entry
is redundant.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Tue, Feb 22, 2011 at 07:36:23PM +0100, Jens Lehmann wrote:
> 1) It would be nice if the new menu entry would only appear when there
>    is more than one remote to fetch from.

How about this? Disclaimer: Only superficially tested on OSX.

 lib/remote.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index 42d2061..18d3d06 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -237,13 +237,13 @@ proc update_all_remotes_menu_entry {} {
 
 	set have_remote 0
 	foreach r $all_remotes {
-		set have_remote 1
+		incr have_remote
 	}
 
 	set remote_m .mbar.remote
 	set fetch_m $remote_m.fetch
 	set prune_m $remote_m.prune
-	if {$have_remote} {
+	if {$have_remote > 1} {
 		make_sure_remote_submenues_exist $remote_m
 		set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
 		if {[$fetch_m entrycget $index -label] ne "All"} {
-- 
1.7.4.1.30.gd0a3

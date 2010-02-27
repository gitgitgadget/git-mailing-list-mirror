From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 3/3] git-gui: fix shortcut creation on cygwin
Date: Sat, 27 Feb 2010 21:48:48 +0100
Message-ID: <20100227204848.GD33000@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> <20100227204108.GA33000@book.hvoigt.net> <20100227204549.GB33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTaq-0000HI-Id
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 21:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030859Ab0B0Usw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 15:48:52 -0500
Received: from darksea.de ([83.133.111.250]:40837 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030834Ab0B0Usv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 15:48:51 -0500
Received: (qmail 2155 invoked from network); 27 Feb 2010 21:48:49 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 21:48:49 +0100
Content-Disposition: inline
In-Reply-To: <20100227204549.GB33000@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141224>

When the user tried to create a desktop icon with git gui on cygwin
wscript was complaining about an unknown option and displaying the
non-native path as such.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui/lib/win32.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/win32.tcl b/git-gui/lib/win32.tcl
index d7f93d0..db91ab8 100644
--- a/git-gui/lib/win32.tcl
+++ b/git-gui/lib/win32.tcl
@@ -18,9 +18,9 @@ proc win32_create_lnk {lnk_path lnk_exec lnk_dir} {
 	eval [list exec wscript.exe \
 		/E:jscript \
 		/nologo \
-		[file join $oguilib win32_shortcut.js] \
+		[file nativename [file join $oguilib win32_shortcut.js]] \
 		$lnk_path \
-		[file join $oguilib git-gui.ico] \
+		[file nativename [file join $oguilib git-gui.ico]] \
 		$lnk_dir \
 		$lnk_exec] $lnk_args
 }
-- 
1.7.0.m5.rc3.5.g38df2

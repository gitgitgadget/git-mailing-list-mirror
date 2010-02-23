From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: git gui create desktop icon currently does not work
Date: Tue, 23 Feb 2010 23:49:57 +0100
Message-ID: <20100223224955.GB11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: msysGit Mailinglist <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3Zz-0007OI-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab0BWWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:50:05 -0500
Received: from darksea.de ([83.133.111.250]:60958 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754259Ab0BWWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:50:04 -0500
Received: (qmail 17555 invoked from network); 23 Feb 2010 23:49:58 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2010 23:49:58 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140858>

Hi,

I have a patch (further down) to this issue but I only tested this on
Windows 7 and my virtual machine (XP) did not like it for some reason (it
created the shortcut but the shortcut did not work). If anyone else can
confirm that this patch actually works we can include it.

Commit 3748b0 git-gui: update shortcut tools to use _gitworktree
from Guiseppe does break the creation of Desktop shortcuts on Windows.

I do not know whether this has worked with any tcl interpreter as it
attempts to execute $_gitworktree as a command.

Here is my fix:

>From 5c22c39d530ffb308826629d974048d30cd32e53 Mon Sep 17 00:00:00 2001
From: Heiko Voigt <hvoigt@hvoigt.net>
Date: Tue, 23 Feb 2010 10:40:14 +0100
Subject: [PATCH 1/2] git-gui: fix usage of _gitworktree when creating shortcut for windows

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui/lib/shortcut.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
index 79c1888..8cad0e2 100644
--- a/git-gui/lib/shortcut.tcl
+++ b/git-gui/lib/shortcut.tcl
@@ -16,7 +16,7 @@ proc do_windows_shortcut {} {
 					[info nameofexecutable] \
 					[file normalize $::argv0] \
 					] \
-					[file normalize [$_gitworktree]]
+					[file normalize $_gitworktree]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
-- 
1.7.0.m5.rc2.15.g8ba4c

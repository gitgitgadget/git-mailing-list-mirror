From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/2] Update git-daemon's documentation wrt. new options
Date: Fri, 21 Oct 2005 02:28:45 +0200
Message-ID: <20051021002845.26819.46168.stgit@machine.or.cz>
References: <20051021002842.26819.56707.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 02:29:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkmE-0003bV-4K
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVJUA2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVJUA2s
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:28:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59273 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964817AbVJUA2r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:28:47 -0400
Received: (qmail 26859 invoked from network); 21 Oct 2005 02:28:45 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 02:28:45 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20051021002842.26819.56707.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10395>

New options --timeout, --init-timeout, --export-all and whitelist support
were added to git-daemon, but noone bothered to also add the proper
documentation. This patch aims to fix that.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-daemon.txt |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a013a58..67c5f22 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -7,7 +7,8 @@ git-daemon - A really simple server for 
 
 SYNOPSIS
 --------
-'git-daemon' [--verbose] [--syslog] [--inetd | --port=n]
+'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
+             [--timeout=n] [--init-timeout=n] [directory...]
 
 DESCRIPTION
 -----------
@@ -20,18 +21,35 @@ what directory to upload, and it verifie
 
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any git directory that hasn't explicitly been marked
-for export this way.
+for export this way (unless the '--export-all' parameter is specified). If you
+pass some directory paths as 'git-daemon' arguments, you can further restrict
+the offers to a whitelist comprising of those.
 
 This is ideally suited for read-only updates, ie pulling from git repositories.
 
 OPTIONS
 -------
+--export-all::
+	Allow pulling from all directories that look like GIT repositories
+	(have the 'objects' subdirectory and a 'HEAD' file), even if they
+	do not have the 'git-daemon-export-ok' file.
+
 --inetd::
 	Have the server run as an inetd service.
 
 --port::
 	Listen on an alternative port.
 
+--init-timeout::
+	Timeout between the moment the connection is established and the
+	client request is received (typically a rather low value, since
+	that should be basically immediate).
+
+--timeout::
+	Timeout for specific client sub-requests. This includes the time
+	it takes for the server to process the sub-request and time spent
+	waiting for next client's request.
+
 --syslog::
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.

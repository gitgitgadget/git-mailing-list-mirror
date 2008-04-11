From: Gabriel <g2p.code@gmail.com>
Subject: [PATCH] Default to fetching a remote after adding it.
Date: Fri, 11 Apr 2008 20:39:23 +0200
Message-ID: <1207939163-24787-1-git-send-email-g2p.code@gmail.com>
References: <20080411203501.7095b866@localhost>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gabriel <g2p.code@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOAY-0000Ay-QH
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 20:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119AbYDKSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYDKSjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 14:39:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37223 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760100AbYDKSjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 14:39:25 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A334D1AB2D1;
	Fri, 11 Apr 2008 20:39:23 +0200 (CEST)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7D2EE1AB2B3;
	Fri, 11 Apr 2008 20:39:23 +0200 (CEST)
Received: from g2p by localhost with local (Exim 4.67)
	(envelope-from <g2p@vapeur.no-ip.org>)
	id 1JkO9j-0006S8-G6; Fri, 11 Apr 2008 20:39:23 +0200
X-Mailer: git-send-email 1.5.5.25.g17ee
In-Reply-To: <20080411203501.7095b866@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79285>

This is what the user wants in 99% of cases.

Signed-off-by: Gabriel <g2p.code@gmail.com>
---
 Documentation/git-remote.txt |    4 ++--
 builtin-remote.c             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2cbd1f7..04de972 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git-remote' add [-t <branch>] [-m <master>] [--no-fetch] [--mirror] <name> <url>
 'git-remote' rm <name>
 'git-remote' show <name>
 'git-remote' prune <name>
@@ -34,7 +34,7 @@ Adds a remote named <name> for the repository at
 <url>.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches <name>/<branch>.
 +
-With `-f` option, `git fetch <name>` is run immediately after
+Without the `--no-fetch` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `-t <branch>` option, instead of the default glob
diff --git a/builtin-remote.c b/builtin-remote.c
index 044215a..c0d7d96 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -54,7 +54,7 @@ static int fetch_remote(const char *name)
 
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 1, mirror = 0;
 	struct path_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
-- 
1.5.5.25.g17ee

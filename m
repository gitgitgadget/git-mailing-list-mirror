From: Erik Broes <erikbroes@ripe.net>
Subject: [PATCH] git-shell: Add 'git-upload-archive' to allowed commands.
Date: Thu, 09 Apr 2009 21:58:52 +0200
Message-ID: <49DE537C.8070907@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 00:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls2fv-0001Ew-IJ
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 00:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762605AbZDIWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 18:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762345AbZDIWXM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 18:23:12 -0400
Received: from postlady.ripe.net ([193.0.19.65]:35895 "EHLO postlady.ripe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758859AbZDIWXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 18:23:11 -0400
X-Greylist: delayed 8648 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2009 18:23:10 EDT
Received: from herring.ripe.net ([193.0.1.203])
	by postlady.ripe.net with esmtp (Exim 4.63)
	(envelope-from <erikbroes@ripe.net>)
	id 1Ls0Oj-0000k9-42
	for git@vger.kernel.org; Thu, 09 Apr 2009 21:58:53 +0200
Received: from Grumm.local (gw.office.nsrp.ripe.net [193.0.1.126])
	by herring.ripe.net (Postfix) with ESMTP id 0AC972F583
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 21:58:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
X-RIPE-Spam-Level: ----
X-RIPE-Signature: a3d33ccd309479c043417935190f954d3b17c25e163f194e5449f913c2dd2402
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116215>

This allows for example gitosis to allow use of 'git archive --remote' in a
controlled environment.

Signed-off-by: Erik Broes <erikbroes@ripe.net>
---

There were some questions on IRC raising (valid) concerns about security.
If there is a dangling commit on the remote end and any user would know
or guess the SHA, it could be retrieved where git-upload-pack will not
allow so.

We were unable to find out if this was the original reason git-shell was
never extended with git-upload-archive functionality or if it was a simple
oversight. If it was the reason I'm not sure there is an easy way out.

 Documentation/git-shell.txt |    6 +++---
 shell.c                     |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 3f8d973..0f3ad81 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -18,9 +18,9 @@ of server-side GIT commands implementing the pull/push functionality.
 The commands can be executed only by the '-c' option; the shell is not
 interactive.

-Currently, only three commands are permitted to be called, 'git-receive-pack'
-'git-upload-pack' with a single required argument or 'cvs server' (to invoke
-'git-cvsserver').
+Currently, only four commands are permitted to be called, 'git-receive-pack'
+'git-upload-pack' and 'git-upload-archive' with a single required argument, or
+'cvs server' (to invoke 'git-cvsserver').

 Author
 ------
diff --git a/shell.c b/shell.c
index e339369..b968be7 100644
--- a/shell.c
+++ b/shell.c
@@ -40,6 +40,7 @@ static struct commands {
 } cmd_list[] = {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
+	{ "git-upload-archive", do_generic_cmd },
 	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
-- 
1.6.2.1.519.gcf01bc

From: Rodrigo Silva =?utf-8?b?KE1lc3RyZUxpb24p?= 
	<linux@rodrigosilva.com>
Subject: [PATCH] Documentation: improve description of =?utf-8?b?R0lUX0VESVRPUg==?= and preference order
Date: Fri, 23 Mar 2012 12:38:42 +0000 (UTC)
Message-ID: <loom.20120323T133648-453@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 13:45:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB3rp-0001BC-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 13:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab2CWMpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 08:45:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:40957 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab2CWMpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 08:45:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SB3rb-0000xY-Ab
	for git@vger.kernel.org; Fri, 23 Mar 2012 13:45:04 +0100
Received: from baddd5e7.virtua.com.br ([baddd5e7.virtua.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 13:45:03 +0100
Received: from linux by baddd5e7.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 13:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 186.221.213.231 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:11.0) Gecko/20100101 Firefox/11.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193757>

Previously GIT_EDITOR was not listed in git(1) "Environment Variables" section,
which could be very confusing to users. Include it in "other" subsection along
with a link to git-var(1), since that is the page that fully describes all
places where editor can be set and also their preference order.

Also, git-var(1) did not say that hardcoded fallback 'vi' may have been changed
at build time. A user could be puzzled if 'nano' pops up even when none of the
mentioned environment vars or config.editor are set. Clarify this.

Ideally, the build system should be changed to reflect the chosen fallback
editor when creating the man pages. Not sure if that is even possible though.

Signed-off-by: Rodrigo Silva (MestreLion) <linux@rodrigosilva.com>
---
 Documentation/git-var.txt |    3 ++-
 Documentation/git.txt     |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

 Granted, this is a very minor issue, but if any user stumble on this, this
 patch may reduce investigation from 50 minutes to 5

 Patch was tested in 1.7.1, but sources show this is still present in 1.7.10-rc1

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 5317cc2..9c49163 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -43,7 +43,8 @@ GIT_EDITOR::
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+    `$VISUAL`, then `$EDITOR`, and then finally a hardcoded fallback
+    editor set at build time, by default 'vi'.
 
 GIT_PAGER::
     Text viewer for use by git commands (e.g., 'less').  The value
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d5b7667..fac57ba 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -711,6 +711,12 @@ other
 	a pager.  See also the `core.pager` option in
 	linkgit:git-config[1].
 
+'GIT_EDITOR'::
+    This environment variable overrides `$EDITOR` and `$VISUAL`.
+    It is used by several git comands when, on interactive mode,
+    an editor is to be launched. See also linkgit:git-var[1]
+    and the `core.editor` option in linkgit:git-config[1].
+
 'GIT_SSH'::
 	If this environment variable is set then 'git fetch'
 	and 'git push' will use this command instead
-- 
1.7.1

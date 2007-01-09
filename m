From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] git-remote
Date: Mon, 8 Jan 2007 23:28:51 -0500
Message-ID: <20070109042851.GF1686@fieldses.org>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 05:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H48bZ-0002pE-Gk
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 05:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbXAIE2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 23:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXAIE2y
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 23:28:54 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53327 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbXAIE2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 23:28:54 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H48bT-0003D6-UE; Mon, 08 Jan 2007 23:28:51 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36308>

On Wed, Jan 03, 2007 at 01:40:56PM -0800, Junio C Hamano wrote:
> 	$ git add another git://git.kernel.org/pub/...
> 
> defines the default remote.another.url and remote.another.fetch
> entries just like a clone does; you can say "git fetch another"
> afterwards.

Nifty.

Would it make sense for "git add" to do the initial fetch as well?

That'd also help catch any typos in the URL early--the first time I used
this I mistyped the URL, then had to delete the configuration by hand
after I found the problem....

How about this as a man page?

--b.

Documentation: add git-remote man page

Add a preliminary man page for git-remote.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-remote.txt |   76 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
new file mode 100644
index 0000000..7d6663e
--- /dev/null
+++ b/Documentation/git-remote.txt
@@ -0,0 +1,76 @@
+git-remote(1)
+============
+
+NAME
+----
+git-remote - manage set of tracked repositories
+
+
+SYNOPSIS
+--------
+[verse]
+'git-remote'
+'git-remote' add <name> <url>
+'git-remote' show <name>
+
+DESCRIPTION
+-----------
+
+Manage the set of repositories ("remotes") whose branches you track.
+
+With no arguments, shows a list of existing remotes.
+
+In the second form, adds a remote named <name> for the repository at
+<url>.  The command `git fetch <name>` can then be used to create and
+update remote-tracking branches <name>/<branch>.
+
+In the third form, gives some information about the remote <name>.
+
+The remote configuration is achieved using the `remote.origin.url` and
+`remote.origin.fetch` configuration variables.  (See
+gitlink:git-repo-config[1]).
+
+Examples
+--------
+
+Add a new remote, fetch, and check out a branch from it:
+
+------------
+$ git remote
+origin
+$ git branch -r
+origin/master
+$ git remote add linux-nfs git://linux-nfs.org/pub/nfs-2.6.git
+$ git remote
+linux-nfs
+origin
+$ git fetch
+* refs/remotes/linux-nfs/master: storing branch 'master' ...
+  commit: bf81b46
+$ git branch -r
+origin/master
+linux-nfs/master
+$ git checkout -b nfs linux-nfs/master
+...
+------------
+
+See Also
+--------
+gitlink:git-fetch[1]
+gitlink:git-branch[1]
+gitlink:git-repo-config[1]
+
+Author
+------
+Written by Junio Hamano 
+
+
+Documentation
+--------------
+Documentation by J. Bruce Fields and the git-list <git@vger.kernel.org>.
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
-- 
1.4.4.4.g4083

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] filter-branch: add an example how to add ACKs to a range of
 commits
Date: Mon, 17 Aug 2009 22:38:46 +0200 (CEST)
Message-ID: <34cc046b42b5a67bb1c926709bcd1163d1d2faf6.1250541493u.git.johannes.schindelin@gmx.de>
References: <cover.1250541493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 17 22:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8yH-0006pp-VE
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbZHQUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758025AbZHQUh6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:37:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:35193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757982AbZHQUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:37:57 -0400
Received: (qmail invoked by alias); 17 Aug 2009 20:37:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 17 Aug 2009 22:37:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180x/pWPZA0F4Hm+4mp+l9ejtX+6/rOTliubE7iuP
	gANOJwMQUN/hmz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1250541493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126274>

When you have to add certain lines like ACKs (or for that matter,
Signed-off-by:s) to a range of commits starting with HEAD, you might
be tempted to use 'git rebase -i -10', but that is a waste of your
time.

It is better to use 'git filter-branch' with an appropriate message
filter, and this commit adds an example how to do so to
filter-branch's man page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ab527b5..32ea856 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -305,6 +305,16 @@ range in addition to the new branch name.  The new branch name will
 point to the top-most revision that a 'git-rev-list' of this range
 will print.
 
+If you need to add 'Acked-by' lines to, say, the last 10 commits (none
+of which is a merge), use this command:
+
+--------------------------------------------------------
+git filter-branch --msg-filter '
+	cat &&
+	echo "Acked-by: Bugs Bunny <bunny@bugzilla.org>"
+' HEAD~10..HEAD
+--------------------------------------------------------
+
 *NOTE* the changes introduced by the commits, and which are not reverted
 by subsequent commits, will still be in the rewritten branch. If you want
 to throw out _changes_ together with the commits, you should use the
-- 
1.6.4.313.g3d9e3

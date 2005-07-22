From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Deb packaging needs two more configuration files
Date: Fri, 22 Jul 2005 02:36:07 -0400
Message-ID: <20050722063607.GS20369@mythryan2.michonline.com>
References: <20050721061545.GM20369@mythryan2.michonline.com> <20050722055556.GR20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 22 08:36:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvr90-0002yT-77
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 08:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVGVGgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 02:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVGVGgM
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 02:36:12 -0400
Received: from mail.autoweb.net ([198.172.237.26]:49380 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261942AbVGVGgK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 02:36:10 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dvr8i-0004Q6-Jo; Fri, 22 Jul 2005 02:36:08 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DvrGr-00025r-00; Fri, 22 Jul 2005 02:44:33 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dvr8i-0004rb-06; Fri, 22 Jul 2005 02:36:08 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050722055556.GR20369@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The deb package building needs these two new files to work correctly.

debian/compat sets the rules under which the debhelper scripts (dh_*) operate.

debian/git-core.install tells dh_install what files to install in each package
that is generated.  There is only one package being generated, so all files go
into it.

(I missed these in the last patch, mostly because I needed to do this to
find stuff I had missed:
	find . -name .git -type d -prune -o -type f -print \
		| grep -v -e .tree1 -e .tree2 \
		| sed -e "s/^\.\///" \
		| sort >.tree1
	git-ls-files | grep -v -e .tree1 -e .tree2 \
		| sort >.tree2
	diff -u .tree1 .tree2
)

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 debian/compat           |    1 +
 debian/git-core.install |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 debian/compat
 create mode 100644 debian/git-core.install

d5ccc10c30f1baa968705aa0c3dfc98e0ade5eaf
diff --git a/debian/compat b/debian/compat
new file mode 100644
--- /dev/null
+++ b/debian/compat
@@ -0,0 +1 @@
+4
diff --git a/debian/git-core.install b/debian/git-core.install
new file mode 100644
--- /dev/null
+++ b/debian/git-core.install
@@ -0,0 +1 @@
+*

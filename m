From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Deb packaging needs two more configuration files
Date: Fri, 22 Jul 2005 22:32:27 -0700
Message-ID: <7virz25bpw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 07:32:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwCcm-0003YW-Pq
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 07:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVGWFca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 01:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVGWFca
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 01:32:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12014 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261419AbVGWFc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 01:32:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723053224.KGHK15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 01:32:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Ryan Anderson <ryan@michonline.com>
Date: 1122014167 -0400

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
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 debian/compat           |    1 +
 debian/git-core.install |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 debian/compat
 create mode 100644 debian/git-core.install

1d3ca8896651928adb5ec138b32c8bc3700fc0a6
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

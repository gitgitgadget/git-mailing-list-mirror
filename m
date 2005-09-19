From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fixing --help, usage for *-id
Date: Mon, 19 Sep 2005 17:29:41 -0400
Message-ID: <1127165381.26772.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 23:30:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTD5-0002nX-V6
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVISV3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVISV3w
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:29:52 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:37335 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932704AbVISV3v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:29:51 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHTCr-0001LB-ES
	for git@vger.kernel.org; Mon, 19 Sep 2005 17:29:45 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHTCn-0000Zd-JW; Mon, 19 Sep 2005 17:29:41 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8910>

Hello!

Removal of cg-Xlib inclusion in *-id scripts broke "--help" switch.
When cg-Xlib is sourced indirectly through cg-Xnormid, the help text is
treated like an ID, and its last word is dropped.

Lack of USAGE string in the *-id scripts breaks the documentation
generation because empty synopsis causes invalid XML.  Thus the USAGE
strings should be provided.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-commit-id b/cg-commit-id
--- a/cg-commit-id
+++ b/cg-commit-id
@@ -5,6 +5,10 @@
 #
 # Takes the appropriate ID, defaults to HEAD.
 
+USAGE="cg-commit-id"
+
+. ${COGITO_LIB}cg-Xlib
+
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=${normid#* }
diff --git a/cg-parent-id b/cg-parent-id
--- a/cg-parent-id
+++ b/cg-parent-id
@@ -7,5 +7,9 @@
 #
 # NOTE: Will return multiple SHA1s if ID is a commit with multiple parents.
 
+USAGE="cg-parent-id"
+
+. ${COGITO_LIB}cg-Xlib
+
 normid=$(. ${COGITO_LIB}cg-Xnormid "$1"^)
 echo ${normid%% *}
diff --git a/cg-tree-id b/cg-tree-id
--- a/cg-tree-id
+++ b/cg-tree-id
@@ -5,6 +5,10 @@
 #
 # Takes ID of the appropriate commit, defaults to HEAD.
 
+USAGE="cg-tree-id"
+
+. ${COGITO_LIB}cg-Xlib
+
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=${normid#* }


-- 
Regards,
Pavel Roskin

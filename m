From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Add -f parameter also to cg-update
Date: Sat, 04 Jun 2005 08:25:08 +0200
Message-ID: <1117866308.3656.120.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-V2Bo62YAlYCKT6hdOL9n"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 08:22:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeS35-0005mG-Ee
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFDGZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFDGZ3
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 02:25:29 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:5823 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261263AbVFDGZL
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 02:25:11 -0400
Received: from pegasus (p5487C92A.dip.t-dialin.net [84.135.201.42])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j546R5Ss008255
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sat, 4 Jun 2005 08:27:05 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/910/Fri Jun  3 18:05:05 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-V2Bo62YAlYCKT6hdOL9n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch adds the -f parameter to force a full pull also to
cg-update.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-V2Bo62YAlYCKT6hdOL9n
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/cg-update b/cg-update
--- a/cg-update
+++ b/cg-update
@@ -7,16 +7,27 @@
 #
 # If local changes conflict with those of the branch updated from the
 # merge will be blocked.
+#
+# OPTIONS
+# -------
+# -f::
+#	Force the complete pull even if the heads are the same.
 
-USAGE="cg-update [BRANCH_NAME]"
+USAGE="cg-update [-f] [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib
 
+force=
+if [ "$1" = "-f" ]; then
+	force=$1
+	shift
+fi
+
 name=$1
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to update from?"
 
-cg-pull $name || exit 1
+cg-pull $force $name || exit 1
 echo
 echo "Applying changes..."
 cg-merge $name

--=-V2Bo62YAlYCKT6hdOL9n--


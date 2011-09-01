From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v2] (short) documentation for the testgit remote helper
Date: Thu,  1 Sep 2011 18:49:38 +0200
Message-ID: <1314895778-17482-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqd3fk1cq5.fsf@bauges.imag.fr>
 <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 01 18:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzASv-00033c-AQ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab1IAQt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:49:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45401 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab1IAQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:49:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81Gn2Mo004436
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 18:49:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QzASY-00034a-Hz; Thu, 01 Sep 2011 18:49:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QzASY-0004Yg-GZ; Thu, 01 Sep 2011 18:49:46 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 18:49:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81Gn2Mo004436
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315500544.66896@LchJQNcjKtXf3ri/uZOrWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180544>

While it's not a command meant to be used by actual users (hence, not
mentionned in git(1)), this command is a very precious help for
remote-helpers authors.

The best place for such technical doc is the source code, but users may
not find it without a link in a manpage.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
change since v1: document environment variables for debugging, not
hacking the source code.

 Documentation/git-remote-helpers.txt |    2 ++
 Documentation/git-remote-testgit.txt |   30 ++++++++++++++++++++++++++++++
 git-remote-testgit.py                |   13 +++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-testgit.txt

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 526fc6a..674797c 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -362,6 +362,8 @@ SEE ALSO
 --------
 linkgit:git-remote[1]
 
+linkgit:git-remote-testgit[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
new file mode 100644
index 0000000..2a67d45
--- /dev/null
+++ b/Documentation/git-remote-testgit.txt
@@ -0,0 +1,30 @@
+git-remote-testgit(1)
+=====================
+
+NAME
+----
+git-remote-testgit - Example remote-helper
+
+
+SYNOPSIS
+--------
+[verse]
+git clone testgit::<source-repo> [<destination>]
+
+DESCRIPTION
+-----------
+
+This command is a simple remote-helper, that is used both as a
+testcase for the remote-helper functionality, and as an example to
+show remote-helper authors one possible implementation.
+
+The best way to learn more is to read the comments and source code in
+'git-remote-testgit.py'.
+
+SEE ALSO
+--------
+linkgit:git-remote-helpers[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e9c832b..3dc4851 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -1,5 +1,18 @@
 #!/usr/bin/env python
 
+# This command is a simple remote-helper, that is used both as a
+# testcase for the remote-helper functionality, and as an example to
+# show remote-helper authors one possible implementation.
+#
+# This is a Git <-> Git importer/exporter, that simply uses git
+# fast-import and git fast-export to consume and produce fast-import
+# streams.
+#
+# To understand better the way things work, one can activate debug
+# traces by setting (to any value) the environment variables
+# GIT_TRANSPORT_HELPER_DEBUG and GIT_DEBUG_TESTGIT, to see messages
+# from the transport-helper side, or from this example remote-helper.
+
 # hashlib is only available in python >= 2.5
 try:
     import hashlib
-- 
1.7.7.rc0.75.g56f27

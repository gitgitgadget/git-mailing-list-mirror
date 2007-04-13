From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] config.txt: Add gitcvs.db* variables
Date: Fri, 13 Apr 2007 18:13:42 +0200
Message-ID: <11764808223731-git-send-email-frank@lichtenheld.de>
References: <evmhot$p0l$2@sea.gmane.org>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOPk-0004bA-27
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXDMQOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXDMQON
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:14:13 -0400
Received: from mail.lenk.info ([217.160.134.107]:4928 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbXDMQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:14:11 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOPM-0000L3-KI; Fri, 13 Apr 2007 18:13:58 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOPV-0001LY-UK; Fri, 13 Apr 2007 18:14:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOP8-0001tP-8g; Fri, 13 Apr 2007 18:13:42 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <evmhot$p0l$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44418>

Adds documentation for gitcvs.{dbname,dbdriver,dbuser,dbpass}
Texts are mostly taken from git-cvsserver.txt whith some
adaptions so that they make more sense out of the context
of the original man page.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/config.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

 Note that this one is made on top of the cvsserver topic
 branch and my fixes to config.txt (i.e. the description
 for gitcvs.allbinary is in the context of the patch).
 Just saying.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 62168e6..ad2c1f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -425,6 +425,33 @@ gitcvs.allbinary::
 	fact that there is no way yet to set single files to mode '-kb'.
 	See gitlink:git-cvsserver[1].
 
+gitcvs.dbname::
+	Database used by git-cvsserver to cache revision information
+	derived from the git repository. The exact meaning depends on the
+	used database driver, for SQLite (which is the default driver) this
+	is a filename. Supports variable substitution (see
+	gitlink:git-cvsserver[1] for details). May not contain semicolons (`;`).
+	Default: '%Ggitcvs.%m.sqlite'
+
+gitcvs.dbdriver::
+	Used Perl DBI driver. You can specify any available driver	
+        for this here, but it might not work. git-cvsserver is tested
+	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
+	reported *not* to work with 'DBD::mysql'. Experimental feature.
+	May not contain double colons (`:`). Default: 'SQLite'.
+	See gitlink:git-cvsserver[1].
+
+gitcvs.dbuser, gitcvs.dbpass::
+	Database user and password. Only useful if setting 'gitcvs.dbdriver',
+	since SQLite has no concept of database users and/or passwords.
+	'gitcvs.dbuser' supports variable substitution (see
+	gitlink:git-cvsserver[1] for details).
+
+All gitcvs variables except for 'gitcvs.allbinary' can also specifed
+as 'gitcvs.<access_method>.<varname>' (where 'access_method' is one
+of "ext" and "pserver") to make them apply only for the given access
+method.
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
-- 
1.5.1.1

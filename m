From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Add example xinetd(8) configuration to Documentation/everyday.txt
Date: Sun, 04 Jun 2006 19:53:45 -0400
Message-ID: <11494652252294-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 01:54:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn2Pw-0005fo-Mv
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 01:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWFDXx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 19:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWFDXx6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 19:53:58 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:32729 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932331AbWFDXx5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 19:53:57 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k54Nrpgu014858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 19:53:52 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k54Nrlfh017992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 19:53:47 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k54NrjrN017991;
	Sun, 4 Jun 2006 19:53:45 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g16a4
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 04 Jun 2006 19:53:52 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21296>

Many Linux distributions use xinetd(8), not inetd(8).
Give a sample configuration file.

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/everyday.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 2ad2d61..ffba543 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -377,6 +377,29 @@ git	stream	tcp	nowait	nobody \
 +
 The actual configuration line should be on one line.
 
+Run git-daemon to serve /pub/scm from xinetd.::
++
+------------
+$ cat /etc/xinetd.d/git-daemon
+# default: off
+# description: The git server offers access to git repositories
+service git
+{
+        disable = no
+        type            = UNLISTED
+        port            = 9418
+        socket_type     = stream
+        wait            = no
+        user            = root
+        server          = /usr/bin/git-daemon
+        server_args     = --inetd --syslog --export-all --base-path=/pub/scm
+        log_on_failure  += USERID
+}
+------------
++
+Check your xinetd(8) documentation and setup, this is from a Fedora system.
+Others might be different.
+
 Give push/pull only access to developers.::
 +
 ------------
-- 
1.3.3.g16a4

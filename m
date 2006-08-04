From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] autoconf: Check for working mmap
Date: Fri,  4 Aug 2006 17:55:56 +0200
Message-ID: <11547069592652-git-send-email-jnareb@gmail.com>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:56:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G922J-0007FZ-Su
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWHDP4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWHDP4K
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:56:10 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:64164 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1161264AbWHDP4I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:56:08 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k74Ft6tx029216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Aug 2006 17:55:06 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k74Ftx9Z018879;
	Fri, 4 Aug 2006 17:55:59 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k74FtxW9018878;
	Fri, 4 Aug 2006 17:55:59 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24800>

Use AC_FUNC_MMAP check to check if the `mmap' function exists and
works correctly.  (It only checks private fixed mapping of
already-mapped memory.)

Attention: uses implementation detail of AC_FUNC_MMAP!

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0a54b44..178220f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -208,6 +208,10 @@ AC_CHECK_FUNC(setenv,[],
 [GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease)])
 #
 # Define NO_MMAP if you want to avoid mmap.
+AC_FUNC_MMAP
+if test $ac_cv_func_mmap_fixed_mapped != yes; then
+	GIT_CONF_APPEND_LINE(NO_MMAP=YesPlease)
+fi
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
-- 
1.4.1.1

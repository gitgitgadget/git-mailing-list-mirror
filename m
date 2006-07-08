From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 6] autoconf: Checks for some library functions.
Date: Sat,  8 Jul 2006 23:07:11 +0200
Message-ID: <11523928373026-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <1152392836910-git-send-email-jnareb@gmail.com> <1152392837823-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1h-0003ja-Vy
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWGHVHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGHVHd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:33 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:63681 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030386AbWGHVHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:30 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6nAC021755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:51 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7HUS015591;
	Sat, 8 Jul 2006 23:07:17 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7HKq015590;
	Sat, 8 Jul 2006 23:07:17 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1152392837823-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23507>

./configure script checks now for the following library functions:
 * strcasestr (NO_STRCASESTR)
 * strlcpy (NO_STRLCPY)
 * setenv (NO_SETENV)
in default C library and in libraries which have AC_CHECK_LIB done for
them.

Checks not implemented:
 * NO_MMAP  - probably only via optional features configuration
 * NO_IPV6  - what does "lack IPv6 support" mean?
 * NO_ICONV - what does "properly support iconv" mean?

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Added only those checks I was sure how to do in autoconf.

Probably other, marked as not implemented checks either need custom
test, or are more suited to site configuration section.

 configure.ac |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index cb81258..ab6a77a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,12 +69,21 @@ GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE
 
 
 ## Checks for library functions.
+## (in default C library and libraries checked by AC_CHECK_LIB)
+AC_MSG_NOTICE([CHECKS for library functions])
+
 # Define NO_STRCASESTR if you don't have strcasestr.
-#
+AC_CHECK_FUNC(strcasestr,[],
+GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease))
+
 # Define NO_STRLCPY if you don't have strlcpy.
-#
+AC_CHECK_FUNC(strlcpy,[],
+GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease))
+
 # Define NO_SETENV if you don't have setenv in the C library.
-#
+AC_CHECK_FUNC(setenv,[],
+GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease))
+
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
-- 
1.4.0

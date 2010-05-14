From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 14/18] Makefile: SunOS 5.6 portability fix
Date: Fri, 14 May 2010 09:31:45 +0000
Message-ID: <20100514093833.233343000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLu-000236-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834Ab0ENJij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:39 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:62502 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789Ab0ENJie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:34 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id DE4975C0C
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:25 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com DE4975C0C
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id A18FED06;
	Fri, 14 May 2010 09:38:33 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 5DD6E11D4D1; Fri, 14 May 2010 09:38:33 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-SunOS56.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147071>

Although configure takes care of most of this, set some default values
for Solaris 2.6 (aka SunOS-5.6) to ensure git compiles even when
configure is not used to build it.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -812,6 +812,18 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
+	ifeq ($(uname_R),5.6)
+		SOCKLEN_T = int
+		NO_HSTRERROR = YesPlease
+		NO_IPV6 = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
+	endif
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)

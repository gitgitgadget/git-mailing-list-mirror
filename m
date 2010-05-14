From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 16/18] Makefile: HPUX11 portability fixes.
Date: Fri, 14 May 2010 09:31:47 +0000
Message-ID: <20100514093843.575490000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrM4-00028C-Iw
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758844Ab0ENJiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:46 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64903 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840Ab0ENJio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:44 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E809C5C71
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:35 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E809C5C71
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id BF445CA0;
	Fri, 14 May 2010 09:38:43 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id B139911D4D1; Fri, 14 May 2010 09:38:43 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX11.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147074>

There is no nanosecond field on HPUX, the inline keyword is
spelled "__inline", and there are no inet_ntop/inet_pton definitions
on HP-UX 11.00

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -971,6 +971,7 @@ ifeq ($(uname_S),IRIX64)
 	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
+	INLINE = __inline
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
@@ -982,6 +983,11 @@ ifeq ($(uname_S),HP-UX)
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
+	NO_NSEC = YesPlease
+	ifeq ($(uname_R),B.11.00)
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
+	endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),Windows)

-- 
Gary V. Vaughan (gary@thewrittenword.com)

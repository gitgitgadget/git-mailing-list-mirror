From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 17/18] Makefile: HP-UX 10.20 portability fixes.
Date: Fri, 14 May 2010 09:31:48 +0000
Message-ID: <20100514093848.745470000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:39:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrMA-0002CT-QW
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab0ENJiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:51 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:52067 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840Ab0ENJit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:49 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 183A95CB7
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:41 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 183A95CB7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id E381BCD2;
	Fri, 14 May 2010 09:38:48 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id D840911D4D1; Fri, 14 May 2010 09:38:48 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX10.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147076>

HP-UX 10.20 has no pread definition, the inline keyword doesn't work,
and has no inet_ntop/inet_pton definitions.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -988,6 +988,14 @@ ifeq ($(uname_S),HP-UX)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
 	endif
+	ifeq ($(uname_R),B.10.20)
+		# Override HP-UX 11.x setting:
+		INLINE =
+		SOCKLEN_T = size_t
+		NO_PREAD = YesPlease
+ 		NO_INET_NTOP = YesPlease
+ 		NO_INET_PTON = YesPlease
+	endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),Windows)

-- 
Gary V. Vaughan (gary@thewrittenword.com)

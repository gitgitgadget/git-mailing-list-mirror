From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 18/18] Makefile: Tru64 portability fix
Date: Fri, 14 May 2010 09:31:49 +0000
Message-ID: <20100514093853.905838000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:39:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrMB-0002CT-Al
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858Ab0ENJi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:56 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:58035 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758852Ab0ENJiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:54 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 3FB615CB8
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:46 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 3FB615CB8
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 16F41CD4;
	Fri, 14 May 2010 09:38:54 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 0BB6D11D4D1; Fri, 14 May 2010 09:38:54 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-OSF1.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147075>

Add defaults for Tru64 Unix.  Without this patch I cannot compile
git on Tru64 5.1.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,13 @@ EXTLIBS =
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
+ifeq ($(uname_S),OSF1)
+	# Need this for u_short definitions et al
+	BASIC_CFLAGS += -D_OSF_SOURCE
+	SOCKLEN_T = int
+	NO_STRTOULL = YesPlease
+	NO_NSEC = YesPlease
+endif
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)

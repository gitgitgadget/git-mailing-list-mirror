From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/2] Makefile: Set EXTRA_CPPFLAGS during the compilation of run-command
Date: Sun, 25 Mar 2012 08:31:36 -0400
Message-ID: <1332678696-4001-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 25 14:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBmbs-0000Ki-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 14:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2CYMbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 08:31:42 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:46323 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633Ab2CYMbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 08:31:41 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60892 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbj-0002Oj-1K; Sun, 25 Mar 2012 08:31:39 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbi-000135-Tz; Sun, 25 Mar 2012 08:31:38 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193864>

When building run-command.o, we want to pass in a define for
SHELL_PATH to ensure that the shell configured at build time is used
at run time when spawning external commands.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index be1957a..344e2e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1913,6 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
+run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH)"'
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln git$X $@ 2>/dev/null || \
-- 
1.7.5.4

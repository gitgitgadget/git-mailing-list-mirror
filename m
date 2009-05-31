From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 02/11] Quiet make: do not leave Windows behind
Date: Sun, 31 May 2009 18:15:16 +0200
Message-ID: <1243786525-4493-3-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniL-0001nG-38
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851AbZEaQQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758739AbZEaQQN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:58619 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532AbZEaQQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:05 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFVXd006795;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPV9021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120410>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, we have to check whether there are scripts which would
override .exe files, but this check missed the "quietification".
Make now prints 'BUILTIN all' instead of a long chain of 'test || rm'
commands.

[spr: added clarification what make will print. ]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 77d8d9c..af08257 100644
--- a/Makefile
+++ b/Makefile
@@ -1202,7 +1202,7 @@ SHELL = $(SHELL_PATH)
 
 all:: shell_compatibility_test $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
-- 
1.6.3.1.54.g99dd

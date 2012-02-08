From: Michael <kensington@astralcloak.net>
Subject: [PATCH v2] Explicitly set X to avoid potential build breakage
Date: Wed, 08 Feb 2012 21:59:04 +1100
Message-ID: <1974397.vopy2n9Vpb@telegraph>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 11:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv5F4-0000O6-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 11:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab2BHK7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 05:59:09 -0500
Received: from astralcloak.net ([66.246.75.167]:45723 "EHLO
	mail.astralcloak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab2BHK7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 05:59:08 -0500
Received: from mail.astralcloak.net (mail.astralcloak.net [127.0.0.1]) by mail.astralcloak.net (Postfix) with ESMTPSA id B611E1FE029
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190231>

$X is appended to binary names for Windows builds (ie. git.exe).
Pollution from the environment can inadvertently trigger this behaviour,
resulting in 'git' turning into 'gitwhatever' without warning.

Signed-off-by: Michael Palimaka <kensington@astralcloak.net>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 87fb30a..b21d40c 100644
--- a/Makefile
+++ b/Makefile
@@ -460,6 +460,9 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-store.o
 
+# Binary suffix used for Windows builds
+X =
+
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
-- 
1.7.8.4

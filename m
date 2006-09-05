From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Include local config before platform tweaks
Date: Tue, 5 Sep 2006 18:00:46 -0400
Message-ID: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 00:01:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiyg-0001lw-3p
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 00:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWIEWBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWIEWBA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 18:01:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38853 "EHLO
	silverinsanity.com") by vger.kernel.org with ESMTP id S965186AbWIEWA6
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 18:00:58 -0400
Received: from [192.168.1.100] (cpe-66-66-66-120.rochester.res.rr.com [66.66.66.120])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id BF56F1FFC019
	for <git@vger.kernel.org>; Tue,  5 Sep 2006 22:00:48 +0000 (UTC)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26493>

Having config.mak included after the platform tweaks ignores NO_FINK  
or NO_DARWIN_PORTS in that file.  Simply including the config earlier  
fixes that.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
Makefile |    6 +++---
1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..81902d4 100644
--- a/Makefile
+++ b/Makefile
@@ -300,6 +300,9 @@ BUILTIN_OBJS = \
GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
LIBS = $(GITLIBS) -lz
+-include config.mak.autogen
+-include config.mak
+
#
# Platform specific tweaks
#
@@ -403,9 +406,6 @@ ifneq (,$(findstring arm,$(uname_M)))
	ARM_SHA1 = YesPlease
endif
--include config.mak.autogen
--include config.mak
-
ifdef WITH_OWN_SUBPROCESS_PY
	PYMODULES += compat/subprocess.py
else

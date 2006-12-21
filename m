From: Rocco Rutte <pdmef@gmx.net>
Subject: [PATCH] Define -D__BSD_VISIBLE for FreeBSD
Date: Thu, 21 Dec 2006 09:00:58 +0000
Message-ID: <11666916581935-git-send-email-pdmef@gmx.net>
Cc: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Thu Dec 21 10:02:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJoW-0001Km-8V
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423039AbWLUJBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423034AbWLUJBW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:01:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423032AbWLUJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:01:15 -0500
Received: (qmail invoked by alias); 21 Dec 2006 09:01:12 -0000
Received: from cable-62-117-26-66.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.66]
  by mail.gmx.net (mp050) with SMTP; 21 Dec 2006 10:01:12 +0100
X-Authenticated: #1642131
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.dyndns.org [192.168.0.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP
	id 30FA420F16; Thu, 21 Dec 2006 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by robert.daprodeges.fqdn.th-h.de (Postfix) with ESMTP
	id 3BFE033FF6; Thu, 21 Dec 2006 09:00:59 +0000 (UTC)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.2.g9474f
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35035>

FreeBSD (6-STABLE) "hides" many declarations (like fchmod(), IPPROTO_IPV6,
etc.) within '#ifdef __BSD_VISIBLE' blocks. Without this flag, compilation
will produce lots of warnings and will even fail to compile daemon.c
since IPPROTO_IPV6 isn't available without it.

>From looking at some include files of OpenBSD and NetBSD (via cvsweb)
they don't seem to need this flag.

Signed-off-by: Rocco Rutte <pdmef@gmx.net>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 7651104..46c49e0 100644
--- a/Makefile
+++ b/Makefile
@@ -366,7 +366,7 @@ ifeq ($(uname_O),Cygwin)
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_CFLAGS += -I/usr/local/include -D__BSD_VISIBLE
 	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),OpenBSD)
-- 
1.4.4.2.g9474f

From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Enable threaded delta search on *BSD and Linux.
Date: Mon, 21 Jul 2008 11:23:43 +0200
Message-ID: <1216632223-14655-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 11:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKrdP-0000q7-Rq
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 11:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbYGUJXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 05:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbYGUJXr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 05:23:47 -0400
Received: from pan.madism.org ([88.191.52.104]:57707 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703AbYGUJXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 05:23:46 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8D90E30D77;
	Mon, 21 Jul 2008 11:23:45 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 188CB4AD4; Mon, 21 Jul 2008 11:23:44 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4.571.g61acac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89327>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  Following the discussion we had 10 days ago, here is a proposal to enable
  threaded delta search on systems that are likely to behave properly wrt
  memory and CPU usage.

 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 551bde9..82f89b7 100644
--- a/Makefile
+++ b/Makefile
@@ -565,9 +565,11 @@ EXTLIBS =
 
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -665,6 +667,7 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -672,6 +675,7 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -680,6 +684,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib
 	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
-- 
1.6.0.rc0.137.g986dd

From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 2/6] Only define NEEDS_SOCKET if libsocket is usable
Date: Sun, 17 Aug 2008 10:57:19 +0200
Message-ID: <2EA0EACE-D8FE-476A-BAE2-7E12EE961C46@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 10:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe5t-0005br-Gb
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 10:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYHQI5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 04:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYHQI5V
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 04:57:21 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35207 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYHQI5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:57:20 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id DAF26EB477E9;
	Sun, 17 Aug 2008 10:57:19 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe4d-0003YQ-00; Sun, 17 Aug 2008 10:57:19 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX19BW834lNJjiCTDfR5zoA9Lokn17/PTejQTS8uA
	KLZ52QLc2kCkroWCdW2qm4r6QRV5HKCLja1txzXjPteGOPFcd4
	AXt86dJOMZTYf1DVD4rQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92584>

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
---
BeOS R5 had socket functions in libnet, Haiku has them in libnetwork,
OpenSolaris has them in libxnet. Hence checking libc is not enough.

  configure.ac |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7c2856e..75ec83a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -223,11 +223,11 @@ AC_LINK_IFELSE(ZLIBTEST_SRC,
  LIBS="$old_LIBS"
  AC_SUBST(NO_DEFLATE_BOUND)
  #
-# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
+# Define NEEDS_SOCKET if linking with libc is required (SunOS,
  # Patrick Mauritz).
-AC_CHECK_LIB([c], [socket],
-[NEEDS_SOCKET=],
-[NEEDS_SOCKET=YesPlease])
+AC_CHECK_LIB([socket], [socket],
+[NEEDS_SOCKET=YesPlease],
+[NEEDS_SOCKET=])
  AC_SUBST(NEEDS_SOCKET)
  test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"

-- 
1.6.0.rc3.32.g8aaa

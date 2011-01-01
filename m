From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2] msvc: Fix compilation error due to missing mktemp() declaration
Date: Sat, 01 Jan 2011 20:31:02 +0000
Message-ID: <4D1F8F06.9090700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, kusmabite@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 01 21:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZ88h-0002FH-PC
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 21:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab1AAUdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 15:33:16 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:53471 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115Ab1AAUdQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jan 2011 15:33:16 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PZ880-0004B0-cs; Sat, 01 Jan 2011 20:33:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164403>


Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
the compat/vcbuild/include/dirent.h compatibility header file.
This file, among other things, included the <io.h> system header
file which provides the declaration of the mktemp() function.

In order to fix the compilation error, we add an include directive
for <io.h> to the compat/mingw.h header.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Change from v1:
    - add #include to compat/mingw.h rather than compat/vcbuild/include/unistd.h

ATB,
Ramsay Jones

 compat/mingw.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index cafc1eb..1c6bc02 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,5 +1,6 @@
 #include <winsock2.h>
 #include <ws2tcpip.h>
+#include <io.h>
 
 /*
  * things that are not available in header files
-- 
1.7.3

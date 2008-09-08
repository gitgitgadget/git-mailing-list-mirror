From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Windows: git-shell can be compiled again
Date: Mon, 08 Sep 2008 12:46:55 +0200
Message-ID: <48C5029F.2010307@viscovery.net>
References: <532046.43033.qm@web95005.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kevin Yu <yujie052@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KceI2-0003Ua-JF
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 12:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYIHKrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 06:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYIHKrF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 06:47:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24356 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYIHKrE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 06:47:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KceGq-0003ll-30; Mon, 08 Sep 2008 12:47:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1D44D6B7; Mon,  8 Sep 2008 12:47:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <532046.43033.qm@web95005.mail.in2.yahoo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95236>

From: Johannes Sixt <johannes.sixt@telecom.at>

The reason that git-shell was excluded from the Windows build was that
our compatibility layer needed stuff that was removed when we tried to
link less of the git library into git-shell. Since 4cfc24afc9ff the
complete library is linked again, so we can build git-shell on Windows
as well. (This fixes 'make install', which depends on that git-shell
is always built.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
dhruva schrieb:
>  I cloned the git repo from 'git://git2.kernel.org/pub/scm/git/git.git'.
> I had an earlier msysGIT with build environment. I just got into the msys
> (bash) environment and ran a 'gmake'. It built fine on Windows XP.

This is good to know.

> A trivial issue in install:
> 'gmake install' had a small issue in trying to install non existant
> 'git-shell.exe'. The following trivial patch on master to Makefile
> handles that:

Thanks for bringing up the issue. I was a bit careless reviewing the
changes in that area. Here is a better fix.

-- Hannes

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index dfed7ba..37575f4 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,7 @@ PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
 PROGRAMS += git-receive-pack$X
 PROGRAMS += git-send-pack$X
+PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
@@ -834,7 +835,6 @@ EXTLIBS += -lz
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
 	PROGRAMS += git-imap-send$X
-	PROGRAMS += git-shell$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-- 
1.6.0.1.1208.g0bd3.dirty

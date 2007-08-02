From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: [MinGW PATCH] Fixed error 'fatal: Not a git repository' on Vista
Date: Wed, 1 Aug 2007 22:47:07 -0700
Message-ID: <DE6EEF3D318C4051827B95DF26D97BE7@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 07:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGTWo-00044I-NT
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 07:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXHBFrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 01:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXHBFrN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 01:47:13 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:21303 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbXHBFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 01:47:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so331956rvb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 22:47:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=D7Sp5nknewCmSfGHhUpBRWcDM9cat8Uf8rk6kDUrBSdDkxaWKnCn1yT5rwz2jHtRsTnbBI5Vu9k7LSgVcPsLjan/znGv+9yy475k4T/5F6nn8e7eJnvpC5qMUiF1XC0DdTV/7QAWYfWHQqVd/z0I3Bo5uVa5KuVOtQ+f9VtQG6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=VPC1ESNI8vN27KrxzKcK+WuonLlRBXxn/Wv/pQlNvfuif6DGLppcRDCPwiXwgfqOW0XmPzcICJx6uImi0vegsRi0lYGLYeIC1cfjBE7+ZPKfOj7z3002ixsmz7o850lALVwdJo336XYMKrBpuFWpwnlUaVTtJR2DWfmbKCnLGc0=
Received: by 10.140.141.15 with SMTP id o15mr535048rvd.1186033631805;
        Wed, 01 Aug 2007 22:47:11 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id b21sm2141018rvf.2007.08.01.22.47.11
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 22:47:11 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54517>

Any git command was immediately failing on Vista under MinGW with
fatal: Not a git repository

>From 51d66fbfe3a7876d9a7b699bb47c0ab186ddc7a2 Mon Sep 17 00:00:00 2001
From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
Date: Wed, 1 Aug 2007 22:30:43 -0700
Subject: [PATCH] Fixed error 'fatal: Not a git repository' on Vista
Defined __USE_MINGW_ACCESS that changes access( ..., X_OK ) into F_OK

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8e9a76b..ef40267 100644
--- a/Makefile
+++ b/Makefile
@@ -500,7 +500,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
  NO_SYMLINKS=YesPlease
  NO_SVN_TESTS=YesPlease
  NO_PERL_MAKEMAKER=YesPlease
- COMPAT_CFLAGS 
+= -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -I compat
+ COMPAT_CFLAGS 
+= -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -D__USE_MINGW_ACCESS 
 -I compat
  COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
  EXTLIBS += -lws2_32
  X = .exe
-- 
1.5.2.2

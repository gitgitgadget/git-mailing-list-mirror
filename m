From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Fixed text wrapping: [MinGW PATCH] Fixed error 'fatal: Not a git repository' on Vista
Date: Thu, 2 Aug 2007 00:46:02 -0700
Message-ID: <1A2D4E815F804E5EABD03C4A5CD455C5@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 09:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGVNx-0000uu-Dz
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 09:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXHBHqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbXHBHqH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 03:46:07 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:16725 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbXHBHqG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 03:46:06 -0400
Received: by qb-out-0506.google.com with SMTP id e11so484094qbe
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 00:46:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=OAnGYjwRGqPdOKX2xWRp0l7LVM6wvYQLQ5Q3d8Dsudfjvr6HjIUbNMA5eXPs9LBEWu4xS481ksRGoEu4mi1z42ddIXrnTYBLRT3gGf5N3oPOPgQREe4ALUah4h0wm4qDEjuYS9bR12d1XYEaXXOuTMDxAyHwSYI4VnQQR8rZNG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=Epe8vMirqeyBD1Hx4T54YyAKi9dh0MbYFaiI2Ei5ImWk1502rzfo/nhRJDnFr1MdcyDS1/iyxQmdFHDEv5xhaYdwqwTqJZHiOtBiD/M+6JN/qR80YbGB7r5hK4KkQoSzpnlBp9KEag9xl4RPj1evCEf9/IIKs+fRKXxik+lIVww=
Received: by 10.141.99.4 with SMTP id b4mr537257rvm.1186040764655;
        Thu, 02 Aug 2007 00:46:04 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id g31sm223993rvb.2007.08.02.00.46.04
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 00:46:04 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54523>

Any git command was immediately failing on Vista under MinGW with
fatal: Not a git repository
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
- COMPAT_CFLAGS += -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -I compat
+ COMPAT_CFLAGS += -DNO_ETC_PASSWD -DNO_ST_BLOCKS -DSTRIP_EXTENSION=\".exe\" -D__USE_MINGW_ACCESS -I compat
  COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
  EXTLIBS += -lws2_32
  X = .exe
-- 
1.5.2.2

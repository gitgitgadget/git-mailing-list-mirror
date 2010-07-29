From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] contrib/svn-fe: Fix IncludePath
Date: Thu, 29 Jul 2010 11:06:19 +0530
Message-ID: <1280381780-6265-3-git-send-email-artagnon@gmail.com>
References: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 07:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeLp8-0006eP-PX
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 07:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab0G2Fi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 01:38:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61688 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab0G2FiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 01:38:14 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so232148iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sRSNS2LxRdsMbLm5bn1bB8vGuHpOEpZkpBYSCYh7h+k=;
        b=DgAEVpR34z253XWhLFqlyIGXGZdvA8x4LcAwPIk1sp29ZDi0xfwhdLR1YIXxCq9Rg1
         9FRjuCDTDn//q6z9/Xv9mzsjGkvf+W9ioPfbyYK+wB33/rERGc8sv8SrNeW2bAv0Gn5w
         MpKUUgi10tReNwLGZpI+pWImNajwolvL6IPzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZRjzGxzAZ+0yo38Gle1hCRxZiE2rUdCp5wacHxqeco0d7zhxcEf1ZlyBy8EApYD6Es
         ecE03FPr6S7zcj9OXQHrZQfmWLg0FDJ5CrpS1yjDrlnkuTMaFMoffrI9kGOD/22tGHIr
         6PlMLKYjQ3ekxAUBJcrxNgwA8MQ/6sxZUZ3eA=
Received: by 10.231.174.136 with SMTP id t8mr13311366ibz.158.1280381894273;
        Wed, 28 Jul 2010 22:38:14 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id h8sm442940ibk.3.2010.07.28.22.38.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 22:38:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152161>

Include the path "../../vcs-svn" while compiling it in the Makefile
and change svn-fe.c to include svndump.h.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/svn-fe/Makefile |    2 +-
 contrib/svn-fe/svn-fe.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 4cc8d15..360d8da 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -38,7 +38,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 		$(ALL_LDFLAGS) $(LIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 43c4320..e9b9ba4 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -4,7 +4,7 @@
  */
 
 #include <stdlib.h>
-#include "vcs-svn/svndump.h"
+#include "svndump.h"
 
 int main(int argc, char **argv)
 {
-- 
1.7.1

From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 06/12] Add _MSC_VER in porting head file git-compat-util.h
Date: Wed, 19 Aug 2009 23:52:41 +0800
Message-ID: <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV5-0002JE-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZHSPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbZHSPyT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:54:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:12118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZHSPyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:54:18 -0400
Received: by wa-out-1112.google.com with SMTP id j5so801601wah.21
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3rrJ0Z3Z3HEZqRBZv0RCyuhELpt1wSgQQC+Q1aRVpzE=;
        b=R83FK6XhJdMyiAXc+A86q8f8MVtboNGwi37tLf+sjm/CU9n6FK1J3YrRAYrBGjMDSf
         NYhXQ3kvbz4dDyVoIAEAIrNHZMNQnVaP2nxe/9RdL8ppVfsIBfCiaUmW22HBQ9/jL0GK
         KtIZlUpbDeAKeAMfjV4tEVd0OCKrragzbFIzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ovl5NprKTpoZhKQXibxhogTHXKoWtWePK5CtxeFMCH7DI2KslFG0qXkoT9/6CIIFb4
         LOj5i9h0+FGLN2qVJuPCka7RZ1PgZ3ArDVmmGH+phniwD4lNuxDdyhocjK3tIHuPittc
         Oky4q4H9TniG5zXLmcIsBOS81f1N6uXYy8wYU=
Received: by 10.140.165.21 with SMTP id n21mr2482454rve.1.1250697260386;
        Wed, 19 Aug 2009 08:54:20 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id l31sm3529677rvb.54.2009.08.19.08.54.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:54:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126558>

Add Microsoft C++ compiler predefine _MSC_VER at
git-compat-util.h to include msvc.h at MSVC environment

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git-compat-util.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..cb89294 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -77,8 +77,10 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#ifndef _MSC_VER
 #include <sys/param.h>
 #include <sys/types.h>
+#endif
 #include <dirent.h>
 #include <sys/time.h>
 #include <time.h>
@@ -86,7 +88,12 @@
 #include <fnmatch.h>
 #include <assert.h>
 #include <regex.h>
+
+#ifndef _MSC_VER
 #include <utime.h>
+#endif
+
+#ifndef _MSC_VER
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
@@ -114,7 +121,10 @@
 #else 	/* __MINGW32__ */
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
-#endif	/* __MINGW32__ */
+#endif  /* __MINGW32__ */
+#else   /* _MSC_VER */
+#include "compat/msvc.h"
+#endif	/* _MSC_VER */
 
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
-- 
1.6.4.msysgit.0

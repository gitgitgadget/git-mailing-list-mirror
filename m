From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 1/5] cache: static list of repo-local env vars
Date: Wed, 24 Feb 2010 00:35:32 +0100
Message-ID: <1266968136-11129-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4IE-0001BB-CH
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab0BWXfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:35:51 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BWXft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:35:49 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so876637wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Mp9RCvbeEg2BwcDNDVhD7s60to5EGMYHMwkLzKOfnfM=;
        b=RUYuBSBshdTV4DfHxzLN5Zs8L2HIPKdDQdLjQEwU5DdVjZQaayp5T1o2vSxlmziRpc
         W+y2OyDSq7b18fGJNFs1Z/sJJK/Nhi7W5voim6vEK7CaQnkVW9YcPTgVNEt3mDMsCJNS
         sDpOCn9B8moVyOFyusfdEV1PoM5Ieji2WvlMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lXLPnB1qOhkooSzH6G1b/4TyUKPhWkuT/sconReemY6EfqepPJAYI8azKAxSHkbEhs
         pFcl7fH9K6alweavptnykteXPAg/mJuq+mNI0FDDlkIdYIZjusT51fP3oj0eiO0ZE+H6
         PviKCgliqgY4bu/DlJPwE0CbRZ4PWXj5hKb8k=
Received: by 10.216.172.203 with SMTP id t53mr1147951wel.56.1266968148602;
        Tue, 23 Feb 2010 15:35:48 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id x6sm20800950gvf.13.2010.02.23.15.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140869>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Makefile |    1 +
 cache.c  |   13 +++++++++++++
 cache.h  |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 cache.c

diff --git a/Makefile b/Makefile
index 36611f4..9e9a858 100644
--- a/Makefile
+++ b/Makefile
@@ -524,6 +524,7 @@ LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle.o
+LIB_OBJS += cache.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += color.o
 LIB_OBJS += combine-diff.o
diff --git a/cache.c b/cache.c
new file mode 100644
index 0000000..961ea56
--- /dev/null
+++ b/cache.c
@@ -0,0 +1,13 @@
+#include "cache.h"
+
+const char *const local_repo_env[] = {
+	ALTERNATE_DB_ENVIRONMENT,
+	CONFIG_ENVIRONMENT,
+	DB_ENVIRONMENT,
+	GIT_DIR_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GRAFT_ENVIRONMENT,
+	INDEX_ENVIRONMENT,
+	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	NULL
+};
diff --git a/cache.h b/cache.h
index c863085..7648a61 100644
--- a/cache.h
+++ b/cache.h
@@ -388,6 +388,8 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
+extern const char *const local_repo_env[];
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
-- 
1.7.0.200.g5ba36.dirty

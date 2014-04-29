From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 04/12] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Tue, 29 Apr 2014 13:11:58 +0400
Message-ID: <1398762726-22825-5-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf471-0006sI-JY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769AbaD2JMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:21 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45006 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaD2JMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:18 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45H-0006BN-3W; Tue, 29 Apr 2014 13:12:15 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247543>

pid_t is available in sys/types.h on both MinGW and MinGW-W64

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 1 -
 compat/msvc.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 87d58ba..7e3d038 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,7 +5,6 @@
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
 #define hstrerror strerror
diff --git a/compat/msvc.h b/compat/msvc.h
index 580bb55..a63d878 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -15,6 +15,8 @@
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
+typedef int pid_t;
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
-- 
1.9.1

From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 2/2] Support for setitimer() on platforms lacking it
Date: Fri, 24 Aug 2012 12:43:37 +0200
Message-ID: <003401cd81e5$51b6a2b0$f523e810$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4rMp-0003Do-De
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 12:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab2HXKnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 06:43:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64228 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2HXKnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 06:43:49 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MIPfz-1T585F2x95-003p61; Fri, 24 Aug 2012 12:43:46 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B5NVTxKcVwc+BRuOZmG5HFOwWNA==
Content-Language: de
X-Provags-ID: V02:K0:1YlAxSr9Yt9rUREa/CNKx24O426qThEHJg6lMi4ka4J
 2L7KCEVzz+hbIKphamG4WumwKxrWg4MunRGI/LJl9bWLKHaeCz
 Bma8wWH8dPL4V42SG0BqDoCXXdY/BOaaty60Sg4umxAE8wGSdF
 19Yqgdun9m6RIOKSHI6PX/VnIgwJPtUEHEos1vQwsZavS/q3xf
 9be38kTT4DNwli4ZI4Bemj1QdhlLOZU6cvKgDqWXCTFnj5G8Pc
 QVS5K0iveMcLNd0YYgRCCM8fZalmVu+dx9RcXhE+cwULpXMUb1
 uirJ93b3uoWuiTopmiU6F/jyuo4rKOGoN5WNGCH5jn8DgSfqsX
 Y6RC/4iaafcaShEMPhHOlXdm4ntw5s4tjRGy9rbj0ZhyTDa0xf
 yqKYmxVJlieVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204203>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
Seems it needs my mkdir() "ignoretraile slash" patch first to be applied cleanly...
It is independent of it otherwise.

 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 34f040f..a047221 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,11 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
+#ifdef NO_SETITIMER
+#define setitimer(a,b,c) git_setitimer((a),(b),(c))
+extern int git_setitimer(int, const struct itimerval *, struct itimerval *);
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-- 
1.7.12

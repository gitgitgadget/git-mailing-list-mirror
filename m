From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 01/12] MINGW: compat/mingw.h: do not attempt to redefine lseek on mingw-w64
Date: Tue, 29 Apr 2014 13:11:55 +0400
Message-ID: <1398762726-22825-2-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45R-00057r-A5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbaD2JMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:18 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44862 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaD2JMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:16 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45C-0006BN-Jm; Tue, 29 Apr 2014 13:12:10 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247533>

Unlike MinGW, MinGW-W64 has lseek already properly defined in io.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index e033e72..262b300 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -265,7 +265,9 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
 #define off_t off64_t
+#ifndef lseek
 #define lseek _lseeki64
+#endif
 
 /* use struct stat with 64 bit st_size */
 #ifdef stat
-- 
1.9.1

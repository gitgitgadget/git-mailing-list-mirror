From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine lseek on mingw-w64
Date: Mon, 28 Apr 2014 17:51:28 +0400
Message-ID: <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem10-0006sv-Fu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbaD1Nyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:54:32 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56124 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaD1Nvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:48 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyD-0004qo-Iq; Mon, 28 Apr 2014 17:51:45 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247336>

mingw-w64 has lseek defined in io.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
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

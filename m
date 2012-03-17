From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compat/win32/pthread.h: Add an pthread_key_delete() implementation
Date: Sat, 17 Mar 2012 18:24:19 +0000
Message-ID: <4F64D6D3.5090802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 19:32:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8yQJ-0001S0-5i
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 19:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab2CQScI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 14:32:08 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:53277 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757262Ab2CQScG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 14:32:06 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S8yQ5-0001Ze-ZK; Sat, 17 Mar 2012 18:32:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193342>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

I thought I had sent this several days ago, but I (obviously) forgot.

HTH.

ATB,
Ramsay Jones

 compat/win32/pthread.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 2e20548..8ad1873 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -86,6 +86,11 @@ static inline int pthread_key_create(pthread_key_t *keyp, void (*destructor)(voi
 	return (*keyp = TlsAlloc()) == TLS_OUT_OF_INDEXES ? EAGAIN : 0;
 }
 
+static inline int pthread_key_delete(pthread_key_t key)
+{
+	return TlsFree(key) ? 0 : EINVAL;
+}
+
 static inline int pthread_setspecific(pthread_key_t key, const void *value)
 {
 	return TlsSetValue(key, (void *)value) ? 0 : EINVAL;
-- 
1.7.9

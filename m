From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] compat/win32/pthread.h: Add an pthread_key_delete() implementation
Date: Sun,  6 May 2012 19:31:53 +0700
Message-ID: <1336307516-1809-1-git-send-email-pclouds@gmail.com>
References: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 14:35:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0gd-0007Vh-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2EFMff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 08:35:35 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:52189 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2EFMff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:35:35 -0400
Received: by dajt11 with SMTP id t11so171877daj.10
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kGsGDuWJsPnOetYYLMQoMst7QuV/OWHkZm+RSpcsR1Y=;
        b=cxih1vAzqlNmdnhpNZHNYwDhpqSVBIgb8NvpviqyUoWPH/2W23DJ4c/gtRXAYzXVy4
         lHslR7ZuYA5FFH6uqX/v1hK3bgoQo++nHwYmqVn13udgIY6/5PtfjZWIkDhgc5UmVVmq
         8XpmlFIi6RQdZagH9rcr1te/Uc93adguc/k/1ZYAP+n6xeT93CNY4GEsMAHbT1LrH6mC
         wCuRc02AA4lkaq0Tjs7LKrTNYGmyr+2nQXJ1VFGm0Bk/zGk7JCsPh5AFKO7LaSs6kHeG
         NC3cqsVRkeQA03stT0fAqbyT7QPxzE5lz1jY3ff0Bs8jFes/CLSWvWam4W/2iBj/R0ir
         DdwQ==
Received: by 10.68.232.3 with SMTP id tk3mr7767537pbc.33.1336307734699;
        Sun, 06 May 2012 05:35:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id nd6sm4808398pbc.63.2012.05.06.05.35.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 05:35:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 19:31:57 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197174>

=46rom: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/win32/pthread.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 2e20548..8ad1873 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -86,6 +86,11 @@ static inline int pthread_key_create(pthread_key_t *=
keyp, void (*destructor)(voi
 	return (*keyp =3D TlsAlloc()) =3D=3D TLS_OUT_OF_INDEXES ? EAGAIN : 0;
 }
=20
+static inline int pthread_key_delete(pthread_key_t key)
+{
+	return TlsFree(key) ? 0 : EINVAL;
+}
+
 static inline int pthread_setspecific(pthread_key_t key, const void *v=
alue)
 {
 	return TlsSetValue(key, (void *)value) ? 0 : EINVAL;
--=20
1.7.8.36.g69ee2

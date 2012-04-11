From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/3] compat/win32/pthread.h: Add an pthread_key_delete() implementation
Date: Wed, 11 Apr 2012 12:49:46 +0700
Message-ID: <1334123388-6083-2-git-send-email-pclouds@gmail.com>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqSF-0003uh-WC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 07:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab2DKFuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 01:50:51 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35976 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2DKFuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 01:50:50 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so706932dak.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QK3yE+L9/b8N6HhD8EsnXmFcxvBrcFdHADn2HySvjlk=;
        b=YoR0hbfORdoW1X8033fYzPuFrF9oqv7GME5vdfGNOeGQ3UNxHYfMCQKRazNdyekY6D
         X739A9F4L6GNnEn8uMqtF4sUQDwPq3VcM01syOGOXa9FVOWLFcYmdn8aXGYgJPIzE4Em
         9Hruel+6mfSlW2x/TzcwKkZcfPz7mlC2UrfTOXbRZ61WgqU/FPDf8s07Q+AptA2BAf1a
         blx5uX1hGtiiYFCUHV/3bco5HRl7OEvTZevZoAUSCXByQ5E73vgqxPR6VE2XdPkYijg5
         ecFu/aQUg/u44IkPcvOFOYotksLTlpVDrdbepaDlSyCAFGW791WmeCNtgZt175xRgQzC
         u20w==
Received: by 10.68.221.227 with SMTP id qh3mr34968869pbc.43.1334123450253;
        Tue, 10 Apr 2012 22:50:50 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oe2sm1930744pbb.37.2012.04.10.22.50.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 22:50:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Apr 2012 12:50:04 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195147>

=46rom: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.3.1.256.g2539c.dirty

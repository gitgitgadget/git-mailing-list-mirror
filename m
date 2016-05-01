From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/41] compat/win32/syslog.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:33 +0700
Message-ID: <1462101297-8610-18-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMu-0007Lv-1U
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbcEALQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33879 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so16225623pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lWlCAZ9GIrU4iWHqOzK3DfvdeTTToKusroD/KBM01k=;
        b=pphFa4c8vPHi51LcR6J2+duVFp9ei9XaLADHLzs7U+CbloHxSKL/TQXfGcLWFzHO7+
         ul+m6YA8MMhorQ5KbM01P2ehWzvia7RZR0rbwz5uJxlS5RCX0jVfboTKGyLSP/ozBX0C
         9/tPGWZrNPMZurpS/zDGgoAkta3laGaR51c8AF0Uh6zBruzalr++Qv4doJIwbdW9iKdY
         iiB3mRgY6QgC5lj/FjOslVt0njG+b1KaLSDEYNZHp8gqnPuBbDGohZduZBATKaSeU2S+
         guslT33lxd9yEBoHxbp9VOkrSqUa8MCpnfozx0n9axUS15KDUmwayIddUKp7b7zAeL4C
         AzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lWlCAZ9GIrU4iWHqOzK3DfvdeTTToKusroD/KBM01k=;
        b=Y8BWpFZsm4mYhJQKwpahlYunwKc0cfgVj/AF20hh2o36xB6grKS3nS8jLJ+emX8zhD
         tNrT7dJFF1BnyGzlNuzu59RtisJLHUHjq5h5DMELiu/xqpTz2E3d8K8UPV9kuMHqXI6v
         oqH1JCHsHQRaLGCf0i5R59laWuc6H1t0LOwCbDXu1RUXcYfDufH2iVn9bh7LnEzPA9pY
         hw50TFgMcbfZ4YA0NbUhtEU3JqwlxeJhPOKCUUw2lnrF4mg/fceJgt3MQsMmXmI964Q2
         Cpk1eACyrhp0LQW8Y4fm5GxUtG09HNBU6oS314r2qIXY+sFgg9H2xzDChnOWefCQ8+rX
         ryVg==
X-Gm-Message-State: AOPr4FUWNSMiF/Po4mkymijz68IT8yYluNo8WdqS0RixVZMTpus91wNz/y6+tbjklhe7dg==
X-Received: by 10.98.36.87 with SMTP id r84mr43443900pfj.5.1462101406186;
        Sun, 01 May 2016 04:16:46 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id xd14sm44191592pac.6.2016.05.01.04.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293167>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/win32/syslog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index b905aea..1c2ae18 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -28,13 +28,13 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
=20
 	if (str_len < 0) {
-		warning("vsnprintf failed: '%s'", strerror(errno));
+		warning_errno("vsnprintf failed:");
 		return;
 	}
=20
 	str =3D malloc(st_add(str_len, 1));
 	if (!str) {
-		warning("malloc failed: '%s'", strerror(errno));
+		warning_errno("malloc failed");
 		return;
 	}
=20
@@ -45,7 +45,7 @@ void syslog(int priority, const char *fmt, ...)
 	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
 		str =3D realloc(str, st_add(++str_len, 1));
 		if (!str) {
-			warning("realloc failed: '%s'", strerror(errno));
+			warning_errno("realloc failed");
 			return;
 		}
 		memmove(pos + 2, pos + 1, strlen(pos));
--=20
2.8.0.rc0.210.gd302cd2

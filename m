From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 41/41] wrapper.c: use warning_errno()
Date: Sun,  8 May 2016 16:48:01 +0700
Message-ID: <1462700881-25108-42-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:52:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLOL-0003gh-4s
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbcEHJwp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34525 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcEHJwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so13763671pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=m4Yf+cprksIfUAMCjTZqkVitlYHV5+b8VW6HC/WDjrgxoULg+mwnB2FTz8kmO7WmQW
         CDGUgt58b8OKbBFxfSlNQLotoYjC7B8DDGpzoDSuEe1t39FmNfYQwO1N15QnH/Uin6pU
         145nQc9R9EoQg1V+sVCdpkRbOm/Ocpz3MIRk49gBzLt0bEhuaUAni2WM1dVnJ8AZjS6U
         tlsTsmKhMZorek76aoKACrw6W+5lI2AGS6QOjROmj3y6c1gU/iMc9wxWtlkgJ4fDKQkP
         3W3peJgrfZ6GOl8NtDSFcuVT/4sehbI5tN48ygNzNyTJRUju9l3EbQlnbOJZF1eAdzs9
         iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=OsfdfdjDH7Dac6ESbkg+HpikjV6feLPeA0Q9i/uN0AqWRILvPF3QAFc7EH2tmayWPm
         0oHQzHLPB3PSldFf+jELHl1ghtf/97674BWul7GdsEBXl90AH4F2xlT7xmTrR7Lu10dU
         +7LafZM1fxPdMqKfplZb+r4fKNB9AZoMYKHpW82mcXwgJQPYEHTGkLnv11sWhmYwqvZd
         Z9wLZGhSeXeImMtYxB98ytnvfN53N0b0keXOlrnfAqioz5268n7EyJWVY+7jbeNzpZFn
         Z028Jdk66rqnGnTFIhXJjZJo5VaOKLweMTiM1gDWQpICTsmYfJGd5t1H4UW2sKPzXqa9
         WoKQ==
X-Gm-Message-State: AOPr4FUytFnpKq9g/9p4pt5BVkGoo7G/OZkHG5EL85NNINc4/h2kR10MEmL07z5ugcPqcg==
X-Received: by 10.98.53.65 with SMTP id c62mr10756058pfa.47.1462701164410;
        Sun, 08 May 2016 02:52:44 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 133sm32766111pfw.35.2016.05.08.02.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:44 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293944>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 9afc1a0..3df2fe0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -572,7 +572,7 @@ static int warn_if_unremovable(const char *op, cons=
t char *file, int rc)
 	if (!rc || errno =3D=3D ENOENT)
 		return 0;
 	err =3D errno;
-	warning("unable to %s %s: %s", op, file, strerror(errno));
+	warning_errno("unable to %s %s", op, file);
 	errno =3D err;
 	return rc;
 }
@@ -608,7 +608,7 @@ int remove_or_warn(unsigned int mode, const char *f=
ile)
=20
 void warn_on_inaccessible(const char *path)
 {
-	warning(_("unable to access '%s': %s"), path, strerror(errno));
+	warning_errno(_("unable to access '%s'"), path);
 }
=20
 static int access_error_is_ok(int err, unsigned flag)
--=20
2.8.0.rc0.210.gd302cd2

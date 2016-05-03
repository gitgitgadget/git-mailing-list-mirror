From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 41/41] wrapper.c: use warning_errno()
Date: Tue,  3 May 2016 19:04:14 +0700
Message-ID: <1462277054-5943-42-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:10:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9u-0001ci-IM
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933220AbcECMKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:10:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33495 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:10:27 -0400
Received: by mail-pa0-f45.google.com with SMTP id xk12so9009793pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=uCKgOtKW8eXRJuwSevrkVhIK8fRfNdPpnCKO/ZXCg1XsKt5zjD8AjsvRXP9AEh6pTR
         0AKqMywUTvc+zSitjfVCKZdISohyYZV3vLy/nmxgMs/3Ndw6t69fTtHSNzKPz27pxhFZ
         zhd+VCUZu7s7DAlP+Hz7+wPc2nEwR4VA+6/uRcZ5g16zsJPq/fFqW2UlVDbUylSgADhl
         VDzVtKRxmWs8I++/O5GlaoLx6QYlu24+66YR3oaUb56VcXlNZxbaZKLNFP5vtGCa7u1v
         cxnjTMnCuTVYK79hcuBd20k8pkVsXZXCfvYOINgAhsAcAVjCH69RvinKh+PpOXkxWisS
         5e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=Oju3jU2vbrtIEAzujWKd92NaYCZMyOSDuaZYtR/CY/f13lXq7rE6iGZ3ZzOoNFJRWb
         apQ2pf55VEcBqpv9sHVyAiRP+omvVoCaiJNkj/7d7PP0NLueSWJsDiAS6ogt6mfBR5hn
         vqsu3rNGDlRnOi/HKQBERO2fruqotU61NjXXkkoNoxddSKHpeCQf2wbm3q+K4MsWr6c8
         29VnPgz5jh6rHn07WHxI4qHJ9v+eqfAr4d7l9xY2ivqb8mRayIvZ6PMbn837L8LSIQaP
         7x6sS4OeqNMVpou2n3MmpIR5GRauWfG1AQUY+OMGi8B5bYm9L3iAfC07z39eHMCtvlrL
         btJw==
X-Gm-Message-State: AOPr4FURXa37znUxxFpvg4g+UGeMta5k7Glg75AhBDHINRtmcvazwm2gngJTNZn/7zuUTQ==
X-Received: by 10.66.145.35 with SMTP id sr3mr2923574pab.82.1462277426811;
        Tue, 03 May 2016 05:10:26 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id d6sm5500328pfj.75.2016.05.03.05.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:10:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:10:22 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293394>

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

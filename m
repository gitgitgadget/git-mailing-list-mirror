From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] apply: report patch skipping in verbose mode
Date: Thu, 24 Mar 2016 18:56:19 +0700
Message-ID: <1458820579-31621-5-git-send-email-pclouds@gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	mehul.jain2029@gmail.com, sandals@crustytoothpaste.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:57:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj3tk-0001R2-Eo
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbcCXL5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 07:57:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34915 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbcCXL5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 07:57:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id td3so19907174pab.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsrI/atS8WNoZTs7bY/xNHFI7qLogV2iYBZJUaS+Vlg=;
        b=eXCy+zpXtlW8wrLrOKi3pZn1i+VZxPFRoQM9hT/WagMPqM95/8eKiEDqDGrP01c/qN
         u4UA/rRJK/RMLRTSgCRk92hc7TzinoTsYtvThqTlqqaDSTK+mTJEPZNnGB+naKSX0SAD
         FpX+S7c+0ZlRGML9kgVk4L0TnSabE130GP9vDTaac3NRcHbSJaxhGQVKFcUSy7bLWTkD
         uLrCYAl3ExiLbY0RCyvLUU9GKCUvRJ9pTGcFc4WdDVH+SbQbM1t2A5lmFEqP0ZtcDDTM
         K9ga3q4coBlxUNOHdUzvg2ZzvifNaBChNWwEoHDb439/lTwwlayug5WI2d4K929XRkRS
         Enzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsrI/atS8WNoZTs7bY/xNHFI7qLogV2iYBZJUaS+Vlg=;
        b=AO8H35URpX9ZOXI9GE5iPaVaNXRLD25Iv3MzWMgjqxOECTfKboWidUcCd7ZfM5ncr2
         ikryPOo0pUn+RG+OHls2C4iuhlkgLuXNPKXntUWPylk4ife7txUa2OMbtJGr42xgmhqt
         L93MKItEnYQ0uErF0w+8AtnbHRLzjfpx/u55UJRSDbr3Ta50uSk9bqvz42F7msQ5A9IR
         RWOE34iro3MjVWZ7SXnOSsCSMws6pqUspUA/5EXMc6xi69dvtB/B1ECBg0pYb30DN1Jp
         GSR3df0P3tQT3u1CFbJyeabeveK98uy8GxCMLiDlkm5REqqgWKHzAN1GpKPFFzIFwqBw
         6O3A==
X-Gm-Message-State: AD7BkJIS5w91cQg7T6R4VQb1FK342ZCzJuQmdh21NORCcIdcwlNXqEUZorHw4MEW422fLQ==
X-Received: by 10.66.248.168 with SMTP id yn8mr12064953pac.24.1458820658758;
        Thu, 24 Mar 2016 04:57:38 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id f12sm9968747pfd.87.2016.03.24.04.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 04:57:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:57:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289741>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 01e1d5e..9cbb186 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4384,6 +4384,8 @@ static int apply_patch(int fd, const char *filena=
me, int options)
 			listp =3D &patch->next;
 		}
 		else {
+			if (apply_verbosely)
+				say_patch_name(stderr, _("Skipped patch '%s'."), patch);
 			free_patch(patch);
 			skipped_patch++;
 		}
--=20
2.8.0.rc0.210.gd302cd2

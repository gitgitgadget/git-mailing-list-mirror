From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/41] builtin/upload-archive.c: use error_errno()
Date: Tue,  3 May 2016 19:03:46 +0700
Message-ID: <1462277054-5943-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7M-0000Cn-7M
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbcECMHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:40 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34578 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbcECMHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id r5so9218852pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=H9Jm9Sjpa1lSOs0aRgGKpI52vYxWL7FzkXnMVNS8tzKVUZ0i6bURV+wIInBiwXSiHg
         Z1Q6CJzsrR5UxLbtHh/JevP2HUeoGbM+mEKtHqCdjgsufzz8YlcDn3Xr8Hro3XTnl/PZ
         KqNsKTxtMABgY+MmtcCfXGVXaSJkqWipxWiGXL1N+9N0+KfNhhTwuo1iCk3m8rCOa0mw
         piPEWf+pIvZ+EITN9dnrrX3ShX4Z8+H9VkFy2i4h7Lh0c1rAqZjCxKeRAb3YpEFXMzlv
         mV9v42iUkGoO4Hk0IO25nDQm4KfAstgeDfyldA1RdbD81t6ycBsongS+pNl2UsUDLRf/
         1JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=cT+2uS0HeaSOdsXcluEK9araJ5onQwodC9duuhNoKQBDXyaMGvpS5SAhGZrxDMxYiz
         uukZiW4wuYSVY5Txzj+fsqyWUfoO6QDhUZDe1btmLjw9IwUGgBmx71gHav6/lLiNmP8r
         LdCkhukC26K6TuPR1xdhXfHL5zj7rOPadICw+nJGX+u855BAVALuSrGWi7OTD+ldokiu
         FdM6lRfdhPBI5ZpVib53pEb2jU8wLo6kQAhXQa5LJADbjVBcwfIW4zBSpPkqsV9mxOkW
         YIe7nxRxZWyXokYrzwj5WyzEAcIxJcrmonvLtCExyNgXjJEYIja0rE4Dine4DOIf3fFF
         BQ1g==
X-Gm-Message-State: AOPr4FWejw62szuJtbJxm9jmVHHypEhlpcOoljLmrURT6NN/owR1UUerXojglrvEj2ZMmQ==
X-Received: by 10.66.66.10 with SMTP id b10mr2963821pat.12.1462277252986;
        Tue, 03 May 2016 05:07:32 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 76sm5505879pfz.44.2016.05.03.05.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:28 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293365>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/upload-archive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dbfe14f..2caedf1 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -104,8 +104,7 @@ int cmd_upload_archive(int argc, const char **argv,=
 const char *prefix)
 		pfd[1].events =3D POLLIN;
 		if (poll(pfd, 2, -1) < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2

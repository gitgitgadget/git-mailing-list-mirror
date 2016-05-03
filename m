From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/41] copy.c: use error_errno()
Date: Tue,  3 May 2016 19:03:53 +0700
Message-ID: <1462277054-5943-21-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7y-0000dk-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbcECMIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:18 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34921 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbcECMIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:17 -0400
Received: by mail-pf0-f178.google.com with SMTP id 77so9232819pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=vbWGf5Sgu6kBCFJD2iq1KyMEe2h+NgHhp0IYeoZieskliDp4kntj8N59EA25v8iYA8
         ZV0MlRJ7BU7Q1UgllUBn7y6mbIvKkNNp9bXidEdi4KlyABLU3tGt9nyQfxzqLAuh5sgG
         GbcBZUvJp6AbEXNLtAw5eCxX20mgeyBgmxoEfRctHyNS93jjO3pPERmU7Bgon/6p2Ugs
         EDzJauSyRv+9mHKhff2wgOqO0zMbLDj2qN7pkiGgCzwS69JYFylATVRmivZo8XNtaerk
         CgTWo/0JXj1qugfIAUBIQw1KO0rieioYXOYrqqyTlf+7cwY14iNVcsBNOrQ/NXqEh49E
         ie6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=GrJlAg6Oc4/vjjzpqaMJtnVHNUxx3fAy5cOp6yqEEEgZ0E5N/iFNT/s18QrS5+0Jz0
         0UqUV/cK/0+jzmB/UF+4gXzrLBh7n17fw1jsgDD90EOsyKADJtTzySPJOvhevTtD6x6F
         T/vBnWFxj0uYNSsfO6Zr2lvUcnJfCWGu3uiwM020PePm0UR/2XbgVFtp30u8P09Mtz5G
         7Z+1d1QEwMRra7UAeMeGdgT6MMHMFCm9rEp5kDqw9rrlCtFmia68T4zpqqWx4Y7/qYCI
         phxR03W+TMXs5Hr8U4dCFdt63gDa1tsiNjTkxQi5O+Uie+Gi2gnRhIhn5NyLaXP9L5cj
         ZEfQ==
X-Gm-Message-State: AOPr4FV1OM8KgnYBIJXXVepP/tT6+yUoT3XDHOwkHiPRfaRcb9gwyKBG6OrcNlG0okFMlA==
X-Received: by 10.98.102.20 with SMTP id a20mr2885888pfc.137.1462277296004;
        Tue, 03 May 2016 05:08:16 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id p189sm5508689pfb.51.2016.05.03.05.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:11 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293372>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/copy.c b/copy.c
index 574fa1f..4de6a11 100644
--- a/copy.c
+++ b/copy.c
@@ -42,15 +42,15 @@ int copy_file(const char *dst, const char *src, int=
 mode)
 	status =3D copy_fd(fdi, fdo);
 	switch (status) {
 	case COPY_READ_ERROR:
-		error("copy-fd: read returned %s", strerror(errno));
+		error_errno("copy-fd: read returned");
 		break;
 	case COPY_WRITE_ERROR:
-		error("copy-fd: write returned %s", strerror(errno));
+		error_errno("copy-fd: write returned");
 		break;
 	}
 	close(fdi);
 	if (close(fdo) !=3D 0)
-		return error("%s: close error: %s", dst, strerror(errno));
+		return error_errno("%s: close error", dst);
=20
 	if (!status && adjust_shared_perm(dst))
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2

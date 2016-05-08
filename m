From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/41] combine-diff.c: use error_errno()
Date: Sun,  8 May 2016 16:47:36 +0700
Message-ID: <1462700881-25108-17-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLx-0000y9-KT
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbcEHJuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34053 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbcEHJuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so13760598pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=lrBkrc5n/ZD1WT8FzBVJwRkdQ1KmkiuIbeJkwcXHrO5neFX0FphuqcKVnnAdZZF+uj
         MSDcQM/ws7RUhPV6KhR/+y7feeg1UDDeOsk6wSxK3FF8DXzUamEILsbukoAC1w5ygY3Z
         FtuVGl0LMO/HnvRi3sigaSpmwojmen/5rb+huNUOdTBL2u3GgTzWsIYG+SaebHJqkS3A
         SQnjKdEW4NRwlNrNQZH2CZ5B/LS3xKEf++cGxCBcURMyY8G3DO2sn7uvayD0E6wvL3P4
         Y2x79/xWK3daab2Pub70PHix37bAiNFTck3M6KrE+d7Zcyw82Wo5jcryQLZ443jjeJML
         O+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=LdDP3LsIW7iBuQKBO5jM2mg8xBzR3YPA8Vpz01W5v4kAhs26P3yR1ub/tLKyZuRo5a
         gTfivQH5jyMXTdg4vh1QPiXfPctP5EHAKrWBCnvK+b3QxikQ5EAhqrUI7GhPeucvXBaF
         nFzwEI6oNwJvP5tM7I5XfAkZ+5yOrXNvHIFMpWkG3PRKaQK6urwiYoZllsnzkUuEQ4dK
         MJXFcDTDizY9uiig0Fu4bikVEQWODxlpamodnzytdX2qGDP68BRKRWL7Gz9J3jOIQfb4
         ixBX2tHTqyLRe2y6TyuLJIFoTqZIGfqDRK+cIcHMCuZQW/Z/JOouwNo8Fv4frTMOntrA
         9Cyg==
X-Gm-Message-State: AOPr4FWPuJtFHoi5DXFU1lHtQvTpFfx8zTONQUmLG3uZLrXxHEMARt9/JPMvPz2FoyRpGg==
X-Received: by 10.98.65.90 with SMTP id o87mr41450641pfa.151.1462701007910;
        Sun, 08 May 2016 02:50:07 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id s124sm32733950pfb.63.2016.05.08.02.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:08 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293926>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 combine-diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..8f2313d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1005,8 +1005,7 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			struct strbuf buf =3D STRBUF_INIT;
=20
 			if (strbuf_readlink(&buf, elem->path, st.st_size) < 0) {
-				error("readlink(%s): %s", elem->path,
-				      strerror(errno));
+				error_errno("readlink(%s)", elem->path);
 				return;
 			}
 			result_size =3D buf.len;
--=20
2.8.0.rc0.210.gd302cd2

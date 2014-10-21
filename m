From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] dir.c: remove the second declaration of "stk" in prep_exclude()
Date: Tue, 21 Oct 2014 18:38:06 +0700
Message-ID: <1413891486-24573-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 13:38:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgXlY-0007tW-6H
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 13:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbaJULiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2014 07:38:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42695 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbaJULiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 07:38:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so1167975pdj.23
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6tbPRhZdB2vQnIURjY0+dbAWH9qR+VQ21Lpr1dkNgV8=;
        b=HeJOZFawAbq+Yr0tWreROzHtFm9gWUOwidriV9hvaJKel+Fogln8IJjZfvWWbEEVCU
         scgNFr1YHEKvres0sHeG+3nWhJ0ZoRKrEnpQXD6qt3RH0vLLJfKvAs0/Beuz9OAX9ArG
         FIPaPapLduR2p1XexIrfDwlHKsfwX0YcMucNzzWLYztaoVqdIsm9ZIo2ciRCt5oiSR77
         ACL9ryjrA+GvZVp/TWkKllSBs0QWK2ZCQ+zm1bjACE2uEJPm4gWZi570e5Q1sXTx180D
         Zsyh/3KgV/XGjg+JtkgvKvwLfPKaZ+z8u8cRRkq2IisMCLY8Cj8+V6WN9aM2lKHU9Gcz
         8low==
X-Received: by 10.70.100.138 with SMTP id ey10mr34986160pdb.38.1413891490939;
        Tue, 21 Oct 2014 04:38:10 -0700 (PDT)
Received: from lanh ([115.73.253.46])
        by mx.google.com with ESMTPSA id z4sm11743073pda.23.2014.10.21.04.38.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 04:38:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 21 Oct 2014 18:38:07 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "stk" shadows the first declaration at the top. There's currently
no bad effect. But let's avoid it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index bd274a7..3f7a025 100644
--- a/dir.c
+++ b/dir.c
@@ -826,9 +826,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 	current =3D stk ? stk->baselen : -1;
 	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
 	while (current < baselen) {
-		struct exclude_stack *stk =3D xcalloc(1, sizeof(*stk));
 		const char *cp;
=20
+		stk =3D xcalloc(1, sizeof(*stk));
 		if (current < 0) {
 			cp =3D base;
 			current =3D 0;
--=20
2.1.0.rc0.78.gc0d8480

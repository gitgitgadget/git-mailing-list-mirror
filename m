From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] attr.c: rename arg name attr_nr to avoid shadowing the global one
Date: Sun, 28 Dec 2014 06:39:46 +0700
Message-ID: <1419723588-13236-2-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
 <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 00:29:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y50nS-00027O-HA
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 00:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbaL0X3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2014 18:29:16 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38121 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaL0X3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 18:29:14 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so14947141pde.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c9EI5hFdHapzvTLzEub4XCiUJkyN8d2lwY1brtQUINs=;
        b=pbhoKQcVz9DetznUUPQHfySFluzu+qALsfZ4dTaTCgSKjUux601GnHe17q4luXX/iU
         Y7cXG/Risq81lNlg74jfhqWzYncwo9lHu4SEM4m0faNCf2jgucO0vKuOGqQq2uHnw+Wd
         GcYvCDFO8ytN6nl/r3+fRI/Xn1mJl7Dk2x+HSgdymkf5EZTN+fNhILuLex+bkqhDMG/9
         Y3dDHsIh7ZFoAQoH5+7p0Q87pqFdBt58L/En+8F7EKKlU+D3x/o9e33e/AafCGoZJEZ1
         jBzbjVSsCOWOwGYKwbXpoxPpq60Xmi3gobENCP138NpnbnF70NFmRmR91oHB7gpUna8z
         ggAw==
X-Received: by 10.68.235.5 with SMTP id ui5mr77945429pbc.152.1419722953664;
        Sat, 27 Dec 2014 15:29:13 -0800 (PST)
Received: from lanh ([115.73.209.146])
        by mx.google.com with ESMTPSA id v8sm31639149pdp.94.2014.12.27.15.29.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 15:29:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Dec 2014 06:40:07 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1419723588-13236-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261843>

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index cd54697..a1758bf 100644
--- a/attr.c
+++ b/attr.c
@@ -681,13 +681,13 @@ static int fill(const char *path, int pathlen, in=
t basename_offset,
 	return rem;
 }
=20
-static int macroexpand_one(int attr_nr, int rem)
+static int macroexpand_one(int nr, int rem)
 {
 	struct attr_stack *stk;
 	struct match_attr *a =3D NULL;
 	int i;
=20
-	if (check_all_attr[attr_nr].value !=3D ATTR__TRUE)
+	if (check_all_attr[nr].value !=3D ATTR__TRUE)
 		return rem;
=20
 	for (stk =3D attr_stack; !a && stk; stk =3D stk->prev)
@@ -695,7 +695,7 @@ static int macroexpand_one(int attr_nr, int rem)
 			struct match_attr *ma =3D stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
-			if (ma->u.attr->attr_nr =3D=3D attr_nr)
+			if (ma->u.attr->attr_nr =3D=3D nr)
 				a =3D ma;
 		}
=20
--=20
2.2.0.84.ge9c7a8a

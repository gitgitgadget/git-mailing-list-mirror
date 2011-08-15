From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] diffcore-pickaxe: terminate grepping as soon as it hits
Date: Mon, 15 Aug 2011 09:41:23 +0700
Message-ID: <1313376083-24713-2-git-send-email-pclouds@gmail.com>
References: <1313376083-24713-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 04:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsn8I-0004c8-MH
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 04:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735Ab1HOCls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 22:41:48 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52696 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1HOClr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 22:41:47 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so6548537iye.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/p6+CrqfsAWzMxbeK3GH6w+CeW63zx8gpFRByRZlr5M=;
        b=TO8XC8I3JfUDegIAtw6iq7pBrSZEng0WHydrxyiZp7X1t7UIiAWsr+73mFVyulf/O8
         59VzZsduO2HtzXx7WK1eC8HoYLcniCcXmwt/pZ+JKA9uHde2q0Ec+BjweYAu+yGZG7gp
         RZQCqM++eSjbF/A7j444ZgO59kDbcj+33KQkY=
Received: by 10.42.161.1 with SMTP id r1mr3749150icx.448.1313376107472;
        Sun, 14 Aug 2011 19:41:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.208.228])
        by mx.google.com with ESMTPS id g21sm3493303ibl.58.2011.08.14.19.41.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 19:41:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Aug 2011 09:41:41 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313376083-24713-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179357>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 12811b9..e028dd5 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -21,11 +21,7 @@ static int diffgrep_consume(void *priv, char *line, =
unsigned long len)
 	if (line[0] !=3D '+' && line[0] !=3D '-')
 		return 0;
 	if (data->hit)
-		/*
-		 * NEEDSWORK: we should have a way to terminate the
-		 * caller early.
-		 */
-		return 0;
+		return -1;
 	/* Yuck -- line ought to be "const char *"! */
 	hold =3D line[len];
 	line[len] =3D '\0';
--=20
1.7.4.74.g639db

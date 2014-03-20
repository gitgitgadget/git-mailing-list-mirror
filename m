From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] ls_colors.c: enable coloring on u+x files
Date: Thu, 20 Mar 2014 17:15:46 +0700
Message-ID: <1395310551-23201-4-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa17-0000ws-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbaCTKQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:00 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48408 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbaCTKP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:15:58 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so734861pab.11
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LW63QmwIS0hx2D3zOKCMgyDI/IWn5VvL2babvxuQNMg=;
        b=WOmL+4JkoCaHxLwUl07mFO1Z9LC9ysQ/A5m+hBSD5n6mZk3NcY2tB9GpQh2M6SXPUq
         dkIqEABC1OLLbVxgIeE4tVS97oFhCjIS9nD8QmUmV8uZs9N10GAtSq6KwenLrqIUGlDf
         Iwt9SgNa93v1oPvZSf0Id1hGBFCsclJ7CTJ939JYNDuEtJM8HSvBDATht3VGBcMbMlVX
         nEeJmyX/mW+V4twghwG2aB7LeDv/gFqYPuupur2AdXEoya333Ojnt+KgoSIGLitWf+Q/
         UZtulO4X+sx668E3fvasw1lAxoYiCIj7SW/2lnTeFI8CZtoYKVlaw4S1ZXm4pGgaGNZ+
         3FSQ==
X-Received: by 10.68.198.36 with SMTP id iz4mr44736239pbc.109.1395310556607;
        Thu, 20 Mar 2014 03:15:56 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id ci4sm2955935pbb.50.2014.03.20.03.15.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:15:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:16:43 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244533>

git-compat-util.h does not seem to carry S_IXUGO. Anyway as far as Git
is concerned, we only care one executable bit. Hard code it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ls_colors.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ls_colors.c b/ls_colors.c
index d492ab3..23f1e0b 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -427,10 +427,8 @@ void print_color_indicator(const char *name, mode_=
t mode, int linkok,
 				type =3D C_SETUID;
 			else if ((mode & S_ISGID) !=3D 0)
 				type =3D C_SETGID;
-#if 0
-			else if ((mode & S_IXUGO) !=3D 0)
+			else if ((mode & 0100) !=3D 0)
 				type =3D C_EXEC;
-#endif
 		} else if (S_ISDIR(mode)) {
 			if ((mode & S_ISVTX) && (mode & S_IWOTH))
 				type =3D C_STICKY_OTHER_WRITABLE;
--=20
1.9.0.40.gaa8c3ea

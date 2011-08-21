From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Do not accept NUL in the path in .git file
Date: Sun, 21 Aug 2011 18:58:10 +0700
Message-ID: <1313927890-21227-2-git-send-email-pclouds@gmail.com>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 13:59:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv6gG-0004rD-BU
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 13:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab1HUL7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 07:59:04 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39564 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab1HUL7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 07:59:02 -0400
Received: by pzk37 with SMTP id 37so7255566pzk.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sQppTBV/XYd+dTDmW6H0I0eUeM8lyK0GQykjnSiKK7o=;
        b=ASsA/x+WF78nkrp7HwTJhzwFzgSd5B9EhDhlehsmiyl90AmJM/Bf1tMNcUFbBHyP3H
         dGRGRXDnMxUG0My5SBiRduttDLJdrKdofPGGtZg8wdDh/MrPqTxKKvv1tCxOXeeBYBmv
         bcYTxAGlq5oGI51hL7mkun85UOb8NHRx4cuAo=
Received: by 10.142.224.1 with SMTP id w1mr969318wfg.326.1313927942530;
        Sun, 21 Aug 2011 04:59:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id v2sm3636958pbi.19.2011.08.21.04.58.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 04:59:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Aug 2011 18:58:56 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179803>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 2c51a9a..c1995b7 100644
--- a/setup.c
+++ b/setup.c
@@ -436,6 +436,8 @@ const char *read_gitfile_gently(const char *path)
 	if (len < 9)
 		die("No path in gitfile: %s", path);
 	buf[len] =3D '\0';
+	if (strlen(buf) < len)
+		die("invalid gitfile format: %s", path);
 	dir =3D buf + 8;
=20
 	if (!is_absolute_path(dir) && (slash =3D strrchr(path, '/'))) {
--=20
1.7.4.74.g639db

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/24] untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
Date: Sun,  8 Mar 2015 17:12:40 +0700
Message-ID: <1425809567-25518-18-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYET-0003zi-93
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbCHKOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40661 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbCHKOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:44 -0400
Received: by padfb1 with SMTP id fb1so55495483pad.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4tgjf4B4yoefHX7T0TNtz/VwViqCLLqAML7d/csHa0o=;
        b=dC0ddsglSVTE0LUnNkhLTiOQ89YNRl4HPk/hecZtlo2B5NokEk7sxZdY/uLmubMtCG
         gApfoL7loAmHSY/XYDlE4iB2GQo+TrktRC5m8qgKE6Gzq9rP5ip5CHwxNtdJ08TCYgAG
         dTYY8I4Oy6uim1qUx9Pc5LUclF5bK6N9FcozXJaWS2TDIDNv1DJbrm8xvwzE6uUx4qsH
         oM1hn8HtTUTnmQ1pqvCNK+YWCloe27ihfSSJvn5fdwdwoVxpwFSgWcY0amUE837nAjP+
         gujT0VGymERRQg5RaM2ihUQ/0F4V6nOkDhF/XRSDp/J9p2lzuGU5EQbpSMypKROCE8rr
         cj8Q==
X-Received: by 10.68.204.39 with SMTP id kv7mr41607188pbc.49.1425809684330;
        Sun, 08 Mar 2015 03:14:44 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id vf6sm14415622pbc.18.2015.03.08.03.14.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265070>

This can be used to double check if results with untracked cache are
correctly, compared to vanilla version. Untracked cache remains in
index, but not used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1b98663..853df93 100644
--- a/dir.c
+++ b/dir.c
@@ -1801,7 +1801,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 	struct untracked_cache_dir *root;
 	int i;
=20
-	if (!dir->untracked)
+	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
=20
 	/*
--=20
2.3.0.rc1.137.g477eb31

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/22] untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
Date: Sat,  8 Nov 2014 16:39:49 +0700
Message-ID: <1415439595-469-17-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2WG-0001Ye-AT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbaKHJlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:13 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35885 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbaKHJlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:11 -0500
Received: by mail-pd0-f174.google.com with SMTP id p10so4798404pdj.33
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wg14vwfAYz4PY4mgH9zrXoxjuJkkA7h/uEwim86C0a0=;
        b=uX+li5j3+Lgmh+uxNKrJq7pxuOkS/R8jl8IC/3tGmQtvz0VvdJQvtRmS1GtzpOLCtI
         BwG1YwxMNG2UDHWPIkXFtSStwetssjDTxxQiqkaAH1frMhwXwVH7xIceldhVRYlArGUr
         ZmO9ygNqMt14cj5TAFlRFGJbPzAJyLpBWqYbH2Nrex8dr7P96omtKCayUALvCsgPbJUL
         a2EADE4npF7y5qkLTieANTiP7djJegCFUJr2OgpxvVSA7shbwKEG4LjHvh7zOsIU3dUi
         cOag3ccB2OnBnQFbPST2VxeM0pbVB2sqTX16VN84AY5Ft7xjexNC6GuQzv+tltuD1E8p
         cODQ==
X-Received: by 10.68.106.161 with SMTP id gv1mr18245440pbb.1.1415439671219;
        Sat, 08 Nov 2014 01:41:11 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id j14sm10941519pbq.85.2014.11.08.01.41.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:25 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be used to double check if results with untracked cache are
correctly, compared to vanilla version. Untracked cache remains in
index, but not used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b1f2be5..a99bd63 100644
--- a/dir.c
+++ b/dir.c
@@ -1798,7 +1798,7 @@ static struct untracked_cache_dir *validate_untra=
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
2.1.0.rc0.78.gc0d8480

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/18] list-files: -u does not imply showing stages
Date: Sun, 30 Mar 2014 20:56:01 +0700
Message-ID: <1396187769-30863-11-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEC-0003CN-3s
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbaC3N4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:41 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36699 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC3N4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:40 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so6760757pdj.8
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yogzGbsQQxDoSvvfFIIAcc7dwDMKphql2+nIfVuBKq0=;
        b=c1tEj1DRVMODpIkLb/Hw2fpeIvO+Gn6RxFImnBfwqItiyVq/olSULwu0MdaoPoO9FP
         cD1lGix8uHp7zcQpeZzrOtVRMs3CyDLV5G19asxz8gHDYWcG3uPEkudnGJKdxA+tfgoZ
         e7sdy16zChQy1PGEberZWLNDFiRNEEDnno0aDk8e1SOsrs2C9bodZ8aB4WJfCQ4WbC8g
         kcm4A6vj1qEpI4Sm9SQZPT8dAv6Fg937xdjZcQAmi3V0gWjHSD2EMaNW+oXbJZDtHxnY
         8086Q6NP4ly+Y6hLMZ1wcBAATFaSs0DMqCXvFhlpah7S1t5l0azRKHWNepECkcKWDozy
         x//A==
X-Received: by 10.68.254.5 with SMTP id ae5mr19210435pbd.83.1396187799241;
        Sun, 30 Mar 2014 06:56:39 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id fg12sm26231202pac.28.2014.03.30.06.56.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:36 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245474>

Showing full index entry information is something for ls-files
only. The users of "git list-files" may just want to know what entries
are not unmerged.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0ae07b0..addbcce 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -656,7 +656,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
-	if (show_unmerged)
+	if (show_unmerged && !porcelain)
 		/*
 		 * There's no point in showing unmerged unless
 		 * you also show the stage information.
--=20
1.9.1.345.ga1a145c

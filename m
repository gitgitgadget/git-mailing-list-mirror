From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/19] list-files: -u does not imply showing stages
Date: Sun, 30 Nov 2014 15:55:58 +0700
Message-ID: <1417337767-4505-11-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0K7-0002zp-GN
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaK3I5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:57:39 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:42813 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:57:38 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so9089122pab.6
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=njDLcMD6FVjoAw/4kVRq58R+5HSfsNn+UNdfMe7x01o=;
        b=OrkoxZtWWG36Nc9JfkUW7cbjroNoehzokxmy4xpY2DURaoJla+DtikYVKreNSqZ3TM
         Zf9OJyeYnUQ1KO9aucTgYgHEq02DbJI3DGD0hFku3B94CkT0T0h43S7/UPHvIM+Kn6T6
         xO76J6h/4IUK1uW5YyBWvzyT0aPUs9cGyRzgADhzHQndDnSDDRAiw5kMo3FTvD/LcpqJ
         5X/QkdTNxvLYjM0MF+OT8dVqmrp52DGhIIgNJyPTo7bB8knIQzv/gGbbCAXMcu3aEdYp
         fxldxjLG/7e347pkS9SnsNrjjrJD9QDLorxHGcDjqCctF6RnEruIlowo3+qU6VFOeRca
         F6yQ==
X-Received: by 10.68.225.7 with SMTP id rg7mr36301355pbc.24.1417337857692;
        Sun, 30 Nov 2014 00:57:37 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id yp8sm14452771pab.48.2014.11.30.00.57.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:57:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:57:36 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260433>

Showing full index entry information is something for ls-files
only. The users of "git list-files" may just want to know what entries
are not unmerged.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f3873a8..f2b62b5 100644
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
2.2.0.60.gb7b3c64

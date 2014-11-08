From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] ls-tree: disable negative pathspec because it's not supported
Date: Sat,  8 Nov 2014 18:00:31 +0700
Message-ID: <1415444432-18596-2-git-send-email-pclouds@gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 12:00:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3l2-0006CW-S1
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 12:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbaKHLA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 06:00:29 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:43417 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbaKHLAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 06:00:25 -0500
Received: by mail-pd0-f173.google.com with SMTP id v10so4865731pde.32
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Kfvai8pTKtfIOQ2h8AXdpD86+UB488fb8/vITZpofhM=;
        b=g5pB3vVmiTY3ltLsqcEKy+J94NmdSeO1ND8Id1hYEb+HL5DtW6MhmTmOCkDRS51gFd
         ISH/7ZIvss/NlfW+NzLHQSH5MgeUzHCQPJqw4y+rduixkGYw1vW34KAg4jp6lCk0918+
         Ukx/mSw4yHsKbJN6vjg1ThgeeASmay6Z0gp9UzKPIZ/3BomNnVrmWWX0Y/9YjYKEUg5Z
         7NhCIXUzzvTVKjILkJh6XnaUzsRAvVqCCFPfo86ZCR7k4VLNRDq9jE2IdeluLsl34u3F
         7bTY8TXlyJLDJhOKrmqu1QaT72wNEBQzaHhuJI9E0GZbhtHDZN3dBMWKQzg6WrZxd/iV
         bJ6g==
X-Received: by 10.68.220.169 with SMTP id px9mr1281140pbc.146.1415444424545;
        Sat, 08 Nov 2014 03:00:24 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id dj1sm11265695pdb.10.2014.11.08.03.00.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 03:00:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 18:00:38 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1ab0381..d226344 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -174,7 +174,8 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE,
+	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
+				  PATHSPEC_EXCLUDE,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
--=20
2.1.0.rc0.78.gc0d8480

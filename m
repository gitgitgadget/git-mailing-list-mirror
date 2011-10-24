From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 06/11] read_directory_recursive: reduce one indentation level
Date: Mon, 24 Oct 2011 17:36:11 +1100
Message-ID: <1319438176-7304-7-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEBn-0000tu-DS
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab1JXGjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55823 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:09 -0400
Received: by mail-yx0-f174.google.com with SMTP id 42so2864889yxl.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DPWD7fEW23nsd7MRhwFrnE5z2nTJd+y2BuFzX7hAaYw=;
        b=FHN7RfEvG0Ytm/29F0WvPZQDQ5Y9XotXsPikH+gaaVVWuF8X0JchyuPj3mnqNcbBg1
         NkEZLTOpypt5gRBmP81ynad6IvAhOnViEbR1tm++jx1OzMDtl9q1vlLFgtwcYJCwkerA
         gtTZ8iKJ0v0fMFp0p0HHpnE0cV78D9M+oVDlM=
Received: by 10.236.168.2 with SMTP id j2mr31755035yhl.24.1319438348925;
        Sun, 23 Oct 2011 23:39:08 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id d5sm31163675yhl.19.2011.10.23.23.39.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:27 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184159>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   50 +++++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/dir.c b/dir.c
index 6c0d782..0a78d00 100644
--- a/dir.c
+++ b/dir.c
@@ -968,34 +968,34 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 {
 	DIR *fdir =3D opendir(*base ? base : ".");
 	int contents =3D 0;
+	struct dirent *de;
+	char path[PATH_MAX + 1];
=20
-	if (fdir) {
-		struct dirent *de;
-		char path[PATH_MAX + 1];
-		memcpy(path, base, baselen);
-
-		while ((de =3D readdir(fdir)) !=3D NULL) {
-			int len;
-			switch (treat_path(dir, de, path, sizeof(path),
-					   baselen, simplify, &len)) {
-			case path_recurse:
-				contents +=3D read_directory_recursive
-					(dir, path, len, 0, simplify);
-				continue;
-			case path_ignored:
-				continue;
-			case path_handled:
-				break;
-			}
-			contents++;
-			if (check_only)
-				goto exit_early;
-			else
-				dir_add_name(dir, path, len);
+	if (!fdir)
+		return 0;
+
+	memcpy(path, base, baselen);
+
+	while ((de =3D readdir(fdir)) !=3D NULL) {
+		int len;
+		switch (treat_path(dir, de, path, sizeof(path),
+				   baselen, simplify, &len)) {
+		case path_recurse:
+			contents +=3D read_directory_recursive(dir, path, len, 0, simplify)=
;
+			continue;
+		case path_ignored:
+			continue;
+		case path_handled:
+			break;
 		}
-exit_early:
-		closedir(fdir);
+		contents++;
+		if (check_only)
+			goto exit_early;
+		else
+			dir_add_name(dir, path, len);
 	}
+exit_early:
+	closedir(fdir);
=20
 	return contents;
 }
--=20
1.7.3.1.256.g2539c.dirty

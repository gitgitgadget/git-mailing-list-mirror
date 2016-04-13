From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/25] worktree.c: add find_worktree_by_path()
Date: Wed, 13 Apr 2016 20:15:35 +0700
Message-ID: <1460553346-12985-15-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfW-0004UL-50
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbcDMNRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:06 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32865 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbcDMNRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:04 -0400
Received: by mail-pa0-f67.google.com with SMTP id vv3so3901446pab.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrGSxma94j/5K7Y9pmXNDDCtSRvSElPQ8OiX0MGgWVg=;
        b=aNREnQvKf2D7e5PtORCM37DZhbD4E/dxx7OqnmjTBAZrY2/TaPhGOjcrezFtJL7ckE
         tT09LJ33KIz2Rpl2n9S9tXurTTlR9IBm/VkhQhoS9Bu577x99Nrz4m2IG3NdE3APZNqv
         DiGXU/wQLacERSwnBihyP83eCbCJkhoEyIdqKZb3CcuNOTp/4cvsMVlE2w+ulXDEPl9g
         +EDk8OjOcIPnDyNc9TXsVp9A866YvwpLzaa9weiy7aIZAZ3DzHjH2bdbhMlfh718q+d0
         UzCDpmf4j4+Rz47Sk1yKM1SfzyahaSFLv8FssywBEqXQAnT6bUMZu8kV8ysvlwpy7ABo
         38zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrGSxma94j/5K7Y9pmXNDDCtSRvSElPQ8OiX0MGgWVg=;
        b=WwI+Wqn1m2Td9MZ9Oo25SZ0FO0FnBPBWqt5/VPczR4RcDUnrIrI6VmXGW9NqCDbOeM
         QCael7Q5oIvAd8sRhE61U0Cv2BwqiZoiSgSKWJxuyQ/Xk6ByL6kDi8Jxk8HJ8o3mCmtu
         cUmu8/wcH1XFk+wQel4ZHAMr3orcJEN5hTf0oqTUyiryn0C9vKRmT9JpP8wM/O9cBFpv
         Hl462ayXhGsn6HcF/6tm9rpPvnKaz4K7BpH22wRRrWYpGKhJrs9AGL5dHZ/4skinVnlY
         tKYN9U4TC8jggGbYwxPk2nx85oWVTiFS8sBL3+i1NRnB9V/CgBjHBBgRDqjSVeEJaTcT
         4ppg==
X-Gm-Message-State: AOPr4FX0rcYfESeaHSqfCUVvIQIEqO338HGFl/nZpOufzkIHS8p/MDZ2vNaArIg809llrA==
X-Received: by 10.67.30.163 with SMTP id kf3mr12836454pad.45.1460553424096;
        Wed, 13 Apr 2016 06:17:04 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id vv8sm51314441pab.22.2016.04.13.06.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291434>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 16 ++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/worktree.c b/worktree.c
index b4e4b57..e444ad1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -198,6 +198,22 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return get_git_common_dir();
 }
=20
+struct worktree *find_worktree_by_path(struct worktree **list,
+				       const char *path_)
+{
+	char *path =3D xstrdup(real_path(path_));
+	struct worktree *wt =3D NULL;
+
+	while (*list) {
+		wt =3D *list++;
+		if (!strcmp_icase(path, real_path(wt->path)))
+			break;
+		wt =3D NULL;
+	}
+	free(path);
+	return wt;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 0ba07ab..c163b6b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -28,6 +28,12 @@ extern struct worktree **get_worktrees(void);
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
 /*
+ * Search a worktree by its path. Paths are normalized internally.
+ */
+extern struct worktree *find_worktree_by_path(struct worktree **list,
+					      const char *path_);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.8.0.rc0.210.gd302cd2

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/20] worktree.c: add find_worktree_by_path()
Date: Wed,  3 Feb 2016 16:35:39 +0700
Message-ID: <1454492150-10628-10-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrp-0005pQ-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbcBCJgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:48 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36484 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbcBCJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id n128so10951640pfn.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qtq4+Y2fp6R3nuQ331g4y1HMLVqPkccGAgunpUh08fM=;
        b=hX7Po07jXQqL+PUr+ntPF1YgnFsmm3+cJzqI7+1HY+61LFQnqcmWYnlj/5PguOTuZp
         louEf0XbnRHmdXy4/ROu50mHvQ1a5sZCUbPfDb7+ATGUH8ui5PLd1QCHFPG9tvj3UpJY
         ugPbCAl2mqykayTu+0X36GQ0ZsS8TSJcDHbvN2M7IRo/u0uQOHgiwb2aaZtMZUfcnbAF
         nGZiwkM6SqEAu8W6KRXxqXxG32ZtuemnXFNG6OiLKffgziDI5NSVxB3uAg6vyjX0H02O
         kHhmGKRhhyhaDcfJrR3GgjzFk1mN8f+E3KTk38KqgZynP2mZpXbNIT4WqMb6E4iJKawT
         DAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=qtq4+Y2fp6R3nuQ331g4y1HMLVqPkccGAgunpUh08fM=;
        b=OeTw4GDAAriOh9XJtLYEn/Bft/KyB6SGQet3nyYBOAFLAVisZFsdXwvzyvGiHoW92N
         ZJFN9d5d0MfOEgaZQszLHm1oSXwy4VsEqYzE4lfEqpJvdgyFKBSp32FGnXeV6wnnaI3P
         D/zUaYPAIxgl1djjQDI88X1fQ6EQAYxzIFqWOau3I/pGou1mpZud07jzAmZ7RXmB9J9m
         DM/2JnOipdnXba4a8+4dbhP+3KJAA2JmnPtXi9THoY4KvpeE5Zt22lHLVuAUOk/P1P7L
         dh99ktJIkzcpziBomSdje4AcaNMLGfaGUUSl8rtWGvKKBNo5Nr5ygDuWR1vv7I6Brq6v
         Bj+A==
X-Gm-Message-State: AG10YOQg0h8mUgp46ol8xUorPp6CEbvACMyQ/57z3cmwGueeyqosMg77BXH/UpchrhaP7A==
X-Received: by 10.98.72.130 with SMTP id q2mr727169pfi.154.1454492204348;
        Wed, 03 Feb 2016 01:36:44 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id i23sm8360398pfj.68.2016.02.03.01.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:55 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285353>

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
2.7.0.377.g4cd97dd

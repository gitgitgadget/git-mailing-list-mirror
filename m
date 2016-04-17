From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] worktree.c: add worktree_git_path_..._head()
Date: Sun, 17 Apr 2016 19:59:22 +0700
Message-ID: <1460897965-486-5-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJK-0007L5-Sd
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbcDQNAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36596 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbcDQNAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so10238289pfb.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyR+tEf4l0O+zpyS28qKSfUZBiTbr5Us+qgXNTylReE=;
        b=dZu8QuzfjCg2tZhXWbkmhcqJOGoMxrbLZAZekt/RSfTLX14c2jqhjeK61KrLYiDIyW
         yT+8iKCT9JAPnIWkcL+TiJqMCmJtsA0djp+Y6MUea6DxNuAGXLkN5OQlHc90gSsjRlKs
         8138+tFwt8Iri6/zl626FUeZ4+V6YXm485pvetd+mpZ7EjR2uocB+QicqDWYP+TPPjSR
         ctaZM01eRhWM1UiuOGlg1EEUMOey8Rj99V2Vgg3ZiW1PRL0N/l7d3KjxO6+y7i6AI1Wd
         8mYZks3mVU0StM5jW3DBzApujZkz+JRb/lk8S5LEhknem0w+6NQSeJ9xiCFiEzupl1oM
         edVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyR+tEf4l0O+zpyS28qKSfUZBiTbr5Us+qgXNTylReE=;
        b=CfJc7JqDjReS0rRlsyXsu8Z42cgEOcKGq9muHHc7IpqRJoo8EqHnFY1DFIEVeeE9zc
         4JD3fx3TW8XQ3NYlHt8H8KEys82NadYy7NvzE+zBoS5QZ89dxYmNeEmPTdtprxtCgWIR
         M3p+D4aoOKp2Hfw67dV7hIAA22Ar8pGLpZplx4/n2NYZgCLqmaa5vwyGP/9wvlIHEd2z
         Sw/Ct/6qp9ohVSBOJ0pdW+GnUkwzBsfG76TqZRKylVjYsvLOMMIV6gbplCaguhRgGkm0
         iO8vRPKwMcTlu30h+WmEcG+s75L6R8N8S0qa+GX5gL8oGrOR6XOY1xnQR6BChOYLFQTs
         4IYQ==
X-Gm-Message-State: AOPr4FU1PWtFZUjZfvuKEL1EKICK/LryIYM1y2K2ENDEi61bjJlMbf4ffLNSwhpRLeepxQ==
X-Received: by 10.98.69.75 with SMTP id s72mr43054313pfa.66.1460898012750;
        Sun, 17 Apr 2016 06:00:12 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id q72sm76835536pfa.70.2016.04.17.06.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 06:00:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291754>

These are a variant of git_path_..._head(), defined with GIT_PATH_FUNC
macro but they takes worktree into account. To be used when
wt_status_get_state() is converted to be worktree-aware.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c |  4 ++++
 worktree.h | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/worktree.c b/worktree.c
index 5ae54f0..c5bf583 100644
--- a/worktree.c
+++ b/worktree.c
@@ -222,3 +222,7 @@ char *find_shared_symref(const char *symref, const =
char *target)
=20
 	return existing;
 }
+
+WORKTREE_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
+WORKTREE_GIT_PATH_FUNC(cherry_pick_head, "CHERRY_PICK_HEAD")
+WORKTREE_GIT_PATH_FUNC(revert_head, "REVERT_HEAD")
diff --git a/worktree.h b/worktree.h
index 9ae2028..b7c5da0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -52,4 +52,17 @@ extern char *worktree_git_pathdup(const struct workt=
ree *wt,
 				  const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
=20
+#define WORKTREE_GIT_PATH_FUNC(func, filename) \
+	const char *worktree_git_path_ ## func(const struct worktree *wt) \
+	{ \
+		static char *ret; \
+		if (!ret) \
+			ret =3D worktree_git_pathdup(wt, filename); \
+		return ret; \
+	}
+
+const char *worktree_git_path_merge_head(const struct worktree *);
+const char *worktree_git_path_cherry_pick_head(const struct worktree *=
);
+const char *worktree_git_path_revert_head(const struct worktree *);
+
 #endif
--=20
2.8.0.rc0.210.gd302cd2

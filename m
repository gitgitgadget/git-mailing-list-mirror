From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 0/6] worktree lock/unlock
Date: Mon, 13 Jun 2016 19:18:20 +0700
Message-ID: <20160613121826.21631-1-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQpo-0004My-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbcFMMTC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:02 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34108 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964790AbcFMMTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:00 -0400
Received: by mail-pa0-f65.google.com with SMTP id ug1so10442384pab.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoucZDnYarxYOdateYWNTbIpM0aVkpAsr4gUk69zoIQ=;
        b=LWVfCerHYt0PYvHr/KNetktrDfr2goGWFF444OYQGigbEgMXzDmKgPb/rOS5jZfb7s
         B3HiRaAhHXBi1j6Rl1R84hSj9B9/enJw4fmvg3PkVND11AwMQB2PXlZ6aHrSQ5e7/3sA
         YkE38ttNk6/fZaq0wAxiWlckth1BFJECIO5fs4N1BzDNaFoENcL2Dr16uhURXOrB3G3X
         H5kwA4Z28A8rK4xhp1D1XNwPbSMtWvELmIERbGCZCgtVX9p0Wd2Gj3Rk19MShgSUGn2w
         C51AZrJzcm9Au6QjAcE5TUUnYsezrify/oflbGSVeEZy1lcvUKIajrfLd7QAvtGQUwQV
         sUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoucZDnYarxYOdateYWNTbIpM0aVkpAsr4gUk69zoIQ=;
        b=Bh5fbV1K3FpnLsymMtLBxjc+WxdBGGq67p4iPhP0EFXcVKq3NMb0WL8JtWNsrnS38c
         XP9JEwjgAHFlxN+I5f5IHEURtCfP2K7w9iWlZJYBqGXivX1xe4LHEg1YjIYWQuFfE6H9
         rfZwoMVUj0BgdnIf/1o3Vqh0grX87eC1DmDui0WhdQWb/VnaAGgo7vK87Nw1lbeZxsfG
         6KU+HZ3WH24LOga7dJMebarfkB7+L4ygDJqo8/fYEpyYyz9B0nLte//ap8mRBgHRhnpT
         QrRzdxACipVt3XR3Xf2A+YyWKlaTmwLvZWREOKn4xhlX8/6HcpXEC44N6ht40p2f451N
         jTQw==
X-Gm-Message-State: ALyK8tLCqeINbORaNBW8SyOnVeVQq0tJ9AWhqDXFzkJMCAzPHU06hQU/Rdwphr2IHSR+Ow==
X-Received: by 10.66.165.40 with SMTP id yv8mr22245828pab.89.1465820339911;
        Mon, 13 Jun 2016 05:18:59 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id x10sm28437339pfd.8.2016.06.13.05.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:18:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:18:54 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297184>

v5 fixes some error messages mentioning "working directory" instead of
"working tree" and split the double use of "lock_reason" field in
"struct worktree". This series depends on
nd/worktree-cleanup-post-head-protection.

Diff from v4

-- 8< --
diff --git a/builtin/worktree.c b/builtin/worktree.c
index cb5026d..4877421 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -478,9 +478,9 @@ static int lock_worktree(int ac, const char **av, c=
onst char *prefix)
 	worktrees =3D get_worktrees();
 	wt =3D find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
-		die(_("'%s' is not a working directory"), av[0]);
+		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
-		die(_("'%s' is a main working directory"), av[0]);
+		die(_("The main working tree cannot be locked or unlocked"));
=20
 	old_reason =3D is_worktree_locked(wt);
 	if (old_reason) {
@@ -511,9 +511,9 @@ static int unlock_worktree(int ac, const char **av,=
 const char *prefix)
 	worktrees =3D get_worktrees();
 	wt =3D find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
-		die(_("'%s' is not a working directory"), av[0]);
+		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
-		die(_("'%s' is a main working directory"), av[0]);
+		die(_("The main working tree cannot be locked or unlocked"));
 	if (!is_worktree_locked(wt))
 		die(_("'%s' is not locked"), av[0]);
 	ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id)=
);
diff --git a/worktree.c b/worktree.c
index b16262b..2107c06 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,8 +5,6 @@
 #include "dir.h"
 #include "wt-status.h"
=20
-static const char *lock_field_uninitialized =3D "value is not importan=
t";
-
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
@@ -15,8 +13,7 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->path);
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
-		if (worktrees[i]->lock_reason !=3D lock_field_uninitialized)
-			free(worktrees[i]->lock_reason);
+		free(worktrees[i]->lock_reason);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -102,7 +99,8 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason =3D (char *)lock_field_uninitialized;
+	worktree->lock_reason =3D NULL;
+	worktree->lock_reason_valid =3D 0;
=20
 done:
 	strbuf_release(&path);
@@ -148,7 +146,8 @@ static struct worktree *get_linked_worktree(const c=
har *id)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason =3D (char *)lock_field_uninitialized;
+	worktree->lock_reason =3D NULL;
+	worktree->lock_reason_valid =3D 0;
=20
 done:
 	strbuf_release(&path);
@@ -271,7 +270,9 @@ int is_main_worktree(const struct worktree *wt)
=20
 const char *is_worktree_locked(struct worktree *wt)
 {
-	if (wt->lock_reason =3D=3D lock_field_uninitialized) {
+	assert(!is_main_worktree(wt));
+
+	if (!wt->lock_reason_valid) {
 		struct strbuf path =3D STRBUF_INIT;
=20
 		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
@@ -283,6 +284,7 @@ const char *is_worktree_locked(struct worktree *wt)
 			wt->lock_reason =3D strbuf_detach(&lock_reason, NULL);
 		} else
 			wt->lock_reason =3D NULL;
+		wt->lock_reason_valid =3D 1;
 		strbuf_release(&path);
 	}
=20
diff --git a/worktree.h b/worktree.h
index 263b61d..90e1311 100644
--- a/worktree.h
+++ b/worktree.h
@@ -10,6 +10,7 @@ struct worktree {
 	int is_detached;
 	int is_bare;
 	int is_current;
+	int lock_reason_valid;
 };
=20
 /* Functions for acting on the information about worktrees. */
-- >8 --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  worktree.c: add find_worktree()
  worktree.c: add is_main_worktree()
  worktree.c: add is_worktree_locked()
  worktree: add "lock" command
  worktree: add "unlock" command
  worktree.c: find_worktree() search by path suffix

 Documentation/git-worktree.txt         | 36 +++++++++++++---
 builtin/worktree.c                     | 66 ++++++++++++++++++++++++++=
+++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh (new +x)      | 62 ++++++++++++++++++++++++++=
+
 worktree.c                             | 77 ++++++++++++++++++++++++++=
++++++++
 worktree.h                             | 21 ++++++++++
 6 files changed, 260 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

--=20
2.8.2.524.g6ff3d78

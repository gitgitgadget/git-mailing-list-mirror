From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] worktree lock/unlock
Date: Sun, 22 May 2016 17:43:36 +0700
Message-ID: <20160522104341.656-1-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 12:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Qrm-0001j6-DC
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbcEVKoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 06:44:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35130 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbcEVKoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:44:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id f144so662049pfa.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmwRs9P916SdPxgeJarlHXQwz9xXRJZGwzerbXSzKNs=;
        b=oWx/FHj11lqsrSkTFs9sXIlPdC4w17PsbJhKbI/6ZwLXkxQ6z9NaEd2vV8PLf9Vail
         t2vMDaeWDxKNd2T1x18oRlcZ9K6IEZS/ar/PY/hi1M3fK3C/OBIvJrVUcqFFGachT7ET
         tMy+YHAXUE0nR7opeDiSvZKbTexvwBy++j9bkg6qBGA4LXT+G1V+OO3WREWP2+5SwBwk
         ycSzjTEq905ph/ItCuFhcnAxDkiRNF/6wYfZEz5PyQLveDU8bDZFxF2Sl2DmMmJryu6Z
         ZUZpMRXfZvLN4w5zxAjhtD5sTUP7k4b5GMI0GoCUwpoVRnKei+bcFDYLskJqr65OUHDL
         48Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmwRs9P916SdPxgeJarlHXQwz9xXRJZGwzerbXSzKNs=;
        b=UvULvSr25GvBglytQG7rqzFCczeoF4z1fDWrF8+qzhH9STa1XAADWYp1V7jIT5/R+E
         hw3iAvA077zW2xppLli86kpS9uNAHZ+SQo0eLZKk7NvB28Ob1au28ArUoVffIKlKvjEz
         R/h3A1lOZ7FaP2EoTTUoZrNT9oiAbFQuVHlP01B+bfxqockHrMP/unIuKG2URYZknoue
         lSCxenC9zUwmqjrHkxwQ7YSk91hZmhtEtbIYgQnttfWDsI9ct/WJpnv8elBWMkwQubpH
         L5/xmk9+w5mQGLDncak5+PEhofo7Hg3cd0JHJayc4GbepsXTrvSuvUntcGiUXRf3s7Zn
         FT4w==
X-Gm-Message-State: AOPr4FUf5j4C34IGatzEtAjbCJIEhVg6p59bkRvzpYhhGrEKz7Hqiz4Bhy/BVn0yYnr+pw==
X-Received: by 10.98.38.196 with SMTP id m187mr18674332pfm.57.1463913848144;
        Sun, 22 May 2016 03:44:08 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id r86sm38997928pfb.21.2016.05.22.03.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 03:44:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 17:44:03 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141416.GA22672@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295270>

This should address all of Eric's comments (thanks!). An extra change
I made is free_worktrees() at the end of {,un}lock_worktree() to avoid
leaking. This series depends on nd/worktree-cleanup-post-head-protectio=
n.

Interdiff
-- 8< --
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 9ac1129..e0f2605 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -40,9 +40,8 @@ section "DETAILS" for more information.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
-being pruned by creating a file named 'locked' alongside the other
-administrative files, optionally containing a plain text reason that
-pruning should be suppressed. See section "DETAILS" for more informati=
on.
+being pruned by issuing the `git worktree lock` command, optionally
+specifying `--reason` to explain why the working tree is locked.
=20
 COMMANDS
 --------
@@ -65,9 +64,11 @@ bare, the revision currently checked out, and the br=
anch currently checked out
=20
 lock::
=20
-When a worktree is locked, it cannot be pruned, moved or deleted. For
-example, if the worktree is on portable device that is not available
-when "git worktree <command>" is executed.
+If a working tree is on a portable device or network share which
+is not always mounted, lock it to prevent its administrative
+files from being pruned automatically. This also prevents it from
+being moved or deleted. Optionally, specify a reason for the lock
+with `--reason`.
=20
 prune::
=20
@@ -123,7 +124,7 @@ OPTIONS
 	With `prune`, only expire unused working trees older than <time>.
=20
 --reason <string>:
-	An explanation why the worktree is locked.
+	With `lock`, an explanation why the worktree is locked.
=20
 DETAILS
 -------
@@ -165,7 +166,8 @@ instead.
=20
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
+entry's working tree is stored on a portable device), use the
+`git worktree lock` comamnd, which adds a file named
 'locked' to the entry's directory. The file contains the reason in
 plain text. For example, if a linked working tree's `.git` file points
 to `/path/main/.git/worktrees/test-next` then a file named
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 53e5f5a..da9f771 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -482,6 +482,7 @@ static int lock_worktree(int ac, const char **av, c=
onst char *prefix)
=20
 	worktrees =3D get_worktrees();
 	wt =3D find_worktree_by_path(worktrees, dst.buf);
+	strbuf_release(&dst);
 	if (!wt)
 		die(_("'%s' is not a working directory"), av[0]);
 	if (is_main_worktree(wt))
@@ -491,11 +492,12 @@ static int lock_worktree(int ac, const char **av,=
 const char *prefix)
 	if (old_reason) {
 		if (*old_reason)
 			die(_("already locked, reason: %s"), old_reason);
-		die(_("already locked, no reason"));
+		die(_("already locked"));
 	}
=20
 	write_file(git_common_path("worktrees/%s/locked", wt->id),
 		   "%s", reason);
+	free_worktrees(worktrees);
 	return 0;
 }
=20
@@ -506,6 +508,7 @@ static int unlock_worktree(int ac, const char **av,=
 const char *prefix)
 	};
 	struct worktree **worktrees, *wt;
 	struct strbuf dst =3D STRBUF_INIT;
+	int ret;
=20
 	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac !=3D 1)
@@ -517,14 +520,16 @@ static int unlock_worktree(int ac, const char **a=
v, const char *prefix)
=20
 	worktrees =3D get_worktrees();
 	wt =3D find_worktree_by_path(worktrees, dst.buf);
+	strbuf_release(&dst);
 	if (!wt)
 		die(_("'%s' is not a working directory"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working directory"), av[0]);
 	if (!is_worktree_locked(wt))
 		die(_("not locked"));
-
-	return unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id))=
;
+	ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id)=
);
+	free_worktrees(worktrees);
+	return ret;
 }
=20
 int cmd_worktree(int ac, const char **av, const char *prefix)
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index f4b2816..1927537 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -25,12 +25,32 @@ test_expect_success 'lock linked worktree' '
 	test_cmp expected .git/worktrees/source/locked
 '
=20
+test_expect_success 'lock linked worktree from another worktree' '
+	rm .git/worktrees/source/locked &&
+	git worktree add elsewhere &&
+	(
+		cd elsewhere &&
+		git worktree lock --reason hahaha ../source
+	) &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
 test_expect_success 'lock worktree twice' '
 	test_must_fail git worktree lock source &&
 	echo hahaha >expected &&
 	test_cmp expected .git/worktrees/source/locked
 '
=20
+test_expect_success 'lock worktree twice (from the locked worktree)' '
+	(
+		cd source &&
+		test_must_fail git worktree lock .
+	) &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
 test_expect_success 'unlock main worktree' '
 	test_must_fail git worktree unlock .
 '
diff --git a/worktree.c b/worktree.c
index a9cfbb3..cb30af3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -218,38 +218,37 @@ struct worktree *find_worktree_by_path(struct wor=
ktree **list,
 				       const char *path_)
 {
 	char *path =3D xstrdup(real_path(path_));
-	struct worktree *wt =3D NULL;
=20
-	while (*list) {
-		wt =3D *list++;
-		if (!fspathcmp(path, real_path(wt->path)))
+	for (; *list; list++)
+		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
-		wt =3D NULL;
-	}
 	free(path);
-	return wt;
+	return *list;
 }
=20
 int is_main_worktree(const struct worktree *wt)
 {
-	return wt && !wt->id;
+	return !wt->id;
 }
=20
 const char *is_worktree_locked(const struct worktree *wt)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+
+	strbuf_git_common_path(&path, "worktrees/%s/locked", wt->id);
=20
-	if (!file_exists(git_common_path("worktrees/%s/locked", wt->id)))
+	if (!file_exists(path.buf)) {
+		strbuf_release(&path);
 		return NULL;
+	}
=20
 	strbuf_reset(&sb);
-	if (strbuf_read_file(&sb,
-			     git_common_path("worktrees/%s/locked", wt->id),
-			     0) < 0)
-		die_errno(_("failed to read '%s'"),
-			  git_common_path("worktrees/%s/locked", wt->id));
+	if (strbuf_read_file(&sb, path.buf, 0) < 0)
+		die_errno(_("failed to read '%s'"), path.buf);
+	strbuf_release(&path);
=20
-	strbuf_rtrim(&sb);
+	strbuf_trim(&sb);
 	return sb.buf;
 }
=20
diff --git a/worktree.h b/worktree.h
index 19a6790..3a780c2 100644
--- a/worktree.h
+++ b/worktree.h
@@ -42,7 +42,7 @@ extern int is_main_worktree(const struct worktree *wt=
);
=20
 /*
  * Return the reason string if the given worktree is locked. Return
- * NULL otherwise.
+ * NULL otherwise. Return value is only valid until the next invocatio=
n.
  */
 extern const char *is_worktree_locked(const struct worktree *wt);
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  worktree.c: add find_worktree_by_path()
  worktree.c: add is_main_worktree()
  worktree.c: add is_worktree_locked()
  worktree: add "lock" command
  worktree: add "unlock" command

 Documentation/git-worktree.txt         | 27 +++++++++---
 builtin/worktree.c                     | 77 ++++++++++++++++++++++++++=
++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh (new +x)      | 68 ++++++++++++++++++++++++++=
++++
 worktree.c                             | 38 +++++++++++++++++
 worktree.h                             | 17 ++++++++
 6 files changed, 225 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

--=20
2.8.2.524.g6ff3d78

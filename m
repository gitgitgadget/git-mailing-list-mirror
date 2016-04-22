From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/13] worktree.c: store "id" instead of "git_dir"
Date: Fri, 22 Apr 2016 20:01:26 +0700
Message-ID: <1461330096-21783-4-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:01:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataiU-0006rB-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbcDVNBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:01:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34361 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbcDVNBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:01:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so2503195pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4nyYt9gSuVJE3lajVQB1muTbjYQAyY50ag1O1QrLME=;
        b=fLUaEh2hY/ycGcbyysngH/vwdLE3eZ5X676mGSmptfOJq8fW69VGMToglZa18T/Bcd
         U/GWhllTxf3iFitjqggsWWSAz4ocQ+FUfJrxezlDdF43qz7G/69SdTv97C2isYe2I8wA
         Yqli8hOhj0eefsr3QpxwYpt4tWEJbcldVh8EJ042CAKlcuB2Zsps8tCCZdigcx1kpVKp
         +16O+uaa/ht9RRcvbm//+MkjDjM1nHqIW0wvFB/D+/3NVRTqIhxbhc5FeALcPxS5HT8w
         LQQnrzhNAJQTRVFZEwJ9iA0E2t0jKLuKG/MvWMI2VMVa6lcOKnmoZs9JpW5YWo9n5SlP
         hoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4nyYt9gSuVJE3lajVQB1muTbjYQAyY50ag1O1QrLME=;
        b=bBem8zdliOE2BYlfUrKfHnfkUCD9S6WoG9kzXTIZ9NyKhTQvyhZae1vc3gp2ZxO0Ea
         M4vXV4SD6ZdYASEmdFJBAzd2vml6Zp7MqOsinhge627MSN73zyKxxuo2GhrNHAaF5cU3
         MG1lWTwVIJsmDMfZOaAxKdkvhXMdEj0fOPVzaVjjhG0neRf64E6YM6ZzG6Y0jwbayxBs
         PwHjIS4SsGsWZvyYXh2RSuuULjDaMQkLk7uDVMVA81pywYv+ozhNLGZTREmo8Dau4q3s
         9ktqs4o2uxDXJSbxCeqzoXVrickVG4Y4jNQIWqgUj0XmacMy9uqkRau0NJKjB7/8NYUm
         lncQ==
X-Gm-Message-State: AOPr4FWSTujNwM+7CXaw48x9vYkibV4KywKQRvuqXm9dE2jXbCJKeV/beUyd9nuxT1AXwg==
X-Received: by 10.98.88.69 with SMTP id m66mr28240482pfb.68.1461330106894;
        Fri, 22 Apr 2016 06:01:46 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id tp9sm9675680pab.14.2016.04.22.06.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:01:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:01:59 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292191>

We can reconstruct git_dir from id quite easily. It's a bit hackier to
do the reverse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c   |  3 ++-
 worktree.c | 31 ++++++++++++++++++-------------
 worktree.h |  8 +++++++-
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 4162443..0674a99 100644
--- a/branch.c
+++ b/branch.c
@@ -357,7 +357,8 @@ int replace_each_worktree_head_symref(const char *o=
ldref, const char *newref)
 		if (strcmp(oldref, worktrees[i]->head_ref))
 			continue;
=20
-		if (set_worktree_head_symref(worktrees[i]->git_dir, newref)) {
+		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
+					     newref)) {
 			ret =3D -1;
 			error(_("HEAD of working tree %s is not updated"),
 			      worktrees[i]->path);
diff --git a/worktree.c b/worktree.c
index 6181a66..5ae54f0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -9,7 +9,7 @@ void free_worktrees(struct worktree **worktrees)
=20
 	for (i =3D 0; worktrees[i]; i++) {
 		free(worktrees[i]->path);
-		free(worktrees[i]->git_dir);
+		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
 		free(worktrees[i]);
 	}
@@ -74,13 +74,11 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
 	struct strbuf worktree_path =3D STRBUF_INIT;
-	struct strbuf gitdir =3D STRBUF_INIT;
 	struct strbuf head_ref =3D STRBUF_INIT;
 	int is_bare =3D 0;
 	int is_detached =3D 0;
=20
-	strbuf_addf(&gitdir, "%s", absolute_path(get_git_common_dir()));
-	strbuf_addbuf(&worktree_path, &gitdir);
+	strbuf_addstr(&worktree_path, absolute_path(get_git_common_dir()));
 	is_bare =3D !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
@@ -92,7 +90,7 @@ static struct worktree *get_main_worktree(void)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D NULL;
 	worktree->is_bare =3D is_bare;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -100,7 +98,6 @@ static struct worktree *get_main_worktree(void)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -111,16 +108,13 @@ static struct worktree *get_linked_worktree(const=
 char *id)
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
 	struct strbuf worktree_path =3D STRBUF_INIT;
-	struct strbuf gitdir =3D STRBUF_INIT;
 	struct strbuf head_ref =3D STRBUF_INIT;
 	int is_detached =3D 0;
=20
 	if (!id)
 		die("Missing linked worktree name");
=20
-	strbuf_addf(&gitdir, "%s/worktrees/%s",
-			absolute_path(get_git_common_dir()), id);
-	strbuf_addf(&path, "%s/gitdir", gitdir.buf);
+	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <=3D 0)
 		/* invalid gitdir file */
 		goto done;
@@ -140,7 +134,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D xstrdup(id);
 	worktree->is_bare =3D 0;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -148,7 +142,6 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -188,6 +181,16 @@ struct worktree **get_worktrees(void)
 	return list;
 }
=20
+const char *get_worktree_git_dir(const struct worktree *wt)
+{
+	if (!wt)
+		return get_git_dir();
+	else if (!wt->id)
+		return get_git_common_dir();
+	else
+		return git_common_path("worktrees/%s", wt->id);
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
@@ -199,7 +202,9 @@ char *find_shared_symref(const char *symref, const =
char *target)
 	for (i =3D 0; worktrees[i]; i++) {
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
-		strbuf_addf(&path, "%s/%s", worktrees[i]->git_dir, symref);
+		strbuf_addf(&path, "%s/%s",
+			    get_worktree_git_dir(worktrees[i]),
+			    symref);
=20
 		if (parse_ref(path.buf, &sb, NULL)) {
 			continue;
diff --git a/worktree.h b/worktree.h
index b4b3dda..3198c8d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -3,7 +3,7 @@
=20
 struct worktree {
 	char *path;
-	char *git_dir;
+	char *id;
 	char *head_ref;
 	unsigned char head_sha1[20];
 	int is_detached;
@@ -23,6 +23,12 @@ struct worktree {
 extern struct worktree **get_worktrees(void);
=20
 /*
+ * Return git dir of the worktree. Note that the path may be relative.
+ * If wt is NULL, git dir of current worktree is returned.
+ */
+extern const char *get_worktree_git_dir(const struct worktree *wt);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
--=20
2.8.0.rc0.210.gd302cd2

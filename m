From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/9] Rename match_pathspec_depth() to match_pathspec()
Date: Fri, 24 Jan 2014 20:40:30 +0700
Message-ID: <1390570836-20394-4-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gv8-00058p-0e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbaAXNf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:26 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50070 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:24 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so3293456pab.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kmdc3nD6FwIsgyXryB0ii7KRR29mezPIG4KCASE0qgY=;
        b=Gf2ZB741WTIwOnChchYAjp9/Vv9R7XlSmQlqxaiUw4J1138kAiD3HldLSHUV0dSJiB
         mTNH3Gf5hDri/9GGfbjRSqrC7twRSK6VVjwaNr7B31LqnG7KVBx7Q2fYD+2lX+xIeQCj
         v+3d1oOCLYoAF1V13r2aoUKwDvJ3QUOyUKai8URVAuZcuGDZp97wZ0DM2Vyiqdw71v4V
         73PJmkx9WABfHYqQoJIhKoEddvqhCa4WPpVJoqWmZ3SmTNyI382jZHE9VS0wMjfZSiWy
         OD3/mexAtOfV+px7smMX5t4TrP8jkar1qPs9yiegw6ZwBMef5Uyvo0Y2beNmpMz747vj
         UicQ==
X-Received: by 10.68.230.137 with SMTP id sy9mr14389132pbc.126.1390570524048;
        Fri, 24 Jan 2014 05:35:24 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id bc4sm3388445pbb.2.2014.01.24.05.35.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:40:58 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241003>

A long time ago, for some reason I was not happy with
match_pathspec(). I created a better version, match_pathspec_depth()
that was suppose to replace match_pathspec()
eventually. match_pathspec() has finally been gone since 6 months
ago. Use the shorter name for match_pathspec_depth().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c           |  4 ++--
 builtin/ls-files.c        |  6 ++++--
 builtin/ls-tree.c         |  2 +-
 dir.c                     | 20 ++++++++++----------
 dir.h                     | 10 +++++-----
 rerere.c                  |  4 ++--
 t/t6131-pathspec-icase.sh |  6 +++---
 7 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 2f26297..f59c753 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -961,8 +961,8 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			die_errno("Cannot lstat '%s'", ent->name);
=20
 		if (pathspec.nr)
-			matches =3D match_pathspec_depth(&pathspec, ent->name,
-						       len, 0, NULL);
+			matches =3D match_pathspec(&pathspec, ent->name,
+						 len, 0, NULL);
=20
 		if (S_ISDIR(st.st_mode)) {
 			if (remove_directories || (matches =3D=3D MATCHED_EXACTLY)) {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e238608..02db0e1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -139,7 +139,8 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
-	if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), len, p=
s_matched))
+	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+			    len, ps_matched))
 		return;
=20
 	if (tag && *tag && show_valid_bit &&
@@ -195,7 +196,8 @@ static void show_ru_info(void)
 		len =3D strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec_depth(&pathspec, path, len, max_prefix_len, ps_m=
atched))
+		if (!match_pathspec(&pathspec, path, len,
+				    max_prefix_len, ps_matched))
 			continue; /* uninterested */
 		for (i =3D 0; i < 3; i++) {
 			if (!ui->mode[i])
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 65ec931..51184df 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -171,7 +171,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
 	 * cannot be lifted until it is converted to use
-	 * match_pathspec_depth() or tree_entry_interesting()
+	 * match_pathspec() or tree_entry_interesting()
 	 */
 	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE,
 		       PATHSPEC_PREFER_CWD,
diff --git a/dir.c b/dir.c
index d10a63f..8960ea1 100644
--- a/dir.c
+++ b/dir.c
@@ -218,7 +218,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	 * The normal call pattern is:
 	 * 1. prefix =3D common_prefix_len(ps);
 	 * 2. prune something, or fill_directory
-	 * 3. match_pathspec_depth()
+	 * 3. match_pathspec()
 	 *
 	 * 'prefix' at #1 may be shorter than the command's prefix and
 	 * it's ok for #2 to match extra files. Those extras will be
@@ -282,10 +282,10 @@ static int match_pathspec_item(const struct paths=
pec_item *item, int prefix,
  * pathspec did not match any names, which could indicate that the
  * user mistyped the nth pathspec.
  */
-static int match_pathspec_depth_1(const struct pathspec *ps,
-				  const char *name, int namelen,
-				  int prefix, char *seen,
-				  int exclude)
+static int do_match_pathspec(const struct pathspec *ps,
+			     const char *name, int namelen,
+			     int prefix, char *seen,
+			     int exclude)
 {
 	int i, retval =3D 0;
=20
@@ -350,15 +350,15 @@ static int match_pathspec_depth_1(const struct pa=
thspec *ps,
 	return retval;
 }
=20
-int match_pathspec_depth(const struct pathspec *ps,
-			 const char *name, int namelen,
-			 int prefix, char *seen)
+int match_pathspec(const struct pathspec *ps,
+		   const char *name, int namelen,
+		   int prefix, char *seen)
 {
 	int positive, negative;
-	positive =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
0);
+	positive =3D do_match_pathspec(ps, name, namelen, prefix, seen, 0);
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
 		return positive;
-	negative =3D match_pathspec_depth_1(ps, name, namelen, prefix, seen, =
1);
+	negative =3D do_match_pathspec(ps, name, namelen, prefix, seen, 1);
 	return negative ? 0 : positive;
 }
=20
diff --git a/dir.h b/dir.h
index 65f54b6..c31ed9a 100644
--- a/dir.h
+++ b/dir.h
@@ -132,9 +132,9 @@ struct dir_struct {
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
-extern int match_pathspec_depth(const struct pathspec *pathspec,
-				const char *name, int namelen,
-				int prefix, char *seen);
+extern int match_pathspec(const struct pathspec *pathspec,
+			  const char *name, int namelen,
+			  int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const struct pathspe=
c *pathspec);
@@ -209,14 +209,14 @@ static inline int ce_path_match(const struct cach=
e_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
 {
-	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, se=
en);
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
 }
=20
 static inline int dir_path_match(const struct dir_entry *ent,
 				 const struct pathspec *pathspec,
 				 int prefix, char *seen)
 {
-	return match_pathspec_depth(pathspec, ent->name, ent->len, prefix, se=
en);
+	return match_pathspec(pathspec, ent->name, ent->len, prefix, seen);
 }
=20
 #endif
diff --git a/rerere.c b/rerere.c
index 1f2d21a..34a21c4 100644
--- a/rerere.c
+++ b/rerere.c
@@ -672,8 +672,8 @@ int rerere_forget(struct pathspec *pathspec)
 	find_conflict(&conflict);
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
-		if (!match_pathspec_depth(pathspec, it->string, strlen(it->string),
-					  0, NULL))
+		if (!match_pathspec(pathspec, it->string,
+				    strlen(it->string), 0, NULL))
 			continue;
 		rerere_forget_one_path(it->string, &merge_rr);
 	}
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index a7c7ff5..39fc3f6 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -69,7 +69,7 @@ test_expect_success 'tree_entry_interesting matches :=
(icase)bar with empty prefi
 	test_cmp expect actual
 '
=20
-test_expect_success 'match_pathspec_depth matches :(icase)bar' '
+test_expect_success 'match_pathspec matches :(icase)bar' '
 	cat <<-EOF >expect &&
 	BAR
 	bAr
@@ -79,7 +79,7 @@ test_expect_success 'match_pathspec_depth matches :(i=
case)bar' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'match_pathspec_depth matches :(icase)bar with pre=
fix' '
+test_expect_success 'match_pathspec matches :(icase)bar with prefix' '
 	cat <<-EOF >expect &&
 	fOo/BAR
 	fOo/bAr
@@ -89,7 +89,7 @@ test_expect_success 'match_pathspec_depth matches :(i=
case)bar with prefix' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'match_pathspec_depth matches :(icase)bar with emp=
ty prefix' '
+test_expect_success 'match_pathspec matches :(icase)bar with empty pre=
fix' '
 	cat <<-EOF >expect &&
 	bar
 	fOo/BAR
--=20
1.8.5.2.240.g8478abd

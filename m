From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/13] dir.c: rename str(n)cmp_icase to fspath(n)cmp
Date: Fri, 22 Apr 2016 20:01:24 +0700
Message-ID: <1461330096-21783-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 22 15:01:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataiS-0006rB-3c
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbcDVNBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:01:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34306 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbcDVNBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:01:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so2502708pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbsinEp6/okboqAbpEPUnIk5JaqYgPcQ7YR5fw6p0wo=;
        b=XXC9/YfpqZx6iC/xN/Sk5OGMQuuP8k4Ubsezcdurp9kNASjPVe4lECshVcvVzoRC0I
         2j1sIJtXGcIgF0fOo1OYS6VeXLXOlMQUJlKsptPIJK2u1NgR9L1kcuq3XGL9MaxPoeO6
         Kfk81Mm/3YDOiAjIV00iWMsZE5TiksS+f3mv0N5DAmjSwhI6YRmi3tMQJrfu3bChZxis
         Edq0piR2Z33ITmQQjCgF65soUheq/kVXwcYXYruW4suq2DD//xhl0zLE9hF7BSHiJraq
         RqOh5B/E579K5TqMZe8Iv0MZuivlcW1gkvav7GziZ4e/Vshy54BhvzG6AKZIz0mfUW4p
         Ikeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbsinEp6/okboqAbpEPUnIk5JaqYgPcQ7YR5fw6p0wo=;
        b=SINpLN+VQBDpv7c7kyXWCMTHTom01w5ytKS4qSclcfGkgcDIjEBvNOrfb+MwJ8yEFI
         Z3/whfYcr1aHFXF3U3Bw+HGfRRntyNDfJTfQ23zGogRaHoFZ+Mk9Si8CG6jx4t/iIHvb
         n5XI+66skuXyNNN3NF0JNEgwmgareTOpv+z2EgKdGy61XO4F0xqHcjvbOwmbyusV7y9U
         stlmdnlqzn19v1faMgfSNX8ijlwOGz8jPgTlQhpO9hvm1Of7EE/daLb3bR7lP0TUQrDC
         uo1YT2MC2Y5+eM+eu0uVr6tzKUXCKtVHES/LS4nP+Q+2trFSVT6BqDHs9PJbIkrqr+Rc
         D6/Q==
X-Gm-Message-State: AOPr4FU7hGABdKvfSAMq9Vx7WQNAx6Hhkz2X1nHuZqJvmyHgVKOGPG4PzMAbILdkjq6w6g==
X-Received: by 10.98.98.1 with SMTP id w1mr28409020pfb.117.1461330090823;
        Fri, 22 Apr 2016 06:01:30 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id c29sm8485380pfd.12.2016.04.22.06.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:01:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:01:44 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292190>

These functions compare two paths that are taken from file system.
Depending on the running file system, paths may need to be compared
case-sensitively or not, and maybe even something else in future. The
current names do not convey that well.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c         | 13 ++++++-------
 dir.h         |  4 ++--
 fast-import.c |  6 +++---
 sha1_file.c   |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index 996653b..f04bd3b 100644
--- a/dir.c
+++ b/dir.c
@@ -53,13 +53,12 @@ static enum path_treatment read_directory_recursive=
(struct dir_struct *dir,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
-/* helper string functions with support for the ignore_case flag */
-int strcmp_icase(const char *a, const char *b)
+int fspathcmp(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
=20
-int strncmp_icase(const char *a, const char *b, size_t count)
+int fspathncmp(const char *a, const char *b, size_t count)
 {
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
@@ -802,12 +801,12 @@ int match_basename(const char *basename, int base=
namelen,
 {
 	if (prefix =3D=3D patternlen) {
 		if (patternlen =3D=3D basenamelen &&
-		    !strncmp_icase(pattern, basename, basenamelen))
+		    !fspathncmp(pattern, basename, basenamelen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		/* "*literal" matching against "fooliteral" */
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strncmp_icase(pattern + 1,
+		    !fspathncmp(pattern + 1,
 				   basename + basenamelen - (patternlen - 1),
 				   patternlen - 1))
 			return 1;
@@ -844,7 +843,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    fspathncmp(pathname, base, baselen))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
@@ -858,7 +857,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 		if (prefix > namelen)
 			return 0;
=20
-		if (strncmp_icase(pattern, name, prefix))
+		if (fspathncmp(pattern, name, prefix))
 			return 0;
 		pattern +=3D prefix;
 		patternlen -=3D prefix;
diff --git a/dir.h b/dir.h
index 301b737..e34d555 100644
--- a/dir.h
+++ b/dir.h
@@ -270,8 +270,8 @@ extern int remove_dir_recursively(struct strbuf *pa=
th, int flag);
 /* tries to remove the path with empty directories along it, ignores E=
NOENT */
 extern int remove_path(const char *path);
=20
-extern int strcmp_icase(const char *a, const char *b);
-extern int strncmp_icase(const char *a, const char *b, size_t count);
+extern int fspathcmp(const char *a, const char *b);
+extern int fspathncmp(const char *a, const char *b, size_t count);
 extern int fnmatch_icase(const char *pattern, const char *string, int =
flags);
=20
 /*
diff --git a/fast-import.c b/fast-import.c
index 9fc7093..339cd38 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1512,7 +1512,7 @@ static int tree_content_set(
 	t =3D root->tree;
 	for (i =3D 0; i < t->entry_count; i++) {
 		e =3D t->entries[i];
-		if (e->name->str_len =3D=3D n && !strncmp_icase(p, e->name->str_dat,=
 n)) {
+		if (e->name->str_len =3D=3D n && !fspathncmp(p, e->name->str_dat, n)=
) {
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode =3D=3D mode
@@ -1602,7 +1602,7 @@ static int tree_content_remove(
 	t =3D root->tree;
 	for (i =3D 0; i < t->entry_count; i++) {
 		e =3D t->entries[i];
-		if (e->name->str_len =3D=3D n && !strncmp_icase(p, e->name->str_dat,=
 n)) {
+		if (e->name->str_len =3D=3D n && !fspathncmp(p, e->name->str_dat, n)=
) {
 			if (*slash1 && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
@@ -1669,7 +1669,7 @@ static int tree_content_get(
 	t =3D root->tree;
 	for (i =3D 0; i < t->entry_count; i++) {
 		e =3D t->entries[i];
-		if (e->name->str_len =3D=3D n && !strncmp_icase(p, e->name->str_dat,=
 n)) {
+		if (e->name->str_len =3D=3D n && !fspathncmp(p, e->name->str_dat, n)=
) {
 			if (!*slash1)
 				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..ea6381b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -301,7 +301,7 @@ static int link_alt_odb_entry(const char *entry, co=
nst char *relative_base,
 			return -1;
 		}
 	}
-	if (!strcmp_icase(ent->base, normalized_objdir)) {
+	if (!fspathcmp(ent->base, normalized_objdir)) {
 		free(ent);
 		return -1;
 	}
--=20
2.8.0.rc0.210.gd302cd2

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/16] list-files: command skeleton
Date: Mon,  9 Mar 2015 17:18:19 +0700
Message-ID: <1425896314-10941-2-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUum7-0001N7-53
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbbCIKS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:18:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46339 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbbCIKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:18:57 -0400
Received: by pabli10 with SMTP id li10so71645500pab.13
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jpvVIq+zePlboQip5Jk9m2QP1AJ0liot6ohNqqKrYfs=;
        b=UHi7SsEa334xb+YWIaPFFzo40dv+9JxNVLvI+UwnXJS/N30NdhscWGp+aiDA7nkIQO
         JAq8PavC2uGEZxwyS2/5Q4Q+zkJBO/ZB20gyS8XfSTrk3Gc8mZ44qeZjH7WAPWleTZu6
         tkhZZyz8vqNFfZKSKVxTfwcev8mWakYFRX2Lg6gfy35KKLD/UhlszF0NcEJOghWP77kZ
         kBy27WHCdbQ6sIocLfi2qBM1lRwQhk473aw8897iERUed8G50YGHqFqAWkcaALEZ5540
         YPuY2gzZljLUK7WXr4G83Elhbh76Ncim8+SGgy7Sq575mqTPU1ycGfs2Vhx9HnP/NgFB
         GUNQ==
X-Received: by 10.70.26.129 with SMTP id l1mr51221992pdg.163.1425896336616;
        Mon, 09 Mar 2015 03:18:56 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id dr5sm18432518pdb.48.2015.03.09.03.18.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:18:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:18:52 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265143>

list-files is supposed to be the user friendly version of ls-files, or
an alternative to git-status. Nothing fancy in this patch yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                 |  1 +
 Makefile                   |  1 +
 builtin.h                  |  1 +
 builtin/list-files.c (new) | 96 ++++++++++++++++++++++++++++++++++++++=
++++++++
 git.c                      |  1 +
 5 files changed, 100 insertions(+)
 create mode 100644 builtin/list-files.c

diff --git a/.gitignore b/.gitignore
index a052419..0534225 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-interpret-trailers
 /git-instaweb
 /git-log
+/git-list-files
 /git-ls-files
 /git-ls-remote
 /git-ls-tree
diff --git a/Makefile b/Makefile
index 459121d..17f52b2 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ BUILTIN_OBJS +=3D builtin/index-pack.o
 BUILTIN_OBJS +=3D builtin/init-db.o
 BUILTIN_OBJS +=3D builtin/interpret-trailers.o
 BUILTIN_OBJS +=3D builtin/log.o
+BUILTIN_OBJS +=3D builtin/list-files.o
 BUILTIN_OBJS +=3D builtin/ls-files.o
 BUILTIN_OBJS +=3D builtin/ls-remote.o
 BUILTIN_OBJS +=3D builtin/ls-tree.o
diff --git a/builtin.h b/builtin.h
index b87df70..afc29e7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -76,6 +76,7 @@ extern int cmd_init_db(int argc, const char **argv, c=
onst char *prefix);
 extern int cmd_interpret_trailers(int argc, const char **argv, const c=
har *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *pre=
fix);
+extern int cmd_list_files(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_remote(int argc, const char **argv, const char *pref=
ix);
diff --git a/builtin/list-files.c b/builtin/list-files.c
new file mode 100644
index 0000000..ac33f13
--- /dev/null
+++ b/builtin/list-files.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "dir.h"
+
+static struct pathspec pathspec;
+static const char *prefix;
+static int prefix_length;
+
+static const char * const ls_usage[] =3D {
+	N_("git list-files [options] [<pathspec>...]"),
+	NULL
+};
+
+struct option ls_options[] =3D {
+	OPT_END()
+};
+
+static void add_one(struct string_list *result, const char *name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct string_list_item *item;
+
+	strbuf_addstr(&sb, name);
+	item =3D string_list_append(result, strbuf_detach(&sb, NULL));
+	item->util =3D (char *)name;
+}
+
+static void populate_cached_entries(struct string_list *result,
+				    const struct index_state *istate)
+{
+	int i;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce =3D istate->cache[i];
+
+		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+				    0, NULL,
+				    S_ISDIR(ce->ce_mode) ||
+				    S_ISGITLINK(ce->ce_mode)))
+			continue;
+
+		add_one(result, ce->name);
+	}
+}
+
+static void display(const struct string_list *result)
+{
+	int i;
+
+	for (i =3D 0; i < result->nr; i++) {
+		const struct string_list_item *s =3D result->items + i;
+
+		printf("%s\n", s->string);
+	}
+}
+
+static int ls_config(const char *var, const char *value, void *cb)
+{
+	return git_default_config(var, value, cb);
+}
+
+int cmd_list_files(int argc, const char **argv, const char *cmd_prefix=
)
+{
+	struct string_list result =3D STRING_LIST_INIT_NODUP;
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(ls_usage, ls_options);
+
+	prefix =3D cmd_prefix;
+	if (prefix)
+		prefix_length =3D strlen(prefix);
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	git_config(ls_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       cmd_prefix, argv);
+	pathspec.max_depth =3D 0;
+	pathspec.recursive =3D 1;
+
+	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
+		      &pathspec, NULL, NULL);
+
+	populate_cached_entries(&result, &the_index);
+	display(&result);
+	string_list_clear(&result, 0);
+	return 0;
+}
diff --git a/git.c b/git.c
index 18fbf79..ae7fe77 100644
--- a/git.c
+++ b/git.c
@@ -418,6 +418,7 @@ static struct cmd_struct commands[] =3D {
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
+	{ "list-files", cmd_list_files, RUN_SETUP | USE_PAGER | NEED_WORK_TRE=
E },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
--=20
2.3.0.rc1.137.g477eb31

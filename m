From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] Use correct grammar in diffstat summary line
Date: Wed,  1 Feb 2012 19:55:07 +0700
Message-ID: <1328100907-20397-1-git-send-email-pclouds@gmail.com>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Dickey <dickey@his.com>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 13:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsZjI-0004lT-2G
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 13:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab2BAMz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 07:55:57 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63784 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab2BAMzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 07:55:54 -0500
Received: by pbdu11 with SMTP id u11so1058797pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 04:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4LVdnXP1vNMtROScdrnCE5RGr8YOWn6ekgJKt9UEvF4=;
        b=EqIXIl9xVbnbGbbv8u9tsfo57OoDswa+AbpDYo0O0b0ZoOXTJ2BvsPcLbeXKqDkUio
         fG8s5KMPuaziQDSLpKCOmsXqb2kqnOhtFGEae7FG2BknzFjKIMcX6OHQXq9LZv7owew5
         qHqO0nXT1mobdG/Xm3JGQ0YwDEAP9kJz7Xo8A=
Received: by 10.68.132.227 with SMTP id ox3mr59169247pbb.86.1328100954200;
        Wed, 01 Feb 2012 04:55:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id x8sm63220467pbr.11.2012.02.01.04.55.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 04:55:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 01 Feb 2012 19:55:09 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189509>

"git diff --stat" and "git apply --stat" now learn to print the line
"%d files changed, %d insertions(+), %d deletions(-)" in singular form
whenever applicable. "0 insertions" and "0 deletions" are also omitted
unless they are both zero.

Also make this line translatable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Second try. Make it unconditionally (I'd still rather have no changes
 when LANG=3DC). Also omit "0 operations", although I keep "%d files
 changed, 0 insertions(+), 0 deletions(-)" for binary diff.

 In Vietnamese, the summary line is "thay =C4=91=E1=BB=95i 68 t=E1=BA=AD=
p tin, th=C3=AAm(+) 163,
 xo=C3=A1(-) 116". Lovely. Perhaps I'll translate git into Vietnamese a=
fter
 all :)

 And this patch's diffstat looks just scary due to test suite's updates=
=2E

 builtin/apply.c                                    |    3 +-
 diff.c                                             |   53 ++++++++++++=
++++++--
 diff.h                                             |    3 +
 t/t0023-crlf-am.sh                                 |    2 +-
 t/t1200-tutorial.sh                                |    2 +-
 t/t3300-funny-names.sh                             |    2 +-
 t/t3508-cherry-pick-many-commits.sh                |   12 ++--
 t/t3903-stash.sh                                   |    4 +-
 ...ff-tree_--cc_--patch-with-stat_--summary_master |    2 +-
 ...diff-tree_--cc_--patch-with-stat_--summary_side |    2 +-
 .../diff.diff-tree_--cc_--patch-with-stat_master   |    2 +-
 .../diff.diff-tree_--cc_--stat_--summary_master    |    2 +-
 t/t4013/diff.diff-tree_--cc_--stat_--summary_side  |    2 +-
 t/t4013/diff.diff-tree_--cc_--stat_master          |    2 +-
 ...pretty=3Doneline_--root_--patch-with-stat_initial |    2 +-
 .../diff.diff-tree_--pretty_--patch-with-stat_side |    2 +-
 ...-tree_--pretty_--root_--patch-with-stat_initial |    2 +-
 ...f-tree_--pretty_--root_--stat_--summary_initial |    2 +-
 .../diff.diff-tree_--pretty_--root_--stat_initial  |    2 +-
 ...diff.diff-tree_--root_--patch-with-stat_initial |    2 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_master  |    2 +-
 t/t4013/diff.diff-tree_-c_--stat_--summary_side    |    2 +-
 t/t4013/diff.diff-tree_-c_--stat_master            |    2 +-
 .../diff.diff_--patch-with-stat_-r_initial..side   |    2 +-
 t/t4013/diff.diff_--patch-with-stat_initial..side  |    2 +-
 t/t4013/diff.diff_--stat_initial..side             |    2 +-
 t/t4013/diff.diff_-r_--stat_initial..side          |    2 +-
 ..._--attach_--stdout_--suffix=3D.diff_initial..side |    2 +-
 ....format-patch_--attach_--stdout_initial..master |    4 +-
 ...format-patch_--attach_--stdout_initial..master^ |    2 +-
 ...ff.format-patch_--attach_--stdout_initial..side |    2 +-
 ...nline_--stdout_--numbered-files_initial..master |    4 +-
 ...tdout_--subject-prefix=3DTESTCASE_initial..master |    4 +-
 ....format-patch_--inline_--stdout_initial..master |    4 +-
 ...format-patch_--inline_--stdout_initial..master^ |    2 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    2 +-
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    2 +-
 ...at-patch_--stdout_--no-numbered_initial..master |    4 +-
 ...ormat-patch_--stdout_--numbered_initial..master |    4 +-
 t/t4013/diff.format-patch_--stdout_initial..master |    4 +-
 .../diff.format-patch_--stdout_initial..master^    |    2 +-
 t/t4013/diff.format-patch_--stdout_initial..side   |    2 +-
 ....log_--patch-with-stat_--summary_master_--_dir_ |    6 +-
 t/t4013/diff.log_--patch-with-stat_master          |    4 +-
 t/t4013/diff.log_--patch-with-stat_master_--_dir_  |    6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |    8 ++--
 ...f.log_--root_--patch-with-stat_--summary_master |    6 +-
 t/t4013/diff.log_--root_--patch-with-stat_master   |    6 +-
 ...og_--root_-c_--patch-with-stat_--summary_master |    8 ++--
 t/t4013/diff.show_--patch-with-stat_--summary_side |    2 +-
 t/t4013/diff.show_--patch-with-stat_side           |    2 +-
 t/t4013/diff.show_--stat_--summary_side            |    2 +-
 t/t4013/diff.show_--stat_side                      |    2 +-
 ...nged_--patch-with-stat_--summary_master_--_dir_ |    6 +-
 t/t4013/diff.whatchanged_--patch-with-stat_master  |    4 +-
 ...ff.whatchanged_--patch-with-stat_master_--_dir_ |    6 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |    8 ++--
 ...anged_--root_--patch-with-stat_--summary_master |    6 +-
 ...iff.whatchanged_--root_--patch-with-stat_master |    6 +-
 ...ed_--root_-c_--patch-with-stat_--summary_master |    8 ++--
 t/t4014-format-patch.sh                            |    2 +-
 t/t4030-diff-textconv.sh                           |    2 +-
 t/t4045-diff-relative.sh                           |    2 +-
 t/t4049-diff-stat-count.sh                         |    2 +-
 t/t4100/t-apply-8.expect                           |    2 +-
 t/t4100/t-apply-9.expect                           |    2 +-
 t/t5150-request-pull.sh                            |    2 +-
 t/t7602-merge-octopus-many.sh                      |    6 +-
 68 files changed, 163 insertions(+), 116 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c24dc54..389898f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -14,6 +14,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "dir.h"
+#include "diff.h"
 #include "parse-options.h"
=20
 /*
@@ -3241,7 +3242,7 @@ static void stat_patch_list(struct patch *patch)
 		show_stats(patch);
 	}
=20
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n", file=
s, adds, dels);
+	print_stat_summary(stdout, files, adds, dels);
 }
=20
 static void numstat_patch_list(struct patch *patch)
diff --git a/diff.c b/diff.c
index 7e15426..5c31b36 100644
--- a/diff.c
+++ b/diff.c
@@ -1322,6 +1322,52 @@ static void fill_print_name(struct diffstat_file=
 *file)
 	file->print_name =3D pname;
 }
=20
+int print_stat_summary(FILE *fp, int files, int insertions, int deleti=
ons)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+
+	if (!files) {
+		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
+		return fputs(_(" no changes\n"), fp);
+	}
+
+	strbuf_addf(&sb,
+		    ngettext(" %d file changed", " %d files changed",
+			     files),
+		    files);
+
+	/*
+	 * For binary diff, the caller may want to print "x files
+	 * changed" with insertions =3D=3D 0 && deletions =3D=3D 0. Not
+	 * omitting "0 insertions(+), 0 deletions(-)" in this case is
+	 * probably less confusing (i.e skip over "2 files changed but
+	 * nothing about added/removed lines? Is this a bug in
+	 * git??").
+	 */
+	if (insertions || deletions =3D=3D 0) {
+		strbuf_addf(&sb,
+			    /* TRANSLATORS: "+" in (+) is a line
+			       addition marker, do not translate it */
+			    ngettext(", %d insertion(+)", ", %d insertions(+)",
+				     insertions),
+			    insertions);
+	}
+
+	if (deletions || insertions =3D=3D 0) {
+		strbuf_addf(&sb,
+			    /* TRANSLATORS: "-" in (-) is a line
+			       removal marker, do not translate it */
+			    ngettext(", %d deletion(-)", ", %d deletions(-)",
+				     deletions),
+			    deletions);
+	}
+	strbuf_addch(&sb, '\n');
+	ret =3D fputs(sb.buf, fp);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static void show_stats(struct diffstat_t *data, struct diff_options *o=
ptions)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
@@ -1475,9 +1521,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		extra_shown =3D 1;
 	}
 	fprintf(options->file, "%s", line_prefix);
-	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels);
 }
=20
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
@@ -1507,8 +1551,7 @@ static void show_shortstats(struct diffstat_t *da=
ta, struct diff_options *option
 				options->output_prefix_data);
 		fprintf(options->file, "%s", msg->buf);
 	}
-	fprintf(options->file, " %d files changed, %d insertions(+), %d delet=
ions(-)\n",
-	       total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels);
 }
=20
 static void show_numstat(struct diffstat_t *data, struct diff_options =
*options)
diff --git a/diff.h b/diff.h
index ae71f4c..7af5f1e 100644
--- a/diff.h
+++ b/diff.h
@@ -324,4 +324,7 @@ extern struct userdiff_driver *get_textconv(struct =
diff_filespec *one);
=20
 extern int parse_rename_score(const char **cp_p);
=20
+extern int print_stat_summary(FILE *fp, int files,
+			      int insertions, int deletions);
+
 #endif /* DIFF_H */
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index aaed725..18fe27b 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -12,7 +12,7 @@ Subject: test1
=20
 ---
  foo |    1 +
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+)
  create mode 100644 foo
=20
 diff --git a/foo b/foo
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 5e29e13..9356bea 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -156,7 +156,7 @@ Updating VARIABLE..VARIABLE
 FASTFORWARD (no commit created; -m option ignored)
  example |    1 +
  hello   |    1 +
- 2 files changed, 2 insertions(+), 0 deletions(-)
+ 2 files changed, 2 insertions(+)
 EOF
=20
 test_expect_success 'git resolve' '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 5e29a05..9f00ada 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -167,7 +167,7 @@ test_expect_success TABS_IN_FILENAMES 'git diff-tre=
e delete with-funny' \
 test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat >expected <<\EOF
  "tabs\t,\" (dq) and spaces"
- 1 files changed, 0 insertions(+), 0 deletions(-)
+ 1 file changed, 0 insertions(+), 0 deletions(-)
 EOF
 '
=20
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-=
many-commits.sh
index 8e09fd0..1b3a344 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -38,13 +38,13 @@ test_expect_success 'cherry-pick first..fourth work=
s' '
 	cat <<-\EOF >expected &&
 	[master OBJID] second
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	[master OBJID] third
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	[master OBJID] fourth
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	EOF
=20
 	git checkout -f master &&
@@ -64,15 +64,15 @@ test_expect_success 'cherry-pick --strategy resolve=
 first..fourth works' '
 	Trying simple merge.
 	[master OBJID] second
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	Trying simple merge.
 	[master OBJID] third
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	Trying simple merge.
 	[master OBJID] fourth
 	 Author: A U Thor <author@example.com>
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	EOF
=20
 	git checkout -f master &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index dbe2ac1..663c60a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,7 +444,7 @@ test_expect_success 'stash show - stashes on stack,=
 stash-like argument' '
 	git reset --hard &&
 	cat >expected <<-EOF &&
 	 file |    1 +
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
 	test_cmp expected actual
@@ -482,7 +482,7 @@ test_expect_success 'stash show - no stashes on sta=
ck, stash-like argument' '
 	git reset --hard &&
 	cat >expected <<-EOF &&
 	 file |    1 +
-	 1 files changed, 1 insertions(+), 0 deletions(-)
+	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
 	test_cmp expected actual
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_ma=
ster b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
index 3a9f78a..2f8560c 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
@@ -2,7 +2,7 @@ $ git diff-tree --cc --patch-with-stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_si=
de b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
index a61ad8c..72e03c1 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
@@ -3,7 +3,7 @@ c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t=
4013/diff.diff-tree_--cc_--patch-with-stat_master
index 49f23b9..8b357d9 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
@@ -2,7 +2,7 @@ $ git diff-tree --cc --patch-with-stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t4=
013/diff.diff-tree_--cc_--stat_--summary_master
index cc6eb3b..e0568d6 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
@@ -2,5 +2,5 @@ $ git diff-tree --cc --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side b/t/t401=
3/diff.diff-tree_--cc_--stat_--summary_side
index 50362be..5afc823 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
@@ -3,6 +3,6 @@ c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.d=
iff-tree_--cc_--stat_master
index fae7f33..f48367a 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_master
@@ -2,5 +2,5 @@ $ git diff-tree --cc --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-w=
ith-stat_initial b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--p=
atch-with-stat_initial
index d5c333a..590864c 100644
--- a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
+++ b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
@@ -3,7 +3,7 @@ $ git diff-tree --pretty=3Doneline --root --patch-with-=
stat initial
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 new file mode 100644
diff --git a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side b/t=
/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
index 4d30e7e..e05e778 100644
--- a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
+++ b/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_i=
nitial b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initi=
al
index 7dfa6af..0e2c956 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 new file mode 100644
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_in=
itial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
index 43bfce2..384fa44 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial b/t/=
t4013/diff.diff-tree_--pretty_--root_--stat_initial
index 9154aa4..10384a8 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
@@ -8,5 +8,5 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial b/=
t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
index 1562b62..f57062e 100644
--- a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
@@ -3,7 +3,7 @@ $ git diff-tree --root --patch-with-stat initial
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 new file mode 100644
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t401=
3/diff.diff-tree_-c_--stat_--summary_master
index ac9f641..7088683 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_master
@@ -2,5 +2,5 @@ $ git diff-tree -c --stat --summary master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_side b/t/t4013/=
diff.diff-tree_-c_--stat_--summary_side
index 2afcca1..ef216ab 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_side
@@ -3,6 +3,6 @@ c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.dif=
f-tree_-c_--stat_master
index c2fe6a9..ad19f10 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_master
@@ -2,5 +2,5 @@ $ git diff-tree -c --stat master
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side b/t/t=
4013/diff.diff_--patch-with-stat_-r_initial..side
index 9ed317a..ddad917 100644
--- a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
@@ -2,7 +2,7 @@ $ git diff --patch-with-stat -r initial..side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.diff_--patch-with-stat_initial..side b/t/t401=
3/diff.diff_--patch-with-stat_initial..side
index 8b50629..bdbd114 100644
--- a/t/t4013/diff.diff_--patch-with-stat_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_initial..side
@@ -2,7 +2,7 @@ $ git diff --patch-with-stat initial..side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.diff_--stat_initial..side b/t/t4013/diff.diff=
_--stat_initial..side
index 0517b5d..6d08f3d 100644
--- a/t/t4013/diff.diff_--stat_initial..side
+++ b/t/t4013/diff.diff_--stat_initial..side
@@ -2,5 +2,5 @@ $ git diff --stat initial..side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.diff_-r_--stat_initial..side b/t/t4013/diff.d=
iff_-r_--stat_initial..side
index 245220d..2ddb254 100644
--- a/t/t4013/diff.diff_-r_--stat_initial..side
+++ b/t/t4013/diff.diff_-r_--stat_initial..side
@@ -2,5 +2,5 @@ $ git diff -r --stat initial..side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.di=
ff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=
=3D.diff_initial..side
index 52116d3..3cab049 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
@@ -15,7 +15,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index ce49bd6..564a4d3 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
@@ -124,7 +124,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 5f1b238..4f28460 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side =
b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 4a2364a..b10cc2e 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -15,7 +15,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-fil=
es_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numb=
ered-files_initial..master
index 43b81eb..a976a8a 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
@@ -124,7 +124,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-pref=
ix=3DTESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--st=
dout_--subject-prefix=3DTESTCASE_initial..master
index ca3f60b..b4fd664 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
@@ -124,7 +124,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 08f2301..0d31036 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
@@ -124,7 +124,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index 07f1230..18d4714 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -75,7 +75,7 @@ Content-Transfer-Encoding: 8bit
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side =
b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index 67633d4..3572f20 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -15,7 +15,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initi=
al..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_init=
ial..master^
index 3b4e113..54cdcda 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
@@ -75,7 +75,7 @@ Subject: [DIFFERENT_PREFIX 2/2] Third
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..=
master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..mast=
er
index f7752eb..23194eb 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
@@ -53,7 +53,7 @@ Subject: [PATCH] Third
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -88,7 +88,7 @@ Subject: [PATCH] Side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..mas=
ter b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
index 8e67dbf..78f1a80 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
@@ -53,7 +53,7 @@ Subject: [PATCH 2/3] Third
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -88,7 +88,7 @@ Subject: [PATCH 3/3] Side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t40=
13/diff.format-patch_--stdout_initial..master
index 7b89978..a3dab7f 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..master
@@ -53,7 +53,7 @@ Subject: [PATCH 2/3] Third
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -88,7 +88,7 @@ Subject: [PATCH 3/3] Side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4=
013/diff.format-patch_--stdout_initial..master^
index b7f9725..39f4a3f 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..master^
@@ -53,7 +53,7 @@ Subject: [PATCH 2/2] Third
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013=
/diff.format-patch_--stdout_initial..side
index e765088..8810920 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--stdout_initial..side
@@ -8,7 +8,7 @@ Subject: [PATCH] Side
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir=
_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index bd7f5c0..4085bbd 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -13,7 +13,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
     Side
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -32,7 +32,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
     Third
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -54,7 +54,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     This is the second commit.
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.l=
og_--patch-with-stat_master
index 14595a6..4586279 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -15,7 +15,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -56,7 +56,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t401=
3/diff.log_--patch-with-stat_master_--_dir_
index 5a4e727..6e172cf 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -13,7 +13,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
     Side
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -32,7 +32,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
     Third
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -54,7 +54,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     This is the second commit.
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_m=
aster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index df0aaa9..48b0d4b 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
 index cead32e,7289e35..992913c
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -89,7 +89,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -165,7 +165,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master=
 b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index c11b5f2c..f9dc512 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -15,7 +15,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -57,7 +57,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -133,7 +133,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013=
/diff.log_--root_--patch-with-stat_master
index 5f0c98f..0807ece 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -15,7 +15,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -56,7 +56,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -130,7 +130,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 new file mode 100644
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index e62c368..84f5ef6 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --combined dir/sub
 index cead32e,7289e35..992913c
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -89,7 +89,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -165,7 +165,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.show_--patch-with-stat_--summary_side b/t/t40=
13/diff.show_--patch-with-stat_--summary_side
index 377f2b7..e60384d 100644
--- a/t/t4013/diff.show_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.show_--patch-with-stat_--summary_side
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.show_--patch-with-stat_side b/t/t4013/diff.sh=
ow_--patch-with-stat_side
index fb14c53..a3a3255 100644
--- a/t/t4013/diff.show_--patch-with-stat_side
+++ b/t/t4013/diff.show_--patch-with-stat_side
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.show_--stat_--summary_side b/t/t4013/diff.sho=
w_--stat_--summary_side
index 5bd5977..d16f464 100644
--- a/t/t4013/diff.show_--stat_--summary_side
+++ b/t/t4013/diff.show_--stat_--summary_side
@@ -8,6 +8,6 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.show_--stat_side b/t/t4013/diff.show_--stat_s=
ide
index 3b22327..6300c05 100644
--- a/t/t4013/diff.show_--stat_side
+++ b/t/t4013/diff.show_--stat_side
@@ -8,5 +8,5 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_maste=
r_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master=
_--_dir_
index 6a467cc..16ae543 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_di=
r_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_di=
r_
@@ -6,7 +6,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
     Side
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -25,7 +25,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
     Third
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     This is the second commit.
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t401=
3/diff.whatchanged_--patch-with-stat_master
index 1e1bbe1..f3e45ec 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -49,7 +49,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_ =
b/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
index 13789f1..c77f0bc 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
@@ -6,7 +6,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
     Side
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -25,7 +25,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
     Third
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     This is the second commit.
 ---
  dir/sub |    2 ++
- 1 files changed, 2 insertions(+), 0 deletions(-)
+ 1 file changed, 2 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--s=
ummary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_=
--summary_master
index e96ff1f..8d03efe 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --cc dir/sub
 index cead32e,7289e35..992913c
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -89,7 +89,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -165,7 +165,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summar=
y_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_=
master
index 0291153..1874d06 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -50,7 +50,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -126,7 +126,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b=
/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
index 9b0349c..5211ff2 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
@@ -49,7 +49,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -123,7 +123,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
 new file mode 100644
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--sum=
mary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--su=
mmary_master
index c0aff68..ad30245 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
@@ -8,7 +8,7 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
=20
  dir/sub |    2 ++
  file0   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
=20
 diff --combined dir/sub
 index cead32e,7289e35..992913c
@@ -47,7 +47,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file3   |    4 ++++
- 3 files changed, 9 insertions(+), 0 deletions(-)
+ 3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
 diff --git a/dir/sub b/dir/sub
@@ -89,7 +89,7 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
 ---
  dir/sub |    2 ++
  file1   |    3 +++
- 2 files changed, 5 insertions(+), 0 deletions(-)
+ 2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
 diff --git a/dir/sub b/dir/sub
@@ -165,7 +165,7 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
  dir/sub |    2 ++
  file0   |    3 +++
  file2   |    3 +++
- 3 files changed, 8 insertions(+), 0 deletions(-)
+ 3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
  create mode 100644 file2
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6797512..7dfe716 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -520,7 +520,7 @@ test_expect_success 'shortlog of cover-letter wraps=
 overly-long onelines' '
 cat > expect << EOF
 ---
  file |   16 ++++++++++++++++
- 1 files changed, 16 insertions(+), 0 deletions(-)
+ 1 file changed, 16 insertions(+)
=20
 diff --git a/file b/file
 index 40f36c6..2dc5c23 100644
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 88c5619..4ac162c 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -86,7 +86,7 @@ test_expect_success 'status -v produces text' '
=20
 cat >expect.stat <<'EOF'
  file |  Bin 2 -> 4 bytes
- 1 files changed, 0 insertions(+), 0 deletions(-)
+ 1 file changed, 0 insertions(+), 0 deletions(-)
 EOF
 test_expect_success 'diffstat does not run textconv' '
 	echo file diff=3Dfail >.gitattributes &&
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 8a3c63b..bd119be 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -33,7 +33,7 @@ check_stat() {
 expect=3D$1; shift
 cat >expected <<EOF
  $expect |    1 +
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+)
 EOF
 test_expect_success "--stat $*" "
 	git diff --stat $* HEAD^ >actual &&
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 641e70d..a6d1887 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -16,7 +16,7 @@ test_expect_success setup '
 	cat >expect <<-\EOF
 	 a |    1 +
 	 b |    1 +
-	 2 files changed, 2 insertions(+), 0 deletions(-)
+	 2 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=3D2 >actual &&
 	test_cmp expect actual
diff --git a/t/t4100/t-apply-8.expect b/t/t4100/t-apply-8.expect
index eef7f2e..55a55c3 100644
--- a/t/t4100/t-apply-8.expect
+++ b/t/t4100/t-apply-8.expect
@@ -1,2 +1,2 @@
  t/t4100-apply-stat.sh |    2 +-
- 1 files changed, 1 insertions(+), 1 deletions(-)
+ 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/t/t4100/t-apply-9.expect b/t/t4100/t-apply-9.expect
index eef7f2e..55a55c3 100644
--- a/t/t4100/t-apply-9.expect
+++ b/t/t4100/t-apply-9.expect
@@ -1,2 +1,2 @@
  t/t4100-apply-stat.sh |    2 +-
- 1 files changed, 1 insertions(+), 1 deletions(-)
+ 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index da25bc2..34c482f 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -95,7 +95,7 @@ test_expect_success 'setup: two scripts for reading p=
ull requests' '
 	b
 	: diffstat
 	n
-	/ [0-9]* files changed/ {
+	/ [0-9]* files\? changed/ {
 		a\\
 	DIFFSTAT
 		b
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many=
=2Esh
index 61f36ba..5783ebf 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -57,7 +57,7 @@ Merge made by the 'octopus' strategy.
  c2.c |    1 +
  c3.c |    1 +
  c4.c |    1 +
- 3 files changed, 3 insertions(+), 0 deletions(-)
+ 3 files changed, 3 insertions(+)
  create mode 100644 c2.c
  create mode 100644 c3.c
  create mode 100644 c4.c
@@ -74,7 +74,7 @@ Already up-to-date with c4
 Trying simple merge with c5
 Merge made by the 'octopus' strategy.
  c5.c |    1 +
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+)
  create mode 100644 c5.c
 EOF
=20
@@ -89,7 +89,7 @@ Trying simple merge with c2
 Merge made by the 'octopus' strategy.
  c1.c |    1 +
  c2.c |    1 +
- 2 files changed, 2 insertions(+), 0 deletions(-)
+ 2 files changed, 2 insertions(+)
  create mode 100644 c1.c
  create mode 100644 c2.c
 EOF
--=20
1.7.8.36.g69ee2

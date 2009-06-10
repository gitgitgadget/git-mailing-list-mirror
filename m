From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Wed, 10 Jun 2009 20:28:35 +1000
Message-ID: <1244629715-30444-1-git-send-email-pclouds@gmail.com>
References: <4A2E576D.704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 12:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEL3E-0002b0-Fe
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 12:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbZFJK2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 06:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZFJK2t
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 06:28:49 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:52849 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZFJK2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 06:28:48 -0400
Received: by pzk1 with SMTP id 1so684432pzk.33
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mm+oCauJWbuophtecrxFd21vDMHP2yTCDtI2O1FXNcY=;
        b=c0oOXY96vu2HtqFBfLXmiO8qnqz3QGNXx9haF/lGySAS8JpcNEbjz5xAK+bi1lbV/m
         DrO9AKWv0x4D9T1sQO/ZYW9tIy7VLAoVcvv9352qrwF3w3eEIqrWksBZjtIUMI6x1pxn
         aXcU/flA1UCm9WSgtctK1XZEaVb8GwWjxF9ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PjYrKs3ADP8ghrIX/I+gkXh0NiY3uUrI5Ql02nlcoIm7YPGT8I5gvkfXZ7WY57rk3F
         XEFE0282A81bUpHKOpTqRNzj1Ncudp7XrSvyRGQgd3L8pidfRp6kGfri83S2hTVgd8U6
         M8kv7poCNvRkCZDKwAL11/emYWe2L1TdiT+B8=
Received: by 10.114.182.1 with SMTP id e1mr1825781waf.141.1244629730542;
        Wed, 10 Jun 2009 03:28:50 -0700 (PDT)
Received: from dektop ([123.200.253.107])
        by mx.google.com with ESMTPS id d20sm8727820waa.12.2009.06.10.03.28.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 03:28:49 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 10 Jun 2009 20:28:37 +1000
X-Mailer: git-send-email 1.6.3.2.318.g2fd57
In-Reply-To: <4A2E576D.704@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121268>

I use git to manage patches in my Gentoo development. In Gentoo, all
ebuilds (another form of RPM spec) corresponding to different versions
of the same package are grouped into one directory. So patches for
each version usually have a prefix to separate them from ones for
other versions. With --filename-prefix it comes handy to produce such
patches, for example:

git format-patch --filename-prefix dbus-1.2.3- HEAD~5

will generate patches for dbus-1.2.3 for me, all starting with "dbus-1.=
2.3-".

This might be handy for RPM developers as well.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Renamed --prefix to --filename-prefix

 Documentation/git-format-patch.txt                 |    6 ++-
 builtin-log.c                                      |    9 ++-
 log-tree.c                                         |   10 ++-
 log-tree.h                                         |    4 +-
 revision.h                                         |    1 +
 t/t4013-diff-various.sh                            |    1 +
 ...h_--stdout_--filename-prefix=3Dfoo-_initial..side |   61 ++++++++++=
++++++++++
 7 files changed, 83 insertions(+), 9 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--attach_--stdout_--filen=
ame-prefix=3Dfoo-_initial..side

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 6f1fc80..30815bc 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 		   [-s | --signoff]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=3DMessage-Id] [--suffix=3D.<sfx>]
+		   [--in-reply-to=3DMessage-Id]
+		   [--filename-prefix=3D<pfx>] [--suffix=3D.<sfx>]
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=3DSubject-Prefix]
 		   [--cc=3D<email>]
@@ -168,6 +169,9 @@ if that is not set.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
=20
+--filename-prefix=3D.<pfx>::
+	Prepend specified prefix in front of generated filenames.
+
 --suffix=3D.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin-log.c b/builtin-log.c
index 0d34050..d458753 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -419,6 +419,7 @@ int cmd_log(int argc, const char **argv, const char=
 *prefix)
=20
 /* format-patch */
=20
+static const char *fmt_patch_prefix =3D "";
 static const char *fmt_patch_suffix =3D ".patch";
 static int numbered =3D 0;
 static int auto_number =3D 1;
@@ -524,18 +525,19 @@ static int outdir_offset;
 static int reopen_stdout(struct commit *commit, struct rev_info *rev)
 {
 	struct strbuf filename =3D STRBUF_INIT;
+	int prefix_len =3D strlen(fmt_patch_prefix);
 	int suffix_len =3D strlen(fmt_patch_suffix) + 1;
=20
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
 		if (filename.len >=3D
-		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
+		    PATH_MAX - FORMAT_PATCH_NAME_MAX - prefix_len - suffix_len)
 			return error("name of output directory is too long");
 		if (filename.buf[filename.len - 1] !=3D '/')
 			strbuf_addch(&filename, '/');
 	}
=20
-	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
+	get_patch_filename(commit, rev->nr, fmt_patch_prefix, fmt_patch_suffi=
x, &filename);
=20
 	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
@@ -877,6 +879,8 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			    "generate a cover letter"),
 		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
 			    "use simple number sequence for output file names"),
+		OPT_STRING(0, "filename-prefix", &fmt_patch_prefix, "pfx",
+			    "prepend <pfx> to output file names"),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, "sfx",
 			    "use <sfx> instead of '.patch'"),
 		OPT_INTEGER(0, "start-number", &start_number,
@@ -1093,6 +1097,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		string_list_append(msgid, rev.ref_message_ids);
 	}
 	rev.numbered_files =3D numbered_files;
+	rev.patch_prefix =3D fmt_patch_prefix;
 	rev.patch_suffix =3D fmt_patch_suffix;
 	if (cover_letter) {
 		if (thread)
diff --git a/log-tree.c b/log-tree.c
index 59d63eb..139c8b5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -180,12 +180,13 @@ static int has_non_ascii(const char *s)
 	return 0;
 }
=20
-void get_patch_filename(struct commit *commit, int nr, const char *suf=
fix,
-			struct strbuf *buf)
+void get_patch_filename(struct commit *commit, int nr, const char *pre=
fix,
+			const char *suffix, struct strbuf *buf)
 {
 	int suffix_len =3D strlen(suffix) + 1;
-	int start_len =3D buf->len;
+	int start_len =3D buf->len + strlen(prefix);
=20
+	strbuf_addstr(buf, prefix);
 	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
 	if (commit) {
 		int max_len =3D start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
@@ -263,7 +264,8 @@ void log_write_email_headers(struct rev_info *opt, =
struct commit *commit,
 		extra_headers =3D subject_buffer;
=20
 		get_patch_filename(opt->numbered_files ? NULL : commit, opt->nr,
-				    opt->patch_suffix, &filename);
+				    opt->patch_prefix, opt->patch_suffix,
+				    &filename);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
diff --git a/log-tree.h b/log-tree.h
index 20b5caf..566c85d 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -20,7 +20,7 @@ void log_write_email_headers(struct rev_info *opt, st=
ruct commit *commit,
 void load_ref_decorations(void);
=20
 #define FORMAT_PATCH_NAME_MAX 64
-void get_patch_filename(struct commit *commit, int nr, const char *suf=
fix,
-			struct strbuf *buf);
+void get_patch_filename(struct commit *commit, int nr, const char *pre=
fix,
+			const char *suffix, struct strbuf *buf);
=20
 #endif
diff --git a/revision.h b/revision.h
index 227164c..b35c038 100644
--- a/revision.h
+++ b/revision.h
@@ -85,6 +85,7 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	const char	*patch_prefix;
 	const char	*patch_suffix;
 	int		numbered_files;
 	char		*message_id;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8b33321..cf16c0a 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -246,6 +246,7 @@ format-patch --stdout initial..master
 format-patch --stdout --no-numbered initial..master
 format-patch --stdout --numbered initial..master
 format-patch --attach --stdout initial..side
+format-patch --attach --stdout --filename-prefix=3Dfoo- initial..side
 format-patch --attach --stdout --suffix=3D.diff initial..side
 format-patch --attach --stdout initial..master^
 format-patch --attach --stdout initial..master
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--filename-pre=
fix=3Dfoo-_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_=
--filename-prefix=3Dfoo-_initial..side
new file mode 100644
index 0000000..72127eb
--- /dev/null
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--filename-prefix=3Df=
oo-_initial..side
@@ -0,0 +1,61 @@
+$ git format-patch --attach --stdout --filename-prefix=3Dfoo- initial.=
=2Eside
+From c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:03:00 +0000
+Subject: [PATCH] Side
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary=3D"------------g-i-t--v-e-r-s-=
i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=3DUTF-8; format=3Dfixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file3   |    4 ++++
+ 3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name=3D"foo-0001-Side.patch"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: attachment; filename=3D"foo-0001-Side.patch"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
--=20
1.6.3.2.318.g2fd57

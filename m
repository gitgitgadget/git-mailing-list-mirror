From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Sun, 14 Jun 2009 17:10:00 +1000
Message-ID: <1244963400-1739-1-git-send-email-pclouds@gmail.com>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Jun 14 09:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFjrT-0002J7-12
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 09:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbZFNHKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 03:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZFNHKZ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 03:10:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:18001 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbZFNHKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 03:10:20 -0400
Received: by wa-out-1112.google.com with SMTP id j5so622988wah.21
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GcnmKsB03pC3FEjTvcwH/eaQYWxA0FJFBQjq6+kOOQw=;
        b=o/H08Sp0QwXYlP5LovykXaYGhjQPiL1sD1Nz4kD7vbXYeou45RYba6mTjmLfIfljl7
         +GgJKrkSzWzksoM5lWJdUj1sRMzWYHkR5+o9s5VJbpeD3TqDdjI6VnD/sLLyYJg+XVFE
         5Z32WVzaKR3SstzsDNfGn+qmT4TUPO6U8QaCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wjwIIVVvD06ym4VYPf+psxSZqyA11TOD2ldkLHKvmaGcVB//TwjIxYwH2BDxBDooGo
         Cv0MKsN3KNPRvBMIpPPe1KW0Nzq3iO6ESaeKoX48G62XiVPqEy+tW4YBx6lBDMDxYpmF
         MzGd8Ba289GAlpueuIwHnRuznNdK62SzmPylY=
Received: by 10.114.202.15 with SMTP id z15mr9318454waf.67.1244963422880;
        Sun, 14 Jun 2009 00:10:22 -0700 (PDT)
Received: from dektop ([121.91.203.177])
        by mx.google.com with ESMTPS id m30sm3884107wag.18.2009.06.14.00.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 00:10:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun, 14 Jun 2009 17:10:02 +1000
X-Mailer: git-send-email 1.6.3.2.318.g2fd57
In-Reply-To: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121539>

In Linux packaging, patches are usually saved along with the "package
spec" (to suit distro specific needs or just to back port some
fixes). Those patches are usually prefixed with either the package
name, or package version for various reasons. With --filename-prefix
it comes handy to produce such patches, for example:

git format-patch --filename-prefix dbus-1.2.3- HEAD~5

will generate patches for dbus-1.2.3 for me, all starting with "dbus-1.=
2.3-".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Wed, Jun 10, 2009 at 08:58:01AM -0700, Junio C Hamano wrote:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
 >=20
 > > I use git to manage patches in my Gentoo development. In Gentoo, a=
ll
 > > ebuilds (another form of RPM spec) corresponding to different vers=
ions
 > > of the same package are grouped into one directory. So patches for
 > > each version usually have a prefix to separate them from ones for
 > > other versions. With --filename-prefix it comes handy to produce s=
uch
 > > patches, for example:
 > >
 > > git format-patch --filename-prefix dbus-1.2.3- HEAD~5
 > >
 > > will generate patches for dbus-1.2.3 for me, all starting with "db=
us-1.2.3-".
 > >
 > > This might be handy for RPM developers as well.
 >=20
 > If this patch needs another round, I would prefer seeing the explana=
tion
 > done in a different order.  When a busy person who is uninterested i=
n
 > Gentoo starts reading the above paragraph, the patch will (incorrect=
ly) be
 > dismissed with an "Ah, Gentoo specific feature?  Not interesting." a=
fter
 > reading the first two lines.  I.e. "Add X that does Y.  This is usef=
ul in
 > such and such situations because ...".

 Done

 >=20
 > > +--filename-prefix=3D.<pfx>::
 > > +	Prepend specified prefix in front of generated filenames.
 >=20
 > Hmm... ;-)
 >=20
 > What happens when I feed a path with a slash in it with --filename-p=
refix?
 > We will fail in open/creat if the leading path does not exist?
 >=20
 > I am not saying we must allow a slash in the prefix and create neces=
sary
 > leading paths ourselves, nor we must check for a slash and fail in t=
he
 > input validation phase, but I am wondering if we can have some cleve=
r way
 > to internally unify the handling of this new option with --outdir.

 Hardly, the way it is handled now (chdir()ing to --outdir, then write =
patches)

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
index 6f1fc80..052a3b8 100644
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
+--filename-prefix=3D<pfx>::
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

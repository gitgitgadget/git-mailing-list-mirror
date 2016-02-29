From: Saurav Sachidanand <sauravsachidanand@gmail.com>
Subject: [PATCH v2] Change type of signed int flags to unsigned
Date: Mon, 29 Feb 2016 19:34:27 +0530
Message-ID: <1456754667-9462-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 15:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaORR-0004Ts-BC
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 15:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbcB2OEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 09:04:49 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32861 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcB2OEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 09:04:47 -0500
Received: by mail-pa0-f66.google.com with SMTP id y7so8695795paa.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 06:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3eEtt8URD1nQlRQI+c6FWgFX47YPBUugv5ZRWKmCB0=;
        b=oVnTo9M47Tz2/o4k3sK+z/+aXG38YkOY8/YeKZw35V5qHFFx+f/oRTFauPfGbH2Vp8
         2Z5jt+UcjPx8Cbx/2py2z6dLsABbRwcQXwfkAN+QzhP/Sq4Vw/Sm6jrRy0PpCqvx4gbW
         3rIE/Y7dAo8n0hmL92gpixo68xH1kwNIeNYGhJvgLuQM5TqbLZquJbVUqRqbn1qOs7W+
         vJO4hGsKf9G0t+U+O08FSdv0tfBsiIqiB2xff5aKh8o00IJfbeldVYHksxwJRuq5R/IJ
         zje0mEPXhtpkCQlbKLCfxgTc1cAEB9J8148wsm4b/9reS19ITBhpyxNqbK6dSh/1tnI9
         dPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3eEtt8URD1nQlRQI+c6FWgFX47YPBUugv5ZRWKmCB0=;
        b=MKHonNSKmP8bvp9RQYl5m0vipYROilBsejQS67SBsh2Q5yMJ59xZIoaI7bDtTmZuvd
         yaAC/fGrP+Yl6swe/uGEdMLPN0BdGS6EaYaA+vpiqYLiCxrLZ/4t47F1NYiD3+hdtUfi
         Lf6TU6/xRbTk6vEqg4BLHucQrrdOfwnd6m297FyykH6GQ9DvAZ686k+Rnfw0+KOw1D/H
         UmVf0PZTKhVvCgU4DiGIhIehjEPUKJ4t/vclncprHDq0DiEnYmEIhnm8SkQuA9vYQA3f
         2jRXTm4orhdc/Ng/Dft8fy/nUFKwDgrdYqkiMlSwNly754a6RbYiIRWVj04ih2uW9yHZ
         l0ew==
X-Gm-Message-State: AD7BkJKQkJlnfTQfdm30ryUp6MOdO2MF2vzSZYbgmFwML3EG9WO7XbRlWv/f1rXP9mXDtw==
X-Received: by 10.66.190.168 with SMTP id gr8mr22577634pac.23.1456754687121;
        Mon, 29 Feb 2016 06:04:47 -0800 (PST)
Received: from localhost.localdomain ([106.51.19.158])
        by smtp.googlemail.com with ESMTPSA id u84sm38488704pfa.57.2016.02.29.06.04.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 06:04:46 -0800 (PST)
X-Mailer: git-send-email 2.7.1.339.g0233b80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287838>

=E2=80=9Cpattern=E2=80=9D and =E2=80=9Cexclude=E2=80=9D are two structs=
 defined in attr.c and dir.h
respectively. Each contain a =E2=80=9Cflags=E2=80=9D field of type int =
that takes on
values from the set of positive integers {1, 4, 8, 16}, that are
enumerated through the macro EXC_FLAG_*.

That the most significant bit (used to store the sign) of these two
fields is not used in any special way is observed from the fact that
the "flags" fields (accessed within attr.c, dir.c, and
builtin/check-ignore.c) are either checked for their values using the
& operator (e.g.: flags & EXC_FLAG_NODIR), or assigned a value of 0
first and then assigned any one of {1, 4, 8, 16} using the | operator
(e.g.: flags |=3D EXC_FLAG_NODIR). Hence, change the type of "flags"
to unsigned in both structs.

=46urthermore, =E2=80=9Cflags=E2=80=9D of both structs is passed by val=
ue or by reference
to the functions parse_exclude_pattern, match_basename and
match_pathname (declared in dir.h), that have an =E2=80=9Cint=E2=80=9D =
or =E2=80=9Cint *=E2=80=9D type
for "flags" in their signatures. To avoid implicit conversion to types,
or pointers to types, of different sign, change the type for =E2=80=9Cf=
lags=E2=80=9D to
=E2=80=9Cunsigned=E2=80=9D and =E2=80=9Cunsigned *=E2=80=9D in the resp=
ective function signatures.

And while we=E2=80=99re at it, document the "flags" field of "exclude" =
to
explicitly state the values it=E2=80=99s supposed to take on.

Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
---

This patch is for the suggested microproject for GSoC 2016 titled
"Use unsigned integral type for collection of bits." It is the third
patch for this project (technically second, considering only the
subject of the email) that incorporates changes to the commit message
suggested by Moritz Neeb and Eric Sunshine, and to some function
signatures suggested by Duy Nguyen. Thanks to them for their feedback.

 attr.c | 2 +-
 dir.c  | 8 ++++----
 dir.h  | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 086c08d..679e13c 100644
--- a/attr.c
+++ b/attr.c
@@ -124,7 +124,7 @@ struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	int flags;		/* EXC_FLAG_* */
+	unsigned flags;		/* EXC_FLAG_* */
 };

 /*
diff --git a/dir.c b/dir.c
index 552af23..82cec7d 100644
--- a/dir.c
+++ b/dir.c
@@ -459,7 +459,7 @@ int no_wildcard(const char *string)

 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
-			   int *flags,
+			   unsigned *flags,
 			   int *nowildcardlen)
 {
 	const char *p =3D *pattern;
@@ -500,7 +500,7 @@ void add_exclude(const char *string, const char *ba=
se,
 {
 	struct exclude *x;
 	int patternlen;
-	int flags;
+	unsigned flags;
 	int nowildcardlen;

 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
@@ -811,7 +811,7 @@ void add_excludes_from_file(struct dir_struct *dir,=
 const char *fname)

 int match_basename(const char *basename, int basenamelen,
 		   const char *pattern, int prefix, int patternlen,
-		   int flags)
+		   unsigned flags)
 {
 	if (prefix =3D=3D patternlen) {
 		if (patternlen =3D=3D basenamelen &&
@@ -836,7 +836,7 @@ int match_basename(const char *basename, int basena=
melen,
 int match_pathname(const char *pathname, int pathlen,
 		   const char *base, int baselen,
 		   const char *pattern, int prefix, int patternlen,
-		   int flags)
+		   unsigned flags)
 {
 	const char *name;
 	int namelen;
diff --git a/dir.h b/dir.h
index 3ec3fb0..e942b50 100644
--- a/dir.h
+++ b/dir.h
@@ -28,7 +28,7 @@ struct exclude {
 	int nowildcardlen;
 	const char *base;
 	int baselen;
-	int flags;
+	unsigned flags;		/* EXC_FLAG_* */

 	/*
 	 * Counting starts from 1 for line numbers in ignore files,
@@ -229,10 +229,10 @@ struct dir_entry *dir_add_ignored(struct dir_stru=
ct *dir, const char *pathname,
  * attr.c:path_matches()
  */
 extern int match_basename(const char *, int,
-			  const char *, int, int, int);
+			  const char *, int, int, unsigned);
 extern int match_pathname(const char *, int,
 			  const char *, int,
-			  const char *, int, int, int);
+			  const char *, int, int, unsigned);

 extern struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     const char *name, int *dtype);
@@ -244,7 +244,7 @@ extern struct exclude_list *add_exclude_list(struct=
 dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string, int *patternlen=
, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--
2.7.1.339.g0233b80

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 19:52:25 +0700
Message-ID: <1456145545-5374-3-git-send-email-pclouds@gmail.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 13:52:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXpyK-000666-NH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 13:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbcBVMwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 07:52:12 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35344 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbcBVMwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 07:52:10 -0500
Received: by mail-pf0-f179.google.com with SMTP id c10so95521978pfc.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 04:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8INcvhYrHNrAN4m/DzuaKZEJKy39eCSB/X4SuHbUZWQ=;
        b=BY7amW49zUYXtyeSZ0GmND/3NDQf5XGJ/Nbr3jkgwJPkzMDcB19N55Qe5Ume9Hny0D
         xUgBrs+OSdDKcVOPEebRpBoogPFXEIfG9YA4zTDEXFHUbF9nY3NrILtYE8f/xeswF8ci
         pgKKa9hSIvGPhNHv4S60uU4eSPc4Pz72m7NJDDpM+avlpeu9HIlzNjfllA94NRLJGnYD
         00rKlXaItTzE0xZ+U/vtGUXdDgBl0c6j5zjp5J/SNK2Qu0LsEQ53fH8m7/TpNf0PhqWD
         B0nhfme+m0iQLtFqs1ldMrjD+6x2RMH8vvQm5NdOZrPexqNtIw8sojUYI7E8vP6FB0oL
         gCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=8INcvhYrHNrAN4m/DzuaKZEJKy39eCSB/X4SuHbUZWQ=;
        b=HwdOICNjlh+eS7OVV2vZTWt47mxKj6vyxNb8sPlhvB6HSS9BTKy9GqwNduqrFXQseV
         9g5eC98Bi+c19MmxDJeyw6exX8JfUrqoojN78RNh+W3ojQmzmDXhLJK6e5NTOjw93fFg
         eSu2fdVyEbsopeUCMVljzrDhsdhAT2lCzVrL+M0sXiyXhcN2HX/JxE0kU5N16jJzxFdp
         xaQ1m4ZZPKFIaYJM3wn7URwlJ3S+rDoFUVN4tKLdMFLaYiju6zssB8oCbIjL6eyXhhS2
         eFexAFQE+5aUJ7JuX2ONuVcryiYFClZatTdBY44vZCgXNuiZZV2y9D8XJbDsjhI48H6S
         e7Mw==
X-Gm-Message-State: AG10YORcaHxswK8Knj4PRHzYN4C6wPzRVS2I3+/jqYuphhNG1xt9zmEdRfvNxG9LQuSrzw==
X-Received: by 10.98.19.205 with SMTP id 74mr37851897pft.31.1456145530018;
        Mon, 22 Feb 2016 04:52:10 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o73sm36846148pfa.37.2016.02.22.04.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 04:52:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 22 Feb 2016 19:52:39 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286928>

fill_textconv() have four code paths to return a new buffer. Two of
them, run_textconv() and notes_cache_get(), return a newly allocated
buffer. The other two return either a constant string or an existing
buffer (mmfile_t). We can only free the result buffer if it's allocated
by fill_textconv(). Correct all call sites.

Changes in combine-diff.c are not clear from diff output. We need to
force not running fill_textconv() unless the function returns a new
buffer so that it falls to the "else" case and allocates a new buffer
with no conversion.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Frankly I don't like the way fill_textconv() returns buffer at all.
 But I don't know much about textconv, or want to spend more time on
 it. This patch can be dropped if people come up with a better one.

 builtin/blame.c    | 2 +-
 combine-diff.c     | 4 ++--
 diff.c             | 8 ++++----
 diffcore-pickaxe.c | 5 +++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cb6f2fb..b5477ad 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -166,7 +166,7 @@ int textconv_object(const char *path,
 	df =3D alloc_filespec(path);
 	fill_filespec(df, sha1, sha1_valid, mode);
 	textconv =3D get_textconv(df);
-	if (!textconv) {
+	if (!textconv || !textconv->textconv) {
 		free_filespec(df);
 		return 0;
 	}
diff --git a/combine-diff.c b/combine-diff.c
index 5571304..c57cefd 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -299,7 +299,7 @@ static char *grab_blob(const struct object_id *oid,=
 unsigned int mode,
 		/* deleted blob */
 		*size =3D 0;
 		return xcalloc(1, 1);
-	} else if (textconv) {
+	} else if (textconv && textconv->textconv) {
 		struct diff_filespec *df =3D alloc_filespec(path);
 		fill_filespec(df, oid->hash, 1, mode);
 		*size =3D fill_textconv(textconv, df, &blob);
@@ -1022,7 +1022,7 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			else
 				result =3D grab_blob(&oid, elem->mode,
 						   &result_size, NULL, NULL);
-		} else if (textconv) {
+		} else if (textconv && textconv->textconv) {
 			struct diff_filespec *df =3D alloc_filespec(elem->path);
 			fill_filespec(df, null_sha1, 0, st.st_mode);
 			result_size =3D fill_textconv(textconv, df, &result);
diff --git a/diff.c b/diff.c
index 5bdc3c0..173ec5b 100644
--- a/diff.c
+++ b/diff.c
@@ -744,9 +744,9 @@ static void emit_rewrite_diff(const char *name_a,
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
 		emit_rewrite_lines(&ecbdata, '+', data_two, size_two);
-	if (textconv_one)
+	if (textconv_one && textconv_one->textconv)
 		free((char *)data_one);
-	if (textconv_two)
+	if (textconv_two && textconv_two->textconv)
 		free((char *)data_two);
 }
=20
@@ -2454,9 +2454,9 @@ static void builtin_diff(const char *name_a,
 			die("unable to generate diff for %s", one->path);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
-		if (textconv_one)
+		if (textconv_one && textconv_one->textconv)
 			free(mf1.ptr);
-		if (textconv_two)
+		if (textconv_two && textconv_two->textconv)
 			free(mf2.ptr);
 		xdiff_clear_find_func(&xecfg);
 	}
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7715c13..f89e106 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "userdiff.h"
=20
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
@@ -150,9 +151,9 @@ static int pickaxe_match(struct diff_filepair *p, s=
truct diff_options *o,
 		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
 		 o, regexp, kws);
=20
-	if (textconv_one)
+	if (textconv_one && textconv_one->textconv)
 		free(mf1.ptr);
-	if (textconv_two)
+	if (textconv_two && textconv_two->textconv)
 		free(mf2.ptr);
 	diff_free_filespec_data(p->one);
 	diff_free_filespec_data(p->two);
--=20
2.7.1.532.gd9e3aaa

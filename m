From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/14] clone: support sparse checkout with --narrow-path option
Date: Sat, 20 Sep 2008 17:01:51 +0700
Message-ID: <1221904913-25887-13-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
 <1221904913-25887-9-git-send-email-pclouds@gmail.com>
 <1221904913-25887-10-git-send-email-pclouds@gmail.com>
 <1221904913-25887-11-git-send-email-pclouds@gmail.com>
 <1221904913-25887-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKb-0001On-7Y
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbYITKDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbYITKDn
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:14530 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYITKDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so808445rvb.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=q8PzofNd2pJwMWEqpFfRihFMDiambsPDrrvar8zOur4=;
        b=WohCq2cwbMrmuTFZTF3gvqBsE1nqIJXeHjkp0i4dHqP7P+qJ+kM7QIJxzMwIOsNJgg
         6jhkNdVdxHZbkYUraKKIG0snWqI+hTU3tudQgcE8yd0PhWTxgqnUdA4Zxkqkw86Ile/2
         aXHNUBqG7zAnw1ZAdSjeiJiE0S9p92HuUq/mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nWKXtdHuUOHZ10bTMD6QololjZ4uu06VBQ/dmOYh4NnEE6XmGSrPcGR69uwB+Pc5qW
         qcI6A6iDz0icKR8otZzPQI7GaZ4EccdWk84fB+2q3MucQcNDSnitwkKC6cgUGjogOxTE
         E3fUCOcjyJq1qcdU5NsgzfCz4ex17arg1u840=
Received: by 10.141.197.8 with SMTP id z8mr610401rvp.285.1221905021594;
        Sat, 20 Sep 2008 03:03:41 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id k41sm2534132rvb.9.2008.09.20.03.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:30 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96349>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |   10 +++++++++-
 builtin-clone.c             |   13 +++++++++++++
 t/t5703-clone-narrow.sh     |   39 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 61 insertions(+), 1 deletions(-)
 create mode 100755 t/t5703-clone-narrow.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0e14e73..c283cf4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--] <repository> [<directory>]
+	  [--depth <depth>] [--narrow-path=3D<sparse patterns>] [--]
+	  <repository> [<directory>]
=20
 DESCRIPTION
 -----------
@@ -94,6 +95,13 @@ then the cloned repository will become corrupt.
 -n::
 	No checkout of HEAD is performed after the clone is complete.
=20
+--narrow-path=3D<sparse patterns>::
+	Make a sparse checkout instead of full one. The checkout area
+	will be narrowed to specific areas based on given sparse
+	patterns. This option will not work with either --no-checkout
+	or --bare.  Please refer to linkgit:git-checkout[1] for more
+	detail on sparse checkout and sparse patterns.
+
 --bare::
 	Make a 'bare' GIT repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin-clone.c b/builtin-clone.c
index a4b8790..5ee8362 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,6 +36,7 @@ static const char * const builtin_clone_usage[] =3D {
 static int option_quiet, option_no_checkout, option_bare, option_mirro=
r;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_narrow_path;
 static char *option_origin =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
=20
@@ -43,6 +44,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT__QUIET(&option_quiet),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
+	OPT_STRING(0, "narrow-path", &option_narrow_path, "prefixes",
+		    "limit checkout to specified areas (sparse checkout)"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
@@ -378,10 +381,15 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
+		if (option_narrow_path)
+			die("--bare and --narrow-path options are incompatible.");
 		option_no_checkout =3D 1;
 		use_separate_remote =3D 0;
 	}
=20
+	if (option_no_checkout && option_narrow_path)
+		die("--no-checkout and --narrow-path options are incompatible.");
+
 	if (!option_origin)
 		option_origin =3D "origin";
=20
@@ -590,6 +598,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		opts.src_index =3D &the_index;
 		opts.dst_index =3D &the_index;
=20
+		if (option_narrow_path) {
+			opts.new_narrow_path =3D 1;
+			opts.narrow_spec =3D parse_narrow_spec(option_narrow_path, NULL);
+		}
+
 		tree =3D parse_tree_indirect(remote_head->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
diff --git a/t/t5703-clone-narrow.sh b/t/t5703-clone-narrow.sh
new file mode 100755
index 0000000..66f9191
--- /dev/null
+++ b/t/t5703-clone-narrow.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description=3D'narrow clone'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src
+		mkdir -p work/sub/dir
+		touch untracked tracked modified added
+		touch work/untracked work/tracked work/modified work/added
+		git add tracked work/tracked
+		git add modified work/modified
+		git commit -m initial
+	)
+
+'
+
+test_expect_success 'narrow clone incompatible with --bare' '
+	rm -fr dst &&
+	test_must_fail git clone --narrow-path=3Dwork --bare src dst
+'
+
+test_expect_success 'narrow clone incompatible with --no-checkout' '
+	rm -fr dst &&
+	test_must_fail git clone --narrow-path=3Dwork -n src dst
+'
+
+test_expect_success 'clone with --narrow-path' '
+	rm -fr dst &&
+	git clone --narrow-path=3Dwork src dst &&
+	cd dst &&
+	test -z "$(git ls-files --sparse | grep -v ^work/)"
+'
+
+test_done
--=20
1.6.0.96.g2fad1.dirty

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] Add option to git-commit to allow empty log messages
Date: Tue,  6 Apr 2010 08:40:35 +0000
Message-ID: <1270543235-8570-1-git-send-email-avarab@gmail.com>
References: <20100406055530.GE3901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 10:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4LN-0003WE-Hi
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 10:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab0DFIlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 04:41:03 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63389 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab0DFIlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 04:41:00 -0400
Received: by fxm23 with SMTP id 23so3465452fxm.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RICS8GvGeMh7cBiCHPO4heLOhE4uQbfgvyTzyk69UBM=;
        b=JeuRWN/Vdv3LQ5/qonlRQqmzBQgZr5VjW+SyK+lS7Bo/sWCNbidZIZSVqhSHHOYeK0
         4Oa+tpb5TFBVbOWLEd3MmSQ3oxaL1TR4Y5wRtJIWKv7Ih/Sv5IT4wW2Ao2iek+Ec6I93
         /vs9xNe+mMqM7RTgkNfWbPXmtjB+k6fNPpivE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rXhmJjHiZg/an/rzsgLOGxLGLioPJgrGOVH/FK1V0up3XXYsiA7PPHf8+v3B9mSqd0
         2ZFB+E/1KcDVCONdgHJIoEsXNlI4ptxCpPKXKsf7zSNyoi7avWCh/e6mdqd9fljmmZwm
         a4PWXD3tzyG6vd4ZWZCpO0pajTCrpIRY6rNUc=
Received: by 10.102.12.13 with SMTP id 13mr3629424mul.133.1270543258492;
        Tue, 06 Apr 2010 01:40:58 -0700 (PDT)
Received: from localhost.localdomain (pD950775A.dip0.t-ipconnect.de [217.80.119.90])
        by mx.google.com with ESMTPS id n10sm54075380mue.42.2010.04.06.01.40.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 01:40:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.298.gc81d
In-Reply-To: <20100406055530.GE3901@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144115>

Change git-commit(1) to accept a --allow-empty-message option
analogous to the existing --allow-empty option which allows empty
trees. This is mainly for compatability with foreign SCM systems.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-commit.txt          |    6 +++++
 builtin/commit.c                      |    7 +++--
 t/t7510-commit-allow-empty-message.sh |   41 +++++++++++++++++++++++++=
++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100755 t/t7510-commit-allow-empty-message.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 64fb458..aa18bee 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -131,6 +131,12 @@ OPTIONS
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign scm interface scripts.
=20
+--allow-empty-message::
+       Like --allow-empty this command is primarily for use by foreign
+       scm interface scripts. It allows you to create a commit with an
+       empty commit message without using plumbing commands like
+       linkgit:git-commit-tree[1].
+
 --cleanup=3D<mode>::
 	This option sets how the commit message is cleaned up.
 	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..7fd963e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -65,8 +65,8 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run, renew_auth=
orship;
-static int no_post_rewrite;
+static int quiet, verbose, no_verify, allow_empty, allow_empty_message=
, dry_run;
+static int no_post_rewrite, renew_authorship;
 static char *untracked_files_arg, *force_date;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -141,6 +141,7 @@ static struct option builtin_commit_options[] =3D {
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewr=
ite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode"=
, "show untracked files, optional modes: all, normal, no. (Default: all=
)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty ch=
ange"),
+	OPT_BOOLEAN(0, "allow-empty-message", &allow_empty_message, "ok to re=
cord a change with an empty message"),
 	/* end commit contents options */
=20
 	OPT_END()
@@ -1293,7 +1294,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 	if (cleanup_mode !=3D CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode =3D=3D CLEANUP_ALL);
-	if (message_is_empty(&sb)) {
+	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, "Aborting commit due to empty commit message.\n");
 		exit(1);
diff --git a/t/t7510-commit-allow-empty-message.sh b/t/t7510-commit-all=
ow-empty-message.sh
new file mode 100755
index 0000000..d7dc0da
--- /dev/null
+++ b/t/t7510-commit-allow-empty-message.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'git commit --allow-empty-message'
+
+. ./test-lib.sh
+
+commit_msg_is () {
+	test "`git log --pretty=3Dformat:%s%b -1`" =3D "$1"
+}
+
+# A sanity check to see if commit is working at all.
+test_expect_success 'a basic commit in an empty tree should succeed' '
+	(
+		echo content > foo &&
+		git add foo &&
+		git commit -m "initial commit"
+	) &&
+	commit_msg_is "initial commit"
+'
+
+test_expect_success 'Commit no message with --allow-empty-message' '
+	(
+		echo "more content" >> foo &&
+		git add foo &&
+		printf "" | git commit --allow-empty-message
+	) &&
+	commit_msg_is ""
+'
+
+test_expect_success 'Commit a message with --allow-empty-message' '
+	(
+		echo "even more content" >> foo &&
+		git add foo &&
+		git commit --allow-empty-message -m"hello there"
+	) &&
+	commit_msg_is "hello there"
+'
+test_done
--=20
1.7.0.4.298.gc81d

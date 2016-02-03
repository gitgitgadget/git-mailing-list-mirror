From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/20] worktree: add "move" commmand
Date: Wed,  3 Feb 2016 16:35:47 +0700
Message-ID: <1454492150-10628-18-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsc-0006Xp-4L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbcBCJhb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:31 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35950 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbcBCJh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:28 -0500
Received: by mail-pa0-f53.google.com with SMTP id yy13so10742092pab.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kCQownbKGod6Z4O3vAim1/I7HnsgsyXRpQafR1UkeIM=;
        b=Ldc5FynrFlTkBVxbtnDT8lez0XBl+6hvNQY9udySXOAp3QBcstU96uTPLs1pM6KJaB
         Q8HVueNK3R8K0mBcDoy5kcWxUYgtwMOHI58yHozOVQ6kQegJXX9W5/BJr/5+u3DDdfp0
         UBvkZkf21FrydWkw9WxfarTcmMBFu4qvaXk7bMTH4qmRMYCZmLgFODSYLhdpJ/8aAPUf
         ebOjI8ppmuUf2B2GB6sK6oovq1vQvH2Elrq+aViXKpAdkSI6dbCBX53AM8d/IhLDgKgp
         3pySiZmOAV52YePTIoLJaHZTzzptjt6n1Qm9Dg6zWdED77k8BPJjXhcynIL9s4xYITpo
         oKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=kCQownbKGod6Z4O3vAim1/I7HnsgsyXRpQafR1UkeIM=;
        b=OgL9wY7uuHxbq/5u5Q0tOFztZ67u4bgS3N8SGpOvR+S1tRN/5xUjapTpL1Uv7n0ZLg
         FT4d1168Xyui3foW0F2nyN6EC/ft6Zdw2vHgE4mTUMByzlFA5e2KXaOEo57Lv9KMBOxK
         a5VmHkg42KJrdArPoa6E6yVFm4y5VVpT78ARjVPQITcVgSPVNU9iEonoYPvXmmaHrdv5
         3ssEaDzzDLV2y/r2rZqRb+NyRAHgGUC0tLdpLuYTQc1fQHv0K1LRHlH9grJbCnP5Fqat
         anw+lQ2FOZf0hjF7lGg7qh4haXzXUADPUqE+3EuF46lGH5aZmaylzGf81QskVwHfU+Yy
         GcaQ==
X-Gm-Message-State: AG10YOSP06wKnD6izsdP91On+sjf7nowNjGQRSjYIoZBQUx6sfU0iSj/8ioPXdJIsMz05w==
X-Received: by 10.66.193.233 with SMTP id hr9mr775487pac.18.1454492247820;
        Wed, 03 Feb 2016 01:37:27 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id s197sm8368134pfs.62.2016.02.03.01.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:39 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285362>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c                | 51 +++++++++++++++++++++++++++++++=
++++++++
 t/t2028-worktree-move.sh (new +x) | 41 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100755 t/t2028-worktree-move.sh

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 36d942e..8d59199 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -445,6 +445,55 @@ static int list(int ac, const char **av, const cha=
r *prefix)
 	return 0;
 }
=20
+static int move(int ac, const char **av, const char *prefix)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst =3D STRBUF_INIT;
+	struct strbuf src =3D STRBUF_INIT;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 2)
+		usage_with_options(worktree_usage, options);
+
+	strbuf_addstr(&dst, prefix_filename(prefix,
+					     strlen(prefix),
+					     av[1]));
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), av[1]);
+
+	worktrees =3D get_worktrees();
+	strbuf_addstr(&src, prefix_filename(prefix,
+					     strlen(prefix),
+					     av[0]));
+	wt =3D find_worktree_by_path(worktrees, src.buf);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+
+	/*
+	 * First try. Atomically move, and probably cheaper, if both
+	 * source and target are on the same file system.
+	 */
+	if (rename(src.buf, dst.buf) =3D=3D -1) {
+		if (errno !=3D EXDEV)
+			die_errno(_("failed to move '%s' to '%s'"),
+				  src.buf, dst.buf);
+
+		/* second try.. */
+		if (copy_dir_recursively(src.buf, dst.buf))
+			die(_("failed to copy '%s' to '%s'"),
+			    src.buf, dst.buf);
+		else
+			(void)remove_dir_recursively(&src, 0);
+	}
+
+	return update_worktree_location(wt, dst.buf);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -461,5 +510,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return prune(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "list"))
 		return list(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
new file mode 100755
index 0000000..e8f6f0c
--- /dev/null
+++ b/t/t2028-worktree-move.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description=3D'test git worktree add'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	git worktree add source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/source
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'move non-worktree' '
+	mkdir abc &&
+	test_must_fail git worktree move abc def
+'
+
+test_expect_success 'move worktree' '
+	git worktree move source destination &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/destination
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=3D%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'move main worktree' '
+	test_must_fail git worktree move . def
+'
+
+test_done
--=20
2.7.0.377.g4cd97dd

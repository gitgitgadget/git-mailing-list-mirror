From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/6] worktree: new command to fix up worktree's info after moving
Date: Mon, 18 Jan 2016 18:21:34 +0700
Message-ID: <1453116094-4987-7-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bf-0004BZ-84
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbcARLEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:04:14 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33627 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbcARLEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:04:11 -0500
Received: by mail-pa0-f68.google.com with SMTP id pv5so33504267pac.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IPQrRxPfYKM7rA++PNh4iVYQf7rm/LoUSPoFwwLMmA4=;
        b=OVE1a7U7NyYXUoEmq/Mb+8sZ04o1eKIgtMWxzUeFT3CYgUl+DfqOnyamaNIyg5Mj6N
         fjDVwkpHrKXNDjZiHiJMAr3no8cJi44Am2C7l86nYAgJb8vc/pc2NSIb014Es3JigDng
         tqvO+4tvfQC/z7Dj8TGKy3O7ZkF07FDUKaI/Yp/vSswbTH7xEWZjzeLd/ddsNPYfdNRO
         9g2c3nCMMrDTP3X4pdWg5QNhDzEx3EozVlfDJCHJlILCJsACz5pnNLxGQ+3kTHd1hyfh
         eJW6Po1H7bJQcRod2z94T6Gj5oFCNlBLTAHhF3EASEbhvFlYHak6C5UF6baCl7I/MuyJ
         bwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=IPQrRxPfYKM7rA++PNh4iVYQf7rm/LoUSPoFwwLMmA4=;
        b=KP6RaYJvLfYZUmZ6kgp8KkNuwblj07e03fBG720PFjzrEV4HiYd2+fISV6vqhwa/s6
         nx8mypTKEWL6QdiWQTs2HCh6f1UmqzpmLymB5pwW6i7u/4Weh3Lgrk9p1tjmw4IsjwYV
         9vfSip55Wpk8DUgu2e0XWy37zveJleylfTvOsWg+1jmmBWq0N2E1jtA3LMeVKEiLo8Fr
         DBax4VgX7XrwBrOnVzQb2NQ5o8PBjWEXcotVYd8gZjDbCQOdIIx6eqodSg43c2Yg2nRH
         ZM1gBYS3uo3An79bTV9DqKyXRXs+r2CdY+XXionrltHRKFkuTfiC/a9JXoKYgnwq837z
         YH6A==
X-Gm-Message-State: ALoCoQljdqW7rloki53764Nkkc07W5JrKZ1j+GS94c2eVvaksy1g6lRf0BWJgiVMWrvF14aTitiZVU6VfqFm803/Wzsm2sPvgg==
X-Received: by 10.67.6.195 with SMTP id cw3mr35709704pad.88.1453115050873;
        Mon, 18 Jan 2016 03:04:10 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id i76sm33163635pfj.68.2016.01.18.03.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:04:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:22:12 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284290>

This is a low-level command that can be used to correct worktree
information after a worktree is moved. The idea is like 'index refresh'=
=2E
In future we may do "worktree refresh" automatically to keep it from
being pruned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  8 +++++++-
 builtin/worktree.c             | 18 ++++++++++++++++++
 t/t1501-worktree.sh            |  9 +++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 62c76c1..306aeec 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree list' [--porcelain]
+'git worktree refresh'
=20
 DESCRIPTION
 -----------
@@ -65,6 +66,11 @@ each of the linked worktrees.  The output details in=
clude if the worktree is
 bare, the revision currently checked out, and the branch currently che=
cked out
 (or 'detached HEAD' if none).
=20
+refresh::
+
+This command is required to update worktree's information after it's m=
oved.
+Executed from inside the moved worktree.
+
 OPTIONS
 -------
=20
@@ -140,7 +146,7 @@ in the entry's directory. For example, if a linked =
working tree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
 `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/te=
st-next`
-instead.
+instead. Alternatively you can run "git worktree refresh".
=20
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..0183ce0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -445,6 +445,22 @@ static int list(int ac, const char **av, const cha=
r *prefix)
 	return 0;
 }
=20
+static int refresh(int ac, const char **av, const char *prefix)
+{
+	const char *gitdir;
+
+	if (ac !=3D 1)
+		die(_("Arguments not expected"));
+
+	gitdir =3D git_pathdup("gitdir");
+	if (access(gitdir, F_OK))
+		return 0;
+	if (!startup_info->first_gitfile)
+		die("BUG: .git file's location not found");
+	write_file(gitdir, "%s", startup_info->first_gitfile);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -459,5 +475,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return prune(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "list"))
 		return list(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "refresh"))
+		return refresh(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index cc5b870..821831b 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -423,4 +423,13 @@ test_expect_success '$GIT_WORK_TREE overrides $GIT=
_DIR/common' '
 	)
 '
=20
+test_expect_success 'worktree refresh corrects gitdir file' '
+	git worktree add test-refresh &&
+	P=3Drepo.git/worktrees/test-refresh/gitdir &&
+	echo corrupt >$P &&
+	git -C test-refresh worktree refresh &&
+	echo "$TRASH_DIRECTORY/test-refresh/.git" >expected &&
+	test_cmp expected $P
+'
+
 test_done
--=20
2.7.0.96.g5373197

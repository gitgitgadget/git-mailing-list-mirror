Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403C3F825B
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001744; cv=none; b=IbfN9cyEptcHcwb/e2eyddTG0uob6aIRUAX87zrb6WjQSEDr4CSCyU1Db4MoF3jGt4soDFgvu16k0qaxRBkOq4Ih1LIqwjLaE+cMZy0mFGKZhuLp6UIg9OS5NKAueLtau7ug10RAikJf3OK4z8k7WqxBTLivY+U3Rwh3wQqGFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001744; c=relaxed/simple;
	bh=csHS5hIl6EavpLv+72xT0B4jNkmTaquoXHolVsCQY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE5tMzqspj1ear+/xWIdVEnd+xzzXdRzPyDIJtfPIBH/P0PaqsqL4v0WRTsW2VVyXWKs0W1+bsSoZYO7sthOzkQHROxjz9I3jTUBCZ7o70gbCgdTkCBpNPKi9fRSEzM2t/Nsxw6D3e2IrivUDD51NAzjy+m8bPJaEBTB4Mm71oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipNIuGlq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipNIuGlq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so44109175e9.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781001739; x=1781606539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mvpxn84t8srS185PD35OLOjva8Hp85fa/FzUHseXDs=;
        b=ipNIuGlquNIGaTxb7k3QAFPXSIqg+eIn+5zhdjClFTh2nW19j67CTwDLh9AI3zPCkg
         ta0J2sTX3hCt1efu93ukyueDUo9oi36dUVKROsVOw7aMXyyu8F66ocPgQZZ/L5N9tvgQ
         4UoRRvP78LQEgnGaszDte7yXj31vAZwjPy6IdQpnQghKaPnt7hlLitW/xm0OyE70g5Lo
         ihFu9nB5neG88SGS25Z/b0edULozgFvS7KQfoNd7e/7N2/+zySJHkWlSRyisoFs7U0Ug
         aZWpmMMv0pcvn/CYvOpft+1Dl50N4akln8bAD2TxeU2A/R+06tDa5eXc6tw+ZTacp+4w
         sfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001739; x=1781606539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mvpxn84t8srS185PD35OLOjva8Hp85fa/FzUHseXDs=;
        b=p9/LUsmZBa90eT35xoVTJLBNAs03SVwfcvHZukhn9LI/UkW8vjI3AjoP47oBvXeHxI
         +WoFZfP6h+YgsGliE4jwFqrHliqEwmF+5NvAE6DILkfGE20P13mSdC1pJrro0ixiQUcD
         hf6RQUTKHOL/+EbNQqXn7dtG2HYObMjLxjd9W7rDBZWHsbKEDSFTKeyBpg6j02hKo4p4
         ZufoZFb78pA7rRMKmUFUraGwI0jsLH7lb3ag9oWAU+TkkDRHKDre+6vhyzx8GBAeexCT
         MPsv7dEHXd4QPgwD/ARcqWbGY3RlDWLjl2dBf92hVzvy/98lJ/fjjzN4aTpngGzIP4y0
         li2g==
X-Gm-Message-State: AOJu0YzzOz9tB5X9ENRS8KSfsbRlgXwfTjami6nCl5KHNZMzMzJYS8xp
	qWc0opjz0FpGRTQnv0hzeRjogFo28zX6LFiq/0YxjJB61wUJfJKK++SJdsm83Yc/
X-Gm-Gg: Acq92OGrI60L8wJKNJyg4iM8bK3Pk0nRv4o1KFm5htWbtc4e/4LmZTu5BwP4aIAzCeH
	aKTQ5EH0yLrUoYTLXDX/xA5pvwtBDZjsTV9rENrq59EXhugqIbdSb+qa5e+56odpofsTq6DXwiw
	MXhCPWcYbExHlSvE6qs9EDRrpOEkFowaqTnRew3k2p1nY4zXCzUt97n047N9kzlr/EhgvcsEnIv
	1myeSmZFYEYgqqGyFgqO8Sqs1AUvNhwS71GsN358LRz64qk4233D6P3UOy+Y75NS4UudI53sef9
	yoleU7/pyCAzy/Ym8p7H5eaf2/GLtRZ6gO4b8JqESdBoLK/PwmKExmy90S5qCqd1SxD4xhi5Cu/
	mE4TfRFwylkmyuorftJap/B6cDuTpHSYUukeoIJNwYgNIrDWvQw/bVfy7HDk4tmqSpMhd+5hfKb
	QOOYtt/Fw1JdYrUnj5lzJ6Ji6c4LT47v3/Jno0sTd9i6i8Q4eZQ2eQDjQLxdQGx79RG+sGvwx7J
	8uERgVD41g+shLwN/HoCsODb3DVHT0MIRCaBi5y5swcGIUrcv+JCZlPJoYS7d2BSAtPrPgn5ssZ
	9m3luXsGTMt15eCREK5HrE56yEMSqiH8v47rELetXNU3XT5fB1nq+RPjYyYeSdj2s7DGtGFAHeQ
	gl0+HZHIyCbxllnJWPJ8feoifpJpYTWjI
X-Received: by 2002:a05:600c:82c3:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490c25f4963mr306797075e9.25.1781001739087;
        Tue, 09 Jun 2026 03:42:19 -0700 (PDT)
Received: from localhost.localdomain (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm499692345e9.14.2026.06.09.03.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 03:42:18 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: cat@malon.dev,
	ps@pks.im,
	kaartic.sivaraam@gmail.com,
	pabloosabaterr@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com
Subject: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
Date: Tue,  9 Jun 2026 12:42:08 +0200
Message-ID: <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When using `git history reword <commit>` if the new message is the same
as the original, it continues and rewrites the history when nothing
changed.

`git commit --amend` and `git rebase -i` with reword share this behavior
and it is wrong as well, but changing them breaks what people are used
to. Take the opportunity of `git history` being a new command and handle
it correctly from the start.

Create COMMIT_TREE_ABORT_ON_SAME_MESSAGE and make a check for if the
messages are the same and the flag is set so other subcommands like
fixup that do not want this behavior just don't send the abort flag.

Make commit_tree_ext() return 1 when facing the same message so its
callers can choose what to do.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/history.c         | 14 +++++++++++++-
 t/t3451-history-reword.sh | 16 ++++++++++++++++
 t/t3453-history-fixup.sh  | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index b3e2e5270d..be07690da4 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -96,6 +96,7 @@ static int fill_commit_message(struct repository *repo,
 
 enum commit_tree_flags {
 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
+	COMMIT_TREE_ABORT_ON_SAME_MESSAGE = (1 << 1),
 };
 
 static int commit_tree_ext(struct repository *repo,
@@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *repo,
 					  original_body, action, &commit_message);
 		if (ret < 0)
 			goto out;
+
+		if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
+		    !strcmp(original_body, commit_message.buf)) {
+			fprintf(stderr, _("Message unchanged, aborting reword.\n"));
+			ret = 1;
+			goto out;
+		}
 	} else {
 		strbuf_addstr(&commit_message, original_body);
 	}
@@ -693,7 +701,8 @@ static int cmd_history_reword(int argc,
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct commit *original, *rewritten;
 	struct rev_info revs = { 0 };
-	enum commit_tree_flags flags = COMMIT_TREE_EDIT_MESSAGE;
+	enum commit_tree_flags flags = COMMIT_TREE_EDIT_MESSAGE |
+				       COMMIT_TREE_ABORT_ON_SAME_MESSAGE;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
@@ -721,6 +730,9 @@ static int cmd_history_reword(int argc,
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
+	} else if (ret == 1) {
+		ret = 0;
+		goto out;
 	}
 
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..6e0e278c42 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -396,4 +396,20 @@ test_expect_success 'retains changes in the worktree and index' '
 	)
 '
 
+test_expect_success 'aborts if the commit message is the same' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git rev-parse HEAD >oid-before &&
+		GIT_EDITOR=true git history reword HEAD 2>err &&
+		git rev-parse HEAD >oid-after &&
+		test_cmp oid-before oid-after &&
+		test_grep "Message unchanged" err
+	)
+'
+
 test_done
diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
index 868298e248..9f9a3c93de 100755
--- a/t/t3453-history-fixup.sh
+++ b/t/t3453-history-fixup.sh
@@ -443,6 +443,28 @@ test_expect_success '--reedit-message opens editor for the commit message' '
 	)
 '
 
+test_expect_success 'fixup --reedit-message does not abort with the same commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		echo content > file.txt &&
+		git add file.txt &&
+		git commit -m "add file" &&
+
+		echo fix >>file.txt &&
+		git add file.txt &&
+		GIT_EDITOR=true git history fixup --reedit-message HEAD &&
+		expect_changes --branches <<-\EOF
+		add file
+		2	0	file.txt
+		initial
+		1	0	initial.t
+		EOF
+	)
+'
+
 test_expect_success 'retains unstaged working tree changes after fixup' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.54.0

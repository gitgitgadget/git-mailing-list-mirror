Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD708612C
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585795; cv=none; b=jfrM6uQG0kqgpv02UYrhP3d5ZZm0pep0QQljQS50T7nn4jm8MZw0miptIIqbRcO/Rmfies2i0fPXzKKHgGMtZRMzbmsp75PrF1Ptb30LvVM0AYuVgfK4kdVpfcRcnvm/GqfjqQADqoFu+a+oGCvznrRLaDy+zt8YRSQCqbi0dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585795; c=relaxed/simple;
	bh=gl0vczJpvrysYnPkk3Z8QuO7kRvSccN9yq2SYc9Rtwc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iiCGdVStZ0OMRBT/JFGjrNQRWQfW+wMrKCKYpqkSD53AN7iwZi+dICnJvpqPRhcT0resusxzY8qt1Nlm++4XZyCqywjr6sTIo6BqH2eNhEODSNdcIltRlxcF3M79Zlv6tETnTXkgS3JL2zIx3NAJ3CEh1xH95EZba03L9IWKQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRfs3KQl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRfs3KQl"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so61171671fa.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585792; x=1713190592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt3Oc9b4cZJkFeeCa7fTHL6YPobnB6vc+X8DAKd1xQQ=;
        b=kRfs3KQlpDNnhdAYvBqDwi/h6YD5vdOW0znFfqX9xCATZFzvxey2EfhVI+OC4ik30m
         XGLg8L+AZmj0bRLGv8L3WZJG5Rn6mASvU/+IOCaHAwjfeVTg2R2mwqYpCiRVrgquOD4z
         lT0NzcVoQDDHAs8WwcZlGbg0TaJ+8QaFRggJcHT/ISXugMqz/oQoB6B/0YXYl1qNfYtT
         W+WiOo+8j8aO81/I/wt0b/83IqDVjzUjv3VBSHuYNyMNndlDKKTn4LJ6tDqjq+TtMLAE
         gmApI98luCkMyLMwaFL6WJGubc4H+fF+2oc77eMKKZvtkNikYKFzRX1M6slzLX3Gc34i
         9HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585792; x=1713190592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt3Oc9b4cZJkFeeCa7fTHL6YPobnB6vc+X8DAKd1xQQ=;
        b=MWd1MUQAe9YXjP9Wvb49eSvI1boJGck9/hT4Dq9mMXtzIOsORAxZknRgVYLf8AxA8F
         hKl5P0vilzdDrF9syYIf0fjMwiFAMPxCtfaAHsACRanCFUd6YsxlBsPTjIcDq+cKmwEB
         no2nEo3pCkmsZMmkIOqv7EP/p949jCF1PQ6keOk5AyGHpDqmKDu0hwaHfi/kLwvo9Py0
         I0f0/QHbh2BqSN6657KCmW/h8+xS2FWdtswoed3VjpX6gGabcDUxgHNtgIcs/AKjq1Pg
         j96UjDEBw2Fr1PA/bHAjI8F8/FdNVjNzbScNI4QHOLs2Y6Imqe451ZNqPcmdwBt9/s+A
         SogQ==
X-Gm-Message-State: AOJu0YwgN3RlCqkbxxjxa8AnvC0k9b6PYIuDafX3s/vFc61ykA8ez6yX
	1EHO7ggW469ao8RCYl5QuTvu83THx4flP8Hz/SIhzOX9Zcw7Dlfb7VBDroK9
X-Google-Smtp-Source: AGHT+IFct1lDagFwSWMA8KoLJBQxfutgRevF2UacCeCSSe0aNJU7YKq7MZXeY/iApFjsh/Ehp+uwyw==
X-Received: by 2002:a2e:a417:0:b0:2d6:f16a:857f with SMTP id p23-20020a2ea417000000b002d6f16a857fmr5004035ljn.0.1712585791630;
        Mon, 08 Apr 2024 07:16:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b0041668770f37sm4576899wmo.17.2024.04.08.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:16:30 -0700 (PDT)
Message-Id: <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
	<pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 14:16:27 +0000
Subject: [PATCH v2 2/2] rebase -i: improve error message when picking merge
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The only todo commands that accept a merge commit are "merge" and
"reset". All the other commands like "pick" or "reword" fail when they
try to pick a a merge commit and print the message

    error: commit abc123 is a merge but no -m option was given.

followed by a hint about the command being rescheduled. This message is
designed to help the user when they cherry-pick a merge and forget to
pass "-m". For users who are rebasing the message is confusing as there
is no way for rebase to cherry-pick the merge.

Improve the user experience by detecting the error when the todo list is
parsed rather than waiting for the "pick" command to fail and print a
message recommending the "merge" command instead. We recommend "merge"
rather than "exec git cherry-pick -m ..." on the assumption that
cherry-picking merges is relatively rare and it is more likely that the
user chose "pick" by a mistake.

It would be possible to support cherry-picking merges by allowing the
user to pass "-m" to "pick" commands but that adds complexity to do
something that can already be achieved with

    exec git cherry-pick -m1 abc123

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 37 +++++++++++++++++++++++++++++++++--
 t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a3154ba3347..4012c6f88d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2573,7 +2573,35 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
 	return 0;
 }
 
-static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
+static int error_merge_commit(enum todo_command command)
+{
+	switch(command) {
+	case TODO_PICK:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s'"),
+			     todo_command_info[command].str, "merge -C");
+
+	case TODO_REWORD:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s'"),
+			     todo_command_info[command].str, "merge -c");
+
+	case TODO_EDIT:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s' followed by '%s'"),
+			     todo_command_info[command].str,
+			     "merge -C", "break");
+
+	case TODO_FIXUP:
+	case TODO_SQUASH:
+		return error(_("cannot squash merge commit into another commit"));
+
+	default:
+		BUG("unexpected todo_command");
+	}
+}
+
+static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 			   struct todo_item *item, const char *buf,
 			   const char *bol, char *eol)
 {
@@ -2679,7 +2707,12 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED
 		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return item->commit ? 0 : -1;
+	if (!item->commit)
+		return -1;
+	if (is_rebase_i(opts) && item->command != TODO_MERGE &&
+	    item->commit->parents && item->commit->parents->next)
+		return error_merge_commit(item->command);
+	return 0;
 }
 
 int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d1bead61fad..8565fd4b5ae 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2215,6 +2215,39 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
 	test_path_is_missing execed
 '
 
+test_expect_success 'non-merge commands reject merge commits' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout E &&
+	git merge I &&
+	oid=$(git rev-parse HEAD) &&
+	cat >todo <<-EOF &&
+	pick $oid
+	reword $oid
+	edit $oid
+	fixup $oid
+	squash $oid
+	EOF
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i HEAD 2>actual
+	) &&
+	cat >expect <<-EOF &&
+	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ}
+	error: invalid line 1: pick $oid
+	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}merge -c${SQ}
+	error: invalid line 2: reword $oid
+	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ} followed by ${SQ}break${SQ}
+	error: invalid line 3: edit $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 4: fixup $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 5: squash $oid
+	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
+	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

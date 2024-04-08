Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DD85C7A
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585794; cv=none; b=n+ZEtXI+DJS7S34ryM24SBLW0C7BPvTP5LmiRi1Brzozl6nvEQyhx4UbQCFEsHJRswQulWGtTpjduKI1SexkMUBIiJMgJwB72kivGu32De52vy/CAkmJvk1d3ztJna7uGox6eSTwMdDnLXuRErR5R1sAt3lZadMPcOXQFJITJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585794; c=relaxed/simple;
	bh=EJ1Ai2NT+YpSCJwKp0Eks/sVRjhiVUSpSE1zKmcOmpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NOYWJBcyieP9WiiK8Tsbodz66j3zV13aJBTZns5nrqcYKYjfRkXZC9viLQBh2ybkxmCQng/YZ2RONlPzOKzMt7lM0pPR5p4JNHRTAST1MkLkoPj3DQeBOigk44D7ZV9H/A5LPWyHtVWqzm8IATlxETmGsmFb7kiziYRjYuB3yK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsKqNP/c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsKqNP/c"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4168a0d113cso3442035e9.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585790; x=1713190590; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QVG03qjaPqzz6hWXjzkQvZr+7bknALgdNsVMm5vk7c=;
        b=OsKqNP/cWcTks+eJ83zEue/e0caMhYDClkGeiOplXBCLugwPdKKxNn2iOE7LeUFlpy
         H0qfkl9S0xsW7utwQPpHickztA45n5ySpjTzPfoAP8uM+NfbP+UDy6XJjAGWfLGvLx29
         7g1eT33b3MDtpZnXrKvJZAMIzEnl4Jl/CLyzjOSiX2VlSHsRqu05GOOspY0x8L5Zc/yu
         qRC9Otw7RUkpcda2UTlVLvBn9Pc1ggcYA5hFDryRgRp5s4y5PVvTUyIrBJufWaZIANXu
         oUrV0b+bxItk5J8TkxkKjhiT4mRTrNMCdRsbZkLIvorUrFXRyDTbOnVa98U+9aV1Yqc2
         hv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585790; x=1713190590;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QVG03qjaPqzz6hWXjzkQvZr+7bknALgdNsVMm5vk7c=;
        b=D0hqb9xZRD5QAl69HBtUQKpB/aG/gM1jB109ton/x+XCq0S9xzgeOKYdT15LLwQ+v/
         EcCFBg9lR8qzTtt+UIk9NTEjkI8OIbGjnBVzHMl8eeAEJ4GmcQ8lVbBZknx6egqoZ8SL
         3EvuTjjlYpRm9Lb2y8toEMbvaJ/HtyoEgkvdVCgyNuXRnnI5QOZXCixJJEJ9MtW18wXR
         Q7o/OX5fh34ptvjY91y+C48SiutURuS4sMhwGnL/lafjCod27zfldnEpg0HhT4+oWUgT
         s3RAlCTaC+fU7vjLXxOn2wRetL+enq4pS+2umzZrD1u5wsROPnaXvjGN213v3QoNZTfG
         a+jQ==
X-Gm-Message-State: AOJu0YzbQ3tL/gsm/mjVl2R58W2Y0t7x8l561P8JjhOr6wEdirmI3eua
	PD1Od7jgVhbmoLG99opNao5k5yv+f8TSAed+hC2fAORMgZRNRdW+c9iwl7BM
X-Google-Smtp-Source: AGHT+IEg1DeMeuBgUc5XCvHtSkAxyJTxQxNDQ0X38yARydxLp6z8wBKA95ADBwXgdhREJV0rQiWXiw==
X-Received: by 2002:a05:600c:19cc:b0:414:60fe:8f2b with SMTP id u12-20020a05600c19cc00b0041460fe8f2bmr7568745wmq.18.1712585789747;
        Mon, 08 Apr 2024 07:16:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c26d300b0041644e9f3a9sm4465007wmv.0.2024.04.08.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:16:29 -0700 (PDT)
Message-Id: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 14:16:25 +0000
Subject: [PATCH v2 0/2] rebase -i: improve error message when picking merge
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
    Phillip Wood <phillip.wood@dunelm.org.uk>

If the user tries to pick a merge commit error out when parsing the todo
list rather than complaining when trying to pick the commit.

Thanks to Patrick and Rubén for their comments on V1. Changes since V1:

 * Rebased to avoid a conflict with jk/core-comment-string
 * Patch 1 is a new preparatory change that plumbs 'struct replay_opts'
   through to parse_insn_line()
 * Patch 2 is updated to use is_rebase_i() rather than requiring the caller
   to pass a boolean indicating whether we're rebasing.

Phillip Wood (2):
  rebase -i: pass struct replay_opts to parse_insn_line()
  rebase -i: improve error message when picking merge

 builtin/rebase.c              | 17 +++++++----
 rebase-interactive.c          | 21 ++++++++-----
 rebase-interactive.h          |  9 ++++--
 sequencer.c                   | 57 ++++++++++++++++++++++++++++-------
 sequencer.h                   |  4 +--
 t/t3404-rebase-interactive.sh | 33 ++++++++++++++++++++
 6 files changed, 111 insertions(+), 30 deletions(-)


base-commit: 19981daefd7c147444462739375462b49412ce33
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2Fphillipwood%2Frebase-reject-merges-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phillipwood/rebase-reject-merges-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1672

Range-diff vs v1:

 -:  ----------- > 1:  1bcf92c6105 rebase -i: pass struct replay_opts to parse_insn_line()
 1:  7726c496385 ! 2:  fbc6746e018 rebase -i: improve error message when picking merge
     @@ Commit message
      
              exec git cherry-pick -m1 abc123
      
     -    The change is relatively straight forward but is complicated slightly as
     -    we now need to tell the parser if we're rebasing or not.
     -
          Reported-by: Stefan Haller <lists@haller-berlin.de>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     - ## builtin/rebase.c ##
     -@@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
     - 	else {
     - 		discard_index(&the_index);
     - 		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
     --						&todo_list))
     -+						&todo_list, 1))
     - 			BUG("unusable todo list");
     - 
     - 		ret = complete_action(the_repository, &replay, flags,
     -
     - ## rebase-interactive.c ##
     -@@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
     - 	 * it.  If there is an error, we do not return, because the user
     - 	 * might want to fix it in the first place. */
     - 	if (!initial)
     --		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
     -+		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf,
     -+							todo_list, 1) |
     - 			file_exists(rebase_path_dropped());
     - 
     - 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
     -@@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
     - 	if (initial && new_todo->buf.len == 0)
     - 		return -3;
     - 
     --	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
     -+	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo, 1)) {
     - 		fprintf(stderr, _(edit_todo_list_advice));
     - 		return -4;
     - 	}
     -@@ rebase-interactive.c: int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_
     - 	int res = 0;
     - 
     - 	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
     --		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
     -+		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup, 1);
     - 		res = todo_list_check(&backup, todo_list);
     - 	}
     - 
     -
       ## sequencer.c ##
      @@ sequencer.c: static int check_label_or_ref_arg(enum todo_command command, const char *arg)
       	return 0;
       }
       
     +-static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
      +static int error_merge_commit(enum todo_command command)
      +{
      +	switch(command) {
     @@ sequencer.c: static int check_label_or_ref_arg(enum todo_command command, const
      +	}
      +}
      +
     - static int parse_insn_line(struct repository *r, struct todo_item *item,
     --			   const char *buf, const char *bol, char *eol)
     -+			   const char *buf, const char *bol, char *eol,
     -+			   int rebasing)
     ++static int parse_insn_line(struct repository *r, struct replay_opts *opts,
     + 			   struct todo_item *item, const char *buf,
     + 			   const char *bol, char *eol)
       {
     - 	struct object_id commit_oid;
     - 	char *end_of_object_name;
     -@@ sequencer.c: static int parse_insn_line(struct repository *r, struct todo_item *item,
     +@@ sequencer.c: static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED
       		return status;
       
       	item->commit = lookup_commit_reference(r, &commit_oid);
      -	return item->commit ? 0 : -1;
      +	if (!item->commit)
      +		return -1;
     -+	if (rebasing && item->command != TODO_MERGE &&
     ++	if (is_rebase_i(opts) && item->command != TODO_MERGE &&
      +	    item->commit->parents && item->commit->parents->next)
      +		return error_merge_commit(item->command);
      +	return 0;
       }
       
       int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
     -@@ sequencer.c: int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
     - }
     - 
     - int todo_list_parse_insn_buffer(struct repository *r, char *buf,
     --				struct todo_list *todo_list)
     -+				struct todo_list *todo_list, int rebasing)
     - {
     - 	struct todo_item *item;
     - 	char *p = buf, *next_p;
     -@@ sequencer.c: int todo_list_parse_insn_buffer(struct repository *r, char *buf,
     - 
     - 		item = append_new_todo(todo_list);
     - 		item->offset_in_buf = p - todo_list->buf.buf;
     --		if (parse_insn_line(r, item, buf, p, eol)) {
     -+		if (parse_insn_line(r, item, buf, p, eol, rebasing)) {
     - 			res = error(_("invalid line %d: %.*s"),
     - 				i, (int)(eol - p), p);
     - 			item->command = TODO_COMMENT + 1;
     -@@ sequencer.c: static int read_populate_todo(struct repository *r,
     - 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
     - 		return -1;
     - 
     --	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
     -+	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list,
     -+					  is_rebase_i(opts));
     - 	if (res) {
     - 		if (is_rebase_i(opts))
     - 			return error(_("please fix this using "
     -@@ sequencer.c: static int read_populate_todo(struct repository *r,
     - 		struct todo_list done = TODO_LIST_INIT;
     - 
     - 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
     --		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
     -+		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done, 1))
     - 			todo_list->done_nr = count_commands(&done);
     - 		else
     - 			todo_list->done_nr = 0;
     -@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
     - 	strbuf_release(&buf2);
     - 	/* Nothing is done yet, and we're reparsing, so let's reset the count */
     - 	new_todo.total_nr = 0;
     --	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
     -+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo, 1) < 0)
     - 		BUG("invalid todo list after expanding IDs:\n%s",
     - 		    new_todo.buf.buf);
     - 
     -
     - ## sequencer.h ##
     -@@ sequencer.h: struct todo_list {
     - }
     - 
     - int todo_list_parse_insn_buffer(struct repository *r, char *buf,
     --				struct todo_list *todo_list);
     -+				struct todo_list *todo_list, int rebasing);
     - int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
     - 			    const char *file, const char *shortrevisions,
     - 			    const char *shortonto, int num, unsigned flags);
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'bad labels and refs rejected when parsing todo list' '

-- 
gitgitgadget

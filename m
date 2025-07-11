Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F88221F29
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266208; cv=none; b=jSt2Or7SVr/4lKvdwUMiq2OB9XJ8pGGP+9wJp7U1njbQO/WEWtA7lVPC8AIjV7mJTocfcqPVexvBbhfAX9fm8k9ewG9q58+vpco5kreoh5KETmyqTw1m4bR/gsy35glqxilRphn7sUI2b8Gz50XHm2n2GzPYFSX1M+f9XNP7Pos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266208; c=relaxed/simple;
	bh=jywRh4HaZ9f3xcrLXJjcY947yFdI1y0Kdf0YmZ4H4Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTbVjrgH4Jco3z6yw9kfgeVqnhh7RZIenBUbpRx52s8Uf0Qhb/4pyeOO4ycxB9rioe3d/wA0yU+QhfNq1/S1RV+gBs4YzMxEVOHeQUjjLNoRhmTjKdsf2ZJN61mby5S5I05/dHuuo08HigLozmx280u6CCUSsYOzmHoA+Ikf83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaMwHTb8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaMwHTb8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f474ded39so2367781fa.3
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752266204; x=1752871004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSQTiLarGM1FpM0z8wc7hQKAD+98SEeSJYyXn8WXe5E=;
        b=IaMwHTb8AMSPsuCDfJ2CSsaKn14Q8vu4dk97ED0xG57LtnrZY3TP7Z6TOFbq+5VXx3
         +W1yZPXp/ZisDuyYaSsYT4RrYJJJprAuUpwrIt1kSrxg80QqNH3PXklszjt4AtebfSlK
         DRXgtfMMBP/zFYd0DAzcwtxJcOTgNt6pPFg5vEZqikism5RhqmJunwHklg15HM4IGzWZ
         KgHV/F9cU4xfIm0nNh+M55uYUH8/E4ga0Igut8ECSFmyZh4i/kVRYt72tCxQ9TYVc08P
         HCLd5YUFATVwKYW0XYRN9KP2QZXa22HRtRbn1oKiQMDdODJv21A8R+mojT0y73+27P5L
         6zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266204; x=1752871004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSQTiLarGM1FpM0z8wc7hQKAD+98SEeSJYyXn8WXe5E=;
        b=S6T10NY09WUO0COlXVOvv4Fc0HbEwBmccEZNQV1N+PNP+HIuiIYw0AUFB0hcR/6PRA
         udtBC6+BVHHbtLcKm1x8Ls+4hcntvkO+Qj829hdkQJsfB7LdlpzaSs7vRBUMZsyXmnfE
         RYPd65yjMD8Ean0A/oc4C8YYm+F1v9Jr9XsEPuH7tCUYUxCuFZhCiDd7h/CxPKiFMCy5
         LqP3s+W4Ye1PkLFKdj9Xx9ct5aBvAifFKQfsqABB8byqkIwW3z8FY2EZFfKfbIP1M8Lg
         8kK+07YQnPVxJoUwNVjDA7hjQTbOYXbP5XQ9NOXVLMwfnmPmdWQzJT0x2sTdzQ+osnVL
         jgAQ==
X-Gm-Message-State: AOJu0YyY+7DvjZA6Mo5N76qKEF2NhX4ZYqHV4GrWTD7QWnEvlAyIJTaj
	G5/XKjeUyaKLfRPUOQ6jkLRb264M3L/FckNtMFf9EG4rqRCw98jMrri2TmspV25D
X-Gm-Gg: ASbGncvp45do9XbiItJE7D63YUgcp6SkxDv4nw4/YhMGvO9sxYxZgT7uwnRNWO+es0y
	BbHoBqxsz4VWU8UXpqc2kRvXK9K1CgfuHzTIW86lyW7yQzdZoX8sD6gRTHbDKZo1wOpk+wNnq0P
	ox7N3CWjTWZC13ZuO0X74wU+pkaBf3gbY5cBqcA+P+GvQ64S6ZNeCCHZXM/0RBw94BEUYYMs+a+
	DAgUqSXP1IIMRiyD2dPJ3u0jKrxo86pMlABBdbYpieghxXjjWw8lMs6yBVezpTx3/eZzq/v8C4z
	JknPuqIveoA3vr4izWxU7Fx6ozkjiHK2ZA7wGQSlDXeAS9NUDB9oFvYOVLzarJU4Mg9Ura4MqGt
	4l0YmY2+2sFaLvOPv9UYXc+vPUKFP
X-Google-Smtp-Source: AGHT+IEDiFMhedI4IslUGRI+3Jp5FaDHdINX1zYAUbvcHQ3GbGjKqs8Jj2wnjRBrLZfxbW3rWyaABQ==
X-Received: by 2002:a05:651c:54f:b0:30b:d156:9ea2 with SMTP id 38308e7fff4ca-330535ede1dmr4308531fa.0.1752266203774;
        Fri, 11 Jul 2025 13:36:43 -0700 (PDT)
Received: from paasan.tail13fe4.ts.net ([2001:4641:9d1:0:c6a9:2307:c38e:a2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab91a64csm8246021fa.111.2025.07.11.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:36:41 -0700 (PDT)
From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	phillip.wood123@gmail.com,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] rebase: write script before initializing state
Date: Fri, 11 Jul 2025 22:36:15 +0200
Message-ID: <20250711203615.9982-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqfrf6qkyy.fsf@gitster.g>
References: <xmqqfrf6qkyy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If rebase.instructionFormat is invalid the repository is left in a
strange state when the interactive rebase fails. `git status` outputs
both the same as it would have in the normal case *and* something
related to the interactive rebase:

    $ git -c rebase.instructionFormat=blah rebase -i
    fatal: invalid --pretty format: blah
    $ git status
    On branch master
    Your branch is ahead of 'upstream/master' by 1 commit.
      (use "git push" to publish your local commits)

    git-rebase-todo is missing.
    No commands done.
    No commands remaining.
    You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
      (use "git commit --amend" to amend the current commit)
      (use "git rebase --continue" once you are satisfied with your changes)

get_commit_format() calls die() on failure so we cannot handle the error
gracefully. By attempting to write the rebase script before initializing
the state this bad state can be avoided.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
So sorry for the delay. I saw that the signoff was missing, then saw
Phillip's review, decided to think about it and then life happened in
the mean time...

This patch is identical to the first one except it has the missing
signoff and a few typos in the commit message corrected. Phillip's
suggestions are noted and appreciated but unfortunately I am unable to
work on the at the moment. And I do think my patch is at least an
improvement albeit perhaps less thorough than it could have been.

Øsse

 builtin/rebase.c             | 42 ++++++++++++++++++------------------
 t/t3415-rebase-autosquash.sh | 10 +++++++++
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e8c4ee678..8139816417 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -293,15 +293,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 				&revisions, &shortrevisions))
 		goto cleanup;
 
-	if (init_basic_state(&replay,
-			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head->object.oid))
-		goto cleanup;
-
-	if (!opts->upstream && opts->squash_onto)
-		write_file(path_squash_onto(), "%s\n",
-			   oid_to_hex(opts->squash_onto));
-
 	strvec_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
 		strvec_pushf(&make_script_args, "^%s",
@@ -310,21 +301,30 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.nr, make_script_args.v,
 				    flags);
-
-	if (ret)
+	if (ret) {
 		error(_("could not generate todo list"));
-	else {
-		discard_index(the_repository->index);
-		if (todo_list_parse_insn_buffer(the_repository, &replay,
-						todo_list.buf.buf, &todo_list))
-			BUG("unusable todo list");
-
-		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head->object.oid, &opts->exec,
-			opts->autosquash, opts->update_refs, &todo_list);
+		goto cleanup;
 	}
 
+	if (init_basic_state(&replay,
+			     opts->head_name ? opts->head_name : "detached HEAD",
+			     opts->onto, &opts->orig_head->object.oid))
+		goto cleanup;
+
+	if (!opts->upstream && opts->squash_onto)
+		write_file(path_squash_onto(), "%s\n",
+			   oid_to_hex(opts->squash_onto));
+
+	discard_index(the_repository->index);
+	if (todo_list_parse_insn_buffer(the_repository, &replay,
+					todo_list.buf.buf, &todo_list))
+		BUG("unusable todo list");
+
+	ret = complete_action(the_repository, &replay, flags,
+		shortrevisions, opts->onto_name, opts->onto,
+		&opts->orig_head->object.oid, &opts->exec,
+		opts->autosquash, opts->update_refs, &todo_list);
+
 cleanup:
 	replay_opts_release(&replay);
 	free(revisions);
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 26b42a526a..5d093e3a7a 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
 	)
 '
 
+test_expect_success 'autosquash with invalid custom instructionFormat' '
+	git reset --hard base &&
+	test_commit invalid-instructionFormat-test &&
+	(
+		test_must_fail git -c rebase.instructionFormat=blah \
+			rebase --autosquash  --force-rebase -i HEAD^ &&
+		test_path_is_missing .git/rebase-merge
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
-- 
2.43.0


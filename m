Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77C1EABA5
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521503; cv=none; b=Lk/JQmQGH6MEo27rlnJTfZp4GCoIYFeU4nCTus8JYVEzmi/TFsaVlvnMk5NGs/AsGVQLjU2r8nbvmIAJs7o3c7JtEEqL5M+2j/dky2JT0pEOMYA0MC2U8Xq7/DPSxTVl7806GZfKeA+E18UAbeSDOHO4CzxdvJ/TgR5WoOLJ4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521503; c=relaxed/simple;
	bh=h8jfJLtfwOpuMCkuwfncOyMWolJlfdl3fBwM4gQY9Cs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SKkv3VAy4hj6pAxZriKkhGHxkk/OJiT5/KupmpEfBO0euIOQtwVtwZOSdjMWwV1qysiTeBymTFD6c8J8C41z6MTa+AzSvhkp8a/7xVqjBBPSmsupfiLqBpvx6IlYjCWD+XenIRpJwLBn/XaIhl4iKf6cBzNI0A/R7FU/KtflD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZGuFq44; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZGuFq44"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so3354357f8f.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521497; x=1730126297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W1DTiNpn7kxV97/jYrxpu3rCz++q1DWICeLpMsLwYU=;
        b=CZGuFq447gUBtFt2POtiffaKTNHyde0Fh/XG6GNkV6h5vLBZ0QUmAZs2EIdoH1MPLz
         jEywMabhpn+Ya1eQ5xKhZeXCt9MwRueO4ENmi01SUWv9UjWTc4zlBAh96zdIWPfsE1DL
         DJRdIziBa/hju8Gl0ew1Zl9mfEvgNUNVD6YO+C12RCe43TZbHJrwp+HmxhNMxcggv3I+
         MUEAS8kBSHGpdOB71nRuifzcWk0d1M/ZBisYGGtVd2PyrgD/9CTzT5J+H2rVAiMi+vvC
         WslZRoIp5SECfIR7uhsT8zsIhhhl4ouxsCnsyivdJYFBcUkrlEXXt7pdth6G48JtQqRK
         JNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521497; x=1730126297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W1DTiNpn7kxV97/jYrxpu3rCz++q1DWICeLpMsLwYU=;
        b=jFCtqpmub9r7zJG3oLLJQZ/5VqVHQb7RoacOkITxYZupelzknoIGpSgZO23iVyLR2W
         4EjHayH7fOtCqsiA2wszs6LwdHPfJxhxYz0oQpd9xTCwhdEj8TMW9R53pphGQYynPW4M
         RtSbR0IpSceFSeLEPBLx9wPRVuXMHQauz0YCMqD02KMw7idk7AQHK8xz9glYXlm6BoMo
         B30y/i3cGVYqE/5+hvxXUjZHPigA3wQKtqv+5DshfrANCN1UWY3EggF9l0mHcvBVjFnu
         QlrdN8yYl3zqk9H2xke1SwkuVXh+2dvBfkjO7Jkj4TM/gXZLBrxS1RQPuV5WCqhOPHt5
         uttw==
X-Gm-Message-State: AOJu0Ywsr/pyPpdqv1/vae6nesMqetN18wa2mToTzG0v3JTMdOtn07/b
	kTZT6ERZlftab1jH9ZijosOVT8GqHwWH+Y7R6kD5TZj1BxFU0FOhZUkF9g==
X-Google-Smtp-Source: AGHT+IFHnYuTgpmt/AhTcAGiBtHKJ5KbUxRWjgvEV1QlPCoPjrkjGVBH94rwActaO3aM5ARiiQL8hw==
X-Received: by 2002:a5d:4c86:0:b0:37d:5359:1ec1 with SMTP id ffacd0b85a97d-37ebd3ba162mr6664580f8f.57.1729521497149;
        Mon, 21 Oct 2024 07:38:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1adsm2001028a12.69.2024.10.21.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:38:16 -0700 (PDT)
Message-Id: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
In-Reply-To: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
References: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Oct 2024 14:38:15 +0000
Subject: [PATCH v3] notes: teach the -e option to edit messages in editor
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Notes can be added to a commit using:
	- "-m" to provide a message on the command line.
	- -C to copy a note from a blob object.
	- -F to read the note from a file.
When these options are used, Git does not open an editor,
it simply takes the content provided via these options and
attaches it to the commit as a note.

Improve flexibility to fine-tune the note before finalizing it
by allowing the messages to be prefilled in the editor and edited
after the messages have been provided through -[mF].

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
    [Outreachy][RFC/PATCH] notes: teach the -e option to edit messages in
    editor
    
    Notes can be added to a commit using the -m (message), -C (copy a note
    from a blob object) or -F (read the note from a file) options. When
    these options are used, Git does not open an editor, it simply takes the
    content provided via these options and attaches it to the commit as a
    note.
    
    Improve flexibility to fine-tune the note before finalizing it by
    allowing the messages to be prefilled in the editor and edited after
    they have been provided through -[mF].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1817%2Fdevdekunle%2Fnotes_add_e_option-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1817/devdekunle/notes_add_e_option-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1817

Range-diff vs v2:

 1:  55804cd1269 ! 1:  8f80c61ec0d notes: teach the -e option to edit messages in editor
     @@ Metadata
       ## Commit message ##
          notes: teach the -e option to edit messages in editor
      
     -    Notes can be added to a commit using the -m (message),
     -    -C (copy a note from a blob object) or
     -    -F (read the note from a file) options.
     +    Notes can be added to a commit using:
     +            - "-m" to provide a message on the command line.
     +            - -C to copy a note from a blob object.
     +            - -F to read the note from a file.
          When these options are used, Git does not open an editor,
          it simply takes the content provided via these options and
          attaches it to the commit as a note.
      
          Improve flexibility to fine-tune the note before finalizing it
     -    by allowing the messages to be prefilled in the editor and editted
     +    by allowing the messages to be prefilled in the editor and edited
          after the messages have been provided through -[mF].
      
          Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
     @@ Documentation/git-notes.txt: SYNOPSIS
       [verse]
       'git notes' [list [<object>]]
      -'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     -+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
     ++'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
       'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
      -'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     -+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
     ++'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
       'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
       'git notes' show [<object>]
       'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
     @@ t/t3301-notes.sh: test_expect_success 'empty notes do not invoke the editor' '
      +	MSG="Appended edited note message" git notes append -m "New appended note" -e &&
      +
      +	# Verify the note content was appended and edited
     -+	echo "Initial note message" >expect &&
     -+	echo "" >>expect &&
     -+	echo "Appended edited note message" >>expect &&
     ++
     ++	cat >expect <<-EOF &&
     ++		Initial note message
     ++
     ++		Appended edited note message
     ++	EOF
      +	git notes show >actual &&
      +	test_cmp expect actual &&
      +	git notes remove HEAD &&
      +
     -+	#Append a note using -F and edit it
     ++	# Append a note using -F and edit it
      +	echo "Note from file" >note_file &&
      +	git notes add -m "Initial note message" &&
      +	MSG="Appended edited note from file" git notes append -F note_file -e &&
      +
      +	# Verify notes from file has been edited in editor and appended
     -+	echo "Initial note message" >expect &&
     -+	echo "" >>expect &&
     -+	echo "Appended edited note from file" >>expect &&
     ++	cat >expect <<-EOF &&
     ++		Initial note message
     ++
     ++		Appended edited note from file
     ++	EOF
      +	git notes show >actual &&
      +	test_cmp expect actual
      +'
     @@ t/t3301-notes.sh: test_expect_success 'empty notes do not invoke the editor' '
      +	git notes show >actual &&
      +	test_cmp expect actual
      +'
     ++test_expect_success 'git notes append aborts when editor fails with -e' '
     ++	test_commit 22nd &&
     ++	echo "foo-file-1" >note_1 &&
     ++
     ++	# Try to append a note with -F and -e, but make the editor fail
     ++	test_env GIT_EDITOR="false" test_must_fail git notes append -F note_1 -e &&
     ++
     ++	# Verify that no note was added due to editor failure
     ++	test_must_fail git notes show
     ++'
      +
       test_done


 Documentation/git-notes.txt | 10 ++++--
 builtin/notes.c             |  8 +++--
 t/t3301-notes.sh            | 71 +++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index c9221a68cce..84022f99d76 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
 'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -67,7 +67,9 @@ add::
 	the existing notes will be opened in the editor (like the `edit`
 	subcommand). If you specify multiple `-m` and `-F`, a blank
 	line will be inserted between the messages. Use the `--separator`
-	option to insert other delimiters.
+	option to insert other delimiters. You can use `-e` to edit and
+	fine-tune the message(s) supplied from `-m` and `-F` options
+	interactively (using an editor) before adding the note.
 
 copy::
 	Copy the notes for the first object onto the second object (defaults to
@@ -93,6 +95,8 @@ append::
 	an existing note, a blank line is added before each new
 	message as an inter-paragraph separator.  The separator can
 	be customized with the `--separator` option.
+	Edit the notes to be appended given by `-m` and `-F` options with
+	`-e` interactively (using an editor) before appending the note.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
diff --git a/builtin/notes.c b/builtin/notes.c
index 8c26e455269..72c8a51cfac 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -32,9 +32,9 @@
 static const char *separator = "\n";
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>] [-e]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>] [-e]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
@@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg),
+		OPT_BOOL('e', "edit", &d.use_editor,
+			N_("edit note message in editor")),
 		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg),
@@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg),
+		OPT_BOOL('e', "edit", &d.use_editor,
+			N_("edit note message in editor")),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT_CALLBACK_F(0, "separator", &separator,
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 99137fb2357..2827f592c66 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1567,4 +1567,75 @@ test_expect_success 'empty notes do not invoke the editor' '
 	git notes remove HEAD
 '
 
+test_expect_success 'git notes add with -m/-F invokes editor with -e' '
+	test_commit 19th &&
+	MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
+	echo "Edited notes message" >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove HEAD &&
+
+	# Add a note using -F and edit it
+	echo "Note from file" >note_file &&
+	MSG="Edited note from file" git notes add -F note_file -e &&
+	echo "Edited note from file" >expect &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
+	test_commit 20th &&
+	git notes add -m "Initial note message" &&
+	MSG="Appended edited note message" git notes append -m "New appended note" -e &&
+
+	# Verify the note content was appended and edited
+
+	cat >expect <<-EOF &&
+		Initial note message
+
+		Appended edited note message
+	EOF
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove HEAD &&
+
+	# Append a note using -F and edit it
+	echo "Note from file" >note_file &&
+	git notes add -m "Initial note message" &&
+	MSG="Appended edited note from file" git notes append -F note_file -e &&
+
+	# Verify notes from file has been edited in editor and appended
+	cat >expect <<-EOF &&
+		Initial note message
+
+		Appended edited note from file
+	EOF
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git notes with a combination of -m, -F and -e invokes editor' '
+	test_commit 21st &&
+	echo "foo-file-1" >note_1 &&
+	echo "foo-file-2" >note_2 &&
+
+	MSG="Collapsed edited notes" git notes append -F note_1 -m "message-1" -F note_2 -e &&
+
+	# Verify that combined messages from file and -m have been edited
+
+	echo "Collapsed edited notes" >expect &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'git notes append aborts when editor fails with -e' '
+	test_commit 22nd &&
+	echo "foo-file-1" >note_1 &&
+
+	# Try to append a note with -F and -e, but make the editor fail
+	test_env GIT_EDITOR="false" test_must_fail git notes append -F note_1 -e &&
+
+	# Verify that no note was added due to editor failure
+	test_must_fail git notes show
+'
+
 test_done

base-commit: 15030f9556f545b167b1879b877a5d780252dc16
-- 
gitgitgadget

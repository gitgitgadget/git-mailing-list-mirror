Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E3366
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729382587; cv=none; b=gJIHFRXhDjlp0xWYtM4ijCY2/X0rU8i8NRKaibfYZTmHfiWTdhT2wC6FX4TjTfBn4VUxtnvmnR6f/DlilGV3k8NnwTtJGazG7kALx1t0MoaRqyy438N5qjtJkkGt5EGfbFjTkt60NBijQtAEykzqiZyDPDzEGcMYy2zyQaHquUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729382587; c=relaxed/simple;
	bh=4sp354reowb5UE+n1obypI3yLsyov4biEohoxfQMvFw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z0br/xHfAMZXqZzB0THmbgnC1FJdSvxNui7ehQz5o0iWAxQFwcFuIrPkIN+mI+Cepf3l+7j4g/EnnXBz3RWsrRrkCh4833dw7ZF3thyRB7gkbhOq2lrASKWjtgAIdqBkXWIezyl+QUrdg7D0v77u1+ReKGUOA+nEqdJTQI3kZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrv/d71c; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrv/d71c"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d461162b8so2198452f8f.1
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729382583; x=1729987383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGPHIKFcZ5l2/7uUoE8JTUOOIDl4R6017AhTnQ9wKvQ=;
        b=Qrv/d71cr3yt4Eumw/NYXWTvh1SRfIHeQBDd0yqEZADTXZBx+fwlKtxm3wSTXCYGnI
         e1lm/3YhOXhAcrWKtXjyyW+eRdvDsXGrekJy55niiPVFNUohcQ4ShZvnWMFn4ESIZgbX
         DcZFrbm6ukbCkzKJw8bhmSJ6zr7YY7VmtlFH/6aLIXU0znANqq0jJvG3arKVKFFZtqTJ
         rkhsqUcGHcoWUkpSK8R7m030ELLt8prH3JDwTzhPu7H7tt9EheBp/lnRKKFzIztcGhD0
         7u/XCTKwGOU9jDRjvE6rj/KNuZJjGlp9HYryTTEuFYE/pwarSbTPLq2an6wUbChWRSbm
         uPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729382583; x=1729987383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGPHIKFcZ5l2/7uUoE8JTUOOIDl4R6017AhTnQ9wKvQ=;
        b=fPFfwYozygKsUjKqvxxMsOWoKmGIVvhxavNNrU2AyzTj9vs/b9sE4frb9EV2QlUnFg
         ID2jugwaD9ErH2OIfoGwRQhfWP8HqRfqHDa0mgpS7/a60uroQMYiI/f3JAl/QGa59nab
         lwZ2KWvcMZzz9wUlselLThvq0B1MQsOYbi7nPN/npAdXeG2dzlITAqv2V08EdNEUnLD1
         g9ciQt1aW9kl4MVkXk90a+IkLjustV6q/6sXMAkntN2b+MNNcQ59NBGEvRtUBxIiieTQ
         ZkKz49cZXcgAwq5lW5SrO1xS/Ruf086VVRujv6hKBd+of6sG/T48MZkwlYcVG3nKBW+L
         OUQw==
X-Gm-Message-State: AOJu0YzK5/ugZ07rbMDLnRIRr6+y98bW8b2EP2nD9u2SEGodDSo7IMu/
	TpZ1LkOptQca8SKlVXZ7lbJRfK4HC70ncHgSXlJpQD+vVwATzuDXRq95KA==
X-Google-Smtp-Source: AGHT+IFVENuJI2zmQDfpVdey/oYOasT3GA2R3PFT4/nZfglvD5RpJ4buomwK4y37AX9VREKz6BzjmA==
X-Received: by 2002:a5d:6dca:0:b0:37d:37b2:385d with SMTP id ffacd0b85a97d-37ea2140067mr4416450f8f.12.1729382582637;
        Sat, 19 Oct 2024 17:03:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6547esm318050a12.37.2024.10.19.17.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 17:03:02 -0700 (PDT)
Message-Id: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
In-Reply-To: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 00:03:00 +0000
Subject: [PATCH v2] notes: teach the -e option to edit messages in editor
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

Notes can be added to a commit using the -m (message),
-C (copy a note from a blob object) or
-F (read the note from a file) options.
When these options are used, Git does not open an editor,
it simply takes the content provided via these options and
attaches it to the commit as a note.

Improve flexibility to fine-tune the note before finalizing it
by allowing the messages to be prefilled in the editor and editted
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1817%2Fdevdekunle%2Fnotes_add_e_option-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1817/devdekunle/notes_add_e_option-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1817

Range-diff vs v1:

 1:  61a6d2dbcb9 ! 1:  55804cd1269 notes: teach the -e option to edit messages in editor
     @@ Commit message
      
          Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
      
     + ## Documentation/git-notes.txt ##
     +@@ Documentation/git-notes.txt: SYNOPSIS
     + --------
     + [verse]
     + 'git notes' [list [<object>]]
     +-'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     ++'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
     + 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     +-'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     ++'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
     + 'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
     + 'git notes' show [<object>]
     + 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
     +@@ Documentation/git-notes.txt: add::
     + 	the existing notes will be opened in the editor (like the `edit`
     + 	subcommand). If you specify multiple `-m` and `-F`, a blank
     + 	line will be inserted between the messages. Use the `--separator`
     +-	option to insert other delimiters.
     ++	option to insert other delimiters. You can use `-e` to edit and
     ++	fine-tune the message(s) supplied from `-m` and `-F` options
     ++	interactively (using an editor) before adding the note.
     + 
     + copy::
     + 	Copy the notes for the first object onto the second object (defaults to
     +@@ Documentation/git-notes.txt: append::
     + 	an existing note, a blank line is added before each new
     + 	message as an inter-paragraph separator.  The separator can
     + 	be customized with the `--separator` option.
     ++	Edit the notes to be appended given by `-m` and `-F` options with
     ++	`-e` interactively (using an editor) before appending the note.
     + 
     + edit::
     + 	Edit the notes for a given object (defaults to HEAD).
     +
       ## builtin/notes.c ##
     +@@
     + static const char *separator = "\n";
     + static const char * const git_notes_usage[] = {
     + 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
     +-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
     ++	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>] [-e]"),
     + 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
     +-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
     ++	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>] [-e]"),
     + 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
     + 	N_("git notes [--ref <notes-ref>] show [<object>]"),
     + 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
      @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
       		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
       			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
     @@ t/t3301-notes.sh: test_expect_success 'empty notes do not invoke the editor' '
       	git notes remove HEAD
       '
       
     -+test_expect_success '"git notes add" with -m/-F invokes the editor with -e' '
     ++test_expect_success 'git notes add with -m/-F invokes editor with -e' '
      +	test_commit 19th &&
     -+	GIT_EDITOR="true" git notes add -m "note message" -e &&
     ++	MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
     ++	echo "Edited notes message" >expect &&
     ++	git notes show >actual &&
     ++	test_cmp expect actual &&
      +	git notes remove HEAD &&
     -+	echo "message from file" >file_1 &&
     -+	GIT_EDITOR="true" git notes add -F file_1 -e &&
     -+	git notes remove HEAD
     ++
     ++	# Add a note using -F and edit it
     ++	echo "Note from file" >note_file &&
     ++	MSG="Edited note from file" git notes add -F note_file -e &&
     ++	echo "Edited note from file" >expect &&
     ++	git notes show >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git notes append with -m/-F invokes editor with -e' '
     ++test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
      +	test_commit 20th &&
     -+	GIT_EDITOR="true" git notes add -m "initial note" -e &&
     -+	GIT_EDITOR="true" git notes append -m "appended note" -e &&
     ++	git notes add -m "Initial note message" &&
     ++	MSG="Appended edited note message" git notes append -m "New appended note" -e &&
     ++
     ++	# Verify the note content was appended and edited
     ++	echo "Initial note message" >expect &&
     ++	echo "" >>expect &&
     ++	echo "Appended edited note message" >>expect &&
     ++	git notes show >actual &&
     ++	test_cmp expect actual &&
      +	git notes remove HEAD &&
     -+	echo  "initial note" >note_a &&
     -+	echo "appended note" >note_b &&
     -+	GIT_EDITOR="true" git notes add -F note_a -e &&
     -+	GIT_EDITOR="true" git notes append -F note_b -e &&
     -+	git notes remove HEAD
     ++
     ++	#Append a note using -F and edit it
     ++	echo "Note from file" >note_file &&
     ++	git notes add -m "Initial note message" &&
     ++	MSG="Appended edited note from file" git notes append -F note_file -e &&
     ++
     ++	# Verify notes from file has been edited in editor and appended
     ++	echo "Initial note message" >expect &&
     ++	echo "" >>expect &&
     ++	echo "Appended edited note from file" >>expect &&
     ++	git notes show >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'append note with multiple combinations of -m, -F and -e, invokes editor' '
     ++test_expect_success 'git notes with a combination of -m, -F and -e invokes editor' '
      +	test_commit 21st &&
      +	echo "foo-file-1" >note_1 &&
      +	echo "foo-file-2" >note_2 &&
     -+	GIT_EDITOR="true" git notes append -F note_1 -m "message-1" -F note_2 -m "message-2" -e &&
     -+	git notes remove HEAD
     ++
     ++	MSG="Collapsed edited notes" git notes append -F note_1 -m "message-1" -F note_2 -e &&
     ++
     ++	# Verify that combined messages from file and -m have been edited
     ++
     ++	echo "Collapsed edited notes" >expect &&
     ++	git notes show >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_done


 Documentation/git-notes.txt | 10 +++++--
 builtin/notes.c             |  8 ++++--
 t/t3301-notes.sh            | 56 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index c9221a68cce..d5505a426aa 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
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
index 99137fb2357..ffa1d21671d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1567,4 +1567,60 @@ test_expect_success 'empty notes do not invoke the editor' '
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
+	echo "Initial note message" >expect &&
+	echo "" >>expect &&
+	echo "Appended edited note message" >>expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove HEAD &&
+
+	#Append a note using -F and edit it
+	echo "Note from file" >note_file &&
+	git notes add -m "Initial note message" &&
+	MSG="Appended edited note from file" git notes append -F note_file -e &&
+
+	# Verify notes from file has been edited in editor and appended
+	echo "Initial note message" >expect &&
+	echo "" >>expect &&
+	echo "Appended edited note from file" >>expect &&
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
+
 test_done

base-commit: 15030f9556f545b167b1879b877a5d780252dc16
-- 
gitgitgadget

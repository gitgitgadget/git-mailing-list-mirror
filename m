Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF81991AE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534347; cv=none; b=Df6k6hW2rYnWP0U7jEvsR5jxBDPg0DmTBsTz4fUomrJfgY/JCYj2fpD0Ku1s91iExYNgfQJC2zd7TSjhP9EBYscYWoCJRr5LtqHyMgmqpHtz+Zffebj9gdZLcxRi8BSwnpxP1xK839tEiXa53gH5Wuwksal0briTSuIfjoWaqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534347; c=relaxed/simple;
	bh=Aa5r24NhLOfk6byL2gFageDFdAnDk2UWkV1AuJPAqss=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nErtBIWmuhqyrHfV/yvsmN0z6SAq93SqOAP8Wr0crr7DTz1WPVGq1IViZtftd2o+BuIFQPopKGcUyXUgWHAv2FUjLGbA7o1WDnszGDBOk6gQRl1hbiO03TSf9mpC1f5aFzWWykCLnSWkYNeMslm771vXx2d/a33dAN/VNps+CnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1izkV6N; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1izkV6N"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so5565186a12.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729534343; x=1730139143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZtMwm4Ks+uHzHLUwx34mECtThrSrm+bC8BqnojGXmY=;
        b=O1izkV6Ni3oZ2Hq58vF0c0JkAKgvj1oQcF8F7aYkmjMdbnMvl2DnNdCssudspNbTke
         9mQwEFP/kqN5zc3SYGi8ORzeHGZGgTWz0lueV63SgQ+b4AroinkYfbjDMdMIYNedpHAw
         0r+vN9SrjkOhHwvMyBD6nGuLLTowtlOXGY+UPo0cptGxJDfgA+Z/O6VJs5rJs9zwdIPg
         ApTkiguIVdcTPRG/pi/q+EgGEudgGw6D0eOpHuYBd4HFasf8SBNHB3VtJF7QV+jgms4G
         0qj6JKxos1AfFKo5lvFapWEzgav+UO/ORza17bMb7zjfITTN9ZPVZneI3o2edw2/q2fY
         6xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534343; x=1730139143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZtMwm4Ks+uHzHLUwx34mECtThrSrm+bC8BqnojGXmY=;
        b=IxSvZ8uJYzb+tO5LdFdg+lNksFyLjHa+bo2YhuJsTrxfWNGldDswov61xJN3LlKlvh
         ZxMipMVtqo3Yvh5aYhLqdNmfFlLPI8W0axUGHiCbMS1Or6zWn0ZAhelRBM/7lHo9r4Rh
         rWfi4MZqTGF2miP+Uv4WUmn1M4Hpd+jDYyPLt30CmHcHtC1nGxG/WJjj4Wn3NvD+TASR
         IIuY9w0rsqmkeN/Ou/m5wk/dzak688LOJqLMXgXjYhlsbmYxmaX643PUGBLA8ohcGZYq
         aJLJIeFeQtGgg57mAd0bbq9Ui89GHMQRKNid6AuyoUXedjfQfyIxqaouJpqEV68XaWjS
         tr9Q==
X-Gm-Message-State: AOJu0YwZOIb7bUiK31vvc4K6Xk3gNYqG8TSfjAVba32+auUfUhV8d7Bl
	zIGdO8/BNpIECerhKgVX7kMRNngcTMtGj0tOSrpCBCwGu6qd94AmGTFDSw==
X-Google-Smtp-Source: AGHT+IHz8rwOgIKZpeOwgjfRvkalA46Lg4WE1ic6xQMlpoRQi6prne2FUW1Wrje/D8IRZmCOxpr7Tw==
X-Received: by 2002:a17:906:7956:b0:a9a:61d:7084 with SMTP id a640c23a62f3a-a9a69c996famr1205277166b.50.1729534342317;
        Mon, 21 Oct 2024 11:12:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f62cbsm238008666b.76.2024.10.21.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:12:22 -0700 (PDT)
Message-Id: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>
In-Reply-To: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
References: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Oct 2024 18:12:20 +0000
Subject: [PATCH v4] notes: teach the -e option to edit messages in editor
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
    Taylor Blau <me@ttaylorr.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1817%2Fdevdekunle%2Fnotes_add_e_option-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1817/devdekunle/notes_add_e_option-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1817

Range-diff vs v3:

 1:  8f80c61ec0d ! 1:  4ecf79e0766 notes: teach the -e option to edit messages in editor
     @@ t/t3301-notes.sh: test_expect_success 'empty notes do not invoke the editor' '
       
      +test_expect_success 'git notes add with -m/-F invokes editor with -e' '
      +	test_commit 19th &&
     -+	MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
     -+	echo "Edited notes message" >expect &&
     ++	echo "edited" >expect &&
     ++	MSG="$(cat expect)" git notes add -m "initial" -e &&
      +	git notes show >actual &&
      +	test_cmp expect actual &&
      +	git notes remove HEAD &&
      +
      +	# Add a note using -F and edit it
     -+	echo "Note from file" >note_file &&
     -+	MSG="Edited note from file" git notes add -F note_file -e &&
     -+	echo "Edited note from file" >expect &&
     ++	echo "initial" >note_file &&
     ++	MSG="$(cat expect)" git notes add -F note_file -e &&
      +	git notes show >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
      +	test_commit 20th &&
     -+	git notes add -m "Initial note message" &&
     -+	MSG="Appended edited note message" git notes append -m "New appended note" -e &&
     -+
     -+	# Verify the note content was appended and edited
     -+
      +	cat >expect <<-EOF &&
     -+		Initial note message
     ++		initial
      +
     -+		Appended edited note message
     ++		edited
      +	EOF
     ++	git notes add -m "initial" &&
     ++	MSG="edited" git notes append -m "appended" -e &&
     ++
     ++	# Verify the note content was appended and edited
      +	git notes show >actual &&
      +	test_cmp expect actual &&
      +	git notes remove HEAD &&
      +
      +	# Append a note using -F and edit it
     -+	echo "Note from file" >note_file &&
     -+	git notes add -m "Initial note message" &&
     -+	MSG="Appended edited note from file" git notes append -F note_file -e &&
     ++	echo "note from file" >note_file &&
     ++	git notes add -m "initial" &&
     ++	MSG="edited" git notes append -F note_file -e &&
      +
      +	# Verify notes from file has been edited in editor and appended
     -+	cat >expect <<-EOF &&
     -+		Initial note message
     -+
     -+		Appended edited note from file
     -+	EOF
      +	git notes show >actual &&
      +	test_cmp expect actual
      +'
     @@ t/t3301-notes.sh: test_expect_success 'empty notes do not invoke the editor' '
      +	test_commit 21st &&
      +	echo "foo-file-1" >note_1 &&
      +	echo "foo-file-2" >note_2 &&
     ++	echo "edited" >expect &&
      +
     -+	MSG="Collapsed edited notes" git notes append -F note_1 -m "message-1" -F note_2 -e &&
     ++	MSG=$(cat expect) git notes append -F note_1 -m "message-1" -F note_2 -e &&
      +
      +	# Verify that combined messages from file and -m have been edited
     -+
     -+	echo "Collapsed edited notes" >expect &&
      +	git notes show >actual &&
      +	test_cmp expect actual
      +'


 Documentation/git-notes.txt | 10 ++++--
 builtin/notes.c             |  8 +++--
 t/t3301-notes.sh            | 63 +++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 5 deletions(-)

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
index 99137fb2357..813dfd8db97 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1567,4 +1567,67 @@ test_expect_success 'empty notes do not invoke the editor' '
 	git notes remove HEAD
 '
 
+test_expect_success 'git notes add with -m/-F invokes editor with -e' '
+	test_commit 19th &&
+	echo "edited" >expect &&
+	MSG="$(cat expect)" git notes add -m "initial" -e &&
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove HEAD &&
+
+	# Add a note using -F and edit it
+	echo "initial" >note_file &&
+	MSG="$(cat expect)" git notes add -F note_file -e &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
+	test_commit 20th &&
+	cat >expect <<-EOF &&
+		initial
+
+		edited
+	EOF
+	git notes add -m "initial" &&
+	MSG="edited" git notes append -m "appended" -e &&
+
+	# Verify the note content was appended and edited
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove HEAD &&
+
+	# Append a note using -F and edit it
+	echo "note from file" >note_file &&
+	git notes add -m "initial" &&
+	MSG="edited" git notes append -F note_file -e &&
+
+	# Verify notes from file has been edited in editor and appended
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git notes with a combination of -m, -F and -e invokes editor' '
+	test_commit 21st &&
+	echo "foo-file-1" >note_1 &&
+	echo "foo-file-2" >note_2 &&
+	echo "edited" >expect &&
+
+	MSG=$(cat expect) git notes append -F note_1 -m "message-1" -F note_2 -e &&
+
+	# Verify that combined messages from file and -m have been edited
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

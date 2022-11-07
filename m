Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2C6C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiKGN5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGN5N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:57:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2B1CFEA
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:57:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l6so10683881pjj.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhKbhBfa7S/y/YUZ4mg3bWVqjxat2Z+IWetQPSQYrg0=;
        b=UjTlJjop8bRt2OD5GhBg3JNMn2a9KscOG1Ea0oRBZDAnwsuBw/TR7gLIUFXABcC+s8
         R5iSHELW3D1gD7RyDWO9men16EulnDapNJff7K6d7Q4BrYDzmSccI8lHIom5CbTTS8bf
         /OkdDlxwWCv21JsjQ6UkeSFbY9kWUE7uJbLhcLFf6QucJUebaepKH3bN04lZfwoVvEaZ
         3XpeCIq+vSFUbRP3iO8Bd2uRQnLsPUe7enMtJCxJ97bb2uaCmY9bGqDTEm5LhVh0IJ1j
         PxHiuZ+m3AvnYyoVtLHMCvrgMLtxUG1J4c1v1TfLmNPfXdCUfC9BYffKmK6gcNJBNKKw
         kqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhKbhBfa7S/y/YUZ4mg3bWVqjxat2Z+IWetQPSQYrg0=;
        b=rAWtZt+bepn7TXTA4povZXgmtT4BTG4wsJUJW3L0ooW29KEN7VTmBVQeVcc9ZKfFWI
         4iwonB9zL6PGYIelMKEnIkJHG9dk38PB8hJfmaGFBVDyQMRqo/w/8/QFhVnyYiTH5w/c
         DG7o48zM8WlR3K+qe/GvytoRQH16DUkJpGNdW16AaSk/d1dwLTcCmjImDG8YQKSbpQ5V
         ZpT+MRbFkGNL8WIYzRyGaXvXOAVjJOhRUNIw3+8DenKZ9Fa7bkBs6DU6Fq+rdey3ZeOm
         pCxrLmzSo75YDv4d97WnGRVbKWf4DeBF7Sp5JMLAmq7CQ7CzyUERyKHVRzDeB5oTyFp4
         8pRw==
X-Gm-Message-State: ACrzQf1++FXg+RYLGI+JPqampH9BQrI8kx9ESoclYhZO7iIB/ULmZAQ/
        sZ9hmI/um8dO8E7UnJ1QU88=
X-Google-Smtp-Source: AMsMyM44Uw6TRYu9XH7VynTuruHpCtOWWihyKYlyraikNR7r3VtCX7MlMuw/qof0JSZu8orrtxFt2A==
X-Received: by 2002:a17:902:e846:b0:187:2127:cbb with SMTP id t6-20020a170902e84600b0018721270cbbmr42362944plg.125.1667829432245;
        Mon, 07 Nov 2022 05:57:12 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm4511383pfj.185.2022.11.07.05.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:57:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 0/3] notes.c: introduce "--blank-line" option
Date:   Mon,  7 Nov 2022 21:57:02 +0800
Message-Id: <cover.1667828335.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.ge7205ac0a40.dirty
In-Reply-To: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff from RFC Patch v1:

* optimize the commit-msg and docs of introducing new "--blank-line" option.

* drop unreachable code in "append_edit()". Ævar found that some code has been
unreachable in patch v1. I think it's because, after the commit "notes.c: fixed
tip when target and append note are both empty", for example in this patch, the
situation of "removing an existing note" should be impossible unless a BUG when
trying to do append. The tests are passed, but I'm not sure I fully understand
the original design.

Thanks to Junio C Hamano, Ævar Arnfjörð Bjarmason and Phillip Wood for
the help in v1.

Teng Long (3):
  notes.c: introduce "--blank-line" option
  notes.c: fixed tip when target and append note are both empty
  notes.c: drop unreachable code in "append_edit()"

 Documentation/git-notes.txt | 11 +++++++++--
 builtin/notes.c             | 27 +++++++++++++++++++--------
 t/t3301-notes.sh            | 15 ++++++++++++++-
 3 files changed, 42 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  d69bd0a011 ! 1:  2381947abd notes.c: introduce "--no-blankline" option
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: introduce "--no-blankline" option
    +    notes.c: introduce "--blank-line" option
     
         When appending to a given object which has note and if the appended
         note is not empty too, we will insert a blank line at first. The
         blank line serves as a split line, but sometimes we just want to
    -    omit it then append on the heels of the target note.
    +    omit it then append on the heels of the target note. So, we add
    +    a new "OPT_BOOL()" option to determain whether a new blank line
    +    is insert at first.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/git-notes.txt: SYNOPSIS
      'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' append [--allow-empty] [--no-blankline] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' edit [--allow-empty] [<object>]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
      	to automatically remove empty notes.
      
    ++--blank-line::
     +--no-blank-line::
    -+	When appending note, do not insert a blank line between
    -+	the note of given object and the note to be appended.
    ++	Controls if a blank line to split paragraphs is inserted
    ++	when appending (the default is true).
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c: static int copy(int argc, const char **argv, const char *prefix
      static int append_edit(int argc, const char **argv, const char *prefix)
      {
      	int allow_empty = 0;
    -+	int no_blankline = 0;
    ++	int blankline = 1;
      	const char *object_ref;
      	struct notes_tree *t;
      	struct object_id object, new_note;
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
    -+		OPT_BOOL(0, "no-blankline", &no_blankline,
    -+			N_("do not initially add a blank line")),
    ++		OPT_BOOL(0, "blank-line", &blankline,
    ++			N_("insert paragraph break before appending to an existing note")),
      		OPT_END()
      	};
      	int edit = !strcmp(argv[0], "edit");
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      
      		strbuf_grow(&d.buf, size + 1);
     -		if (d.buf.len && prev_buf && size)
    -+		if (!no_blankline && d.buf.len && prev_buf && size)
    ++		if (blankline && d.buf.len && prev_buf && size)
      			strbuf_insertstr(&d.buf, 0, "\n");
      		if (prev_buf && size)
      			strbuf_insert(&d.buf, 0, prev_buf, size);
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      '
      
     +test_expect_success 'append to existing note without a beginning blank line' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +		Initial set of notes
     +		Appended notes
     +	EOF
     +	git notes add -m "Initial set of notes" &&
    -+	git notes append --no-blankline -m "Appended notes" &&
    ++	git notes append --no-blank-line -m "Appended notes" &&
     +	git notes show >actual &&
     +	test_cmp expect actual
     +'
2:  c581cb24b6 ! 2:  5dbe014a09 notes.c: fixed tip when target and append note are both empty
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
     -	char *logmsg;
     +	char *logmsg = NULL;
      	const char * const *usage;
    - 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
    -+	struct note_data cp = { 0, 0, NULL, STRBUF_INIT };
    +-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
    ++	struct note_data d = {
    ++		.given = 0,
    ++		.use_editor = 0,
    ++		.edit_path = NULL,
    ++		.buf = STRBUF_INIT
    ++	};
    ++
      	struct option options[] = {
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
      			N_("note contents as a string"), PARSE_OPT_NONEG,
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 
    - 	prepare_note_data(&object, &d, edit && note ? note : NULL);
    - 
    -+	strbuf_addbuf(&cp.buf, &d.buf);
    -+
    - 	if (note && !edit) {
    - 		/* Append buf to previous note contents */
    - 		unsigned long size;
    -@@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      		if (add_note(t, &object, &new_note, combine_notes_overwrite))
      			BUG("combine_notes_overwrite failed");
      		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
     +		commit_notes(the_repository, t, logmsg);
    -+	} else if (!cp.buf.len) {
    ++	} else if (!d.buf.len && !note) {
     +		fprintf(stderr,
     +			_("Both original and appended notes are empty in %s, do nothing\n"),
     +			oid_to_hex(&object));
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      
      	free(logmsg);
      	free_note_data(&d);
    -+	free_note_data(&cp);
    - 	free_notes(t);
    - 	return 0;
    - }
     
      ## t/t3301-notes.sh ##
     @@ t/t3301-notes.sh: test_expect_success 'git notes append == add when there is no existing note' '
-:  ---------- > 3:  2475ea0c04 notes.c: drop unreachable code in "append_edit()"
-- 
2.38.1.383.ge7205ac0a40.dirty


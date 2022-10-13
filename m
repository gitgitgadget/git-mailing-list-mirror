Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCCC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 05:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJMF5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJMF5P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 01:57:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE4D12B352
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1078181pjl.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD/WoMz+8La/qcbAKsuNzuWTLF+cJcCaFdF4GSnDTzU=;
        b=KDOat9mZepeQ3cAAKB++extfvxWznxG5IQC60W8SrrBGYgD8q5JR1/XAf0IVn6x2Ir
         ClHtbniMWnWRW5sZN02ogGAzljXKBtAj7BVNslpA1NIy4DXfQve+MPybObUZOc/kJp2u
         X0l3SJEWTOYmhosKudl3Sga4PXaQjghUE2q9FQysJYaxoZ7XLAAiIAQBvBqQG5LCR7Zi
         /nM5kLzitvWLWG2++aGY4+9oqC5ufhjE9YyCXVETbpCbPKc2Zc/v+fFvEA4vCGVY5cN5
         pfir66bg4X1VNdPHlYUcr0qBHUXIgXoTVLwMefm1YGNcxxQNeiouXF2/YMIMK5Tgvdgp
         yEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD/WoMz+8La/qcbAKsuNzuWTLF+cJcCaFdF4GSnDTzU=;
        b=T7Bpp9PbNerGxbeR2ORYfOIF5Colp9/dv59xtSk55CK5pWDgCoh+qQNmd6DBbCdkSv
         Lz9YX1iZqmV5XtgatkSnqQchnn9p2LHeOgvpNL/+wo9J1V/OCXfPyzyIjR7C8AWYe2Bj
         be/j+px7YeOKmY1ngIjzBgZSXXIm78b6O3ABxL2vHndYYq7GqViyZpAD6frmFgBF+2jV
         9r9SH84ZlA7+8VsNTMgt/lmCsYZqF26EaDBZKrG6Ikwj1nFlaebuUaCaG57XV/HcHJkk
         n/ZxHSTAEWz81qFo7XNABLTiZFyLrpGntjmq6Z6hEJvn1L1j+2GDmIc/QbM84GFGNs5B
         nDEQ==
X-Gm-Message-State: ACrzQf1fRqx/5/DT6a0+ESs1w0hZjfsM+Gz3CD1mC+/rMcWHto/Bj4h5
        hHF9QIbC5/pjAGfO0QIb0QaWGGdsORlxfA==
X-Google-Smtp-Source: AMsMyM6pr1rke0+6Fr0IqB6u9xPklJAGrjATxLcr7kwpdckQ1eNq/tW8U3/IWHFYRXgMwrXW+s3afA==
X-Received: by 2002:a17:902:ce08:b0:179:ed2b:8cd8 with SMTP id k8-20020a170902ce0800b00179ed2b8cd8mr33355134plg.23.1665640631481;
        Wed, 12 Oct 2022 22:57:11 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id l76-20020a633e4f000000b00460a5c6304dsm8008822pga.67.2022.10.12.22.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:57:11 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 1/2] notes.c: introduce "--no-blankline" option
Date:   Thu, 13 Oct 2022 13:56:53 +0800
Message-Id: <20221013055654.39628-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc2
In-Reply-To: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When appending to a given object which has note and if the appended
note is not empty too, we will insert a blank line at first. The
blank line serves as a split line, but sometimes we just want to
omit it then append on the heels of the target note.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt | 10 ++++++++--
 builtin/notes.c             |  5 ++++-
 t/t3301-notes.sh            | 12 ++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0f5..fd0fc3d9c7 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--no-blankline] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Creates a new notes object if needed. If the note of the given
+	object and the note to be appended are not empty, a blank line
+	will be inserted between them.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +161,10 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--no-blank-line::
+	When appending note, do not insert a blank line between
+	the note of given object and the note to be appended.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index be51f69225..1ca0476a27 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -562,6 +562,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
 	int allow_empty = 0;
+	int no_blankline = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	struct object_id object, new_note;
@@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_BOOL(0, "no-blankline", &no_blankline,
+			N_("do not initially add a blank line")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -619,7 +622,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
-		if (d.buf.len && prev_buf && size)
+		if (!no_blankline && d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec7d..43ac3feb78 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -521,12 +521,24 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append to existing note without a beginning blank line' '
+	cat >expect <<-EOF &&
+		Initial set of notes
+		Appended notes
+	EOF
+	git notes add -m "Initial set of notes" &&
+	git notes append --no-blankline -m "Appended notes" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'append to existing note with "git notes append"' '
 	cat >expect <<-EOF &&
 		Initial set of notes
 
 		More notes appended with git notes append
 	EOF
+	git notes remove HEAD &&
 	git notes add -m "Initial set of notes" &&
 	git notes append -m "More notes appended with git notes append" &&
 	git notes show >actual &&
-- 
2.38.0.rc2


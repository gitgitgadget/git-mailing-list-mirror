Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128BC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5916D20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgXTLa6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbgAPVSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:18:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbgAPVSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:18:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so20646701wru.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tGWW5GWGQ5n+OONFuzts+bLIu5RMUOprhZXg39c3pDE=;
        b=lgXTLa6LJM5Y3Gpogm35LfBuTGk/G8e7J1E0BF2cJ6tlntNN/nqdF77WLl8rl69OYt
         GT6Vho7luw6KTGKw6lBsaQmODA9XJ/jMzlUWG3WfjH0CrCvj3ifgnFGGIbgeUphRm9O1
         Ixa5WnpNhYN4ELizsb6FAa+8xgh5OVI7h+li+uV6fHxNbKZCh/ghV/eWTgt018HOUzKK
         L6YgxO39xqzzwTGeStzKtXl29PrRz216mKvPQcwQuK5t+5NOVT5Cul0y5PJBqM+8tS1M
         vhoqAqvFiESLWeWsJxI5mAuz7xadDE9b2nQeOMTjonrKfr6zyPlVz8Ix9Wb8Nomfjnv1
         if4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tGWW5GWGQ5n+OONFuzts+bLIu5RMUOprhZXg39c3pDE=;
        b=l26hmzz00dQGQ1RZmNRbn/C7QoifIT2qbPgRn6p/SMbFGoF4GtArC9kgv6z8mfJZzI
         TzU4AvjDJuuMVq7KWtfpXdHlEpJaeV/hjGeBLPNUwuJ6BFEvRwtORMy98hksuk5V4S4/
         BjbrNb4akrDaAjxHBDIodcirltY6P18vK8UwSCXj32FuCLYzXwGmpYMhPZsvxS7oZ6UV
         hbH054YxjG+IfsB+XUG/Me++Empme0pNgHRqNQ56XWkbpwIbc2OgFTToYXHpKn1b9Qac
         9fCGhUM4EFPAcQgQokUNlqsWl03i0cSRQmRsPrgVGRl6mcqo21couOcYUmVfFkKViLol
         Xz/g==
X-Gm-Message-State: APjAAAU0heUJWMZYkwFJjEpGLPV2E4MCSAaaCpUy/NlMq22nPOcP5Syd
        Y4jiyriHx9Sg+/1WOGgeqH50WvM1
X-Google-Smtp-Source: APXvYqyKHUNkkeVvARk2JLsGVi1XxSlfVk99ZIyL6Tq+Q+T7/kMjVsZ32MEBigsWsurXEgSmZ0cvNw==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr5105479wrr.138.1579209509438;
        Thu, 16 Jan 2020 13:18:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm6255751wmj.14.2020.01.16.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:18:28 -0800 (PST)
Message-Id: <ad50cd1b92e3e52309536f3a84064571a224a0da.1579209506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.git.1579209506.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 21:18:25 +0000
Subject: [PATCH 2/3] rebase -i: re-fix short SHA-1 collision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 66ae9a57b88 (t3404: rebase -i: demonstrate short SHA-1 collision,
2013-08-23), we added a test case that demonstrated how it is possible
that a previously unambiguous short commit ID could become ambiguous
*during* a rebase.

In 75c69766554 (rebase -i: fix short SHA-1 collision, 2013-08-23), we
fixed that problem simply by writing out the todo list with expanded
commit IDs (except *right* before letting the user edit the todo list,
in which case we shorten them, but we expand them right after the file
was edited).

However, the bug resurfaced as a side effect of 393adf7a6f6 (sequencer:
directly call pick_commits() from complete_action(), 2019-11-24): as of
this commit, the sequencer no longer re-reads the todo list after
writing it out with expanded commit IDs.

The only redeeming factor is that the todo list is already parsed at
that stage, including all the commits corresponding to the commands,
therefore the sequencer can continue even if the internal todo list has
short commit IDs.

That does not prevent problems, though: the sequencer writes out the
`done` and `git-rebase-todo` files incrementally (i.e. overwriting the
todo list with a version that has _short_ commit IDs), and if a merge
conflict happens, or if an `edit` or a `break` command is encountered, a
subsequent `git rebase --continue` _will_ re-read the todo list, opening
an opportunity for the "short SHA-1 collision" bug again.

To avoid that, let's make sure that we do expand the commit IDs in the
todo list as soon as we have parsed it after letting the user edit it.

Additionally, we improve the 'short SHA-1 collide' test case in t3404 to
test specifically for the case where the rebase is resumed. We also
hard-code the expected colliding short SHA-1s, to document the
expectation (and to make it easier on future readers).

Note that we specifically test that the short commit ID is used in the
`git-rebase-todo.tmp` file: this file is created by the fake editor in
the test script and reflects the state that would have been presented to
the user to edit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   | 14 +++++++++++++-
 t/t3404-rebase-interactive.sh | 15 +++++++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7c30dad59c..c2945c699d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5076,7 +5076,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list->buf;
+	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
 	struct object_id oid = onto->object.oid;
 	int res;
 
@@ -5128,6 +5128,18 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
+	/* Expand the commit IDs */
+	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
+	strbuf_swap(&new_todo.buf, &buf2);
+	strbuf_release(&buf2);
+	new_todo.total_nr -= new_todo.nr;
+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0) {
+		fprintf(stderr, _(edit_todo_list_advice));
+		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
+		todo_list_release(&new_todo);
+		return error(_("invalid todo list after expanding IDs"));
+	}
+
 	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79..1cc9f36bc7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
 test_expect_success SHA1 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
+	colliding_sha1=6bcda37 &&
+	test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
 	(
 		unset test_tick &&
 		test_tick &&
 		set_fake_editor &&
 		FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
-		FAKE_LINES="reword 1 2" git rebase -i HEAD~2
-	)
+		FAKE_LINES="reword 1 break 2" git rebase -i HEAD~2 &&
+		test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
+		grep "^pick $colliding_sha1 " \
+			.git/rebase-merge/git-rebase-todo.tmp &&
+		grep "^pick [0-9a-f]\{40\}" \
+			.git/rebase-merge/git-rebase-todo &&
+		git rebase --continue
+	) &&
+	collide2="$(git rev-parse HEAD~1 | cut -c 1-4)" &&
+	collide3="$(git rev-parse collide3 | cut -c 1-4)" &&
+	test "$collide2" = "$collide3"
 '
 
 test_expect_success 'respect core.abbrev' '
-- 
gitgitgadget


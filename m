Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD95C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9178820719
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj2DgEFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgDAUbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:31:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35450 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:31:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so1521620edj.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=h4+Ursvutr8NPKLL9YWRGFUW5Agq9ZhlNofiRl7vx4U=;
        b=pj2DgEFSkY9RACTQ8Dq/b85gOw3jTwbxX4jUAWJoNVlUoVwtm1j9Cp7BOWOh/dY5Uj
         kVrEnYAY+T0YJIoJjgRIchszYdFC5jZdNiD+UALSDiWaq0TtWiq/6TuRSFoUPHTmzjwH
         0ucGzC8O6QMhN4SDJeDlsT047DKd1v8dVXEZW0xRTOyXxe+4yJOms4apdqf3iVgt27rP
         Sn0eX/2fUKicTuWpWR8uh6GtCg1IIPbYY3paAnlWRd963hOzXmpWp19WSN8PhBoZkhel
         /rH4w4x+j2kvXAtk+bu3PUXh9UdiOsWkSs9nHgR3mLzCKQLKOzuufHeVZjepR5QpKuQD
         2Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h4+Ursvutr8NPKLL9YWRGFUW5Agq9ZhlNofiRl7vx4U=;
        b=r0NqE6ziGm7wBFLpAWeokjkeldWtA71qznWpInL4Mzisry6M3VGhqAz5Y3daKjMjTF
         g2Gs9vLlkyJfZuhHMQ0FU/9sraY31yHIhOL9tv9/0N3TZMV/DeUu1GKXGJV+s+vvvJZR
         a8ku4SJUbsQ00W3SX7lTNqPA+a5UE/UWhDFxl+naOD3No09HFtXu1djnX4bTnj1bCQwa
         k+lZgJXR5FXGxJg09VqZ/VCQj2LqL/t/VaCFzh9h3U2CxQ54poHFySSC3vbmXCAbtfoC
         l1aivQ4lMyI7QO3SYgxGwHi8VSTeHzv1v56yU21bWBzYWI9ZXjaWUV0ZQPhrr9k8qpI/
         1BgQ==
X-Gm-Message-State: ANhLgQ0oWyUjLRI60kBLXfpsD3G1cTSGilwP2zQcle7bsXsYm4bfHUbz
        1lJxkd2leGHZ4i6/ZlHT5UH9Q0Pi
X-Google-Smtp-Source: ADFU+vu1cr7pg5phmxavJjNGts+Ap7cxfcs6kJxrYRm+ERH1C9LD7XzyiwgB7eHxYxlB3sX3TLzWHw==
X-Received: by 2002:a50:9f85:: with SMTP id c5mr22033211edf.55.1585773097033;
        Wed, 01 Apr 2020 13:31:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cq25sm641126edb.16.2020.04.01.13.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:31:36 -0700 (PDT)
Message-Id: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 20:31:35 +0000
Subject: [PATCH] sequencer: honor GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, elbrus@debian.org,
        ijackson@chiark.greenend.org.uk, phillip.wood@dunelm.org.uk,
        alban.gruin@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
including some in sequencer.c; unfortunately, reflog_message() and its
callers ignored it.  Instruct reflog_message() to check the existing
environment variable, and use it when present as an override to
action_name().

Also restructure pick_commits() to only temporarily modify
GIT_REFLOG_ACTION for a short duration and then restore the old value,
so that when we do this setting within a loop we do not keep adding "
(pick)" substrings and end up with a reflog message of the form
    rebase (pick) (pick) (pick) (finish): returning to refs/heads/master

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: honor GIT_REFLOG_ACTION
    
    I'm not the best with getenv/setenv. The xstrdup() wrapping is
    apparently necessary on mac and bsd. The xstrdup seems like it leaves us
    with a memory leak, but since setenv(3) says to not alter or free it, I
    think it's right. Anyone have any alternative suggestions?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-746%2Fnewren%2Fhonor-reflog-action-in-sequencer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-746/newren/honor-reflog-action-in-sequencer-v1
Pull-Request: https://github.com/git/git/pull/746

 sequencer.c               |  9 +++++++--
 t/t3406-rebase-message.sh | 16 ++++++++--------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e787..5837fdaabbe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3708,10 +3708,11 @@ static const char *reflog_message(struct replay_opts *opts,
 {
 	va_list ap;
 	static struct strbuf buf = STRBUF_INIT;
+	char *reflog_action = getenv("GIT_REFLOG_ACTION");
 
 	va_start(ap, fmt);
 	strbuf_reset(&buf);
-	strbuf_addstr(&buf, action_name(opts));
+	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
 	if (sub_action)
 		strbuf_addf(&buf, " (%s)", sub_action);
 	if (fmt) {
@@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *r,
 			struct replay_opts *opts)
 {
 	int res = 0, reschedule = 0;
+	char *prev_reflog_action;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
@@ -3845,12 +3848,14 @@ static int pick_commits(struct repository *r,
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
-				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
+				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
 			res = do_pick_commit(r, item->command, item->commit,
 					     opts, is_final_fixup(todo_list),
 					     &check_todo);
+			if (is_rebase_i(opts))
+				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
 				advise(_(rescheduled_advice),
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 61b76f33019..927a4f4a4e4 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -89,22 +89,22 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	git checkout -b reflog-topic start &&
 	test_commit reflog-to-rebase &&
 
-	git rebase --apply reflog-onto &&
+	git rebase reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
-	rebase finished: returning to refs/heads/reflog-topic
-	rebase: reflog-to-rebase
-	rebase: checkout reflog-onto
+	rebase (finish): returning to refs/heads/reflog-topic
+	rebase (pick): reflog-to-rebase
+	rebase (start): checkout reflog-onto
 	EOF
 	test_cmp expect actual &&
 
 	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase --apply reflog-onto &&
+	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
-	rebase finished: returning to refs/heads/reflog-prefix
-	change-the-reflog: reflog-to-rebase
-	change-the-reflog: checkout reflog-onto
+	change-the-reflog (finish): returning to refs/heads/reflog-prefix
+	change-the-reflog (pick): reflog-to-rebase
+	change-the-reflog (start): checkout reflog-onto
 	EOF
 	test_cmp expect actual
 '

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget

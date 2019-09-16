Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792641F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfIPUyw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:54:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIPUyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:54:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so827207wrm.9
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dZzpMmgfDv7JoYGituWLX6NS6q4AWtZ3vgo4VptJBM=;
        b=gx6Uv/DYA4PgFpoxXkxPju1dh+57oOSMVlzX5VoVDBlPNSSBlkAzUvHb/3P9OrhexS
         gFWa0FSXh6CdVXrzd9IkD+CbhtEsc4AbaT/BwZ4c4Cvm1h144iYX4D4lRgszrL61PQVt
         lCHHrbxYShh0AiIVt3Fjw/gBGQoH1X6V1cyBJa0z6tbZztLYQJsl6ByaEnuoWPT1qbGx
         skBd065duwbFs7mcCBvuPcrZoxcMVzT+BgBxGgrUdRtrJBwEfFpeLLjH61wMH/cJ7/PW
         QAZ2AHyqHGPhlcrmSxiQM6/nQJc06mh28x5E8oRyTM0Ng9vzs737lBuCEpgagrokdkbv
         r1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dZzpMmgfDv7JoYGituWLX6NS6q4AWtZ3vgo4VptJBM=;
        b=joL+Wj7McCGFGAZi76DR3hxnw/O/uRT2GMaOFdqiV0loC5bCDm0Jg88VikY23JX+Ou
         PZoylhAuAYUvu6ch4bkAQXZXBv9Msn59X/27upj6dufCEYoQiDbsWWQ40Z4ITO+o389k
         82iuT565qqyrMW6UOTEV2JiCwAiz6gaY+70W8SCuDv/icCDDgm/E1or63UV3zIwfeJMo
         lROryDP+6NTLTF+gTYAyjFFzq3dZsrdevo4BT6tt77x8CVOha3SalLMOBTexFpux7Y6c
         SOAhlkmwco61EnLr+GJP/lSl3v9nlfoa8grwTMMHKVRNLcOmVCvWP6zrUoaoZazRwQOJ
         1IUw==
X-Gm-Message-State: APjAAAWieTsuoRsCvidRyLgsHhzysP/c+reYlIwTQc0WC9GEobHmyU8j
        WK+UfSfkfm+22pZInSOgPsU=
X-Google-Smtp-Source: APXvYqz4BTaN1B013Ll6gpVIcPAFcocPHGjpyI9uSseAbplybl4LHnCRO2xFLLztKmpvWb0no3F4yg==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr234094wrr.334.1568667289224;
        Mon, 16 Sep 2019 13:54:49 -0700 (PDT)
Received: from localhost.localdomain (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id u22sm102944wru.72.2019.09.16.13.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 13:54:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Charles Diza <chdiza@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] Revert "progress: use term_clear_line()"
Date:   Mon, 16 Sep 2019 22:54:11 +0200
Message-Id: <20190916205412.8602-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190916205412.8602-1-szeder.dev@gmail.com>
References: <20190822162907.GA17013@sigill.intra.peff.net>
 <20190916205412.8602-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 5b12e3123b (progress: use term_clear_line(),
2019-06-24), because covering up the entire last line while refreshing
the progress line caused unexpected problems during 'git
clone/fetch/push':

  $ git clone ssh://localhost/home/szeder/src/tmp/linux.git/
  Cloning into 'linux'...
  remote:
  remote:
  remote:
  remote: Enumerating objects: 999295

The length of the progress bar line can shorten when it includes
throughput and the unit changes, or when its length exceeds the width
of the terminal and is broken into two lines.  In these cases the
previously displayed longer progress line should be covered up,
because otherwise the leftover characters from the previous progress
line make the output look weird [1].  term_clear_line() makes this
quite simple, as it covers up the entire last line either by using an
ANSI control sequence or by printing a terminal width worth of space
characters, depending on whether the terminal is smart or dumb.

Unfortunately, when accessing a remote repository via any non-local
protocol the remote 'git receive-pack/upload-pack' processes can't
possibly have any idea about the local terminal (smart of dumb? how
wide?) their progress will end up on.  Consequently, they assume the
worst, i.e. standard-width dumb terminal, and print 80 spaces to cover
up the previously displayed progress line.  The local 'git
clone/fetch/push' processes then display the remote's progress,
including these coverup spaces, with the 'remote: ' prefix, resulting
in a total line length of 88 characters.  If the local terminal is
narrower than that, then the coverup gets line-wrapped, and after that
the CR at the end doesn't return to the beginning of the progress
line, but to the first column of its last line, resulting in those
repeated 'remote: <many-spaces>' lines.

By reverting 5b12e3123b (progress: use term_clear_line(),
2019-06-24) we won't cover up the entire last line, but go back to
comparing the length of the current progress bar line with the
previous one, and cover up as many characters as needed.

[1] See commits 545dc345eb (progress: break too long progress bar
    lines, 2019-04-12) and 9f1fd84e15 (progress: clear previous
    progress update dynamically, 2019-04-12).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c                 | 29 ++++++++++++++++++-----------
 t/t5541-http-push-smart.sh |  6 +++---
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/progress.c b/progress.c
index 277db8afa2..0eddf1804d 100644
--- a/progress.c
+++ b/progress.c
@@ -88,6 +88,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
+	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -115,21 +116,27 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
 			const char *eol = done ? done : "\r";
+			size_t clear_len = counters_sb->len < last_count_len ?
+					last_count_len - counters_sb->len + 1 :
+					0;
+			/* The "+ 2" accounts for the ": ". */
+			size_t progress_line_len = progress->title_len +
+						counters_sb->len + 2;
+			int cols = term_columns();
 
-			term_clear_line();
 			if (progress->split) {
-				fprintf(stderr, "  %s%s", counters_sb->buf,
-					eol);
-			} else if (!done &&
-				   /* The "+ 2" accounts for the ": ". */
-				   term_columns() < progress->title_len +
-						    counters_sb->len + 2) {
-				fprintf(stderr, "%s:\n  %s%s",
-					progress->title, counters_sb->buf, eol);
+				fprintf(stderr, "  %s%*s", counters_sb->buf,
+					(int) clear_len, eol);
+			} else if (!done && cols < progress_line_len) {
+				clear_len = progress->title_len + 1 < cols ?
+					    cols - progress->title_len - 1 : 0;
+				fprintf(stderr, "%s:%*s\n  %s%s",
+					progress->title, (int) clear_len, "",
+					counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%s", progress->title,
-					counters_sb->buf, eol);
+				fprintf(stderr, "%s: %s%*s", progress->title,
+					counters_sb->buf, (int) clear_len, eol);
 			}
 			fflush(stderr);
 		}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index b86ddb60f2..92bac43257 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -262,7 +262,7 @@ test_expect_success TTY 'push shows progress when stderr is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
 	test_terminal git push >output 2>&1 &&
-	test_i18ngrep "Writing objects" output
+	test_i18ngrep "^Writing objects" output
 '
 
 test_expect_success TTY 'push --quiet silences status and progress' '
@@ -277,7 +277,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "Writing objects" output
+	test_i18ngrep ! "^Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
@@ -285,7 +285,7 @@ test_expect_success 'push --progress shows progress to non-tty' '
 	test_commit progress &&
 	git push --progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep "Writing objects" output
+	test_i18ngrep "^Writing objects" output
 '
 
 test_expect_success 'http push gives sane defaults to reflog' '
-- 
2.23.0.331.g4e51dcdf11


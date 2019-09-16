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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CE01F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfIPUyy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:54:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfIPUyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:54:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so837038wrw.8
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqfpsIZi1u20DpuKkG69KU0+glDhk2ViMrCtp6k0YFE=;
        b=GgKwmn998NEZtauEepCfqUNhQCZnWjtOc+Wmz89kb4ps4cnihitnd+GDIrfG8hzRrn
         P3pWKKef4eb5dzV62v5TBf3TvcmNhaWahXMuQNNiER8ORZtIkthekdL1QNpKuGmkFQH9
         l5QzZRf0UuLo284LVJMIDwWC8G/koO/5clC5RhIyx56BGSv6hNp6aYnuLtGnEfr+8tNl
         kvLA3pJr3Rzs8eaa0b5Ow5R1rMQvYfbQfOy5IgrnEZ/4FY+/wHeblkRHbovL5izG9Bxn
         6n+ITaLUMnUOLwEORObLO7VF7PYQBG9ZsQhtTWMlB1NAAzxgNDd0JWyOej4nd7sL5jxL
         E3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqfpsIZi1u20DpuKkG69KU0+glDhk2ViMrCtp6k0YFE=;
        b=mK4WJI+hjgS+d5DHGLkfDPtOlRYyCtseqz00htjPGZ3esqlL+R5yNjLcknqK3HCcj8
         PaJG3bcd4s9qi2iklUQDZKHlcmoAD9rpcSYm4MHXFFQGwO6X0hIfOHoPWXqk9VUdgGPv
         l5tiCE+4nDg4pW1dLWhN0ZP+q3KVKpW4nia/SUu5XKkgdZqzuZ6Blmvmz8QrZTLeCASo
         3ocQTdIico8WbdYbkN9go00trkod8ND6ZgdG2Ylxc33HFBMsse/1NIg+IRo16yT+1oHp
         KKEfQi1AIyUAHMdZFcXG3MCtHswwxOqhWXip0vNIIBhhl3/vJTDW4Z3pg4mVfykifiiL
         hnbA==
X-Gm-Message-State: APjAAAV35OoBmnP1epJTrE3IFaU4N+vF7lLl6xVASmpNRgX5YWL9HdI8
        X5wfkJr/vOrXqjbIHQlJVQo=
X-Google-Smtp-Source: APXvYqyYRO7/KuAsyR5O2w/XwNDTSlKH9TXvkwZ8do+M46QeNr2GAESdR8h1ale/dVhIsrwz1Hpr8A==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr235439wru.6.1568667290507;
        Mon, 16 Sep 2019 13:54:50 -0700 (PDT)
Received: from localhost.localdomain (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id u22sm102944wru.72.2019.09.16.13.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 13:54:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Charles Diza <chdiza@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] Test the progress display
Date:   Mon, 16 Sep 2019 22:54:12 +0200
Message-Id: <20190916205412.8602-3-szeder.dev@gmail.com>
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

'progress.c' has seen a few fixes recently [1], and, unfortunately,
some of those fixes required further fixes [2].  It seems it's time to
have a few tests focusing on the subtleties of the progress display.

Add the 'test-tool progress' subcommand to help testing the progress
display, reading instructions from standard input and turning them
into calls to the display_progress() and display_throughput()
functions with the given parameters.

The progress display is, however, critically dependent on timing,
because it's only updated once every second or, if the toal is known
in advance, every 1%, and there is the throughput rate as well.  These
make the progress display far too undeterministic for testing as-is.
To address this, add a few testing-specific variables and functions to
'progress.c', allowing the the new test helper to:

  - Disable the triggered-every-second SIGALRM and set the
    'progress_update' flag explicitly based in the input instructions.
    This way the progress line will be updated deterministically when
    the test wants it to be updated.

  - Specify the time elapsed since start_progress() to make the
    throughput rate calculations deterministic.

Add the new test script 't0500-progress-display.sh' to check a few
simple cases with and without throughput, and that a shorter progress
line properly covers up the previously displayed line in different
situations.

[1] See commits 545dc345eb (progress: break too long progress bar
    lines, 2019-04-12) and 9f1fd84e15 (progress: clear previous
    progress update dynamically, 2019-04-12).
[2] 1aed1a5f25 (progress: avoid empty line when breaking the progress
    line, 2019-05-19)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile                    |   1 +
 progress.c                  |  32 +++-
 t/helper/test-progress.c    |  81 ++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t0500-progress-display.sh | 286 ++++++++++++++++++++++++++++++++++++
 6 files changed, 400 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-progress.c
 create mode 100755 t/t0500-progress-display.sh

diff --git a/Makefile b/Makefile
index ad71ae1219..3ca48ec4b0 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-midx.o
diff --git a/progress.c b/progress.c
index 0eddf1804d..0063559aab 100644
--- a/progress.c
+++ b/progress.c
@@ -45,6 +45,19 @@ struct progress {
 
 static volatile sig_atomic_t progress_update;
 
+/*
+ * These are only intended for testing the progress output, i.e. exclusively
+ * for 'test-tool progress'.
+ */
+int progress_testing;
+uint64_t progress_test_ns = 0;
+void progress_test_force_update(void); /* To silence -Wmissing-prototypes */
+void progress_test_force_update(void)
+{
+	progress_update = 1;
+}
+
+
 static void progress_interval(int signum)
 {
 	progress_update = 1;
@@ -55,6 +68,9 @@ static void set_progress_signal(void)
 	struct sigaction sa;
 	struct itimerval v;
 
+	if (progress_testing)
+		return;
+
 	progress_update = 0;
 
 	memset(&sa, 0, sizeof(sa));
@@ -72,6 +88,10 @@ static void set_progress_signal(void)
 static void clear_progress_signal(void)
 {
 	struct itimerval v = {{0,},};
+
+	if (progress_testing)
+		return;
+
 	setitimer(ITIMER_REAL, &v, NULL);
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
@@ -154,6 +174,14 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 	strbuf_humanise_rate(buf, rate * 1024);
 }
 
+static uint64_t progress_getnanotime(struct progress *progress)
+{
+	if (progress_testing)
+		return progress->start_ns + progress_test_ns;
+	else
+		return getnanotime();
+}
+
 void display_throughput(struct progress *progress, uint64_t total)
 {
 	struct throughput *tp;
@@ -164,7 +192,7 @@ void display_throughput(struct progress *progress, uint64_t total)
 		return;
 	tp = progress->throughput;
 
-	now_ns = getnanotime();
+	now_ns = progress_getnanotime(progress);
 
 	if (!tp) {
 		progress->throughput = tp = xcalloc(1, sizeof(*tp));
@@ -296,7 +324,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		struct throughput *tp = progress->throughput;
 
 		if (tp) {
-			uint64_t now_ns = getnanotime();
+			uint64_t now_ns = progress_getnanotime(progress);
 			unsigned int misecs, rate;
 			misecs = ((now_ns - progress->start_ns) * 4398) >> 32;
 			rate = tp->curr_total / (misecs ? misecs : 1);
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
new file mode 100644
index 0000000000..4e9f7fafdf
--- /dev/null
+++ b/t/helper/test-progress.c
@@ -0,0 +1,81 @@
+/*
+ * A test helper to exercise the progress display.
+ *
+ * Reads instructions from standard input, one instruction per line:
+ *
+ *   "progress <items>" - Call display_progress() with the given item count
+ *                        as parameter.
+ *   "throughput <bytes> <millis> - Call display_throughput() with the given
+ *                                  byte count as parameter.  The 'millis'
+ *                                  specify the time elapsed since the
+ *                                  start_progress() call.
+ *   "update" - Set the 'progress_update' flag.
+ *
+ * See 't0500-progress-display.sh' for examples.
+ */
+#include "test-tool.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "progress.h"
+#include "strbuf.h"
+
+/*
+ * These are defined in 'progress.c', but are not exposed in 'progress.h',
+ * because they are exclusively for testing.
+ */
+extern int progress_testing;
+extern uint64_t progress_test_ns;
+void progress_test_force_update(void);
+
+int cmd__progress(int argc, const char **argv)
+{
+	uint64_t total = 0;
+	const char *title;
+	struct strbuf line = STRBUF_INIT;
+	struct progress *progress;
+
+	const char *usage[] = {
+		"test-tool progress [--total=<n>] <progress-title>",
+		NULL
+	};
+	struct option options[] = {
+		OPT_INTEGER(0, "total", &total, "total number of items"),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc != 1)
+		die("need a title for the progress output");
+	title = argv[0];
+
+	progress_testing = 1;
+	progress = start_progress(title, total);
+	while (strbuf_getline(&line, stdin) != EOF) {
+		char *end;
+
+		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
+			uint64_t item_count = strtoull(end, &end, 10);
+			if (*end != '\0')
+				die("invalid input: '%s'\n", line.buf);
+			display_progress(progress, item_count);
+		} else if (skip_prefix(line.buf, "throughput ",
+				       (const char **) &end)) {
+			uint64_t byte_count, test_ms;
+
+			byte_count = strtoull(end, &end, 10);
+			if (*end != ' ')
+				die("invalid input: '%s'\n", line.buf);
+			test_ms = strtoull(end + 1, &end, 10);
+			if (*end != '\0')
+				die("invalid input: '%s'\n", line.buf);
+			progress_test_ns = test_ms * 1000 * 1000;
+			display_throughput(progress, byte_count);
+		} else if (!strcmp(line.buf, "update"))
+			progress_test_force_update();
+		else
+			die("invalid input: '%s'\n", line.buf);
+	}
+	stop_progress(&progress);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ce7e89028c..19ee26d931 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -42,6 +42,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
+	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "read-midx", cmd__read_midx },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f805bb39ae..c2aa56ef50 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,6 +32,7 @@ int cmd__parse_options(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
new file mode 100755
index 0000000000..24ccbd8d3b
--- /dev/null
+++ b/t/t0500-progress-display.sh
@@ -0,0 +1,286 @@
+#!/bin/sh
+
+test_description='progress display'
+
+. ./test-lib.sh
+
+show_cr () {
+	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
+}
+
+test_expect_success 'simple progress display' '
+	cat >expect <<-\EOF &&
+	Working hard: 1<CR>
+	Working hard: 2<CR>
+	Working hard: 5<CR>
+	Working hard: 5, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	update
+	progress 1
+	update
+	progress 2
+	progress 3
+	progress 4
+	update
+	progress 5
+	EOF
+	test-tool progress "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display with total' '
+	cat >expect <<-\EOF &&
+	Working hard:  33% (1/3)<CR>
+	Working hard:  66% (2/3)<CR>
+	Working hard: 100% (3/3)<CR>
+	Working hard: 100% (3/3), done.
+	EOF
+
+	cat >in <<-\EOF &&
+	progress 1
+	progress 2
+	progress 3
+	EOF
+	test-tool progress --total=3 "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display breaks long lines #1' '
+	sed -e "s/Z$//" >expect <<\EOF &&
+Working hard.......2.........3.........4.........5.........6:   0% (100/100000)<CR>
+Working hard.......2.........3.........4.........5.........6:   1% (1000/100000)<CR>
+Working hard.......2.........3.........4.........5.........6:                   Z
+   10% (10000/100000)<CR>
+  100% (100000/100000)<CR>
+  100% (100000/100000), done.
+EOF
+
+	cat >in <<-\EOF &&
+	progress 100
+	progress 1000
+	progress 10000
+	progress 100000
+	EOF
+	test-tool progress --total=100000 \
+		"Working hard.......2.........3.........4.........5.........6" \
+		<in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display breaks long lines #2' '
+	# Note: we dont need that many spaces after the title to cover up
+	# the last line before breaking the progress line.
+	sed -e "s/Z$//" >expect <<\EOF &&
+Working hard.......2.........3.........4.........5.........6:   0% (1/100000)<CR>
+Working hard.......2.........3.........4.........5.........6:   0% (2/100000)<CR>
+Working hard.......2.........3.........4.........5.........6:                   Z
+   10% (10000/100000)<CR>
+  100% (100000/100000)<CR>
+  100% (100000/100000), done.
+EOF
+
+	cat >in <<-\EOF &&
+	update
+	progress 1
+	update
+	progress 2
+	progress 10000
+	progress 100000
+	EOF
+	test-tool progress --total=100000 \
+		"Working hard.......2.........3.........4.........5.........6" \
+		<in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display breaks long lines #3 - even the first is too long' '
+	# Note: we dont actually need any spaces at the end of the title
+	# line, because there is no previous progress line to cover up.
+	sed -e "s/Z$//" >expect <<\EOF &&
+Working hard.......2.........3.........4.........5.........6:                   Z
+   25% (25000/100000)<CR>
+   50% (50000/100000)<CR>
+   75% (75000/100000)<CR>
+  100% (100000/100000)<CR>
+  100% (100000/100000), done.
+EOF
+
+	cat >in <<-\EOF &&
+	progress 25000
+	progress 50000
+	progress 75000
+	progress 100000
+	EOF
+	test-tool progress --total=100000 \
+		"Working hard.......2.........3.........4.........5.........6" \
+		<in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display breaks long lines #4 - title line matches terminal width' '
+	cat >expect <<\EOF &&
+Working hard.......2.........3.........4.........5.........6.........7.........:
+   25% (25000/100000)<CR>
+   50% (50000/100000)<CR>
+   75% (75000/100000)<CR>
+  100% (100000/100000)<CR>
+  100% (100000/100000), done.
+EOF
+
+	cat >in <<-\EOF &&
+	progress 25000
+	progress 50000
+	progress 75000
+	progress 100000
+	EOF
+	test-tool progress --total=100000 \
+		"Working hard.......2.........3.........4.........5.........6.........7........." \
+		<in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+# Progress counter goes backwards, this should not happen in practice.
+test_expect_success 'progress shortens - crazy caller' '
+	cat >expect <<-\EOF &&
+	Working hard:  10% (100/1000)<CR>
+	Working hard:  20% (200/1000)<CR>
+	Working hard:   0% (1/1000)  <CR>
+	Working hard: 100% (1000/1000)<CR>
+	Working hard: 100% (1000/1000), done.
+	EOF
+
+	cat >in <<-\EOF &&
+	progress 100
+	progress 200
+	progress 1
+	progress 1000
+	EOF
+	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display with throughput' '
+	cat >expect <<-\EOF &&
+	Working hard: 10<CR>
+	Working hard: 20, 200.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 30, 300.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 40, 400.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 40, 400.00 KiB | 100.00 KiB/s, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	throughput 102400 1000
+	update
+	progress 10
+	throughput 204800 2000
+	update
+	progress 20
+	throughput 307200 3000
+	update
+	progress 30
+	throughput 409600 4000
+	update
+	progress 40
+	EOF
+	test-tool progress "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'progress display with throughput and total' '
+	cat >expect <<-\EOF &&
+	Working hard:  25% (10/40)<CR>
+	Working hard:  50% (20/40), 200.00 KiB | 100.00 KiB/s<CR>
+	Working hard:  75% (30/40), 300.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 100% (40/40), 400.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 100% (40/40), 400.00 KiB | 100.00 KiB/s, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	throughput 102400 1000
+	progress 10
+	throughput 204800 2000
+	progress 20
+	throughput 307200 3000
+	progress 30
+	throughput 409600 4000
+	progress 40
+	EOF
+	test-tool progress --total=40 "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'cover up after throughput shortens' '
+	cat >expect <<-\EOF &&
+	Working hard: 1<CR>
+	Working hard: 2, 800.00 KiB | 400.00 KiB/s<CR>
+	Working hard: 3, 1.17 MiB | 400.00 KiB/s  <CR>
+	Working hard: 4, 1.56 MiB | 400.00 KiB/s<CR>
+	Working hard: 4, 1.56 MiB | 400.00 KiB/s, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	throughput 409600 1000
+	update
+	progress 1
+	throughput 819200 2000
+	update
+	progress 2
+	throughput 1228800 3000
+	update
+	progress 3
+	throughput 1638400 4000
+	update
+	progress 4
+	EOF
+	test-tool progress "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_expect_success 'cover up after throughput shortens a lot' '
+	cat >expect <<-\EOF &&
+	Working hard: 1<CR>
+	Working hard: 2, 1000.00 KiB | 1000.00 KiB/s<CR>
+	Working hard: 3, 3.00 MiB | 1.50 MiB/s      <CR>
+	Working hard: 3, 3.00 MiB | 1024.00 KiB/s, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	throughput 1 1000
+	update
+	progress 1
+	throughput 1024000 2000
+	update
+	progress 2
+	throughput 3145728 3000
+	update
+	progress 3
+	EOF
+	test-tool progress "Working hard" <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_i18ncmp expect out
+'
+
+test_done
-- 
2.23.0.331.g4e51dcdf11


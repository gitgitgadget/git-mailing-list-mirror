Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271E2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHFQmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:42:47 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:49363 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHFQmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:42:47 -0400
Received: by mail-yb0-f202.google.com with SMTP id c2-v6so13503968ybl.16
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Nio9u4+UWg/Xc0EikNTu3WY/k8yYYh5B1wuxT3qkcA=;
        b=Bps/NYkpbSoDfwHc9axHXCUuPWv/IQMCm+cx8NWjEpoe/5ThmzeQbpITP1b5ESLzqn
         WwHGxOXzNdx63sHwbVlkTzqsfbNWk00QwmgDXAU0Hj4tkNifOUevRDpEu2GhQenfgw6R
         2cd1PGjWsNWn9sNLUUh0Dgp26y+SI4NeZBXJHl1p0C4gjeW5HwkzYKX8GRUGw/1bP6j4
         foqss5hoZHiXFVGEcFy72BGpxKWOgm1ST/f2uD9wtnfK1/Xmh+q7Mje0eb8js/IIAvOu
         MZtouVutPpBdMmijSW4qAfEeeONzqTtlOoKwPRXbw4qnEiQ+pYqn35N2/XK6YRdGYlVt
         Q0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Nio9u4+UWg/Xc0EikNTu3WY/k8yYYh5B1wuxT3qkcA=;
        b=IBwzdZEtXE2ZGdwGO4P//LvQbCWWlJ65yzarShonPQlCnT7z9zcErQX96w6ujp9B4W
         DcSi5dJs95WMKoTLvwcUHlkaXjk3CHEW0Gcfv09rUYocI0rxzoH36R2zjdw3UDzNeCaS
         bW+B9d4xq73fv2lLC9on82oWQWnYmbHiI8xiqAN7LBr8XDC8VmXHbhW254BAqOW2f785
         dfcp+6SfNLJdXg098+0nJeBwf6gc/3VLt5GP19v2UtW7RX+WX6v5HjWwRq2wed3f1tN8
         xMTHTdWVOCUuNDWZaxmDpozowcwL3zYqydRQ4ZJC0P3O4KDuhMHSQ3R0yWynFhw9MJf6
         6egA==
X-Gm-Message-State: AOUpUlGpEwbA0kSG6pdh+KZzX5ajLOqWTtLq2MPsyed78G18AUo7rF8T
        JDj/tuWBYHt/7XQ6Upm56l0I+dnbHpQ=
X-Google-Smtp-Source: AAOMgpcYRY5N6ZCkkXKvPJC3GGrwZFJbqH7wfo0IwXUkOtsftAC082yurTA6a8uoosTei5dEYBTD/xM6OKU=
X-Received: by 2002:a81:a093:: with SMTP id x141-v6mr5949188ywg.52.1533566003518;
 Mon, 06 Aug 2018 07:33:23 -0700 (PDT)
Date:   Mon,  6 Aug 2018 16:33:13 +0200
In-Reply-To: <20180806143313.104495-1-hanwen@google.com>
Message-Id: <20180806143313.104495-3-hanwen@google.com>
Mime-Version: 1.0
References: <20180806143313.104495-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v5 2/2] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com, jrn@google.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The colorization is controlled with the config setting "color.remote".

Supported keywords are "error", "warning", "hint" and "success". They
are highlighted if they appear at the start of the line, which is
common in error messages, eg.

   ERROR: commit is missing Change-Id

The Git push process itself prints lots of non-actionable messages
(eg. bandwidth statistics, object counters for different phases of the
process), which obscures actionable error messages that servers may
send back. Highlighting keywords in the sideband draws more attention
to those messages.

The background for this change is that Gerrit does server-side
processing to create or update code reviews, and actionable error
messages (eg. missing Change-Id) must be communicated back to the user
during the push. User research has shown that new users have trouble
seeing these messages.

The highlighting is done on the client rather than server side, so
servers don't have to grow capabilities to understand terminal escape
codes and terminal state. It also consistent with the current state
where Git is control of the local display (eg. prefixing messages with
"remote: ").

Finally, this solution is backwards compatible: many servers already
prefix their messages with "error", and they will benefit from this
change without requiring a server update. By contrast, a server-side
solution would likely require plumbing the TERM variable through the
git protocol, so it would require changes to both server and client.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/config.txt            |  12 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 126 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  80 ++++++++++++++++++
 5 files changed, 210 insertions(+), 10 deletions(-)
 create mode 100755 t/t5409-colorize-remote-messages.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3d..33bc1a3def 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1263,6 +1263,18 @@ color.push::
 color.push.error::
 	Use customized color for push errors.
 
+color.remote::
+	If set, keywords at the start of the line are highlighted. The
+	keywords are "error", "warning", "hint" and "success", and are
+	matched case-insensitively. Maybe set to `always`, `false` (or
+	`never`) or `auto` (or `true`). If unset, then the value of
+	`color.ui` is used (`auto` by default).
+
+color.remote.<slot>::
+	Use customized color for each remote keyword. `<slot>` may be
+	`hint`, `warning`, `success` or `error` which match the
+	corresponding keyword.
+
 color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
diff --git a/help.c b/help.c
index 3ebf0568db..b6cafcfc0a 100644
--- a/help.c
+++ b/help.c
@@ -425,6 +425,7 @@ void list_config_help(int for_human)
 		{ "color.diff", "<slot>", list_config_color_diff_slots },
 		{ "color.grep", "<slot>", list_config_color_grep_slots },
 		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.remote", "<slot>", list_config_color_sideband_slots },
 		{ "color.status", "<slot>", list_config_color_status_slots },
 		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
diff --git a/help.h b/help.h
index f8b15323a6..9eab6a3f89 100644
--- a/help.h
+++ b/help.h
@@ -83,6 +83,7 @@ void list_config_color_diff_slots(struct string_list *list, const char *prefix);
 void list_config_color_grep_slots(struct string_list *list, const char *prefix);
 void list_config_color_interactive_slots(struct string_list *list, const char *prefix);
 void list_config_color_status_slots(struct string_list *list, const char *prefix);
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix);
 void list_config_fsck_msg_ids(struct string_list *list, const char *prefix);
 
 #endif /* HELP_H */
diff --git a/sideband.c b/sideband.c
index 325bf0e974..239be2ec85 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,108 @@
 #include "cache.h"
+#include "color.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "help.h"
+
+struct keyword_entry {
+	/*
+	 * We use keyword as config key so it should be a single alphanumeric word.
+	 */
+	const char *keyword;
+	char color[COLOR_MAXLEN];
+};
+
+static struct keyword_entry keywords[] = {
+	{ "hint",	GIT_COLOR_YELLOW },
+	{ "warning",	GIT_COLOR_BOLD_YELLOW },
+	{ "success",	GIT_COLOR_BOLD_GREEN },
+	{ "error",	GIT_COLOR_BOLD_RED },
+};
+
+/* Returns a color setting (GIT_COLOR_NEVER, etc). */
+static int use_sideband_colors(void)
+{
+	static int use_sideband_colors_cached = -1;
+
+	const char *key = "color.remote";
+	struct strbuf sb = STRBUF_INIT;
+	char *value;
+	int i;
+
+	if (use_sideband_colors_cached >= 0)
+		return use_sideband_colors_cached;
+
+	if (!git_config_get_string(key, &value)) {
+		use_sideband_colors_cached = git_config_colorbool(key, value);
+	} else if (!git_config_get_string("color.ui", &value)) {
+		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
+	} else {
+		use_sideband_colors_cached = GIT_COLOR_AUTO;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
+		if (git_config_get_string(sb.buf, &value))
+			continue;
+		if (color_parse(value, keywords[i].color))
+			die(_("config value %s is not a color: %s"), sb.buf, value);
+	}
+	strbuf_release(&sb);
+	return use_sideband_colors_cached;
+}
+
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++)
+		list_config_item(list, prefix, keywords[i].keyword);
+}
+
+/*
+ * Optionally highlight one keyword in remote output if it appears at the start
+ * of the line. This should be called for a single line only, which must be
+ * passed as the first N characters of the SRC array.
+ */
+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+
+	if (!want_color_stderr(use_sideband_colors())) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
+	while (isspace(*src)) {
+		strbuf_addch(dest, *src);
+		src++;
+		n--;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		struct keyword_entry *p = keywords + i;
+		int len = strlen(p->keyword);
+		/*
+		 * Match case insensitively, so we colorize output from existing
+		 * servers regardless of the case that they use for their
+		 * messages. We only highlight the word precisely, so
+		 * "successful" stays uncolored.
+		 */
+		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
+			strbuf_addstr(dest, p->color);
+			strbuf_add(dest, src, len);
+			strbuf_addstr(dest, GIT_COLOR_RESET);
+			n -= len;
+			src += len;
+			break;
+		}
+	}
+
+	strbuf_add(dest, src, n);
+}
+
 
 /*
  * Receive multiplexed output stream over git native protocol.
@@ -16,7 +118,7 @@
 #define DISPLAY_PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
-#define DUMB_SUFFIX "        "
+#define DUMB_SUFFIX "	     "
 
 int recv_sideband(const char *me, int in_stream, int out)
 {
@@ -48,8 +150,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+				    DISPLAY_PREFIX);
+			maybe_colorize_sideband(&outbuf, buf + 1, len);
+
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -69,20 +173,22 @@ int recv_sideband(const char *me, int in_stream, int out)
 				if (!outbuf.len)
 					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
-					strbuf_addf(&outbuf, "%.*s%s%c",
-						    linelen, b, suffix, *brk);
-				} else {
-					strbuf_addch(&outbuf, *brk);
+					maybe_colorize_sideband(&outbuf, b, linelen);
+					strbuf_addstr(&outbuf, suffix);
 				}
+
+				strbuf_addch(&outbuf, *brk);
 				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);
 
 				b = brk + 1;
 			}
 
-			if (*b)
-				strbuf_addf(&outbuf, "%s%s", outbuf.len ?
-					    "" : DISPLAY_PREFIX, b);
+			if (*b) {
+				strbuf_addstr(&outbuf, outbuf.len ?
+					    "" : DISPLAY_PREFIX);
+				maybe_colorize_sideband(&outbuf, b, strlen(b));
+			}
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
new file mode 100755
index 0000000000..a9afb55ef1
--- /dev/null
+++ b/t/t5409-colorize-remote-messages.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='remote messages are colorized on the client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+	write_script .git/hooks/update <<-\EOF &&
+echo error: error
+echo ERROR: also highlighted
+echo hint: hint
+echo hinting: not highlighted
+echo success: success
+echo warning: warning
+echo prefixerror: error
+echo "  error: leading space"
+exit 0
+EOF
+	chmod +x .git/hooks/update &&
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git clone . child &&
+	(
+		cd child &&
+		test_commit message2 file content2
+	)
+'
+
+test_expect_success 'keywords' '
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/keywords 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>: error" decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;YELLOW>warning<RESET>:" decoded
+'
+
+test_expect_success 'whole words at line start' '
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/whole-words 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "hinting: not highlighted" decoded &&
+	grep "prefixerror: error" decoded
+'
+
+test_expect_success 'case-insensitive' '
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/case-insensitive 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>: error" decoded &&
+	grep "<BOLD;RED>ERROR<RESET>: also highlighted" decoded
+'
+
+test_expect_success 'leading space' '
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space 2>output &&
+	test_decode_color <output >decoded &&
+	grep "  <BOLD;RED>error<RESET>: leading space" decoded
+'
+
+test_expect_success 'no coloring for redirected output' '
+	git --git-dir child/.git push -f origin HEAD:refs/heads/redirected-output 2>output &&
+	test_decode_color <output >decoded &&
+	grep "error: error" decoded
+'
+
+test_expect_success 'push with customized color' '
+	git --git-dir child/.git -c color.remote=always -c color.remote.error=blue push -f origin HEAD:refs/heads/customized-color 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BLUE>error<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded
+'
+
+test_expect_success 'fallback to color.ui' '
+	git --git-dir child/.git -c color.ui=always push -f origin HEAD:refs/heads/fallback-color-ui 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>: error" decoded
+'
+
+test_done
-- 
2.18.0.597.ga71716f1ad-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0074208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbeHFTzQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:55:16 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:41748 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbeHFTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:55:16 -0400
Received: by mail-qk0-f201.google.com with SMTP id w8-v6so13441300qkf.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MZ4b6PXxrWkwmX6UFyXKUegqa/KfdgHzNxWdL838dDQ=;
        b=LJp+WqnB75LqKhJf362+neW0n4H4edsrVpuRbVEDWZYqjVQlWuS7H8rOEqHP6DDbrd
         doCptMgxKUB/yE2j2UPOOuFHExrRpiuF+lfPu9RCNxWOP3PMwAPobffk7jB4+PXIQ7EZ
         Wrsf7u9UFz3c867/lck/teo2R1jOLDbjqwMlqa9GdaqtagQYnqd4k/VtB6HHbt4CQw+W
         1zM1FfFdDZnFKSz1HD+jqwngcRKPkwddihCCzvdKyXsKMJzssl+WroTPKv9G8yYETFxL
         Hu+IZ2m0Fa9PCOKZE/Roi1GnufXZyvqtROj/m9Wl+4/6Jxv4Gig8s95RyuSB7GuPSWL9
         AP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZ4b6PXxrWkwmX6UFyXKUegqa/KfdgHzNxWdL838dDQ=;
        b=CAWVrTyo1K5Wm4jrNRc8cdfaKUopaCrrTMR3C/DKizPsPrqtxuGG08oz0oYoASIfZK
         YANrrrRIjxRlFVf3+f5vG4acn/NUsk+dCoeRn5uMjlzvMMH7zgtAbL1S4WAhmOANwvAC
         dE6Wg63+PvT3353doUbW6gVo02jXuzleSkANjzbgRRc2RrVIHsGA3mZCzauYDpiZ7Fuf
         4gSdTy2RokzRUxadOmm0Pu9S45ZdDPha4WrdZnNtCFt3gLTzeX2RoRCbZ3MhQK5vTnrE
         2Iz/6Ej13seQctHSpaXCURlpHV51JLSG1DW0cpzS0CrmGGmcvJr+0HTRmS4OPD2btwa3
         RuXQ==
X-Gm-Message-State: AOUpUlE26ZwxtjmLuP+wr1i7dK1fE6vsOBr6QFdcWDdlG1kQ4YFhHsQg
        AJvFiHF19x7sybltHVg0tWfZqcdlh2s=
X-Google-Smtp-Source: AAOMgpf3/dnLlLod3dDGhJGwifMtRtDW9fDHhANGb7Vp4OU+vVfSlhooC5+zJtt3KVUNvhVDYYhqz93pNeY=
X-Received: by 2002:a0c:c20c:: with SMTP id l12-v6mr9031646qvh.51.1533577506590;
 Mon, 06 Aug 2018 10:45:06 -0700 (PDT)
Date:   Mon,  6 Aug 2018 19:44:59 +0200
In-Reply-To: <20180806174459.199589-1-hanwen@google.com>
Message-Id: <20180806174459.199589-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180806174459.199589-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v6 1/1] sideband: highlight keywords in remote sideband output
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
process). This obscures actionable error messages that servers may
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

The highlighting can be configured using color.remote.<KEYWORD>
configuration settings. Since the keys are matched case insensitively,
we match the keywords case insensitively too.

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
 sideband.c                          | 127 ++++++++++++++++++++++++++--
 t/t5409-colorize-remote-messages.sh |  87 +++++++++++++++++++
 5 files changed, 219 insertions(+), 9 deletions(-)
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
index 325bf0e974..d882e79a5f 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,110 @@
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
+			continue;
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
+ * of the line. This should be called for a single line only, which is
+ * passed as the first N characters of the SRC array.
+ */
+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+
+	if (!want_color_stderr(use_sideband_colors())) {
+		strbuf_add(dest, src, n);
+		fprintf(stderr, "added: '%s'\n", dest->buf);
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
+
+}
+
 
 /*
  * Receive multiplexed output stream over git native protocol.
@@ -48,8 +152,10 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -69,20 +175,22 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -96,6 +204,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 	}
 
 	if (outbuf.len) {
+		fprintf(stderr, "last bit '%s'\n", outbuf.buf);
 		strbuf_addch(&outbuf, '\n');
 		xwrite(2, outbuf.buf, outbuf.len);
 	}
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
new file mode 100755
index 0000000000..7057277a5f
--- /dev/null
+++ b/t/t5409-colorize-remote-messages.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='remote messages are colorized on the client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+	write_script .git/hooks/update <<-\EOF &&
+	echo error: error
+	echo ERROR: also highlighted
+	echo hint: hint
+	echo hinting: not highlighted
+	echo success: success
+	echo warning: warning
+	echo prefixerror: error
+	echo " " "error: leading space"
+	exit 0
+	EOF
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
+        cat output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>: error" decoded &&
+	grep "<BOLD;RED>ERROR<RESET>: also highlighted" decoded
+'
+
+test_expect_success 'leading space' '
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space 2>output &&        cat output &&
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
+
+test_expect_success 'error in customized color' '
+	git --git-dir child/.git -c color.remote=always -c color.remote.error=i-am-not-a-color push -f origin HEAD:refs/heads/error-customized-color 2>output &&
+	test_decode_color <output >decoded &&
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


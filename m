Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5B31F597
	for <e@80x24.org>; Thu,  2 Aug 2018 12:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbeHBOEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:04:14 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:42214 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBOEO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:04:14 -0400
Received: by mail-it0-f74.google.com with SMTP id l138-v6so2015547itb.7
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dFSBkC9HJP6PC5wekDeE2+19rOw64GPa/1q6Je87Fq0=;
        b=GUAmTWHFRHrTocTN47QBByqEkBsDngRK+uCNSPXxXhPFPZheaxkXMOa0ME3+A51Udz
         jV34FafAQbTVcuQiWrTfckiqHoVU3Wsl08uU15e5Gf3nSo3w/RJ1kH02S+Sa4VdXD2av
         1xIDbcVgAoLU149aNgQBtU66BmC7CbhV2J3PUs9alNbBIJAXxc4xf5pBJHcrLa/ERWg4
         cORHe9KJLDa3yvZxaTykdbneCiQ2cgznpeNhD6WcW6gaEI/2PnSacpNBmn9dLPpEOV54
         5ud7k7fAmZePqWcVhUbS2Hy/lhWbsQw6Hzo8lQyl30y9QdPqgAUEW4ZECheSVUwqnikV
         OEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dFSBkC9HJP6PC5wekDeE2+19rOw64GPa/1q6Je87Fq0=;
        b=h2GUGm5MYhwMlcGY1RTw1nJohqeuSOkRX7fqQ1k2fib/MP6Q0Uqxm+S3zWK0cj5KJI
         EM6wG82Ux4lAlYY9/teNVEjUbV5tyFC0gMbpWjPmJEhLN9tudu+tQvHDXIB6CkiIVxa5
         IKRdnxVRjjxmxMAJ3SDjcQo1h5oSXI+PnLKBwSNhWDvaplmFggQICPFJCRnd5DMnconG
         9PIK/XRcDNwjUOzzRldgZAkyVe3l61yxOGq2juO7X8KU6zifWQgk+7VdR2xBLWeb8Heq
         pNt0v/Euxfi6Kv72j3coV34X1pHKSr1ht+YirmtGhDTaHuUyRUMJA3RY/F+Y5adwO3Nh
         kNQA==
X-Gm-Message-State: AOUpUlE3/UNQyLfg24sepqQt6NLMO9g4daayzteJGJZ//Ul1E91mC6we
        TW4r+U8bcXgEuvj8zpRWDxsg/pdrGlA=
X-Google-Smtp-Source: AA+uWPzT6wdvkgJ79uNHrArfZJiClia1a2XMtYKLEWU2aX9MV2REHF1A1BgyTSBUBIdtMlPIHW/w4+lJuCE=
X-Received: by 2002:a6b:c648:: with SMTP id w69-v6mr999827iof.108.1533211999157;
 Thu, 02 Aug 2018 05:13:19 -0700 (PDT)
Date:   Thu,  2 Aug 2018 14:13:08 +0200
In-Reply-To: <20180802121308.17371-1-hanwen@google.com>
Message-Id: <20180802121308.17371-3-hanwen@google.com>
Mime-Version: 1.0
References: <20180802121308.17371-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/2] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com
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

The rationale for this change is that Gerrit does server-side
processing to create or update code reviews, and actionable error
messages (eg. missing Change-Id) must be communicated back to the user
during the push. User research has shown that new users have trouble
seeing these messages.

The Git push process itself prints lots of non-actionable messages
(eg. bandwidth statistics, object counters for different phases of the
process), and my hypothesis is that these obscure the actionable error
messages that our server sends back. Highlighting keywords in the
draws more attention to actionable messages.

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
 Documentation/config.txt            |   9 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 119 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 +++++++++++
 5 files changed, 168 insertions(+), 9 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5..0783323be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1229,6 +1229,15 @@ color.push::
 color.push.error::
 	Use customized color for push errors.
 
+color.remote::
+	A boolean to enable/disable colored remote output. If unset,
+	then the value of `color.ui` is used (`auto` by default).
+
+color.remote.<slot>::
+	Use customized color for each remote keywords. `<slot>` may be
+	`hint`, `warning`, `success` or `error` which match the
+	corresponding keyword.
+
 color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
diff --git a/help.c b/help.c
index 3ebf0568d..b6cafcfc0 100644
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
index f8b15323a..9eab6a3f8 100644
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
index 325bf0e97..5c72db83c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,103 @@
 #include "cache.h"
+#include "color.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "help.h"
+
+struct kwtable {
+	/*
+	 * We use keyword as config key so it can't contain funny chars like
+	 * spaces. When we do that, we need a separate field for slot name in
+	 * load_sideband_colors().
+	 */
+	const char *keyword;
+	char color[COLOR_MAXLEN];
+};
+
+static struct kwtable keywords[] = {
+	{ "hint",	GIT_COLOR_YELLOW },
+	{ "warning",	GIT_COLOR_BOLD_YELLOW },
+	{ "success",	GIT_COLOR_BOLD_GREEN },
+	{ "error",	GIT_COLOR_BOLD_RED },
+};
+
+// Returns a color setting (GIT_COLOR_NEVER, etc).
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
+	if (!git_config_get_string(key, &value))
+		use_sideband_colors_cached = git_config_colorbool(key, value);
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
+		if (git_config_get_string(sb.buf, &value))
+			continue;
+		if (color_parse(value, keywords[i].color))
+			die(_("expecting a color: %s"), value);
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
+ * Optionally highlight some keywords in remote output if they appear at the
+ * start of the line. This should be called for a single line only.
+ */
+void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+ 	if (!want_color_stderr(use_sideband_colors())) {
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
+		struct kwtable* p = keywords + i;
+		int len = strlen(p->keyword);
+                /*
+                 * Match case insensitively, so we colorize output from existing
+                 * servers regardless of the case that they use for their
+                 * messages. We only highlight the word precisely, so
+                 * "successful" stays uncolored.
+                 */
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
@@ -48,8 +145,10 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -69,20 +168,22 @@ int recv_sideband(const char *me, int in_stream, int out)
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
new file mode 100644
index 000000000..4e1bd421f
--- /dev/null
+++ b/t/t5409-colorize-remote-messages.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='remote messages are colorized on the client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+	cat << EOF > .git/hooks/update &&
+#!/bin/sh
+echo error: error
+echo hint: hint
+echo success: success
+echo warning: warning
+echo prefixerror: error
+exit 0
+EOF
+	chmod +x .git/hooks/update &&
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git clone . child &&
+	cd child &&
+	echo 2 > file &&
+	git commit -a -m 2
+'
+
+test_expect_success 'push' '
+	git -c color.remote=always push -f origin HEAD:refs/heads/newbranch 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>:" decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;YELLOW>warning<RESET>:" decoded &&
+	grep "prefixerror: error" decoded
+'
+
+test_expect_success 'push with customized color' '
+	git -c color.remote=always -c color.remote.error=white push -f origin HEAD:refs/heads/newbranch2 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<WHITE>error<RESET>:" decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;YELLOW>warning<RESET>:" decoded
+'
+
+test_done
-- 
2.18.0.597.ga71716f1ad-goog


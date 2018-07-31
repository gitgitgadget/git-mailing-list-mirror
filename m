Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA181F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGaTSb (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:18:31 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:53277 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeGaTSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:18:31 -0400
Received: by mail-it0-f73.google.com with SMTP id e5-v6so3300676itf.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P2/qSgC2CH521lS1pVd1iXZUD6It7Sl0iqVjPVvUmck=;
        b=LoQ0OBNXpqrV8Do2gsCxDaDdDlg9dJxsJBYZKgCJRTxWCna7Lu9Fb2B4LwtMCltPbC
         XfpdcfQ+3dWTV23svKezklBB57wwjYmldemsjdBpeoooiLVlz5NJEqAMZl5A9/HUr5Ns
         dLCJxBqDfJIwXUvb2ToVBR7TkdRnGsxE3FjcKlDx3dM17040Swdm/CR8hOiLLTQyr8sy
         TXYnu9Zp8+0ECAXMnJK06HMyiOwYxgjaKQzLX50kRLercgfGqvz+4BQsmbtx/L81OEv2
         CryGztgGbDVqSSZOumUuanwRzChel6q8vEG7A+Le1kV7Tmu7sldp3m9+wGZ8zf/UQRPn
         h0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P2/qSgC2CH521lS1pVd1iXZUD6It7Sl0iqVjPVvUmck=;
        b=gW30kfCj5sUBF2CU9JP9P7BRIrzDVTyylC+dahJntTyJptsSzh8NCWrxmy6u0F9p5a
         CqGuF1CWyAh2WRZiROg63GAXcrwH6yspGU3+oGp9C6BQtCQW2/jEe/3SixLh4jYO7p8k
         BGG0AFWiNFs28I6NHTa56rBNL3SBN64x+P3NmB1TL0qQRZ8dlVqe5FEcObAXUubW53PZ
         p1Ij3EM9yezPGPhwxWdq1tk2RH2GW1zb+GR8moZLhcB3uDrZxUvx7BDwNChUXW1mLqy8
         sd4zkHZyZzl2PgiedYXTrqtMIXYbdI6DHBl86etaEMKQCw1qHGA7ydGszlZqVICbeUJj
         e08A==
X-Gm-Message-State: AOUpUlHmbQv9UzHSoMSFP41GImxj/UdH1M42apIhIAkihZGcrSRayA+E
        kJvLVzo5KeNqkfows9pc9C5HOjIriJE=
X-Google-Smtp-Source: AAOMgpfy+us6djQ/B8OI7H//HZredEFYUM/4l1O4u4xFj011PvFBZdDKRHL7xwMT5fdBVFAgK1lO+7IUhFs=
X-Received: by 2002:a6b:6803:: with SMTP id d3-v6mr8419608ioc.7.1533058629187;
 Tue, 31 Jul 2018 10:37:09 -0700 (PDT)
Date:   Tue, 31 Jul 2018 19:36:51 +0200
In-Reply-To: <20180731173651.184716-1-hanwen@google.com>
Message-Id: <20180731173651.184716-3-hanwen@google.com>
Mime-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 2/2] Highlight keywords in remote sideband output.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The highlighting is done on the client-side. Supported keywords are
"error", "warning", "hint" and "success".

The colorization is controlled with the config setting "color.remote".

Co-authored-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/config.txt            |   9 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 113 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 ++++++++++++
 5 files changed, 162 insertions(+), 9 deletions(-)
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
index 325bf0e97..0d67583ec 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,97 @@
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
+static int sideband_use_color = -1;
+
+static void load_sideband_colors(void)
+{
+	const char *key = "color.remote";
+	struct strbuf sb = STRBUF_INIT;
+	char *value;
+	int i;
+
+	if (sideband_use_color >= 0)
+		return;
+
+	if (!git_config_get_string(key, &value))
+		sideband_use_color = git_config_colorbool(key, value);
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
+ * start of the line.
+ */
+void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+
+	load_sideband_colors();
+ 	if (!want_color_stderr(sideband_use_color)) {
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
@@ -48,8 +139,10 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -69,20 +162,22 @@ int recv_sideband(const char *me, int in_stream, int out)
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
2.18.0.345.g5c9ce644c3-goog


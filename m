Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84608C33CAB
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E0E214D8
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWRtVXvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgAMI3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgAMI3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so8548627wmf.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aIVFmW+ag61G3qpmr5SfVtnq0Qq3IxumTrYFwfEvO/w=;
        b=NWRtVXvxlzCOqLzqAH5Iw2HH9QHjHia+yStyg4jm8l6VC/W9kx5S7v18gHTfMMUNc8
         9ov2xKXnCo0eFandwzQ4ZCxXF6rAlSY2Cu8pfrNu4ZM6+fZfGy58podSyPXnKXDxr0xd
         zAFCFs9oDzWkH+eZAkrLZq3Pk+naC50EPpcw8l37cSFolNS0+aZnVL3bQNvt21uGVd6V
         q/vele7/5aDX1ItfbiRpYx3Q3VaIExCRkvhf5LFEe8ZF8YE2miFlslIclQ5bbjQ7XN7O
         Y8dznq2LnwhZ9UHKkfCuZm6abmMy5D/ctiD0UBY9MgNmooRWoKyVcXu9QKXLMBK7Urcg
         j2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aIVFmW+ag61G3qpmr5SfVtnq0Qq3IxumTrYFwfEvO/w=;
        b=CWh5zKaLkQew0P8RZcpWW9hhLzrPGa8+x56vSEVBDtaKVnCRfUdz2qFUkmvVVCprkV
         8LnSlpK54pqDFB51Brq+B3qFAFaeHw/wnXHKXJi2OxBE7NFWuLbT/ngQtGVAaXblj19/
         MPULWV4aSAbKcnFiS8TAULlowBnhKAxFiYQ5wgpCNoMjlQU04BCaabbNL5194qp/Of0O
         AkIEnhh28z8bu4OpqXnrBhr/p6aKUrFXYDXeyZ5kODj+zlNCVe/yjY5TD8SlZ2Za1/vm
         ONuHA54pV5Hjsjnlt+otHp5s1APUbN5PivPpBsYDPJaXVK/xuSZSX/iV8uYr1lp3cnMG
         /uNQ==
X-Gm-Message-State: APjAAAXbdOHlrXsHrN4pIo8ZCKsLAWMkMEChUjU0db3G8o6RkuDMuxuD
        PrPcdVHlzQvdLLri+4JEma7d/ICW
X-Google-Smtp-Source: APXvYqznYl6we8xHGADHw581l3+qeftgmvz4gosF3t9Qj/MgEbkJlRKwItjC3QAZIfi509/CyKyJEQ==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr18312248wmo.48.1578904179306;
        Mon, 13 Jan 2020 00:29:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm14874730wrg.27.2020.01.13.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:38 -0800 (PST)
Message-Id: <bdb6268b8b5830311d0e7c8528eaa2e7a0664ab8.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:30 +0000
Subject: [PATCH v3 09/10] built-in add -p: handle Escape sequences more
 efficiently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `interactive.singlekey = true`, we react immediately to keystrokes,
even to Escape sequences (e.g. when pressing a cursor key).

The problem with Escape sequences is that we do not really know when
they are done, and as a heuristic we poll standard input for half a
second to make sure that we got all of it.

While waiting half a second is not asking for a whole lot, it can become
quite annoying over time, therefore with this patch, we read the
terminal capabilities (if available) and extract known Escape sequences
from there, then stop polling immediately when we detected that the user
pressed a key that generated such a known sequence.

This recapitulates the remaining part of b5cc003253c8 (add -i: ignore
terminal escape sequences, 2011-05-17).

Note: We do *not* query the terminal capabilities directly. That would
either require a lot of platform-specific code, or it would require
linking to a library such as ncurses.

Linking to a library in the built-ins is something we try very hard to
avoid (we even kicked the libcurl dependency to a non-built-in remote
helper, just to shave off a tiny fraction of a second from Git's startup
time). And the platform-specific code would be a maintenance nightmare.

Even worse: in Git for Windows' case, we would need to query MSYS2
pseudo terminals, which `git.exe` simply cannot do (because it is
intentionally *not* an MSYS2 program).

To address this, we simply spawn `infocmp -L -1` and parse its output
(which works even in Git for Windows, because that helper is included in
the end-user facing installations).

This is done only once, as in the Perl version, but it is done only when
the first Escape sequence is encountered, not upon startup of `git add
-i`; This saves on startup time, yet makes reacting to the first Escape
sequence slightly more sluggish. But it allows us to keep the
terminal-related code encapsulated in the `compat/terminal.c` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index b7f58d1781..35bca03d14 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "hashmap.h"
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
@@ -238,6 +239,71 @@ char *git_terminal_prompt(const char *prompt, int echo)
 	return buf.buf;
 }
 
+/*
+ * The `is_known_escape_sequence()` function returns 1 if the passed string
+ * corresponds to an Escape sequence that the terminal capabilities contains.
+ *
+ * To avoid depending on ncurses or other platform-specific libraries, we rely
+ * on the presence of the `infocmp` executable to do the job for us (failing
+ * silently if the program is not available or refused to run).
+ */
+struct escape_sequence_entry {
+	struct hashmap_entry entry;
+	char sequence[FLEX_ARRAY];
+};
+
+static int sequence_entry_cmp(const void *hashmap_cmp_fn_data,
+			      const struct escape_sequence_entry *e1,
+			      const struct escape_sequence_entry *e2,
+			      const void *keydata)
+{
+	return strcmp(e1->sequence, keydata ? keydata : e2->sequence);
+}
+
+static int is_known_escape_sequence(const char *sequence)
+{
+	static struct hashmap sequences;
+	static int initialized;
+
+	if (!initialized) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf buf = STRBUF_INIT;
+		char *p, *eol;
+
+		hashmap_init(&sequences, (hashmap_cmp_fn)sequence_entry_cmp,
+			     NULL, 0);
+
+		argv_array_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
+		if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
+			strbuf_setlen(&buf, 0);
+
+		for (eol = p = buf.buf; *p; p = eol + 1) {
+			p = strchr(p, '=');
+			if (!p)
+				break;
+			p++;
+			eol = strchrnul(p, '\n');
+
+			if (starts_with(p, "\\E")) {
+				char *comma = memchr(p, ',', eol - p);
+				struct escape_sequence_entry *e;
+
+				p[0] = '^';
+				p[1] = '[';
+				FLEX_ALLOC_MEM(e, sequence, p, comma - p);
+				hashmap_entry_init(&e->entry,
+						   strhash(e->sequence));
+				hashmap_add(&sequences, &e->entry);
+			}
+			if (!*eol)
+				break;
+		}
+		initialized = 1;
+	}
+
+	return !!hashmap_get_from_hash(&sequences, strhash(sequence), sequence);
+}
+
 int read_key_without_echo(struct strbuf *buf)
 {
 	static int warning_displayed;
@@ -271,7 +337,12 @@ int read_key_without_echo(struct strbuf *buf)
 		 * Start by replacing the Escape byte with ^[ */
 		strbuf_splice(buf, buf->len - 1, 1, "^[", 2);
 
-		for (;;) {
+		/*
+		 * Query the terminal capabilities once about all the Escape
+		 * sequences it knows about, so that we can avoid waiting for
+		 * half a second when we know that the sequence is complete.
+		 */
+		while (!is_known_escape_sequence(buf->buf)) {
 			struct pollfd pfd = { .fd = 0, .events = POLLIN };
 
 			if (poll(&pfd, 1, 500) < 1)
-- 
gitgitgadget


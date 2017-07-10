Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFA720357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbdGJV43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36136 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbdGJV41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id f28so12304310lfi.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtyjIqfQbxOvKYe5dnbwQ0FD/tK7FXZrfchFVCsN2Ns=;
        b=fL1aZYKiBfQoXvp1DlutGa0bVxntBOAaDPwMP/VFE7jH7Jj9GklII96zshf/arwWIu
         4gn/g9xWKfr90LqH2c6h2q12o6XTVKB769WlHmpUTKvo+hf0O27iV/sdBu6VSTDGWuAj
         /OaLk0TyK2T1lTfBDSuat+jat4oZJP9MctZEAA9qIX1qdsTiTMh4KnRS+FaLp2eQLWUZ
         J/2pVmCLEGIstCQsCgOJ1XTP4zWcEjtaJJQ/hLYcymx4GJZhs7ZRoYBMd9v8n7rZSlLL
         6CEDL6tlXV9NfKk0/MhsPPytmijl2ELhb7Tb88r0/mRvLmlEXxJrOXw6x5Tm1c5NhdDi
         9UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtyjIqfQbxOvKYe5dnbwQ0FD/tK7FXZrfchFVCsN2Ns=;
        b=fN5sn2o5d05ay7MUXv542xXuOn3nycwxVyuLngh5aMTdUpu8cRZW1NgFArvCYmMqUr
         nzjA2r8+bOJ90O2D52nwk/roiv6S1BwOylryAI5pgW7wB5LKfjcYuRZfbQ6RysDySN/+
         Ee3BIeb79dNSGj5uvaL48+3qVvSv62x67hHvrnzBZcZw+kUj4gcImK6pViKfRyftGlNW
         7jQbLqJW3t6HCfcFg4WiE9Pk9mjkd24U3e9SLuMCXJdH685McJ+xyHWYrJIDJPcJsr7h
         lHdakNvj03NEFEkcKBLqeN4LkIfP83vHFvjzywvQUeJ/GyJuV1OIEf4zHhKAOCVkocXO
         FC2Q==
X-Gm-Message-State: AIVw113RFyCkfFQCzZFnxxQsX7VOSYF179pL3HrObNaC906mc3EUMOKR
        AVX4Gg1mjKYuRUiR02g=
X-Received: by 10.25.24.80 with SMTP id o77mr2131700lfi.143.1499723784913;
        Mon, 10 Jul 2017 14:56:24 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/7] git.c: provide setup_auto_pager()
Date:   Mon, 10 Jul 2017 23:55:16 +0200
Message-Id: <1d639a4c7be5f1c173502f79e85aadd017ef5f7c.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch introduced a way for builtins to declare that they
will take responsibility for handling the `pager.foo`-config item. (See
the commit message of that patch for why that could be useful.)

Provide setup_auto_pager(), which builtins can call in order to handle
`pager.<cmd>`, including possibly starting the pager. Make this function
don't do anything if a pager has already been started.

When the `cmd` given to setup_auto_pager() contains one or more '.', use
a fallback strategy which checks `pager.foo.bar.baz`, then
`pager.foo.bar`, then `pager.foo`, then resorts to the provided default
value. This ensures a consistent fallback strategy for builtins which
take this type of more fine-grained pager configuration.

An alternative fallback strategy would have been to check for
`pager.foo.bar.baz`, then immediately fall back to `def`. However, that
would have meant that git foo would sometimes completely ignore
`pager.foo`, which seems conceptually wrong. It would also have meant
that builtins that are moved to more fine-grained pager configurations
would have regressed for certain usecases.

Whenever this function is called from a builtin, git.c will already have
called commit_pager_choice(). Since commit_pager_choice() treats the
special value -1 as "punt" or "not yet decided", it is not a problem
that we might end up calling commit_pager_choice() many times. Make the
new function use -1 in the same way and document it as "punt".

Don't add any users of setup_auto_pager just yet, one will follow in
later patches.

setup_auto_pager() is more capable than it needs to be for this patch
series. It would have been sufficient to handle zero or one '.'. We
would probably have wanted some verification+BUG()-patterns or to
define whether we split at the first or last '.', so it seems just as
easy, and certainly more flexible, to handle the more general situation.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h | 14 ++++++++++++++
 git.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/builtin.h b/builtin.h
index 498ac80d0..a6ed6c4ac 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,6 +25,20 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
+/**
+ * If a builtin has IGNORE_PAGER_CONFIG set, the builtin should call this early
+ * when it wishes to respect the `pager.foo`-config. In the simplest case, the
+ * `cmd` is the name of the builtin, e.g., "foo". If a paging-choice has already
+ * been setup, this does nothing. The default in `def` should be 0 for "pager
+ * off", 1 for "pager on" or -1 for "punt".
+ *
+ * With one or more '.', substrings are tried out from longer to shorter. If no
+ * config is found, uses `def`. For example, with `cmd` as "foo.bar.baz", this
+ * function tries `pager.foo.bar.baz`, `pager.foo.bar` and `pager.foo` in that
+ * order before resorting to `def`.
+ */
+extern void setup_auto_pager(const char *cmd, int def);
+
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index ae92f8ed5..696eaf87a 100644
--- a/git.c
+++ b/git.c
@@ -33,6 +33,34 @@ static void commit_pager_choice(void) {
 	}
 }
 
+void setup_auto_pager(const char *cmd, int def)
+{
+	if (use_pager != -1)
+		return;
+
+	use_pager = check_pager_config(cmd);
+
+	if (use_pager == -1) {
+		struct strbuf buf = STRBUF_INIT;
+		size_t len;
+
+		strbuf_addstr(&buf, cmd);
+		len = buf.len;
+		while (use_pager == -1 && len--) {
+			if (buf.buf[len] == '.') {
+				strbuf_setlen(&buf, len);
+				use_pager = check_pager_config(buf.buf);
+			}
+		}
+		strbuf_release(&buf);
+	}
+
+	if (use_pager == -1)
+		use_pager = def;
+
+	commit_pager_choice();
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
-- 
2.13.2.653.gfb5159d


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C211F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeKNHeH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:34:07 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40247 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNHeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:34:07 -0500
Received: by mail-pg1-f202.google.com with SMTP id r13so9072839pgb.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N9Y9JCzQ/GkX8zrBcGPk7UOLXKxhLjaoxqmaWxbyuq4=;
        b=kt1sxRRSPE5VZtRP8hPHWPjVtHGGawLdCU07yeR/gGl81naLupbfL8VmAoKDt8kxYr
         u9hDKP3HGRn8j0lEkUTYgHz7qfSDbiYOtnNtA+vIearPanAjYvnG0c+ZXfO4TxSraL/D
         r0Rf4GLtNDm/YhG8NXtHo2PlRjeX0lZ8M/dL4d+reb8FtmAGyjD1e72edeszS3LrDG80
         Jqb9J+SqnpD83FuBACZsibXnVyMxj/ieBelikNl1HovZsV4m0fxMtg1WP0LE2Y45JwiQ
         jL4Z8AJ4UbyMCt8oHfIvP+NV0nlVuBBJ7zZAo2PggjHQbCM6/XkENMxo94kjKZb15Dv9
         4L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9Y9JCzQ/GkX8zrBcGPk7UOLXKxhLjaoxqmaWxbyuq4=;
        b=FiudRhaO3Rw8ZHLYM6JsYTDK25aMVrK6/uMmWYWJ9q3vBgfxkO4wLKs0NEMAtPNugc
         /zceXsF2e5w2zY5Amro7jWZ96OJEP6iaMauqWlrt+OD1tc+7IZFvv3kObucMvjKVQVP7
         PZjxVi0ofvbCUowRGA5VZjjIlB4zjo8cWLHBHI6wGwKndUwgp9bTDpQmHai8tGy4aI+h
         hYgfQLJ80/2Ss0kRvde0ka/y5iMp1yAvcl50BcgHUbcsabWDbWH8SxVv/bio1AalXP0m
         eTi/vYA8Iva4IgVG/9oz5A9bgbfKWZ7Dvh5ms7lOFl6QWS5JhGTPswR40O3uCiFgrTQ2
         fhGQ==
X-Gm-Message-State: AGRZ1gJIlT70ntPYT62O0DJiXGvck16Z0BJSInR4hDtRE3/QUESga/8e
        vg2/3BIezcGU9kONHmqGvWC8qu1G0sX5
X-Google-Smtp-Source: AJdET5dK0xf6+c9KXcBpSNdgE8vuu3ukKIkxPyNT2btLW3fUCLDilFdhAznM/MLnVy2scpQzGqL0GoNQw5Do
X-Received: by 2002:a62:b513:: with SMTP id y19-v6mr321299pfe.89.1542144844133;
 Tue, 13 Nov 2018 13:34:04 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:33:57 -0800
In-Reply-To: <CAGZ79kbJvX1Y8-iiAzXKKam7hy=pg-5+p_rzDse42-oCswMXSQ@mail.gmail.com>
Message-Id: <20181113213357.205769-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbJvX1Y8-iiAzXKKam7hy=pg-5+p_rzDse42-oCswMXSQ@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH] diff: align move detection error handling with other options
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes the error handling for the options --color-moved-ws
and --color-moved-ws to be like the rest of the options.

Move the die() call out of parse_color_moved_ws into the parsing
of command line options. As the function returns a bit field, change
its signature to return an unsigned instead of an int; add a new bit
to signal errors. Once the error is signaled, we discard the other
bits, such that it doesn't matter if the error bit overlaps with any
other bit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

c.f.
./git -c diff.colormovedws=bogus diff HEAD
error: unknown color-moved-ws mode 'bogus'
fatal: unable to parse 'diff.colormovedws' from command-line config
./git -c core.abbrev=41 diff
error: abbrev length out of range: 41
fatal: unable to parse 'core.abbrev' from command-line config

./git diff --color=bogus
error: option `color' expects "always", "auto", or "never"
./git -c diff.colormovedws=bogus diff HEAD
error: unknown color-moved-ws mode 'bogus'
fatal: unable to parse 'diff.colormovedws' from command-line config


 diff.c                     | 25 ++++++++++++++++---------
 diff.h                     |  3 ++-
 t/t4015-diff-whitespace.sh | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 8647db3d30..d7d467b605 100644
--- a/diff.c
+++ b/diff.c
@@ -291,7 +291,7 @@ static int parse_color_moved(const char *arg)
 		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed-zebra', 'plain'"));
 }
 
-static int parse_color_moved_ws(const char *arg)
+static unsigned parse_color_moved_ws(const char *arg)
 {
 	int ret = 0;
 	struct string_list l = STRING_LIST_INIT_DUP;
@@ -312,15 +312,19 @@ static int parse_color_moved_ws(const char *arg)
 			ret |= XDF_IGNORE_WHITESPACE;
 		else if (!strcmp(sb.buf, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
-		else
-			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
+		else {
+			ret |= COLOR_MOVED_WS_ERROR;
+			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), sb.buf);
+		}
 
 		strbuf_release(&sb);
 	}
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
-	    (ret & XDF_WHITESPACE_FLAGS))
-		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+	    (ret & XDF_WHITESPACE_FLAGS)) {
+		error(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+		ret |= COLOR_MOVED_WS_ERROR;
+	}
 
 	string_list_clear(&l, 0);
 
@@ -341,8 +345,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.colormovedws")) {
-		int cm = parse_color_moved_ws(value);
-		if (cm < 0)
+		unsigned cm = parse_color_moved_ws(value);
+		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		diff_color_moved_ws_default = cm;
 		return 0;
@@ -5032,10 +5036,13 @@ int diff_opt_parse(struct diff_options *options,
 	else if (skip_prefix(arg, "--color-moved=", &arg)) {
 		int cm = parse_color_moved(arg);
 		if (cm < 0)
-			die("bad --color-moved argument: %s", arg);
+			return error("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
 	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
-		options->color_moved_ws_handling = parse_color_moved_ws(arg);
+		unsigned cm = parse_color_moved_ws(arg);
+		if (cm & COLOR_MOVED_WS_ERROR)
+			return -1;
+		options->color_moved_ws_handling = cm;
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
diff --git a/diff.h b/diff.h
index ce5e8a8183..9e8061ca29 100644
--- a/diff.h
+++ b/diff.h
@@ -225,7 +225,8 @@ struct diff_options {
 
 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
 	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
-	int color_moved_ws_handling;
+	#define COLOR_MOVED_WS_ERROR (1<<0)
+	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
 };
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index a9fb226c5a..9a3e4fdfec 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1890,6 +1890,24 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 	test_cmp expected actual
 '
 
+test_expect_success 'bogus settings in move detection erroring out' '
+	test_must_fail git diff --color-moved=bogus 2>err &&
+	test_i18ngrep "must be one of" err &&
+	test_i18ngrep bogus err &&
+
+	test_must_fail git -c diff.colormoved=bogus diff 2>err &&
+	test_i18ngrep "must be one of" err &&
+	test_i18ngrep "from command-line config" err &&
+
+	test_must_fail git diff --color-moved-ws=bogus 2>err &&
+	test_i18ngrep "possible values" err &&
+	test_i18ngrep bogus err &&
+
+	test_must_fail git -c diff.colormovedws=bogus diff 2>err &&
+	test_i18ngrep "possible values" err &&
+	test_i18ngrep "from command-line config" err
+'
+
 test_expect_success 'compare whitespace delta incompatible with other space options' '
 	test_must_fail git diff \
 		--color-moved-ws=allow-indentation-change,ignore-all-space \
-- 
2.19.1.1215.g8438c0b245-goog


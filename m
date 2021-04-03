Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D16C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C1E611CE
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 12:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhDCMv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhDCMv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 08:51:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78ACC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 05:51:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g8so10965973lfv.12
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6jTIC+mWSjbUHfm/QIj632QPSSTjrop+B5IvUWqPG0=;
        b=dGfsg0tS8TqP/foCYOgYYHXLku3u42g7D2EbARPLLUYNJfXynauR5X/xr+nj0lx7Zd
         2+/3voxzDwmoOtz2py9YjcYqnozJdP4XpZl5enBodr31QOinjUCJMgZwoPz5cg72TN6b
         BNXy50Z/R5szwwx/r+Bz+Zv5nqu9BEGnbI6eZtcD6gqHk4FsU5lupNeI3tbgcG/oG7Fi
         IqcF1Y19/MugtcefE6alCmwgvKu8ZStPOI1kQakSN1PgRIKaMUkDDjmRqVWQME14hn8L
         /+TaEgRbN5svMObTDXelQWeCYWTaIXlzKk2bmAimyiK9z0xFrrHMK8SYEB9SLD2uQLnI
         BtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6jTIC+mWSjbUHfm/QIj632QPSSTjrop+B5IvUWqPG0=;
        b=RftUI7oiuJHDW4sjICT3+82HEchX42OfjFLZ6K/8P6ksvUF8y1UqlrV7f6Z2ARndnz
         DugsJKeN8PDCmA1aQyBQkNU8lIVatwG0ZZiLHL13cV+kjciZ+O4ceFJo/RFZ9WEKCjrX
         Z6J/Q6nnYmLeX528kQprRbFTA/d/1X6vVrgRM+P8mys67dUEYjDvEVcCHiS8subBecz6
         l0EguJ8j4TMuel0yqKO7Iw6OEalTF71DAOoovUyB2aY6C4PNQnYW3IfZcicfxYIMdbEy
         tlVzQlKHK40yfK6qvHAJQN0eYiXV9ktixBFLDE2DKe8AaDaaFrLHhR0ZQRuXjTfc6Ycn
         fE4A==
X-Gm-Message-State: AOAM53183hc5W++vzt663gBwWYz7VgDh8UIe04wHmrUtUqM6XWh69pUu
        dBYyzdKC7h59mQQvkPYo1/KZmtPpiQRspXza
X-Google-Smtp-Source: ABdhPJyV9fsWg6iINKfZCK6+FXn7qgpoHDwdgNQ44+lJ6zMSBrhXEO0ZOPMhpmmV1xqAoWSc4n8BEQ==
X-Received: by 2002:a05:6512:3d1c:: with SMTP id d28mr11326375lfv.41.1617454311704;
        Sat, 03 Apr 2021 05:51:51 -0700 (PDT)
Received: from localhost.localdomain (88-115-235-153.elisa-laajakaista.fi. [88.115.235.153])
        by smtp.googlemail.com with ESMTPSA id a14sm1142818lfi.7.2021.04.03.05.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 05:51:51 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        peff@peff.net,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v4] pathspec: advice: long and short forms are incompatible
Date:   Sat,  3 Apr 2021 15:51:43 +0300
Message-Id: <20210403125143.22498-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be a "reasonable" mistake to mix short and long forms,
e.g. `:!(glob)`, instead of the (correct) `:(exclude,glob)`.

Teach git to issue an advice when such a pathspec is given.
        i.e.: While in short form parsing:
        * if the string contains an open parenthesis [`(`], and
        * without having explicitly terminated magic parsing (`:`)
        issue an advice hinting to that fact.

Based on "Junio C Hamano <gitster@pobox.com>"'s code suggestions:
* https://lore.kernel.org/git/xmqqa6qoqw9n.fsf@gitster.g/
* https://lore.kernel.org/git/xmqqo8f0cr9z.fsf@gitster.g/

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 Documentation/config/advice.txt |  3 +++
 advice.c                        |  3 +++
 advice.h                        |  2 ++
 pathspec.c                      | 33 ++++++++++++++++++++++++++++
 t/t6132-pathspec-exclude.sh     | 38 +++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index acbd0c09aa..05a3cbc164 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -119,4 +119,7 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	mixedPathspecMagic::
+		Advice shown if a user tries to mix short- and
+		longform pathspec magic.
 --
diff --git a/advice.c b/advice.c
index 164742305f..b1955966d5 100644
--- a/advice.c
+++ b/advice.c
@@ -33,6 +33,7 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 int advice_add_ignored_file = 1;
 int advice_add_empty_pathspec = 1;
+int advice_mixed_pathspec_magic = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -95,6 +96,7 @@ static struct {
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 	{ "addIgnoredFile", &advice_add_ignored_file },
 	{ "addEmptyPathspec", &advice_add_empty_pathspec },
+	{ "mixedPathspecMagic", &advice_mixed_pathspec_magic },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
@@ -137,6 +139,7 @@ static struct {
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+	[ADVICE_MIXED_PATHSPEC_MAGIC]			= { "mixedPathspecMagic", 1 },
 };
 
 static const char turn_off_instructions[] =
diff --git a/advice.h b/advice.h
index bc2432980a..aa229fded8 100644
--- a/advice.h
+++ b/advice.h
@@ -33,6 +33,7 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_submodule_alternate_error_strategy_die;
 extern int advice_add_ignored_file;
 extern int advice_add_empty_pathspec;
+extern int advice_mixed_pathspec_magic;
 
 /*
  * To add a new advice, you need to:
@@ -72,6 +73,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
 	ADVICE_WAITING_FOR_EDITOR,
+	ADVICE_MIXED_PATHSPEC_MAGIC,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/pathspec.c b/pathspec.c
index 18b3be362a..5f77e2e8d8 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -336,6 +336,36 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	return pos;
 }
 
+
+/*
+ * Give hint for a common mistake of mixing short and long
+ * form of pathspec magic, as well as possible corrections
+ */
+static void warn_mixed_magic(unsigned magic, const char *elem, const char *pos)
+{
+	struct strbuf longform = STRBUF_INIT;
+	int i;
+
+	if (!advice_enabled(ADVICE_MIXED_PATHSPEC_MAGIC))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+		if (pathspec_magic[i].bit & magic) {
+			if (longform.len)
+				strbuf_addch(&longform, ',');
+			strbuf_addstr(&longform, pathspec_magic[i].name);
+		}
+	}
+	advise_if_enabled(ADVICE_MIXED_PATHSPEC_MAGIC,
+	                  _("'%.*s(...': cannot mix short- and longform pathspec magic!\n"
+	                    "Either spell the shortform magic '%.*s' as ':(%s,...'\n"
+	                    "or end magic pathspec matching with '%.*s:'."),
+	                  (int)(pos - elem), elem,
+	                  (int)(pos - (elem + 1)), elem + 1,
+	                  longform.buf,
+	                  (int)(pos - elem), elem);
+}
+
 /*
  * Parse the pathspec element looking for short magic
  *
@@ -356,6 +386,9 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 			continue;
 		}
 
+		if (ch == '(')
+			warn_mixed_magic(*magic, elem, pos);
+
 		if (!is_pathspec_magic(ch))
 			break;
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 30328b87f0..8b9d543e1e 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -244,4 +244,42 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
 	test_cmp expect-grep actual-grep
 '
 
+cat > expected_warn <<"EOF"
+hint: ':!(...': cannot mix short- and longform pathspec magic!
+hint: Either spell the shortform magic '!' as ':(exclude,...'
+hint: or end magic pathspec matching with ':!:'.
+hint: Disable this message with "git config advice.mixedPathspecMagic false"
+EOF
+test_expect_success 'warn pathspec not matching longform magic in :!(...)' '
+	git log --oneline --format=%s -- '"'"':!(glob)**/file'"'"' >actual 2>warn &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	cat actual &&
+	cat warn &&
+	test_cmp expect actual &&
+	test_cmp expected_warn warn
+'
+
+test_expect_success 'do not warn pathspec not matching longform magic in :!:(...) (i.e. if magic parsing is explicitly stopped)' '
+	git log --oneline --format=%s -- '"'"':!:(glob)**/file'"'"' >actual 2>warn &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	cat actual &&
+	cat warn &&
+	test_cmp expect actual &&
+	! test_cmp expected_warn warn
+'
+
 test_done
-- 
2.31.1


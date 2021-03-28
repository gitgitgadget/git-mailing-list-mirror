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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E87EC433E4
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C708619B1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhC1PqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC1Ppw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:45:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1CDC061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:45:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x16so10369840wrn.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmcY9CIyANR5x3I0iy1R3is7RNFZ04msrtEkdV7ZsgY=;
        b=dqGootULrrd1eKJejJovQZFshzm9dorfIcmg/mUEJoEWqx6nZCzLzmsYs8BNeQ+qEA
         +7p4brbOXs8NTICz88Uwjqv1zXnkBksIiBLf/mLujkzXl0mwxe9AlnDFYtfHG5sPz9nH
         4yR3MD6R2sxUeIdFFFNYBaJdHtQWWOqA+eVxjIb7FFy8eAXhqOprxL/7TQvqv15ih4KV
         /VAKqXHv2Xk5F4gI/u7fUrmBJGyACClKUQT8Eo+xXktmuvGro7UXRmQ7dlhX9xnBiAGg
         ubxTgTpuUyUG04JQJqn734hYio0fTwVapmLaLa1ZzizreqJpEOM6WBbXauiHuNPs9i67
         8n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmcY9CIyANR5x3I0iy1R3is7RNFZ04msrtEkdV7ZsgY=;
        b=LKOQV4KM6Vzkv+ihtoP/ShBdXdXTLTUPzFrkZ+OD6eRXdGb7Mkc2budTVDp30wkI1W
         KOR4RKuLtklYVimWtkR4C1H7W7D8M7hhv7mOGOnkagSdxsd5boP2/2f6En0b7i2ta3fe
         WdSab/SFgXBLd0pKILWf9pHkZOdqXS6keG2bIdZZqxpIz0pI7soXzLCv2qq2K2uZguJN
         BAJy+5DMcqUlslJAghFVlMVnYzSV8TRbHQbpcAq939URGVSldGOCTfTMkk1tjNqP7Y5A
         J6zmzjFtbZwi82nmJ+TYgGhj/O3/H3Ioh6UxcB8BfW4KlRMHmTl+8zxJd6YtX5C+ef6t
         fzTg==
X-Gm-Message-State: AOAM531IqavZbf8HZO33lUWy6XHlwfV0wM3Pbl6GKgKBD9k8IfbkM3VK
        tDZIyWYsC+vpKnovdhsNCVFvwGx3ADypkkm5/oU=
X-Google-Smtp-Source: ABdhPJwmxAQEA1n9XhKt1kw66JBwxeCqhL+OrKTwjrLRE1qiSQdvXPSXFBbhGLsZ4N3Cq4HyVLbp1g==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr24152484wry.48.1616946350007;
        Sun, 28 Mar 2021 08:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a302:a800:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id e17sm26980569wra.65.2021.03.28.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:45:49 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        peff@peff.net,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v2] pathspec: advice: long and short forms are incompatible
Date:   Sun, 28 Mar 2021 18:45:32 +0300
Message-Id: <20210328154532.23803-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
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

Based on "Junio C Hamano <gitster@pobox.com>"'s code suggestion
(in https://lore.kernel.org/git/xmqqa6qoqw9n.fsf@gitster.g/).

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 Documentation/config/advice.txt |  5 +++++
 advice.c                        |  3 +++
 advice.h                        |  2 ++
 pathspec.c                      | 16 ++++++++++++++
 t/t6132-pathspec-exclude.sh     | 37 +++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index acbd0c09aa..f7ccd05c3a 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -119,4 +119,9 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	mixedShortLongMagic::
+		Advice shown if a user provides a pathspec that could be
+		interpreted as a mixed short and long magic modifier(s)
+		(i.e. contains an open parenthesis `(` without explictly
+		terminating pathspec magic parsing with `:`).
 --
diff --git a/advice.c b/advice.c
index 164742305f..6630c57678 100644
--- a/advice.c
+++ b/advice.c
@@ -33,6 +33,7 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 int advice_add_ignored_file = 1;
 int advice_add_empty_pathspec = 1;
+int advice_mixed_short_long_magic_pathspec = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -95,6 +96,7 @@ static struct {
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 	{ "addIgnoredFile", &advice_add_ignored_file },
 	{ "addEmptyPathspec", &advice_add_empty_pathspec },
+	{ "mixedShortLongMagicPathspec", &advice_mixed_short_long_magic_pathspec },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
@@ -137,6 +139,7 @@ static struct {
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+	[ADVICE_MIXED_SHORT_LONG_MAGIC_PATHSPEC]	= { "mixedShortLongMagicPathspec", 1 },
 };
 
 static const char turn_off_instructions[] =
diff --git a/advice.h b/advice.h
index bc2432980a..050f058274 100644
--- a/advice.h
+++ b/advice.h
@@ -33,6 +33,7 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_submodule_alternate_error_strategy_die;
 extern int advice_add_ignored_file;
 extern int advice_add_empty_pathspec;
+extern int advice_mixed_short_long_magic_pathspec;
 
 /*
  * To add a new advice, you need to:
@@ -72,6 +73,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
 	ADVICE_WAITING_FOR_EDITOR,
+	ADVICE_MIXED_SHORT_LONG_MAGIC_PATHSPEC,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/pathspec.c b/pathspec.c
index 18b3be362a..085a624ad9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -336,6 +336,11 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	return pos;
 }
 
+static const char mixed_pathspec_magic[] = N_(
+	"'%.*s...': cannot mix shortform magic with longform [e.g. like :(glob)].\n"
+	"If '%.*s...' is a valid path, explicitly terminate magic parsing with ':'; or");
+static int extra_lookahead_chars = 7;
+
 /*
  * Parse the pathspec element looking for short magic
  *
@@ -356,6 +361,17 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 			continue;
 		}
 
+		if (ch == '(') {
+			/*
+			 * a possible mistake: once you started a shortform
+			 * you cannot add a longform, e.g. ":!(top)"
+			 */
+			advise_if_enabled(ADVICE_MIXED_SHORT_LONG_MAGIC_PATHSPEC,
+			                  _(mixed_pathspec_magic),
+			                  (int)(pos-elem+extra_lookahead_chars), elem,
+			                  extra_lookahead_chars, pos);
+		}
+
 		if (!is_pathspec_magic(ch))
 			break;
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 30328b87f0..b5d51c1429 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -244,4 +244,41 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
 	test_cmp expect-grep actual-grep
 '
 
+cat > expected_warn <<"EOF"
+hint: ':!(glob)*...': cannot mix shortform magic with longform [e.g. like :(glob)].
+hint: If '(glob)*...' is a valid path, explicitly terminate magic parsing with ':'; or
+hint: Disable this message with "git config advice.mixedShortLongMagicPathspec false"
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
2.31.0


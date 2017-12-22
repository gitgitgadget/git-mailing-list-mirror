Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BAD1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756201AbdLVUmH (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:42:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36351 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755941AbdLVUmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:42:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so23807016wmg.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBwKkorrKHWxYTZZUGTQ7VHoery90bONEZCmJMFHRQg=;
        b=At9ebqozktyAKzU6g7NVCg/39guIAnLwYXNLqrjonTirdQ5mjtbMrrOsdFRPZhuCra
         jPbVQttm2iK1OnUGFMc+Ilsq8gFF7WQNKv6434iKnSKW6esYUzd0PtAX3xZ5bp1Bx6/G
         Vr7ijWOv5seTVFhtDWmL8JVdWCg9Inrrk6wPQi1NsgTu6NaE0z+qIDev74f0LG3mtY/2
         M32dr1PHyjktENWu97vhuNFBkXYCzjQ5OEh00ph0p4Pkn8/lblqUxT05KZMROV1IvDuZ
         Tlj/LXz0ut0OTgElDvZpbqLQJDLn6mb2FYhqQVZCPK3Cd5xgXQRJI9NWB9RSLwqoCAyo
         skAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBwKkorrKHWxYTZZUGTQ7VHoery90bONEZCmJMFHRQg=;
        b=XiNrOTaGoQ0cykPEiutKvUayxKj0nYDm6QS7ZaRqhnutGtyKW9UvLVtBBjFzg8QK1w
         mc4w7LiEJBqIe3rEuI8xefMLqIZpA6lblv6ATl54RWS/g/2W8pB5rhhBiu9MAmmJN3XP
         y3jwXQiGKoWOWa/YKup6REoOemouIyyQpnQfiN9V3s212MJSiYZ74kePcuEQTWOdUGj0
         Okde3UEmJoMDwIs6YaT7bhq1OSpsSuNSRU0RETIyb1abBAVwaN1AKXqJuOO5h5Hrqt8u
         IreMlYanclTftzpBM/REPRWu4hKIGTE5LHhesAwB5O7OmuwEOv+JidwPojz/Eb8QY/ir
         4O+A==
X-Gm-Message-State: AKGB3mJdQnj4nYNnEvboSUDJJcQBXsakoRF+21lltcr7DQrk2SGQ4Swj
        5c4WNa1kXJ55+4B7b2WFAhBEBsbP
X-Google-Smtp-Source: ACJfBotEv1+Wqin9LXRgq/un+0xl7YzVER2Ii8j7xK0mmBg/CVz8NwIYIb1DL5gRzxP3PRnh0R65oA==
X-Received: by 10.28.175.66 with SMTP id y63mr14324583wme.125.1513975325116;
        Fri, 22 Dec 2017 12:42:05 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 192sm7870563wmg.32.2017.12.22.12.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 12:42:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
Date:   Fri, 22 Dec 2017 20:41:52 +0000
Message-Id: <20171222204152.4822-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for supplying the -m option with --fixup. Doing so has
errored out ever since --fixup was introduced. Before this, the only
way to amend the fixup message while committing was to use --edit and
amend it in the editor.

The use-case for this feature is one of:

 * Leaving a quick note to self when creating a --fixup commit when
   it's not self-evident why the commit should be squashed without a
   note into another one.

 * (Ab)using the --fixup feature to "fix up" commits that have already
   been pushed to a branch that doesn't allow non-fast-forwards,
   i.e. just noting "this should have been part of that other commit",
   and if the history ever got rewritten in the future the two should
   be combined.

   In such a case you might want to leave a small message,
   e.g. "forgot this part, which broke XYZ".

With this, --fixup <commit> -m"More" -m"Details" will result in a
commit message like:

    !fixup <subject of <commit>>

    More

    Details

The reason the test being added here seems to squash "More" at the end
of the subject line of the commit being fixed up is because the test
code is using "%s%b" so the body immediately follows the subject, it's
not a bug in this code, and other tests t7500-commit.sh do the same
thing.

When the --fixup option was initially added the "Option -m cannot be
combined" error was expanded from -c, -C and -F to also include
--fixup[1]

Those options could also support combining with -m, but given what
they do I can't think of a good use-case for doing that, so I have not
made the more invasive change of splitting up the logic in commit.c to
first act on those, and then on -m options.

1. d71b8ba7c9 ("commit: --fixup option for use with rebase
   --autosquash", 2010-11-02)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit.txt | 3 +--
 builtin/commit.c             | 8 +++++---
 t/t7500-commit.sh            | 9 ++++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3fbb7352bc..f970a43422 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -145,8 +145,7 @@ OPTIONS
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
 +
-The `-m` option is mutually exclusive with `-c`, `-C`, `-F`, and
-`--fixup`.
+The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -t <file>::
 --template=<file>::
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..4e68394391 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -701,7 +701,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
-	if (have_option_m) {
+	if (have_option_m && !fixup_message) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
@@ -731,6 +731,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		ctx.output_encoding = get_commit_output_encoding();
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
+		if (have_option_m)
+			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(), &statbuf)) {
 		/*
@@ -1197,8 +1199,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		f++;
 	if (f > 1)
 		die(_("Only one of -c/-C/-F/--fixup can be used."));
-	if (have_option_m && f > 0)
-		die((_("Option -m cannot be combined with -c/-C/-F/--fixup.")));
+	if (have_option_m && (edit_message || use_message || logfile))
+		die((_("Option -m cannot be combined with -c/-C/-F.")));
 	if (f || have_option_m)
 		template_file = NULL;
 	if (edit_message)
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 5739d3ed23..2d95778b74 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -272,6 +272,14 @@ test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_msg_is "fixup! target message subject line"
 '
 
+test_expect_success 'commit --fixup -m"something" -m"extra"' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 -m"something" -m"extra" &&
+	commit_msg_is "fixup! target message subject linesomething
+
+extra"
+'
+
 test_expect_success 'commit --squash works with -F' '
 	commit_for_rebase_autosquash_setup &&
 	echo "log message from file" >msgfile &&
@@ -325,7 +333,6 @@ test_expect_success 'invalid message options when using --fixup' '
 	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
 	test_must_fail git commit --fixup HEAD~1 -F log
 '
 
-- 
2.15.1.424.g9478a66081


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19699211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 19:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeK3GPt (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 01:15:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3GPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 01:15:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so1497420plb.10
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NXeCRtrZS9umQjlzK+901GtMeIMD0OREXvrKHVy74ww=;
        b=mknfrkb1S7xjLd38AOyys4FS+l6IakO0KpFxlfKXOCvLCrUh84FYxTbe0ADtc5nkW5
         ADIKPHebM4PEWc2p96h6MFeuKDuTxwvw6dorwwrgPIMP3I7d9zdDAZG0a88XKAYmTnPn
         nZKu086CN6OOfXM/xKTDPMh7GPQnLwDZvaDY6Rb8EnAEofln+AW0HX58G7Oflabjg56O
         AKPQ6rMN5c7L6BaT2B5tly2KWMXJppRZM6sj+4DpdkFZI8M0xBImCZJ6os/VrwiTEqE9
         pD6Ix4GKpPMPxrPYoP+theZrZJ1yvXzuBi3gDHLgIAMLo0qLrXlqDq3caQWtqkCa1DlE
         eTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NXeCRtrZS9umQjlzK+901GtMeIMD0OREXvrKHVy74ww=;
        b=FreVIH9XgKiEk+dJCT0CE61No5zxU5thBUo+3I7R8IlPi+ffdIThSL58P0ZhvpsiKH
         pxCeZGxTNcE+kZvlBXUWHgLwTLQIQWgK/xfLvdc1a4yo9ZYO7EfPHjbeGSDesCz4+pV+
         Fene882tYZk/A93M9qStNKw7DGQPGfhj8eZsv0IL2j9bsfZuXEAjqPzJBUJG2Y7elngI
         FrbYqWRP5UknrvohOMlqlGUwetQm/IR+0GFpWbgkbRQH0XD9c2u/5KtfpBbmZgkeRI0S
         5vaQUC6BKskiepcgGzd+sBC+xiOdMCKuVUvXriQvYT8OWI7NigRFl9xkN8uC8/xuGoxi
         GsMw==
X-Gm-Message-State: AA+aEWZbBnc78Yb+55SJNGvQvkw6Tca3rt6iL+d/iZvSQaRytOrqsog+
        Aw+iCewlLm0vZBha68ajmKCcoAl6WtQ=
X-Google-Smtp-Source: AFSGD/UkpC5tOc9Mg/lNhDogryRYGgHengsM8gin0M3PH4lgtV5RkKZHvYaggHnLsVgpw3w9YyzfAg==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr2662871plb.79.1543518562552;
        Thu, 29 Nov 2018 11:09:22 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o7sm3718642pfb.34.2018.11.29.11.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:09:21 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:09:21 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 19:09:18 GMT
Message-Id: <3295df5829e245a7dba80d3cb669a797ae42ebb9.1543518559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.91.git.gitgitgadget@gmail.com>
References: <pull.91.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase: fix GIT_REFLOG_ACTION regression
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version (partially) heeded the `GIT_REFLOG_ACTION` and when
we converted to a built-in, this regressed.

Fix that, and add a regression test, both with `GIT_REFLOG_ACTION` set
and unset.

Note: the reflog message for "rebase finished" did *not* heed
GIT_REFLOG_ACTION, and as we are very late in the v2.20.0-rcN phase, we
leave that bug for later (as it seems that that bug has been with us
from the very beginning).

Reported by Ian Jackson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c          | 29 ++++++++++++++++++++++++++---
 t/t3406-rebase-message.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..ba0c3c954b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -776,6 +776,23 @@ static void NORETURN error_on_missing_default_upstream(void)
 	exit(1);
 }
 
+static void set_reflog_action(struct rebase_options *options)
+{
+	const char *env;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!is_interactive(options))
+		return;
+
+	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	if (env && strcmp("rebase", env))
+		return; /* only override it if it is "rebase" */
+
+	strbuf_addf(&buf, "rebase -i (%s)", options->action);
+	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
+	strbuf_release(&buf);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -978,6 +995,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
+	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
 	if (action == ACTION_EDIT_TODO && !is_interactive(&options))
 		die(_("The --edit-todo action can only be used during "
@@ -990,6 +1008,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int fd;
 
 		options.action = "continue";
+		set_reflog_action(&options);
 
 		/* Sanity check */
 		if (get_oid("HEAD", &head))
@@ -1018,6 +1037,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		options.action = "skip";
+		set_reflog_action(&options);
 
 		rerere_clear(&merge_rr);
 		string_list_clear(&merge_rr, 1);
@@ -1033,6 +1053,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	case ACTION_ABORT: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 		options.action = "abort";
+		set_reflog_action(&options);
 
 		rerere_clear(&merge_rr);
 		string_list_clear(&merge_rr, 1);
@@ -1440,11 +1461,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				}
 
 				strbuf_reset(&buf);
-				strbuf_addf(&buf, "rebase: checkout %s",
+				strbuf_addf(&buf, "%s: checkout %s",
+					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 					    options.switch_to);
 				if (reset_head(&oid, "checkout",
 					       options.head_name, 0,
-					       NULL, NULL) < 0) {
+					       NULL, buf.buf) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
 						      options.switch_to);
@@ -1508,7 +1530,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
+	strbuf_addf(&msg, "%s: checkout %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
 		       RESET_HEAD_DETACH, NULL, msg.buf))
 		die(_("Could not detach HEAD"));
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 38bd876cab..db8505eb86 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -91,4 +91,30 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 	test_i18ngrep "Invalid whitespace option" err
 '
 
+test_expect_success 'GIT_REFLOG_ACTION' '
+	git checkout start &&
+	test_commit reflog-onto &&
+	git checkout -b reflog-topic start &&
+	test_commit reflog-to-rebase &&
+
+	git rebase reflog-onto &&
+	git log -g --format=%gs -3 >actual &&
+	cat >expect <<-\EOF &&
+	rebase finished: returning to refs/heads/reflog-topic
+	rebase: reflog-to-rebase
+	rebase: checkout reflog-onto
+	EOF
+	test_cmp expect actual &&
+
+	git checkout -b reflog-prefix reflog-to-rebase &&
+	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
+	git log -g --format=%gs -3 >actual &&
+	cat >expect <<-\EOF &&
+	rebase finished: returning to refs/heads/reflog-prefix
+	change-the-reflog: reflog-to-rebase
+	change-the-reflog: checkout reflog-onto
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

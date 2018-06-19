Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652151F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966849AbeFSPpD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:45:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40267 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966410AbeFSPpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:45:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so1301672wmc.5
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyfP+MavPaXx8UTUEhkpR6Vc5YgNwfaNpmLC7C/xK4Q=;
        b=G2Sa4TnjWMVfbL70B3zzr//ZylBlbfv83EQQ76I86LLWfqZbqKzi6aEbDFRQ70paAZ
         dx05EXwqnY2ChC8zl8ljehVb5uOjITh5LZROliiQOs5CNVpEabnRqL4KQ8BZQSe7uOPs
         rgMycy6WxWYN5xjELhOvuTFUBSH8OEwCNIFkl5YdCVVUwX1nk5VEWhRx4NESZsTWVucb
         mgOFMTXmf6k5CA+dizZquUGPvNhPLZ/B4lydlFQsdE1DLuFP+5UZuKmt4cGbCscWNIRL
         wZPiABCALbXFF4RSt6yTBfQ/HirdMieKn+8SgkkNI/k8f08nsmRFzQRVxv4ERaCFoKpN
         BTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyfP+MavPaXx8UTUEhkpR6Vc5YgNwfaNpmLC7C/xK4Q=;
        b=aojNEOGTNeXpD+71MQiY75HmbogMEN6/1SbFDgUL78V0GfUdxfZHz63eWbndnrPGy7
         Q8PrkjFAM2GHYpK8mJqJlf6PZ4m6jm8SpofLqsh+Gs/tT9J6bi7q3sp34vjUQt+z6y9a
         aV/n5H8elJRkJQhIo0jZVpyPgHC2LniZGBw2D2nYsLTXBjLPk27480zNMATCa8Ker7Ty
         +m9ezVad6Knzvdew384hEkZKoMIgJY1RAuGRZyHR4eZIa2+JhJbx+/QS/+Lq2iN3Bx4z
         WXSekyQBAfIWJYdo744Y/LnYl+mIbQWGN0h+UXBT0+j6WHgSHF9HT0A9zhavzDmpAG+Q
         xMzQ==
X-Gm-Message-State: APt69E1Ppc3i7v/sIeUEs6yGH2+EG7dBqUpqM91bu+OXPV9bwMtwV1db
        sMNwJ7iry/t1z9xWKWqgn3Y2C6Iz
X-Google-Smtp-Source: ADUXVKJre0eQJ8zKTJ4qAdzeOIYdCI4rn53N8ums/aNOmZ2PXAw9OTMQ0NZwlibjvmnUcTrv5lMMKQ==
X-Received: by 2002:a1c:64c5:: with SMTP id y188-v6mr12070037wmb.45.1529423100277;
        Tue, 19 Jun 2018 08:45:00 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id q77-v6sm596176wmg.25.2018.06.19.08.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:44:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 1/3] sequencer: add a new function to silence a command, except if it fails.
Date:   Tue, 19 Jun 2018 17:44:19 +0200
Message-Id: <20180619154421.14999-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180619154421.14999-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new function, run_command_silent_on_success(), to redirect
the stdout and stderr of a command to a strbuf, and then to run that
command. This strbuf is printed only if the command fails. It also takes
a parameter, “verbose”. When true, the command is executed without
redirecting its output. It is functionnally similar to output() from
git-rebase.sh.

run_git_commit() is then refactored to use of
run_command_silent_on_success().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 55 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7cc76332e..9aa7ddb33 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -766,6 +766,29 @@ N_("you have staged changes in your working tree\n"
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
 
+static int run_command_silent_on_success(struct child_process *cmd,
+					 unsigned verbose)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int rc;
+
+	if (verbose)
+		return run_command(cmd);
+
+	/* hide stderr on success */
+	cmd->stdout_to_stderr = 1;
+	rc = pipe_command(cmd,
+			  NULL, 0,
+			  /* stdout is already redirected */
+			  NULL, 0,
+			  &buf, 0);
+
+	if (rc)
+		fputs(buf.buf, stderr);
+	strbuf_release(&buf);
+	return rc;
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -820,18 +843,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts)) {
-		if (!(flags & EDIT_MSG)) {
-			cmd.stdout_to_stderr = 1;
-			cmd.err = -1;
-		}
+	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
+		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-		if (read_env_script(&cmd.env_array)) {
-			const char *gpg_opt = gpg_sign_opt_quoted(opts);
-
-			return error(_(staged_changes_advice),
-				     gpg_opt, gpg_opt);
-		}
+		return error(_(staged_changes_advice),
+			     gpg_opt, gpg_opt);
 	}
 
 	argv_array_push(&cmd.args, "commit");
@@ -861,21 +877,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&cmd.args, "--allow-empty-message");
 
-	if (cmd.err == -1) {
-		/* hide stderr on success */
-		struct strbuf buf = STRBUF_INIT;
-		int rc = pipe_command(&cmd,
-				      NULL, 0,
-				      /* stdout is already redirected */
-				      NULL, 0,
-				      &buf, 0);
-		if (rc)
-			fputs(buf.buf, stderr);
-		strbuf_release(&buf);
-		return rc;
-	}
-
-	return run_command(&cmd);
+	return run_command_silent_on_success(&cmd,
+					     !(is_rebase_i(opts) && !(flags & EDIT_MSG)));
 }
 
 static int rest_is_empty(const struct strbuf *sb, int start)
-- 
2.16.4


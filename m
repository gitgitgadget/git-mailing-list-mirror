Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6BCC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356124AbiBULWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:22:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356249AbiBULUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145FEBE
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i14so26379024wrc.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DbmCoZwypBuMMIe4XObqTM7EOQuZ449bEHECh/zC6tc=;
        b=MdHNP0fW5NGPEj07Dz9s81BMSxiD5yyFZPoRnJyFfGXxVLqEqclCAx5mIdmrwDUIs+
         Oox+Y3t7A7kgI3t/zDlKP8q4WAiYN7QmTJXnnrrcJGNcN1p7qi1isxrdw1NJSFPxd+a3
         q4av2Mfw2XZW1KlS+wEaVxVnZWyf0rAKxE4nVIQJ5aRzZJrR1jJ5TAdQOVucrJHv9XRI
         9BnIFvEajJVlEBsYXAWhTZbQEmjW7JAycS4T+Y131hnZEMgQSRLJn05vlGcgBIo/qJAH
         ZDj7m8r43MvZ4wJjzGG2J6W6fkLluvozEPJ5UrWXoAx1wzyo3egwuwjPjL1Qod1TXo8u
         1Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DbmCoZwypBuMMIe4XObqTM7EOQuZ449bEHECh/zC6tc=;
        b=CKmju5g+eBbw66xVU8izbkl0UA3Pz/p49Qvk9BrhjYsUGaZwNgqSptlIgrkS8Lgtcm
         M43uR4ZfAXkp0lnf/lYmNF6s+TGI5fBq54tJHrkQKwnXQLqunLHoYO0g6VNDkDlvEA+L
         LMhcoCRgfT+S9JEoj9pEhaDCUC3qKOWmeyBdc/t9gUaT/4fnM5J/xSp53D4b/h8U6MUM
         GDXkhSibg+9OHS7m0pZIOFQoV5u2JjoS/FD01f8wLeFlmBkgFt/ph8Au3E8uePWc3CiD
         vRsNk63o0sh0LSi3FeZauFvlaa5z6CvaofJ8LRfbeZAFl0pGB9n9K4az/gC38UkxZFc+
         BWdg==
X-Gm-Message-State: AOAM532iKj49vtnEjsnbR3Z04uvXiLwfosp+ltC5T18ErqrROb5XN/Z3
        6H5P1F8vQmt4dpL1dwxh+/0Llc8yTyg=
X-Google-Smtp-Source: ABdhPJwbTU58+Y6AUd+tOvOvWkLGq2Anw7/+/aQWAq0zGI/321hriesJclvSlA52bxPW6mG4KHv5rw==
X-Received: by 2002:a05:6000:1289:b0:1d5:c107:b63e with SMTP id f9-20020a056000128900b001d5c107b63emr15450808wrx.651.1645441860870;
        Mon, 21 Feb 2022 03:11:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm9923421wrv.28.2022.02.21.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:11:00 -0800 (PST)
Message-Id: <c863cebbdc8485225af40593cf2952c933f4ea8d.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:53 +0000
Subject: [PATCH 6/7] rebase --abort: improve reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When aborting a rebase the reflog message looks like

	rebase (abort): updating HEAD

which is not very informative. Improve the message by mentioning the
branch that we are returning to as we do at the end of a successful
rebase so it looks like.

	rebase (abort): returning to refs/heads/topic

If GIT_REFLOG_ACTION is set in the environment we no longer omit
"(abort)" from the reflog message. We don't omit "(start)" and
"(finish)" when starting and finishing a rebase in that case so we
shouldn't omit "(abort)".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 28 ++++++---------------
 t/t3406-rebase-message.sh | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 678339c7bf7..70426e17b40 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -992,23 +992,6 @@ static void NORETURN error_on_missing_default_upstream(void)
 	exit(1);
 }
 
-static void set_reflog_action(struct rebase_options *options)
-{
-	const char *env;
-	struct strbuf buf = STRBUF_INIT;
-
-	if (!is_merge(options))
-		return;
-
-	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	if (env && strcmp("rebase", env))
-		return; /* only override it if it is "rebase" */
-
-	strbuf_addf(&buf, "rebase (%s)", options->action);
-	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
-	strbuf_release(&buf);
-}
-
 static int check_exec_cmd(const char *cmd)
 {
 	if (strchr(cmd, '\n'))
@@ -1287,18 +1270,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 	case ACTION_ABORT: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
-		options.action = "abort";
-		set_reflog_action(&options);
+		struct strbuf head_msg = STRBUF_INIT;
 
+		options.action = "abort";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
 			exit(1);
+
+		strbuf_addf(&head_msg, "%s (abort): returning to %s",
+			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+			    options.head_name ? options.head_name
+					      : oid_to_hex(&options.orig_head));
 		ropts.oid = &options.orig_head;
+		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
-		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5c6cd9af3bc..ceca1600053 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -187,6 +187,57 @@ test_reflog () {
 	EOF
 	test_cmp expect actual
 	'
+
+	test_expect_success "rebase $mode --abort reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	git log -g -1 conflicts >branch-expect &&
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual &&
+
+	# check branch reflog is unchanged
+	git log -g -1 conflicts >branch-actual &&
+	test_cmp branch-expect branch-actual
+	'
+
+	test_expect_success "rebase $mode --abort detached HEAD reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout Q &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to $(git rev-parse Q)
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget


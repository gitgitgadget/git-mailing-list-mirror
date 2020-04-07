Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF17C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5124B207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhxz4Wyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgDGO2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38098 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGO2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id 13so895037qtt.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVpvRBsOEcGbH9LZoGNRkq69RUMJ2X5uwsFCDN5jT7s=;
        b=Nhxz4Wyz/3ndD6UVfrpcrogbQkFuCUwr+6JHR97oQNk8+h815BKjU6r2rFtlGsstSb
         e5nUWNwuHJriuSn4G5XIJ6XK+/B9uAqXfoX492qwYhgANp1XhYjlTGgDvRq3jL3Ss88h
         3KkGPslm9aEN21oIyY2NQx4qTn4+9XS54GmGGcZxr+/ZSTB0Kz0Q6VphO+4yvcRHUQtU
         78mCx228YFWSFFzuS5CuyiyJmRzmjKJCA/B9f3lURwWs5Aoo/o3InC9rnO02nNZfRs9Z
         oK1AM+gIIvx8EdJptgYFVB9EKis72KPJ9mY8inpfRbSv2ZHvOaoO8rJM9w62PuoSD2bO
         enKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVpvRBsOEcGbH9LZoGNRkq69RUMJ2X5uwsFCDN5jT7s=;
        b=jGTvhtNDWpjWcNCmBHyH6KD4/Ue6TSZ8JQBCI8RifVlOc/cRLf/ZEq1D8qxzA/3Kdr
         Xog06KhU3LcH11K7udQBv3OptF3K1KpfsDeQM9x4KocErgwlPgPE6qWzE3lxlRRCbw0C
         EEE/A6bHXYHS7lA9SXimtOnPFisI/PRZxziHMZbedNIsRPsVZS8KK/vTr03uD31eKAaY
         Qf4BntRQRxWz0W3ZxVA7VXtY04Gv5MGqq6299MGYpvNFgDkZybDUn8cuPMa0G8PN78fg
         1tUmfncaNwq0+4Nu6nu9UXVWriucyOvKOtR4mTxKUuNJkB+c9qDuMiAlw1YPZoXUe3nv
         UIMA==
X-Gm-Message-State: AGi0PuanDai1zmVQRZ9kkshv7FXh0mq0w54YpFD6pLb4eTSCLRG8Rbeh
        cajwMaEmSAQ11/YWIdni5g72Zd/s
X-Google-Smtp-Source: APiQypK8rNbTX6Y47tm920cNe1HpBtAV8EPQdh03JUyhLJ3Z/stxLx5TJ8x32YkCxLF9puIhYGX+Ag==
X-Received: by 2002:ac8:4557:: with SMTP id z23mr2522790qtn.350.1586269721122;
        Tue, 07 Apr 2020 07:28:41 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 18/22] sequencer: implement save_autostash()
Date:   Tue,  7 Apr 2020 10:28:05 -0400
Message-Id: <7e04ce8d8e8ec8308efda05ea7f0cd31f9612ea0.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract common functionality of apply_autostash() into
apply_save_autostash() and use it to implement save_autostash(). This
function will be used in a future commit.

The difference between save_autostash() and apply_autostash() is that
the former does not try to apply the stash. It skips that step and
just stores the created entry in the stash reflog.

This is useful in the case where we abort an operation when an autostash
is present but we don't want to dirty the worktree with the application
of the stash. For example, in a future commit, we will implement
`git merge --autostash`. Since merges can be aborted using
`git reset --hard`, we'd make use of save_autostash() to save the
autostash entry instead of applying it to the worktree thus keeping the
worktree undirtied.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 37 +++++++++++++++++++++++++++----------
 sequencer.h |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 645bc47ce3..084ea4117e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3707,7 +3707,7 @@ void create_autostash(struct repository *r, const char *path,
 	strbuf_release(&buf);
 }
 
-int apply_autostash(const char *path)
+static int apply_save_autostash(const char *path, int attempt_apply)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -3720,13 +3720,17 @@ int apply_autostash(const char *path)
 	}
 	strbuf_trim(&stash_oid);
 
-	child.git_cmd = 1;
-	child.no_stdout = 1;
-	child.no_stderr = 1;
-	argv_array_push(&child.args, "stash");
-	argv_array_push(&child.args, "apply");
-	argv_array_push(&child.args, stash_oid.buf);
-	if (!run_command(&child))
+	if (attempt_apply) {
+		child.git_cmd = 1;
+		child.no_stdout = 1;
+		child.no_stderr = 1;
+		argv_array_push(&child.args, "stash");
+		argv_array_push(&child.args, "apply");
+		argv_array_push(&child.args, stash_oid.buf);
+		ret = run_command(&child);
+	}
+
+	if (attempt_apply && !ret)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -3742,10 +3746,13 @@ int apply_autostash(const char *path)
 			ret = error(_("cannot store %s"), stash_oid.buf);
 		else
 			fprintf(stderr,
-				_("Applying autostash resulted in conflicts.\n"
+				_("%s\n"
 				  "Your changes are safe in the stash.\n"
 				  "You can run \"git stash pop\" or"
-				  " \"git stash drop\" at any time.\n"));
+				  " \"git stash drop\" at any time.\n"),
+				attempt_apply ?
+				_("Applying autostash resulted in conflicts.") :
+				_("Autostash exists; creating a new stash entry."));
 	}
 
 	unlink(path);
@@ -3753,6 +3760,16 @@ int apply_autostash(const char *path)
 	return ret;
 }
 
+int save_autostash(const char *path)
+{
+	return apply_save_autostash(path, 0);
+}
+
+int apply_autostash(const char *path)
+{
+	return apply_save_autostash(path, 1);
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
diff --git a/sequencer.h b/sequencer.h
index 9d1fe0ccfb..306d4cecfb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -193,6 +193,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path,
 		      const char *default_reflog_action);
+int save_autostash(const char *path);
 int apply_autostash(const char *path);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
-- 
2.26.0.159.g23e2136ad0


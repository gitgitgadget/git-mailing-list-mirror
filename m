Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12CD61F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfAWFGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:06:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43935 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWFGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:06:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so512567plb.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpmkQDrJ/bGlLdaqRV19Zh/O9dsNM1KJBQH7633r+L4=;
        b=J70McHsqm8eXQWm2QgYrzPMy14Sg4YobHAePGR0b3ztyQ5wjA4y2Ravd0a/GWCI1N+
         vmF/JvP1PJL6ihe1zkR1OGZieFQO/gn3gmQnv0mP/7zeOSssWEYwS5ky8Mwx3M00CmuN
         Yv8+9X2LR6l4tGEYhfMu7uYPDgP2PHvLfypA0YOVkOzBYaAM5r9XxWWPDlFP49Ly8uJH
         cN3s0wSiX0+SwS9R0rZBMLdiwYmLomLWSMD6CRtYwDhzrCKFDqYCPmkrcmrfSUTphCBx
         1BxyNfoFOKQh3zygzQK+oV0i3xQ9IWvi7RbmtzJ8EAilMdsbyCb8/TA+qp3Huxz8El8E
         x+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpmkQDrJ/bGlLdaqRV19Zh/O9dsNM1KJBQH7633r+L4=;
        b=Yln48LVdWY3z/pHKdF3vMwN3Oe4YT5JX46+qJsq8AP4qpsUzrFYxR/uOAtlnxQ5ekH
         y9ewA7lq2NGjYOZe8lPDUtjGMxsblRPj/mWTlcSj/sLOoupUhKjGn0/Bdq7nnOGK5070
         E+4qvI07D1eFIFjqr8KISjAOyf7EYU65UHiGMaHRmjpBDswbhSRg8GCm6XZtX3P9SyR6
         peCIoxmAllpGqBtqza0Ren1EKkCuyDDRm3BhwQyiDAlAMHxx5T8jlFSBVNyjsT1GqsTH
         QklCqtgEI8rHinUIQ63yOhVB9O3u3Q2kaz+TDS7TjxTw64fvwJx4nPHrv14k/XawRszA
         1ZRg==
X-Gm-Message-State: AJcUukeom2jdTyXnC1s60Yj/3ZiD7N52xvp4NdBYykrWSkFYHdKFq4Xc
        0gOecPP1NjGstAwJ8vnLvosl/M+7
X-Google-Smtp-Source: ALg8bN7ZAXVjfUk9KmOytbxjmNWUtr+RU2B2jPXMqnjF3GGVtNZrfNb58Fq2ng3LRvcnOZrhZ56EBw==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr838788plr.56.1548219981051;
        Tue, 22 Jan 2019 21:06:21 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 84sm24377004pfk.134.2019.01.22.21.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 21:06:20 -0800 (PST)
Date:   Tue, 22 Jan 2019 21:06:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v6 1/4] commit: extract cleanup_mode functions to sequencer
Message-ID: <69199be34dbe0648f88fa7eb5f0cc11ed1e7feb7.1548219737.git.liu.denton@gmail.com>
References: <cover.1545745331.git.liu.denton@gmail.com>
 <cover.1548219737.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548219737.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 21 ++-------------------
 sequencer.c      | 29 +++++++++++++++++++++++++++++
 sequencer.h      |  4 ++++
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..3ac0a21a22 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1165,20 +1165,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_ALL :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
 
@@ -1615,11 +1602,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
 
-	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	cleanup_message(&sb, cleanup_mode, verbose);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/sequencer.c b/sequencer.c
index f5370f4965..4f79892801 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -510,6 +510,25 @@ static int fast_forward_to(struct repository *r,
 	return 0;
 }
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor)
+{
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		return COMMIT_MSG_CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		return COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		return COMMIT_MSG_CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "scissors"))
+		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -1012,6 +1031,16 @@ static int rest_is_empty(const struct strbuf *sb, int start)
 	return 1;
 }
 
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose)
+{
+	if (verbose || /* Truncate the message just before the diff, if any. */
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+}
+
 /*
  * Find out if the message in the strbuf contains only whitespace and
  * Signed-off-by lines.
diff --git a/sequencer.h b/sequencer.h
index 9d83f0f3e9..57ad6fc7de 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -115,7 +115,11 @@ extern const char sign_off_header[];
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor);
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
-- 
2.20.1.3.ge68552ea27.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2859202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCGJ6j (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:58:39 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37630 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJ6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:58:38 -0500
Received: by mail-pf1-f181.google.com with SMTP id s22so11037218pfh.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g3dlSD/5UcPU+iH3xviy5+63lSKvMmzaL/HXMiUyTz0=;
        b=FgXMp2yjdBGaZz49SF8SfVgq/C9GV9VTPLmzQrT76GFdA/O877m2T5L6EX5/ucnQa2
         Qtffrlgzb+Zpq7McCEdnWYQfs0a7zKI977oHsJWg6jzKwqeYq63eLJ1dPsYgWbFsN/r8
         Fot3mfJsR8+Hidp2baJoYR8E4WXzJXSBn4hmWtgqUFiudj2sIe8nU19NnPKQdgKkFe1I
         4WypS+bBaQUSh1WokLHmWLFrYVlK2mC2sF2Heirl3GtKYXVb8uaJeR2SCrnUaQ0DjKDZ
         jn+Pb1vPS5a2RGA1FbP0HFO7PoWUnHcl3Phm3u32Di6BYVzaYReOfmSqeDKy0/UC0i0D
         RWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g3dlSD/5UcPU+iH3xviy5+63lSKvMmzaL/HXMiUyTz0=;
        b=f2t7/8XTiBZKQsHTP/5wvm72O9g68H7Al17gxrJhUxi3hO8HV8QPMpwliLJ66OjZfB
         mKi39MLeK4bVj35Gwo+EZl3Yk2VOMQatcKa+olN0yP47aRZe40iPTMyeNVcDAxdocSgJ
         AEO0uCdEyWk3Q5IsLqijCqG6MSHFOwCa8pCSeQodlzyMHHwtAjVZYzL36k5bE8dNMq8y
         D9NkulehYkx2Q9eUI/5IfNXNJe5zqfxBhOcteobNFbipGmQ+fjWwl7DXufE0muPGUZrd
         CgMwgZwEzTtRm9drp2rV+ZGmz7JTOjYdLCe3WsxdLugYvGFOFYRyujoeLcLOY1z6e7Fd
         44EA==
X-Gm-Message-State: APjAAAVM+dMFNS6luN72sz9apd2s4/9FkS5i5mT2p5XoS16O7jBSReqc
        fXP/GGK8q3o8txC0uUXnLHYFV9cj
X-Google-Smtp-Source: APXvYqw9Ea1+zZzBTmMBdR7mn65sFa25yGsfmy+C0aeCrMIR6km5UdVHaGTOdakMsFAC2lFb9V/IIg==
X-Received: by 2002:a62:1bd4:: with SMTP id b203mr11825704pfb.144.1551952717388;
        Thu, 07 Mar 2019 01:58:37 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k7sm1931402pgo.60.2019.03.07.01.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:58:36 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:58:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] sequencer.c: don't die on invalid cleanup_arg
Message-ID: <68ec2b7cd7457e9bcd3f6f211774457c73ef8646.1551951770.git.liu.denton@gmail.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551951770.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When get_cleanup_mode was provided with an invalid cleanup_arg, it used
to die. Warn user and fallback to default behaviour if an invalid
cleanup_arg is given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c |  2 +-
 builtin/merge.c  |  4 ++--
 builtin/revert.c |  2 +-
 sequencer.c      | 10 +++++++---
 sequencer.h      |  2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 43291d79bd..0072a5817a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1167,7 +1167,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor, 1);
 
 	handle_untracked_files_arg(s);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index d4217ebcf5..3b597ec540 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -916,7 +916,7 @@ static int suggest_conflicts(void)
 	 * Thus, we will get the cleanup mode which is returned when we _are_ using
 	 * an editor.
 	 */
-	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1));
+	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
@@ -1424,7 +1424,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (option_edit < 0)
 		option_edit = default_edit_option();
 
-	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
 
 	if (!use_strategies) {
 		if (!remoteheads)
diff --git a/builtin/revert.c b/builtin/revert.c
index fe18036be7..a96f2ecd8a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -139,7 +139,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		opts->allow_empty = 1;
 
 	if (cleanup_arg)
-		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
 
 	/* Check for incompatible command line arguments */
 	if (cmd) {
diff --git a/sequencer.c b/sequencer.c
index 5c04bae7ac..7d18c55223 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -170,7 +170,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts));
+		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
 
 		free((char *)s);
 		return status;
@@ -488,7 +488,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 }
 
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor)
+	int use_editor, int die_on_error)
 {
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
@@ -502,7 +502,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	else if (!strcmp(cleanup_arg, "scissors"))
 		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
 				    COMMIT_MSG_CLEANUP_SPACE;
-	else
+	else if (!die_on_error) {
+		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	} else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 }
 
diff --git a/sequencer.h b/sequencer.h
index aa99503dd7..c4c80051ea 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -94,7 +94,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf,
 		enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor);
+	int use_editor, int die_on_error);
 
 void cleanup_message(struct strbuf *msgbuf,
 	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
-- 
2.21.0.370.g4fdb13b891


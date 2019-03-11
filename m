Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03C720248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfCKDmm (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38772 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so2960567pgl.5
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bsd02n8xPECKi1/scXhJYBTSAoZKofufeyf8DYPbziA=;
        b=vKfPlc/43X1wpqa+seVvTAY6EwQMGsoUCiWXO9F03+Xx3F4nn53pOF4enE7fKGbD7m
         JTfzg1k64DdTQyXGh94rAuwy/gtIjv+QY4+p3L+wzQpuSn4gKdT/ZPaZMvb01lEjh5rE
         Dh6/QZEd4YiQztnzlXi4KBt4+HPjPA2p9gJq/UNwj7aDv2XzHMJRVtd0bCpfLcSNldkp
         TEUcm9voPd+iWFSH4rH6gLOwpaB3O+24s46/IKVJJbKSpsoieh56wjoPoGo3PYI0q4qq
         +Qwa0DOmy+cHiMns70wM/gcXbeMCJb1ywEE7GLqoNe3D7dl18tgIZBVn2hlFmm3CVV4J
         MmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsd02n8xPECKi1/scXhJYBTSAoZKofufeyf8DYPbziA=;
        b=gHWLl0dcM47TWMPrJg1zSVuE8n3R3TzfyeCrbR0cgfUWz+P2QVIEWgEL8RCbUGiXW3
         0BgKTpD2e39NYyrBl/c+WE8dBRRqlQrJBY0zkNkRyDoUEwai7iAzsKlhaUdBu6j1WjmT
         9yXwpeLda3Hc3PzXiNAhER058wLrBsA0qjON+qqKRwOyvXKf+JPOTfPGzWPyZtuRFOKe
         y5ZuHn+HgkPHleoIJB9ZMOOLJ06LfZ/KU92UjnNMjpHvhwn7b63GHG1Cq24tj8eemDsH
         lcGX3akQyY+RSOThSQKo2uTQCBH8KIs0y9XRXpZW8FiYzovsE5xl6IFU3xpj8s4zkzvp
         bA9Q==
X-Gm-Message-State: APjAAAWOgo77dF7ScnXfm6aPnwXCGeZ+OJvv4q/qHuw8GQ5/MzMVDDet
        qBidRnMR94aZQYDOKl0gB6RoszDd
X-Google-Smtp-Source: APXvYqzWtL/+4jaoNII10v8UBBSwIytkqYYqJDjjQzn+eunp2L4Chg41gikei4QEM2ExpQKJf8O+mw==
X-Received: by 2002:a63:5b43:: with SMTP id l3mr27980656pgm.298.1552275760997;
        Sun, 10 Mar 2019 20:42:40 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id g80sm6861367pfd.72.2019.03.10.20.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:40 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 4/8] sequencer.c: remove duplicate code
Message-ID: <6d5ce3ffffe5ef6c23b12538650b2cdf86e4cac9.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we implemented get_cleanup_mode, we had some duplicate code in
git_sequencer_config which essentially performed the same operations.
Refactor git_sequencer_config to take advantage of the logic already in
get_cleanup_mode.

Note that we had to introduce a separate argument to get_cleanup_mode
indicating whether to die or not on an invalid value. This is because if
we are parsing a config, we do not want to die but instead, we only want
to warn the user, whereas if we are parsing a command-line option, we
would like to actually die.

Finally, this is almost a no-op refactor but not quite. Previously, in
the case that an invalid value is presented, default_msg_cleanup would
not be set. We change the behaviour so that default_msg_cleanup will now
take on the value as if "default" were provided as the cleanup_arg.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c |  2 +-
 sequencer.c      | 20 +++++++-------------
 sequencer.h      |  2 +-
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0df15e4851..81e3bd21ca 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1172,7 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor, 1);
 
 	handle_untracked_files_arg(s);
 
diff --git a/sequencer.c b/sequencer.c
index 224c823b43..612621f221 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -172,17 +172,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		if (!strcmp(s, "verbatim"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-		else if (!strcmp(s, "whitespace"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else if (!strcmp(s, "strip"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
-		else if (!strcmp(s, "scissors"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else
-			warning(_("invalid commit message cleanup mode '%s'"),
-				  s);
+		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
 
 		free((char *)s);
 		return status;
@@ -512,7 +502,7 @@ static int fast_forward_to(struct repository *r,
 }
 
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor)
+	int use_editor, int die_on_error)
 {
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
@@ -526,7 +516,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
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
index eb9bd97ef3..e7908f558e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -117,7 +117,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor);
+	int use_editor, int die_on_error);
 
 void cleanup_message(struct strbuf *msgbuf,
 	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
-- 
2.21.0.370.g4fdb13b891


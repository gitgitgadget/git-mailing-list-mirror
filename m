Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885C720248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfCKDmu (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id u65so2973655pgc.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=COQBjWuta7+SEoo8IPZ/H5mlXXdjS66poQogYpgwd5w=;
        b=MYZURh4XAfnS2DRSWlsX4yzbmIxs5QweJIfJtBpFquSA6vdRtJviplDFlXTtK6l2cn
         nciJ0p6enahLNFtxtitKXqbhJgr40Hw6jV0uvlCoSXOlR4ct3wRrboQHVFCcrurlEPGV
         sXtoUMG8Q+eJr1V988tnTWG55hQpZImSJnAYEvRBiQl5nOS90BYpNxp6YBF6NtAHUIJc
         hrmQg0UYfmBUS5LKegI22+BHHuuBAO0hke9akbZYR+F5eiEF/wva2hfp86Ex9WR5Ytcw
         ws8RHMJtLA8irb+0d2/TWswt8gikK6NdnMxPohrNYGxlaE+SkKcWbET4mDIlPGwjK9Zq
         DwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=COQBjWuta7+SEoo8IPZ/H5mlXXdjS66poQogYpgwd5w=;
        b=f7RwsvFRCOYF6oMPsgBO6nmzhxxXJHg1Lwsw6oILDwZ22GYA5c2N31WAqotb3DDkn4
         kl2kNRybpvhTa/nqbK+m4fCLLyeMoqBPZJL3K3sVDNCgT/rLdGvKBvSE/pKV9eaTCgun
         BY3x/SAZjYQ8GIWyisf1yrminRa8+qpe9qYsrUCMQgYnWgnQiKXwnbbpHaB7W12kyiSo
         MytGPJLqWhtDFzKUxe5AJDhrWtwFSIsoz4u7T/slBoGO6XOimKlyCp6s9MbhkYq7bC9O
         63g6UI/7J3UWR9jb0KIhOjZUMUvsUqOEoxPmgP8SMRrS+adeBSRrRznk+4XcJZNs7vJy
         H0sw==
X-Gm-Message-State: APjAAAX/VjnrmNdi2EHVThHGddM7m0lrXv1EpU0BV10FC6r295Mw8YiE
        PNgEwALVwc45W/R+FGERtnMD+Z1o
X-Google-Smtp-Source: APXvYqzjHzXZ1vR81sss1M2afVLkm0ch21C1DbDMIbqK3MbZnwZpXu186MgguC1eMCQsAuRfwAwGLw==
X-Received: by 2002:a17:902:2a48:: with SMTP id i66mr30899164plb.14.1552275768777;
        Sun, 10 Mar 2019 20:42:48 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id v9sm6529380pfg.130.2019.03.10.20.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:48 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:46 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 7/8] sequencer.c: define get_config_from_cleanup
Message-ID: <ced1df0fc76c97c9896b6cbb5b4154532461716d.1552275703.git.liu.denton@gmail.com>
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

Define a function which allows us to get the string configuration value
of a enum commit_msg_cleanup_mode. This is done by refactoring
get_cleanup_mode such that it uses a lookup table to find the mappings
between string and enum and then using the same LUT in reverse to define
get_config_from_cleanup.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 67 +++++++++++++++++++++++++++++++++++++++++------------
 sequencer.h |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 612621f221..5d94e2c865 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,6 +160,22 @@ static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
 
+struct cleanup_config_mapping {
+    const char *config_value;
+    enum commit_msg_cleanup_mode editor_cleanup;
+    enum commit_msg_cleanup_mode no_editor_cleanup;
+};
+
+/* note that we assume that cleanup_config_mapping[0] contains the default settings */
+struct cleanup_config_mapping cleanup_config_mappings[] = {
+	{ "default", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_SPACE },
+	{ "verbatim", COMMIT_MSG_CLEANUP_NONE, COMMIT_MSG_CLEANUP_NONE },
+	{ "whitespace", COMMIT_MSG_CLEANUP_SPACE, COMMIT_MSG_CLEANUP_SPACE },
+	{ "strip", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_ALL },
+	{ "scissors", COMMIT_MSG_CLEANUP_SCISSORS, COMMIT_MSG_CLEANUP_SPACE },
+	{ NULL, 0, 0 }
+};
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -504,26 +520,42 @@ static int fast_forward_to(struct repository *r,
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error)
 {
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
-				    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		return COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		return COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		return COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-				    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!die_on_error) {
+	struct cleanup_config_mapping *default_mapping = &cleanup_config_mappings[0];
+	struct cleanup_config_mapping *current_mapping;
+
+	if (!cleanup_arg) {
+		return use_editor ? default_mapping->editor_cleanup :
+				    default_mapping->no_editor_cleanup;
+	}
+
+	for (current_mapping = cleanup_config_mappings; current_mapping->config_value; current_mapping++) {
+		if (!strcmp(cleanup_arg, current_mapping->config_value)) {
+			return use_editor ? current_mapping->editor_cleanup :
+					    current_mapping->no_editor_cleanup;
+		}
+	}
+
+	if (!die_on_error) {
 		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
-		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
-				    COMMIT_MSG_CLEANUP_SPACE;
+		return use_editor ? default_mapping->editor_cleanup :
+				    default_mapping->no_editor_cleanup;
 	} else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 }
 
+const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)
+{
+	struct cleanup_config_mapping *current_mapping;
+
+	for (current_mapping = &cleanup_config_mappings[1]; current_mapping->config_value; current_mapping++) {
+		if (cleanup_mode == current_mapping->editor_cleanup) {
+			return current_mapping->config_value;
+		}
+	}
+
+	BUG(_("invalid cleanup_mode provided"));
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -2350,6 +2382,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_rerere_auto =
 			git_config_bool_or_int(key, value, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
+	else if (!strcmp(key, "options.default-msg-cleanup"))
+		opts->default_msg_cleanup = get_cleanup_mode(value, 1, 1);
 	else
 		return error(_("invalid key: %s"), key);
 
@@ -2754,6 +2788,9 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
 						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 						     "true" : "false");
+
+	res |= git_config_set_in_file_gently(opts_file, "options.default-msg-cleanup",
+					     get_config_from_cleanup(opts->default_msg_cleanup));
 	return res;
 }
 
diff --git a/sequencer.h b/sequencer.h
index e7908f558e..e3c1f44807 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -118,6 +118,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error);
+const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode);
 
 void cleanup_message(struct strbuf *msgbuf,
 	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
-- 
2.21.0.370.g4fdb13b891


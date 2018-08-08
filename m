Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E121208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHHRny (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35042 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id e6-v6so1464262edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzjLhrSDmKt6zrZQG6wR+dQwV2S5B5FryeUpJ4F6mKs=;
        b=fwJ91NksSyHAJncFCr4pf2mrJ0kBCHtWA6OzxDEGy+7f1carD2vXK0kXE78hHTt2uk
         DaNWLZ3sqVeTAZb7iJzSY4mPxuEgDgcmm53oS8b/AD4o+TXnYbHI46W1JxcpdSp/2+Je
         q+78QUzFhuFsPToshAu0lbq8HSC96v6KFcxquOnefvCvCcR7Ly0U0mBsLdQpNDOCM/Ke
         rNaaYiSNWGHEgtJgmhGKxaexw19VTqfG7Q+qeFD9nWvVuKGXFGbSkBrHlqOs2OlfP1IU
         roYgC2pdcxPANb8qzDGASQoq6xpCtMfCg0VnhOKUtpHgfW9ftKcz0xsbFKNOVaoKuzX/
         Y+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzjLhrSDmKt6zrZQG6wR+dQwV2S5B5FryeUpJ4F6mKs=;
        b=R6o9ZH9T+/jcoxUKKCRQq+7AFvHGiFvOVwjJ4rKV2t05DQMJbucKJ3ZB/OfBNSy6M7
         8CONMk0Ik0bJYy+urCakfg5Ak3drR+MNhndyS4QyouJMoXV6Ymjl/GtumL2ERhRjOqPK
         b6VBIQdwOIEsGgrjAmoU90eWSXTbZ5ocsdUucPne7wEgeFg6lOVUdxLzRTEG8dY29dzE
         Ohh/xeDaJa0dL/MtVa7twGHH/q0Z7anGtBsa5DQdcsfVqJVH+aY63kpMu7MC5uRh6f81
         ihY9zCKajj8JYyTwzjFNLOGuUl/LF6O/nMJSvA3WCzQNwR52DSYStBHoswwGxwZA9hDH
         J+Tg==
X-Gm-Message-State: AOUpUlFWpZbkl0jAcKHSO1aIxQ02JOC6R24FWwHfXRKjStyKH9ycrv8e
        hOSMa2EyHN1PGn4O7GboX4VUCXdh
X-Google-Smtp-Source: AA+uWPz6yTshKG+89pnPdIDTuGn22ejVY1l6t+2fS3Fs5Hup0NtHyUYySQqnog3d6+CDtI7Ygd+k5Q==
X-Received: by 2002:a50:87d2:: with SMTP id 18-v6mr3809356edz.1.1533741824311;
        Wed, 08 Aug 2018 08:23:44 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:43 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 18/18] builtin rebase: support --root
Date:   Wed,  8 Aug 2018 21:06:40 +0545
Message-Id: <20180808152140.14585-19-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option allows to rebase entire histories up to, and including, the
root commit.

The conversion from the shell script is straight-forward, apart from
the fact that we do not have to write an empty tree in C.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 65e7be1c48..94abaaa890 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -76,6 +76,7 @@ struct rebase_options {
 	const char *revisions;
 	const char *switch_to;
 	int root;
+	struct object_id *squash_onto;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
 	enum {
@@ -375,6 +376,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->rebase_cousins ? "t" : "");
 	add_var(&script_snippet, "strategy", opts->strategy);
 	add_var(&script_snippet, "strategy_opts", opts->strategy_opts);
+	add_var(&script_snippet, "rebase_root", opts->root ? "t" : "");
+	add_var(&script_snippet, "squash_onto",
+		opts->squash_onto ? oid_to_hex(opts->squash_onto) : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -653,6 +657,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
+	struct object_id squash_onto;
+	char *squash_onto_name = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -743,6 +749,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				N_("option"),
 				N_("pass the argument through to the merge "
 				   "strategy")),
+		OPT_BOOL(0, "root", &options.root,
+			 N_("rebase all reachable commits up to the root(s)")),
 		OPT_END(),
 	};
 
@@ -1020,6 +1028,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.root && !options.onto_name)
+		imply_interactive(&options, "--root without --onto");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1058,8 +1069,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
 		options.upstream_arg = options.upstream_name;
-	} else
-		die("TODO: upstream for --root");
+	} else {
+		if (!options.onto_name) {
+			if (commit_tree("", 0, the_hash_algo->empty_tree, NULL,
+					&squash_onto, NULL, NULL) < 0)
+				die(_("Could not create new root commit"));
+			options.squash_onto = &squash_onto;
+			options.onto_name = squash_onto_name =
+				xstrdup(oid_to_hex(&squash_onto));
+		}
+		options.upstream_name = NULL;
+		options.upstream = NULL;
+		if (argc > 1)
+			usage_with_options(builtin_rebase_usage,
+					   builtin_rebase_options);
+		options.upstream_arg = "--root";
+	}
 
 	/* Make sure the branch to rebase onto is valid. */
 	if (!options.onto_name)
@@ -1207,6 +1232,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 */
 	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
 	    !is_interactive(&options) && !options.restrict_revision &&
+	    options.upstream &&
 	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
 		int flag;
 
@@ -1311,5 +1337,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	free(squash_onto_name);
 	return ret;
 }
-- 
2.18.0


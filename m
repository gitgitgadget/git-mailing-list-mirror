Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6D81F458
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeH1QCr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34551 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeH1QCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id m199-v6so1739226wma.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OIqCwAJl8XnY2CENFdmKu3qhWCbVNJDnu2gTSyr3R4=;
        b=s7NO7awINGR2KjnGjkj5n3yvV6s9sdozm55PTeyVemABEG1t0EJKRWyCLekFZGr6Wu
         C1tuSdkQf6v+z5A1dxskL6Z36j7QspMN0XxOfUVe+IuDSX0W+dHaR1fQ9DhNEbuQkkYO
         gY3kMUGAP0thRQdJsucmT0hjxRA16qLiVWzq5UaF3Yz1aRlJqC9SydS7oPoZZ529OMhE
         lMYteNfGfeJ6qmoxhfsn1PIHVJGu1wej4bbADJb80eUlE13npOJYrBs16lnXTbyk4CZW
         zb/JOZhxl4x93tUktXIQwzwd5XRkVsa2GZGEkfsxaSrGs4Ccvg2POJ7b0gq3JsnzBM0V
         leuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OIqCwAJl8XnY2CENFdmKu3qhWCbVNJDnu2gTSyr3R4=;
        b=qYtQ/c5m57LW6mqaxmPbhxuRBBSNJr7Jx03isI7L9+fphCi/Rv5RDfxP1hq+80qjvl
         uxi/cOVlNTsGt1wdpsl+8D5mRRfJwwbtBfbhg8ktsup8rAgIdeRD7MI242G9xjvRXkJn
         Et85HGdHzetQ1PbA/ZO0WIELUPTTZqZZhFLvk5aOKGqwcZBeMcif50IAYEGTylJgl6ya
         rqoxYJvw5l1WU0+2nE1ULz1UtN51lGXXf3F9RjdaR4CsCDJVc3CYlca+pVTT1JwKA1DP
         pkWtT5PjgMqz9S76dkH8E1yOPB6gWpbWN4UQQZpIq9poikx+hV34rx7vstpHJdoMdFty
         kUPg==
X-Gm-Message-State: APzg51Cm04olAVlbrF5mZCzbpz18sb26Z5+4LH77jS2tQiQZcQ+j1vVj
        5GHvNkgvVZixQdY5svRDP5IYBKY+
X-Google-Smtp-Source: ANB0VdaERls6UuprDeoHBYEPuQk/Ph5J8g2I56itm5/X9xvppFiwXL9xC01KzBujXhtYhsZ2H5zzsA==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr1120888wmf.141.1535458283229;
        Tue, 28 Aug 2018 05:11:23 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:22 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 13/20] rebase -i: implement the logic to initialize $revisions in C
Date:   Tue, 28 Aug 2018 14:10:38 +0200
Message-Id: <20180828121045.14933-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the part of init_revisions_and_shortrevisions() needed by
`--make-script` from shell to C.  The new version is called
get_revision_ranges(), and is a static function inside of
rebase--helper.c.  As this does not initialize $shortrevision, the
original shell version is not yet stripped.

Unlike init_revisions_and_shortrevisions(), get_revision_ranges()
doesn’t write $squash_onto to the state directory, it’s done by the
handler of `--make-script` instead.

Finally, this drops the $revision argument passed to `--make-script` in
git-rebase--interactive.sh, and rebase--helper is changed accordingly.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 builtin/rebase--helper.c   | 56 ++++++++++++++++++++++++++++++++++++--
 git-rebase--interactive.sh |  4 ++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index e1460136f5..acc71a6f99 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -4,6 +4,25 @@
 #include "parse-options.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "argv-array.h"
+
+static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+
+static int get_revision_ranges(const char *upstream, const char *onto,
+			       const char **head_hash,
+			       char **revisions)
+{
+	const char *base_rev = upstream ? upstream : onto;
+	struct object_id orig_head;
+
+	if (get_oid("HEAD", &orig_head))
+		return error(_("no HEAD?"));
+
+	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	return 0;
+}
 
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
@@ -14,7 +33,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret;
+	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
+		*squash_onto = NULL, *upstream = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
@@ -54,6 +75,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "complete-action", &command,
 			    N_("complete the action"), COMPLETE_ACTION),
+		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
+		OPT_STRING(0, "restrict-revision", &restrict_revision,
+			   N_("restrict-revision"), N_("restrict revision")),
+		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
+			   N_("squash onto")),
+		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
+			   N_("the upstream commit")),
 		OPT_END()
 	};
 
@@ -81,8 +109,30 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
-	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(stdout, argc, argv, flags);
+	if (command == MAKE_SCRIPT && argc == 1) {
+		char *revisions = NULL;
+		struct argv_array make_script_args = ARGV_ARRAY_INIT;
+
+		if (!upstream && squash_onto)
+			write_file(path_squash_onto(), "%s\n", squash_onto);
+
+		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions);
+		if (ret)
+			return ret;
+
+		argv_array_pushl(&make_script_args, "", revisions, NULL);
+		if (restrict_revision)
+			argv_array_push(&make_script_args, restrict_revision);
+
+		ret = sequencer_make_script(stdout,
+					    make_script_args.argc, make_script_args.argv,
+					    flags);
+
+		free(revisions);
+		argv_array_clear(&make_script_args);
+
+		return !!ret;
+	}
 	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d66c0f8b8..4ca47aed1e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -92,7 +92,9 @@ git_rebase__interactive () {
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
 		${rebase_cousins:+--rebase-cousins} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"} \
+		${squash_onto:+--squash-onto "$squash_onto"} \
+		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
 	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
-- 
2.18.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC82C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 12:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjD1M4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjD1M4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 08:56:52 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA436272E
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:56:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 85BAA2410B;
        Fri, 28 Apr 2023 08:56:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psNeb-DP1-00; Fri, 28 Apr 2023 14:56:49 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] Capitalization and punctuation fixes to some user visible messages
Date:   Fri, 28 Apr 2023 14:56:49 +0200
Message-Id: <20230428125649.1719796-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are conscious violations of the usual rules for error messages,
based on this reasoning:
- If an error message is directly followed by another sentence, it needs
  to be properly terminated with a period, lest the grammar looks broken
  and becomes hard to read.
- That second sentence isn't actually an error message any more, so it
  should abide to conventional language rules for good looks and
  legibility. Arguably, these should be converted to advice messages
  (which the user can squelch, too), but that's a much bigger effort to
  get right.
- Neither of these apply to the first hunk in do_exec(), but this
  two-line message looks just too much like a real sentence to not
  terminate it. Also, leaving it alone would make it asymmetrical to
  the other hunk.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>

---
v2:
- tried to make commit message more convincing
- put it last in the series, to make the less controversial changes
  easier to apply
---
 builtin/pull.c | 2 +-
 sequencer.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 56f679d94a..bb2ddc93ab 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1044,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (!opt_autostash)
 			require_clean_work_tree(the_repository,
 				N_("pull with rebase"),
-				_("please commit or stash them."), 1, 0);
+				_("Please commit or stash them."), 1, 0);
 
 		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
 			oidclr(&rebase_fork_point);
diff --git a/sequencer.c b/sequencer.c
index 0677c9ab09..21748bbfb0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3629,13 +3629,13 @@ static int do_exec(struct repository *r, const char *command_line)
 			  "\n"),
 			command_line,
 			dirty ? _("and made changes to the index and/or the "
-				"working tree\n") : "");
+				"working tree.\n") : "");
 		if (status == 127)
 			/* command not found */
 			status = 1;
 	} else if (dirty) {
 		warning(_("execution succeeded: %s\nbut "
-			  "left changes to the index and/or the working tree\n"
+			  "left changes to the index and/or the working tree.\n"
 			  "Commit or stash your changes, and then run\n"
 			  "\n"
 			  "  git rebase --continue\n"
-- 
2.40.0.152.g15d061e6df


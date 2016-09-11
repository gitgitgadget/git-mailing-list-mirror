Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA23F207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbcIKICs (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:02:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:62499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753741AbcIKICp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:02:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McVGq-1bRSs51Bo0-00HeBK; Sun, 11 Sep 2016 10:02:41
 +0200
Date:   Sun, 11 Sep 2016 10:02:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] pull: make code more similar to the shell script
 again
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <c448851c24599d73143bce90984b9efc43d4a7aa.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AhskJcmog5bWBwIa0UR5mjNI2M73mGOoXdvnWAIKugwzC1AuiiR
 uKH5vKgQL+avS0VnMEpn2KUV02YlL7r0B4/zoET9JEFhuuykwXAwNjkaWxlByjEo3oJB/FG
 rCIoE/g/Id9MN7yEzOZkf9rdaIxgfSHnOht785UkH/ktnxWzeiV6JObLxJl9YVpCMarCRw9
 z9vqqQM/K4AuUgPiYw/gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GTenvZH8Oi0=:mqyOwnwjmJ8Eid/e8R2YIJ
 PGI8x54/d/bNvKTukjpMpq0UC3iTSdYAU27B8YoomDI1y9f5r70dscO1yCnLGAJmE/NEUdd77
 4wCR4jF4gbfnHwXcfzugptHppavrHFR6CcNxBKB8aJ4wH1RPhWHLaRX91V/kY1Sw655bXajyo
 1uLVGHYnWbn1fov1/vV7IFVLwI8+mpzuC8XAHTPMYnrxpclEG83sbsR0GXWCjxdfTbxbdhCKA
 qn5IJIyQi20RAQH+/loyPrDLu9dE/OIk2uwHh/jBWaKZqhEpXHfuo6nBNiKXoSUhj/6+mepYJ
 uYEh6yCto7wnZN32BKN2b73cquzQJOlyKnh9Bv8nLmUwx9rzG51xB7Fl9ol6kdKChXJZ12z+j
 19kZjt5LKDIr7qWGtg3I1U21b4ZO3AbfXjOYtuWeJI8mM3TaW284eR2UZ4bcgsWhTNUoxKC72
 4PwW6j515uHXrea5jX0O8svTPpy8TLZ6ew4PvSmVb2XMLj/LuRt8uPphycKq3yhjmdrsS5Psj
 t8A1LpmcqlOIAixK9CGFeeo3HIQqAZ/LqaTIZjoKwZicFg69dTOnDMZk3P1tUzd7XdeddwPxz
 VI5a2EG1WFM0ZxjImMzS+PVqB+bfwOIrRSu3eJGY8+SKAYS9ksC9lB/HlLOMTZwTzDkDwbwfJ
 jUm4He5djLPTbEgGrxFXmN1ycRg9uCSz9Fh9pIBM4KRuu87+vSqt4XU5cqeAf8XNXGXZ+DBql
 DLlaUiJ49kUEhtpwoNfAD/bjKtIf0rJxy8tplD8mzzEIafogZG0cWMDP1R5rmc6KrkAOgrXsW
 x4WZrbr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting the pull command to a builtin, the
require_clean_work_tree() function was renamed and the pull-specific
parts hard-coded.

This makes it impossible to reuse the code, so let's modify the code to
make it more similar to the original shell script again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d4bd635..a3ed054 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -365,10 +365,11 @@ static int has_uncommitted_changes(void)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-static void die_on_unclean_work_tree(void)
+static int require_clean_work_tree(const char *action, const char *hint,
+		int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
-	int do_die = 0;
+	int err = 0;
 
 	hold_locked_index(lock_file, 0);
 	refresh_cache(REFRESH_QUIET);
@@ -376,20 +377,27 @@ static void die_on_unclean_work_tree(void)
 	rollback_lock_file(lock_file);
 
 	if (has_unstaged_changes()) {
-		error(_("Cannot pull with rebase: You have unstaged changes."));
-		do_die = 1;
+		error(_("Cannot %s: You have unstaged changes."), _(action));
+		err = 1;
 	}
 
 	if (has_uncommitted_changes()) {
-		if (do_die)
+		if (err)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
-			error(_("Cannot pull with rebase: Your index contains uncommitted changes."));
-		do_die = 1;
+			error(_("Cannot %s: Your index contains uncommitted changes."),
+			      _(action));
+		err = 1;
 	}
 
-	if (do_die)
-		exit(1);
+	if (err) {
+		if (hint)
+			error("%s", hint);
+		if (!gently)
+			exit(err);
+	}
+
+	return err;
 }
 
 /**
@@ -875,7 +883,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			die_on_unclean_work_tree();
+			require_clean_work_tree(N_("pull with rebase"),
+				"Please commit or stash them.", 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.windows.1.10.g803177d



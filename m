Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C291420986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbcJDNFY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:49849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbcJDNFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:23 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LhkiL-1b4a8k0zeD-00moNE; Tue, 04 Oct 2016 15:05:19
 +0200
Date:   Tue, 4 Oct 2016 15:05:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] pull: make code more similar to the shell script
 again
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <5ec93712f8cb1f6d154c57e1afc69c772a8797b5.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W5d16vkzUVzmoj+g7y+Nf6XYA/0zKdjVSUE1SvzrTwd8B8Zphk1
 deN8pGdnJP801YkM+L1PEg9ymg8HxsFxNfKyS9bFffFA4iUGmA2U+S8A92taTqjMn60liop
 qB92fbr5XqjXxZqElXYigsbwqEiIXYwotEk95Uv2UmoFcdUNeG5BFK1u1RrwFTTakj0qPVF
 x6wlsw+4/3H37wsFKihkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F2bLpo2WJxQ=:2XpIFEmy+pSbFMBX2eV2UD
 ZhiVypnbWx4mR2nnsOVx5JTvwEdH9Kw3Z3fsLRTNAjE6DemLb4neo/rMnQUy8hMuMEFhBHwY4
 0hyJwO0RW5j/HWXZABEoK3ukOlP0Gx8jJAxSqHPlDiry7kkR+JXVTsMpaIFE8AC7X6IVX0WLC
 eoEUY1SsrejB4RK5oKbLORnI6oQccctYEH7rNOLQxKx+nwT/BT2KhmsBoS4XqikPiff/IcIaI
 4ADkPehC/7AluL69oGKT4ciQSbkutQetghq2iNiPCrvI0EzARUcARc2KDvcqMFdcZCcifjQQO
 FNQm4W+ENMPKZkAKOh2ta9hlMax0xW5gid4i6gbR3kNZqENptZBAIPDTvfA01VwaeO2OmMvax
 N8fx2JROS890UlNAsW+rrRKtlFgMdHeLyDdqgkwFoVMM9o5jWTyi34eBF5V2AzUhv+65vvHaI
 Fft0jz5xlfGbbRj7hKkr7EU2gyitvkRYmc6lQsFkvstwg3SgF90mboXbQilCqbidpeInVfTZh
 Bbxn5VYUOG5KVtkl1ITKMok37kYvYyd+XvxL0hWMoBXY5eTOExD/cd6RnVBHdDYnTSgEzJVbi
 etVCZpij0hcUZ2j/cGdNUYU0wAp6v742HuHJt4pZrpqrhYMiDJluXjWLWsP1li1OSkvneSBzc
 oLdhQh5yymcc+cVTOygoeypDs+GCsjUrbQpfVx9GK6laUjhiFraWvtuya6KvDf2kHO8xlsJrn
 jnBbgLwyjUia5q9/Abfc6K2QPT5YQgIWQeCtOelxEnzZ1GDrtIYaknEFRddkTWSML4y19mHek
 QoNBafC
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
 builtin/pull.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d4bd635..d1e093c 100644
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
@@ -376,20 +377,28 @@ static void die_on_unclean_work_tree(void)
 	rollback_lock_file(lock_file);
 
 	if (has_unstaged_changes()) {
-		error(_("Cannot pull with rebase: You have unstaged changes."));
-		do_die = 1;
+		/* TRANSLATORS: the action is e.g. "pull with rebase" */
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
@@ -875,7 +884,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			die_on_unclean_work_tree();
+			require_clean_work_tree(N_("pull with rebase"),
+				"Please commit or stash them.", 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.windows.1.325.ge6089c1



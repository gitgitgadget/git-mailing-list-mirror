Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A79820986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938945AbcJGQIt (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:08:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:59005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938937AbcJGQIr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:08:47 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYfJW-1bNBDd1VKc-00VPYk; Fri, 07 Oct 2016 18:08:35
 +0200
Date:   Fri, 7 Oct 2016 18:08:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/6] pull: make code more similar to the shell script
 again
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <5c016337b8affc4d51c7235334eef64a0f59879a.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/1aC3htvde+Kh0rIT7knqlXVspSdYrPqtlhts3WTk2k+zsir+V1
 /HDNVXwtwNHnWyht/nWrt/C/t5R3+01DjYErnFTCPfoxphRhN9ZWFuJ0f70MFlcXsCRcJLN
 AuVlx44D00bd8TInsvo9OktNCe3pI9vIWQoC6ifIECnQY/rwhDiZAwmZr5SyBiWzloNI74P
 rdj+oOanh4YGtADcSY/HA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:URshYypuAbY=:aGjEYSrRe7hujqx95/uJHc
 laVvus9702LbE2NLpb9CkTpHKx54qwMWrow92na3R9Lv3oe+073sfzm0+msh1zMiBR7SM7Ww+
 KUPJD+B6F+fcwJkN3+XOePOJEvs/Alg1w21VsdFYfcGtIAG3iBQkgWHfXEoZsVlvB/gjFV3wK
 O1to0ObP6/X+qqtnNJT2cJbhRSPw+IiyxN3sCvsdyArJcDT5M9ii5c//LbldV7pMaEk3INH5w
 lgw/2Bb4MLkAvhepyA3L61EKkFyCZv2VkPCf9YIXRy7ROUQmmVTs/F2q/pZvAWY9fCibbN0Ql
 YHAtvGDvHL6ZREK61wx6UctDpkPUVVhdB6i21EAP9nk0RivwFc9rj8/qOJ0f0EIrlI3Rpabbs
 sBn0rY2hXiLRsFM3HIU54mz8zysN8E14ty8ScmUWE4O73rNU1+8dITQ2M+JUMnL0gyF3cuuR1
 5YzhMcecOg21VLyZc/vQXbHIr2KaSl5fQoXAUzi5cPK91A5wAVwXha4OvOFGRF2B4WQsMfny+
 kjwEu0FhVvn7XfDWixMDSH8ZW42/+oHrF3Spg8REXTT57ME4cUbSQ84gJnMijUmwcwH/mlCrI
 JpJsdQqTJYBoczsuIzcS5fADz/n539hrwp6AYSKhx67vZxE/iL9sl+Z4O7CML1tykYLf1978b
 MEZQzUa2Paa8sM8gefCc/Z8MRuJfpTc5ftyMaymfpNgYhdVbbMOi3FZ6r+IG3zGNzuyCWd0tP
 VLYZ5SB+DoVAuGyIbqRCtYVFSDHk4xhu3byEEH6tytdPOAI38rfJkUg1kzUJbtjHg9LD3q08E
 ITYUZPj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting the pull command to a builtin, the
require_clean_work_tree() function was renamed and the pull-specific
parts hard-coded.

This makes it impossible to reuse the code, so let's modify the code to
make it more similar to the original shell script again.

Note: when the hint "Please commit or stash them" was introduced first,
Git did not have the convention of continuing error messages in lower
case, but now we do have that convention, therefore we reintroduce this
hint down-cased, obeying said convention.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d4bd635..58fc176 100644
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
+			exit(128);
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
+				_("please commit or stash them."), 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.windows.1.325.ge6089c1



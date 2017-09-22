Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278FC202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbdIVMEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 08:04:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:65367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdIVMEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 08:04:25 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MhJ69-1diM7R49on-00MM3I; Fri, 22
 Sep 2017 14:04:21 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] merge: --no-verify to bypass pre-merge hook
Date:   Fri, 22 Sep 2017 14:04:14 +0200
Message-Id: <bdc45cade9a8d108b7d11d66c0eecb27c2f23af6.1506081120.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.909.g0fa57a0913
In-Reply-To: <cover.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu>
X-Provags-ID: V03:K0:oHAHwxht3Sq4/08Wv62r9YWUKXeH9yO/gnqYK7LcDiaZSKHdnOM
 u3UNkTLUpzfdjC9GLS2wedXXBAzx9BUwzDFj8KAASjCx2mfVdHPQBSlp2ps3LURerYxn5EY
 Q9Iyyg106SFzAGs88mHxr9ruwBFzqazl+v48Ef7bKwdJxlKrxq//mwsEuMi8MgF+hOMIrDX
 4hcjJOhkFUR+9WjNqaQlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rbxxVvJitZc=:ofg6eU+fgk0FsEZlBE5DFM
 0SM/ppFXImqu40WJr409lm09QwURxnTohHj/E8p9p7aGwOe4Uc/UlyI2GrPhW7HsxPtuFzkwA
 HyZDR4yLKiEQiuZDU/nkeOAYJZDKfHAKHyZLML/MVm/4MpgqrDZyFb8WGj63+kHQ2pTFQAeZJ
 87luK1ahcya/+dnPuiIu28S2Q5bNP3260T9tMdw50exCbqVBjwLPNqzth3RXd/1zhx46zQmcd
 9W4MbKo3vWM4EsasGh5LlUwm/k3YzO2Zz6OEyVNg8IGN1OptAYua2KQJ9goIqmy66y2p213p/
 73pmuBoaQJgAZVaqpvfVal2ugVQdi2n850+1R+DUwhJ4UmbpJIr1WGsFNPFhTgMGFERlcKLPm
 86M1hm0WG3bcSGJnxx6CItiZZ3BJVqIHEDQrm5byRez2OveYJcJhnd0kQHuKD6XQVkixqoOdE
 cz8d//SeFshTLpSUM/EPLpay4wDF6x+2OXmvsWQgnFyJLIN7DoAO5RN88h6lHrvveNzlbkSY3
 eTIVh0qdkxHXEpDhrB7DEBx3E25OojfbuMVZI2oFKTjdtgNpT6cLErq2GVRalsz6V6d4uzxyp
 jnrxVdrKRk/HQ4hDZBCpPMvhEUT0ZTL8osONBY+f8f8R7+Cp0C88zAiyqteMLxdKxtAFKoXsK
 i4fsc9wIn574129BJF6W5hrtKZ1RRaje96eFxiaCLsraWxTiARwdE8lANeSSXJ6/PFhtkzViL
 JwUxjFOQMNKcFbfO4hyJFYQ88c9y1Iy0PV9GVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-merge hook. The shorthand '-n' is taken by the (non-existing)
'--no-stat' already.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/githooks.txt      | 2 +-
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4df6431c34..5f0e1768e1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' --abort
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 85bedd208c..969441d7a2 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -104,7 +104,7 @@ pre-merge
 
 This hook is invoked by 'git merge' when doing an automatic merge
 commit; it is equivalent to 'pre-commit' for a non-automatic commit
-for a merge.
+for a merge, and can be bypassed with the `--no-verify` option. 
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 4e32304301..75019d5919 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -74,6 +74,10 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 
+--no-verify::
+	This option bypasses the pre-merge and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin/merge.c b/builtin/merge.c
index 7ba094ee87..c63510c199 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -237,7 +237,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -771,7 +771,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge hook could have updated it,
-- 
2.14.1.909.g0fa57a0913


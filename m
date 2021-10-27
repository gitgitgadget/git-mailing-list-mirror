Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF4DC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9659F6103B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbhJ0MMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:12:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241832AbhJ0MMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:12:21 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQvH5-1mL2Ex2luR-00NxB1; Wed, 27 Oct 2021 14:09:44 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 821EC1E01E7;
        Wed, 27 Oct 2021 12:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T6_ri1rDNxbb; Wed, 27 Oct 2021 14:09:43 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (19-usr-pf-main.vpn.it.cetitec.com [10.8.5.19])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 1366B1E01E6;
        Wed, 27 Oct 2021 14:09:43 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Wed, 27 Oct 2021 14:09:42 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXlBhmfXl3wFQ5Bj@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
X-Provags-ID: V03:K1:b2IBwWL8XgmkzbkevGmIlJ2U1rvuQ/T4xb9u+E8y/VZdD+4aGKw
 RzPGsjdaYeEGzgUgjIZINRX5AkdlIa3ypsR6+GLHTlCvzVJxiRtBNHW5MjSbmRiPNkjQd7w
 xDITtgoeA2wazpWpwig04oTJsAScncsrvsJPCg5T1Z0sKuBSP0UyYXH4+PeuIGUOguB9qJM
 e/HTTpPJ0AwLvsfrgbVZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EMR3MoLIPkY=:IV4gvllqGXixniVjWynz1s
 5LmDB96m4TVDypi3TYm+8mj4xzNSFIKiATVilIqP1zvgT7fwx7eQT2r3zdiTjG9lby/8DlYTQ
 n4p2SR/+bIBhJ2tzuAgbFtAZMmTow+q30vePgH1RZeGjKdJMjOxejX5QdNVBl2NJ9mHdePUiQ
 3eQJb5kqpycK9lse6CqJZp8+xU8BMiBKSrmPAxoSfnCfWwXmv6I7Nsh5wLc0l0HvVhg5yCkXX
 UXVLSZjmJeTGHuUiwW8/J6Bmr0Mvua5/LqfJcv2gQ2gIYCQCZeUlWSKdz2sZa5/vjPlm/+dBs
 1XKrVLtuK4I7HPX+Om0IflVY0BgAEVeXBZo4FgtmOnDKuWrDl+W79tdG8PvfYCa/0tsE4oT/6
 TzOBFFnB+hs09r3rqp1Zj1pIplmZ9dY2LeCy/XyWhxZvu9l2ue/FHz5jhrhXemznDOg7N6V01
 RH7vqYn5hUP06zYnwWkJITEMhMFt8uXXgecH3TQucuHw5h8qPIfXUxfzQEbCltve6WwFOR3Tx
 /nqede9jSZAi5QMaC7hPa/Iq0EfEiVbuLo80/2iU4imojH1857Ay8G3360Yw1HvpLKwZhsVLq
 yq7rzRhCyg/9wdizfzQdSvvi5vpuUvxkkp7LmzBlI3Q8ZI1kU/EM2SqOgWEWV/rkgPz3R9JoZ
 IoM1hz/tCkRYCWy8ZgfCTr188RpiPMQ2BYiZqIq4SS0d7ikMgsFvDQGWFya0PKH8GRLiSQ2kU
 dJfLfyQd3nR3hSCJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Tue, Oct 26, 2021 23:16:09 +0200:
> On Tue, Oct 26, 2021 at 02:11:22PM +0200, Alex Riesen wrote:
> I was going to ask whether this should be passing through "verify", and
> allowing its "no-" variant, but there is no "--verify" in git-merge.
> Arguably there should be (for consistency and to countermand an earlier
> --no-verify), but that is outside the scope of your fix (sadly if
> somebody does change that, they'll have to remember to touch this spot,
> too, but I don't think it can be helped).

This seems simple enough, though. Like this?

[PATCH] Remove negation from the merge option "--no-verify"

This allows re-enabling hooks disabled by an earlier "--no-verify"
in command-line and makes the interface more consistent.
---
 Documentation/git-merge.txt     |  2 +-
 Documentation/merge-options.txt |  5 +++--
 builtin/merge.c                 | 12 ++++++------
 builtin/pull.c                  | 12 ++++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1..324ae879d2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--[no-]verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
 'git merge' (--continue | --abort | --quit)
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..54cd3b04df 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,9 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
---no-verify::
-	This option bypasses the pre-merge and commit-msg hooks.
+--[no-]verify::
+	With `--no-verify`, bypass the pre-merge and commit-msg hooks,
+	which will be run by default.
 	See also linkgit:githooks[5].
 
 -s <strategy>::
diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..ab5c221234 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -83,7 +83,7 @@ static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
 static int autostash;
-static int no_verify;
+static int verify = 1;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -290,7 +290,7 @@ static struct option builtin_merge_options[] = {
 	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
+	OPT_BOOL(0, "verify", &verify, N_("control use of pre-merge-commit and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -822,7 +822,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
@@ -858,9 +858,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
-					  git_path_merge_msg(the_repository), NULL))
+	if (verify && run_commit_hook(0 < option_edit, get_index_file(),
+				      "commit-msg",
+				      git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
diff --git a/builtin/pull.c b/builtin/pull.c
index 428baea95b..e783da10b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,7 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
-static char *opt_no_verify;
+static char *opt_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -161,9 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-	OPT_PASSTHRU(0, "no-verify", &opt_no_verify, NULL,
-		N_("bypass pre-merge-commit and commit-msg hooks"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
+		N_("control use of pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -692,8 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
-	if (opt_no_verify)
-		strvec_push(&args, opt_no_verify);
+	if (opt_verify)
+		strvec_push(&args, opt_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
-- 
2.33.0.22.g8cd9218530



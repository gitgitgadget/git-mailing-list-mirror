Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A668E1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 11:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFOL0Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 07:26:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52037 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfFOL0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 07:26:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so4827140wma.1
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V8dDmtN/Cl/oJkFAaEiL4kNj2bIPIcMD1MGL5tgJUiE=;
        b=ijxZXVw2LDvMT/hy/MLvIgrmA0DquOz0OC/cyOIgw4n/JTyFJMNaR8fRqXu2FfUnvL
         WFixO6hdWFA9qg0Ok/OxSpx790EUaPlFdPxvxRahnTr+p9YrFO/1NqUI1AT9UGl4smRw
         hZS29dgoZR0ZTx9zTssS13vUuK/AZLBNcGMf8vLtEreLVm+z9LRixSQxZX0a0SvfXkXQ
         CjIXlW8Ypx4leMzRSarjYXI+82NWBNOr3JWWYGSZcTgSaIuOP8kfsUqJbDAb95Ra3X6V
         pkChDbWXIbLLfmBEyirJvVviASubs1Kv72a5aTUCMOSu4WExpq3m3RPu4rwSfNA8YMp3
         LDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V8dDmtN/Cl/oJkFAaEiL4kNj2bIPIcMD1MGL5tgJUiE=;
        b=rI6V/m6TwBmUt3eHli5L/OAI8aO7fPxUatU/hSUpBSu/2DwCjhqFY8inBZ9fpKBoq0
         pYM6mXnbMzAqXWL2YPPsVt9xxcEj55H2uQKDMXgcDhzzbk6YGavg6c8/28Vk+kykFDb7
         R0mGjpTR0k7/502MPL14TaByn+Ogzep92liXVSq0uKp2XwN+FurrMMJkbMTdUB9U4ozJ
         RtlUZo5AUqcnFU6SI5YMPdJiLBlvoniDE7qKd5dm6h77smjiPcONKpa9zSJlGKi+50hn
         TDP3YQJeYokrDSBo5mGNggWFQAyzdo/PjX8mKLLYwVREoMSTd65j0GM9YW6oL+EuKg54
         XzHw==
X-Gm-Message-State: APjAAAWEfJIgCwkUUd7NYCQI8bzCCbUUirDdXq9Cc26ghDX5WDaL+zsJ
        0VRXCz17N6IqcvVvx+YQT4k=
X-Google-Smtp-Source: APXvYqxilKWZaU4a00vhZOrKdBhFNc9VaRQ6S+NBttiEEHI1t7FY9xNbppIJn6QnEmK9PbYErT29WQ==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr11640526wmb.19.1560597981701;
        Sat, 15 Jun 2019 04:26:21 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id y2sm4914178wrl.4.2019.06.15.04.26.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 04:26:20 -0700 (PDT)
Date:   Sat, 15 Jun 2019 12:26:18 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, ungureanupaulsebastian@gmail.com
Subject: [PATCH] stash: fix show referencing stash index
Message-ID: <20190615112618.GC11340@hank.intra.tgummerer.com>
References: <20190614074207.mxidz3h573mtd43x@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614074207.mxidz3h573mtd43x@glandium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Mike Hommey wrote:
> Hi,
> 
> `git stash <command> <n>` where n is a number used to work until 2.21.*.
> It doesn't work in 2.22.0.
> 
> Bisection points to:
> 
> dc7bd382b1063303f4f45d243bff371899285acb is the first bad commit
> commit dc7bd382b1063303f4f45d243bff371899285acb
> Author: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> Date:   Mon Feb 25 23:16:20 2019 +0000
> 
>     stash: convert show to builtin
> 
> which I guess makes sense :)

Yup, this is definitely a bug.  I think it only affected 'git stash
show' however, and not other stash subcommands.  If not, could you
point me to where else you saw this bug?

Below is a patch that should fix it.

--- >8 ---
Subject: [PATCH] stash: fix show referencing stash index

In the conversion of 'stash show' to C in dc7bd382b1 ("stash: convert
show to builtin", 2019-02-25), 'git stash show <n>', where n is the
index of a stash got broken, if n is not a file or a valid revision by
itself.

'stash show' accepts any flag 'git diff' accepts for changing the
output format.  Internally we use 'setup_revisions()' to parse these
command line flags.  Currently we pass the whole argv through to
'setup_revisions()', which includes the stash index.

As the stash index is not a valid revision or a file in the working
tree in most cases however, this 'setup_revisions()' call (and thus
the whole command) ends up failing if we use this form of 'git stash
show'.

Instead of passing the whole argv to 'setup_revisions()', only pass
the flags (and the command name) through, while excluding the stash
reference.  The stash reference is parsed (and validated) in
'get_stash_info()' already.

This separate parsing also means that we currently do produce the
correct output if the command succeeds.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  |  9 +++++----
 t/t3903-stash.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 2a8e6d09b4..fde6397caa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -713,11 +713,11 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int opts = 0;
 	int ret = 0;
 	struct stash_info info;
 	struct rev_info rev;
 	struct argv_array stash_args = ARGV_ARRAY_INIT;
+	struct argv_array revision_args = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT_END()
 	};
@@ -726,11 +726,12 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	init_revisions(&rev, prefix);
 
+	argv_array_push(&revision_args, argv[0]);
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-')
 			argv_array_push(&stash_args, argv[i]);
 		else
-			opts++;
+			argv_array_push(&revision_args, argv[i]);
 	}
 
 	ret = get_stash_info(&info, stash_args.argc, stash_args.argv);
@@ -742,7 +743,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	 * The config settings are applied only if there are not passed
 	 * any options.
 	 */
-	if (!opts) {
+	if (revision_args.argc == 1) {
 		git_config(git_stash_config, NULL);
 		if (show_stat)
 			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
@@ -756,7 +757,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = setup_revisions(revision_args.argc, revision_args.argv, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
 		usage_with_options(git_stash_show_usage, options);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea30d5f6a0..3973cbda0e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -708,6 +708,24 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
 	git stash drop
 '
 
+test_expect_success 'valid ref of the form "n", n >= N' '
+	git stash clear &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
+	git add file2 &&
+	git stash &&
+	git stash show 0 &&
+	git stash branch tmp 0 &&
+	git checkout master &&
+	git stash &&
+	git stash apply 0 &&
+	git reset --hard &&
+	git stash pop 0 &&
+	git stash &&
+	git stash drop 0 &&
+	test_must_fail git stash drop
+'
+
 test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
-- 
2.22.0.rc2


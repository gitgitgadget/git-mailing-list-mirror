Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D4D1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 19:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJKCvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:51:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40396 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJKCvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:51:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so7006632wro.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5DvMD4aSpEDjqY/+R5xyCYhvz5T8rxWlwhTNMDYXZs=;
        b=Pgb4U33b7WqhkNtyHetK4yLimS4/eXiqeOtMsk4bB3mt0iahkk017nL1BQioe9Prk6
         8AZjbSlL4LNMB8cy79RfQM5g2ZtyF67Fvnfq6NtMqfk8bldKnBddwvP61OWwp+bYpE+j
         8ZLgvrWUA39eFnQ723gKbalB1bRIRI1qUPyJ9pD7neeSN40PRd/FgcLJJQK7kYm4fDWt
         /q9T6fDZZYTHLzN8E0zjhv9w86NCp7VqujLLV0h2Ar6WXK+LxWFjfQwwFK7mvNauKEzp
         GaMZBCkM7b3dtFgZHr0Rb8xxJjm9NN4RIjHb/fNSlJXHGK2NHiJqkogwY0JNIrfLcNx4
         KzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5DvMD4aSpEDjqY/+R5xyCYhvz5T8rxWlwhTNMDYXZs=;
        b=cdQDskSpDksbMGrxDqEUusx7LfFZUx94u5W2ar0RClNuKRM9Ph8bRIFAJBD7uYONqJ
         ESkSdLGkmD0psruMia+JTFqHuqWnAJz1YDG7pZXp/7HFercpqce3ixDpltdarsODH7LX
         1URhBrrrLuxwYtawv8MsacaYCMUsATU4JxiW68GIHTWdjayhVjaUdipQJO5afBaKeAvy
         cFBtZIl8Ca0JQih9rT2aWEBuK/dxeL5/clN03CHLy4En2qtZmf4QFgRi1jUjKPJMLtlu
         g4Nx/ojjxhqxz7McphskPrkrYlJmF+CYr/UbeklaNqAzoh/Nje7XKmPQDmHSCUhOql9m
         cW5A==
X-Gm-Message-State: ABuFfoiJd2zzQ0I4OTOzsKZ+KZBYmzt7jz7V8q0r1lucZv1DWOHZ/ivJ
        AEaOJyDIxeIynaYPXDFu/AqqQafkJuo=
X-Google-Smtp-Source: ACcGV62lTOVY1ApF4o66WXovzRx/fn2OGUXGTX4ak6Huoe5ajMxPGX6PyVT2S/WlfO7hsg3QjNklMQ==
X-Received: by 2002:adf:fb4b:: with SMTP id c11-v6mr14900581wrs.117.1539199662908;
        Wed, 10 Oct 2018 12:27:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k25-v6sm45056157wre.18.2018.10.10.12.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:27:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc: introduce an --auto-exit-code option for undoing 3029970275
Date:   Wed, 10 Oct 2018 19:27:32 +0000
Message-Id: <20181010192732.13918-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
In-Reply-To: <20181010174624.GC8786@sigill.intra.peff.net>
References: <20181010174624.GC8786@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --auto-exit-code variable and a corresponding 'gc.autoExitCode'
configuration option to optionally bring back the 'git gc --auto' exit
code behavior as it existed between 2.6.3..2.19.0 (inclusive).

This was changed in 3029970275 ("gc: do not return error for prior
errors in daemonized mode", 2018-07-16). The motivation for that patch
was to appease 3rd party tools whose treatment of the 'git gc --auto'
exit code is different from that of git core where it has always been
ignored.

That means that out of the three modes gc --auto will operate in:

 1. gc --auto has nothing to do
 2. gc --auto has something to do, will fork and try to do it
 3. gc --auto has something to do, but notices that gc has been failing
    before when forked and can't do anything now.

We started exiting with zero in the case of #3, instead of
non-zero (see [1] for more details). As noted by the docs being added
here the #3 case is relatively rare, so I think it's fine to change
this as the default with the assumption that the use-case for tools
like the "repo" tool noted in commit 3029970275 above are more common
than not.

But it left us without any option to have "git gc --auto" tell us
about this failure except by starting to either parse its output, or
for the caller to start breaking the encapsulation and starting to
check for .git/gc.log themselves.

Let's instead provide an option to exit with non-zero when we have
errors to tell the user about, and provide a configuration option so
that it can be dropped in-place in anticipation of upgrading to Git
version 2.20 without having to make using --auto-exit-code conditional
on the git version in use.

1. https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> On Wed, Oct 10, 2018 at 09:51:52AM -0700, Jonathan Nieder wrote:
>
>> Ævar Arnfjörð Bjarmason wrote:
>> 
>> > I'm just saying it's hard in this case to remove one piece without the
>> > whole Jenga tower collapsing, and it's probably a good idea in some of
>> > these cases to pester the user about what he wants, but probably not via
>> > gc --auto emitting the same warning every time, e.g. in one of these
>> > threads I suggested maybe "git status" should emit this.
>> 
>> I have to say, I don't have a lot of sympathy for this.
>> 
>> I've been running with the patches I sent before for a while now, and
>> the behavior that they create is great.  I think we can make further
>> refinements on top.  To put it another way, I haven't actually
>> experienced any bad knock-on effects, and I think other feature
>> requests can be addressed separately.
>
> I think there may be some miscommunication here. The Jenga tower above
> is referring (I think) to Jonathan Tan's original patch to drop the
> warning entirely, which does have some unwanted side effects.
>
> Your patches are much less controversial, I think, and are in next and
> marked as "will merge to master" in the last "what's cooking".

[Junio: This goes on top of gitster/jn/gc-auto]

I thought the jn/gc-auto topic was still in "pu", my fault for not
paying attention. It seems the general consensus is against my notion
of what should be the default (which is fine), but since (as noted in
the patch) it seems yucky to start breaking the encapsulation of
gc.log, especially as it's looking more and more likely that it'll be
an implementation detail we might drop, here's a patch on top of
jn/gc-auto to optionally restore the old behavior.

 Documentation/config.txt | 28 ++++++++++++++++++++++++++++
 Documentation/git-gc.txt |  7 +++++++
 builtin/gc.c             |  7 ++++++-
 t/t6500-gc.sh            |  2 ++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5b72684999..e37a463bf8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1635,6 +1635,34 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.autoExitCode::
+	Make `git gc --auto` return non-zero if it would have
+	demonized itself (see `gc.autoDetach`) due to a needed gc, but
+	a 'gc.log' is found within the `gc.logExpiry` with an error
+	from a previous run.
++
+When 'git gc' is run with the default of `gc.autoDetach=true` a
+failure might have been noted in the 'gc.log' from a previously
+detached `--auto` run. If the failure is within the time configured in
+`gc.logExpiry` the `--auto` run will abort early and report the error
+in the 'gc.log'.
++
+From version 2.6.3 to version 2.19 of Git encountering this error
+would cause 'git gc' to exit with non-zero, but this was deemed to be
+a hassle for third-party tools to handle since it rarely happens, and
+they usually don't assume that 'git gc --auto' can fail. Therefore
+since version 2.20 of Git 'git gc --auto' will always exit with zero
+if it would have demonized itself, even when encountering such an
+error.
++
+Supplying this option will make 'git gc' exit with non-zero in that
+case, which allows for detecting cases where a repository is in a
+state where git 'gc --auto' is refusing to demonize due to previously
+encountered errors.
++
+This option can also be turned on as a one-off with the
+`--auto-exit-code` option, see linkgit:git-gc[1].
+
 gc.bigPackThreshold::
 	If non-zero, all packs larger than this limit are kept when
 	`git gc` is run. This is very similar to `--keep-base-pack`
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 24b2dd44fe..adf53fc959 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -71,6 +71,13 @@ If houskeeping is required due to many loose objects or packs, all
 other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
+--auto-exit-code::
+	Make `git gc --auto` return non-zero if it would have
+	demonized itself (see `gc.autoDetach`) due to a needed gc, but
+	a 'gc.log' is found within the time period of `gc.logExpiry`
+	with an error from a previous run. See linkgit:git-config[1]
+	for more details about this option which can also be
+	configured with the `gc.autoExitCode` boolean variable.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
diff --git a/builtin/gc.c b/builtin/gc.c
index ce8a663a01..69c0dedd8c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,6 +41,7 @@ static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
+static int gc_auto_exit_code = 0;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
@@ -130,6 +131,7 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+	git_config_get_bool("gc.autoexitcode", &gc_auto_exit_code);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
@@ -518,6 +520,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL_F(0, "auto-exit-code", &gc_auto_exit_code,
+			   N_("exit with non-zero if an error is encountered before gc is daemonized"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -582,7 +587,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 				exit(128);
 			if (ret == 1)
 				/* Last gc --auto failed. Skip this one. */
-				return 0;
+				return gc_auto_exit_code;
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a222efdbe1..25bce70316 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -121,6 +121,8 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =-345600 .git/gc.log &&
 	git gc --auto &&
+	test_must_fail git gc --auto --auto-exit-code &&
+	test_must_fail git -c gc.autoExitCode=true gc --auto &&
 	test_config gc.logexpiry 2.days &&
 	run_and_wait_for_auto_gc &&
 	ls .git/objects/pack/pack-*.pack >packs &&
-- 
2.19.1.390.gf3a00b506f


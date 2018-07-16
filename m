Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1151F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPX0P (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:26:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42242 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbeGPX0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:26:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so11707301plb.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pdgn37wFJ+QATwWsGBISOV8rV8qPOppakGNa+qmXEz0=;
        b=ShHLtt/mh0iw8agsOPhiN3EDUM0mltrXv9Rq4SfFJe2v5HLRUMactb39PcSH+4gTUU
         9qV11/BU4Ow4jIKOtdX4EQDZeLJYKboSc21q+nAzS5nWdKyYOqY8a8MAT1buV0w8UAx8
         UseXv+E8kFXtKr6wKe5rSpJpf6tJDR7Tjujn/MH6fz8m2EngUdkaFcCYsRqqgemu0/Z/
         ECfUyeJH68sPQsC0ord96E5nHMgD7ts2L6Z20IwjsI8JFpSbRI5qQCOBFpqZx1l9qrUh
         JGwj4xgMQ3khJuW7qNFvIh84nTFiTGDFxO6370K4KW907fn+xpQF1SEeS+JUeRsm9i2f
         AHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pdgn37wFJ+QATwWsGBISOV8rV8qPOppakGNa+qmXEz0=;
        b=H0BYvRt4lIvTO8R4t4B8u/pK8ADcUgJtz0s834lmXqomzxFV74GzWPOoQ2C2Hd7WEu
         wCrNs1ZUos8GRaS2PquVFj4+9uZmC5OvBgKNWrQl4610SpucvKv0lYksCjjl3Zmupia7
         WHfGhE5l4WEiyOaSSIZEuriYJkx6gibU5HPylx8qowxLV+KJ7rNU9E/JnpsaiPZsH2ym
         x53ZCTS4zZCnPedQtvjyt9LWzVbYtWdm+xRr9ZRJIGtQ7PjaqtVxjdlsLw/w+T+9iMEQ
         G0Zd/UbdqaXvxgsq9h+wP0/4qdfyJ9wkzE2CQJUwdw1aeiNbsb6a5lhdC8GJK05OeiLM
         RG6w==
X-Gm-Message-State: AOUpUlFCwU/l7Kx77uS0KDrOMHRAmcHEV7tWWPlAYl/vkC8xqfkO5GBt
        gyb+sWfF9JcwLmWhRrno3xE=
X-Google-Smtp-Source: AAOMgpdy4wHpNeU+sp4Lg990JrV601VjUllvxSUxY8Z5QoZ3kcvfW5HnfTNfrGD/LuFhum14ksXt0g==
X-Received: by 2002:a17:902:585:: with SMTP id f5-v6mr9980860plf.7.1531781801481;
        Mon, 16 Jul 2018 15:56:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x2-v6sm69730571pfi.166.2018.07.16.15.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:56:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:56:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716225639.GK11513@aiede.svl.corp.google.com>
References: <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716224337.GB12482@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 16, 2018 at 03:03:06PM -0700, Jonathan Nieder wrote:

>> Oh, good point.  In non-daemon mode, we don't let "gc --auto" failure
>> cause the invoking command to fail, but in daemon mode we do.  That
>> should be a straightforward fix; patch coming in a moment.
>
> OK, that definitely sounds like a bug. I'm still confused how that could
> happen, though, since from the caller's perspective they ignore git-gc's
> exit code either way. I guess I'll see in your patch. :)

Alas, I just misremembered.  What I was remembering is that gc --auto
does

	if (auto_gc && too_many_loose_objects())
		warning(_("There are too many unreachable loose objects; "
			"run 'git prune' to remove them."));
	return 0;

which means that too_many_loose_objects is not an error in undaemonized
mode, while it is in daemonized mode.  But we've already discussed that.

The calling command in the motivating example is Android's "repo" tool:

            bare_git.gc('--auto')

from https://gerrit-review.googlesource.com/c/git-repo/+/10598/.  I
think it's reasonable that it expects a status code of 0 in the normal
case.  So life is less simple than I hoped.

[...]
>> Can you point me to some discussion about building that rate-limiting?
>> The commit message for v2.12.2~17^2 (gc: ignore old gc.log files,
>> 2017-02-10) definitely doesn't describe that as its intent.
>
> I think that commit is a loosening of the rate-limiting (because we'd
> refuse to progress for something that was actually time-based). But the
> original stopping comes from this discussion, I think:
>
>   https://public-inbox.org/git/xmqqlhijznpm.fsf@gitster.dls.corp.google.com/

Interesting!  It looks like that thread anticipated the problems we've
seen here.  Three years without having to have fixed it is a good run,
I suppose.

The discussion of stopping there appears to be primarily about
stopping in the error case, not rate-limiting in the success or
warning case.

Here's a patch for the 'return -1' thing.

-- >8 --
Subject: gc: exit with status 128 on failure

A value of -1 returned from cmd_gc gets propagated to exit(),
resulting in an exit status of 255.  Use die instead for a clearer
error message and a controlled exit.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/gc.c  | 36 ++++++++++++++++--------------------
 t/t6500-gc.sh |  2 +-
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..2bebc52bda 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -438,10 +438,10 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	return NULL;
 }
 
-static int report_last_gc_error(void)
+static void report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
+	ssize_t ret;
 	struct stat st;
 	char *gc_log_path = git_pathdup("gc.log");
 
@@ -449,16 +449,17 @@ static int report_last_gc_error(void)
 		if (errno == ENOENT)
 			goto done;
 
-		ret = error_errno(_("Can't stat %s"), gc_log_path);
-		goto done;
+		die_errno(_("cannot stat '%s'"), gc_log_path);
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
 		goto done;
 
 	ret = strbuf_read_file(&sb, gc_log_path, 0);
+	if (ret < 0)
+		die_errno(_("cannot read '%s'"), gc_log_path);
 	if (ret > 0)
-		ret = error(_("The last gc run reported the following. "
+		die(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
@@ -468,20 +469,18 @@ static int report_last_gc_error(void)
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
-	return ret;
 }
 
-static int gc_before_repack(void)
+static void gc_before_repack(void)
 {
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
+		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, reflog.argv[0]);
+		die(FAILED_RUN, reflog.argv[0]);
 
 	pack_refs = 0;
 	prune_reflogs = 0;
-	return 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -562,13 +561,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			if (report_last_gc_error())
-				return -1;
+			report_last_gc_error(); /* dies on error */
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
-			if (gc_before_repack())
-				return -1;
+			gc_before_repack(); /* dies on failure */
 			delete_tempfile(&pidfile);
 
 			/*
@@ -608,12 +605,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		atexit(process_log_file_at_exit);
 	}
 
-	if (gc_before_repack())
-		return -1;
+	gc_before_repack();
 
 	if (!repository_format_precious_objects) {
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, repack.argv[0]);
+			die(FAILED_RUN, repack.argv[0]);
 
 		if (prune_expire) {
 			argv_array_push(&prune, prune_expire);
@@ -623,18 +619,18 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
-				return error(FAILED_RUN, prune.argv[0]);
+				die(FAILED_RUN, prune.argv[0]);
 		}
 	}
 
 	if (prune_worktrees_expire) {
 		argv_array_push(&prune_worktrees, prune_worktrees_expire);
 		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, prune_worktrees.argv[0]);
+			die(FAILED_RUN, prune_worktrees.argv[0]);
 	}
 
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, rerere.argv[0]);
+		die(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 818435f04e..c474a94a9f 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -117,7 +117,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_config gc.autodetach true &&
 	echo fleem >.git/gc.log &&
 	test_must_fail git gc --auto 2>err &&
-	test_i18ngrep "^error:" err &&
+	test_i18ngrep "^fatal:" err &&
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =-345600 .git/gc.log &&
 	test_must_fail git gc --auto &&
-- 
2.18.0.233.g985f88cf7e


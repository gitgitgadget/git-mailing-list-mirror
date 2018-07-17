Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF20C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGQCXt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 22:23:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbeGQCXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 22:23:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so8248961pgr.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=htwlfZ9HUHPx7OacBTE3KVgBsxSWKNTEhO+SEFvfnaI=;
        b=L2KAnKiEF5pyPtcHpOGa4MavhUDKX1YI9AaYujniRKUPSbku73UnQBnD1MmRHYOBjh
         kcQdFZLYpLTXCJ/QYj9e4eoOfAihLr9AMoQIo5QnBu9uH2lVnfYOpvmKEqN7lwbrPzTx
         9tdFINuEZNsay+37fmeMZMhpv5+7i9jgtmqgI5PhZfehGfRZr+5sAKXyHxihWD9Lvml1
         WaO7pimBs0YExhSTKybaXyeBXTBHsxOJe8YfFg6yAr+YfTiucAQDAeuSAYpsCeExO6iH
         YpFGwi+oJpAEsa8oxD9ybl5jAhqq3lrHvxIbjVuKstcVAzJWDc+jc21uK7lEcJrwpnAm
         sugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=htwlfZ9HUHPx7OacBTE3KVgBsxSWKNTEhO+SEFvfnaI=;
        b=jbayeb+PLwXTIhxJ0EuEuGjaS65f7TgHZWCjv35KmS1c/MBbz/txrZDP7tgLXC5Ygm
         xVz5c6C+WC5EVIPl9bThLEWV9+n4Li1toO5Bz9Nghb0GKE1mWcZsDW39jouH0W5amkuj
         CCF8gJcwxVNtRz+haXCmbMfwRHDD53JBMe+fRPZs1JVvfrv4QzTOLn+oxoajQwMCZTiK
         +yjThR+z2LgBnP3DbUvpKrRm2OmDdI1XT3tGzDOHTAc9bjgneh+oXR6H2FED2Z/E36wM
         V+qAUQPUp+dz/C0PwAScFLWa6pkxnWao/qWzKSGp6G1ULA5CweMgvPc7J94v53OXcIEH
         LQBw==
X-Gm-Message-State: AOUpUlHxFRblE3nvgWVjBcin55rFcqPLZWKEoQXFeRk0AoU/R1azYqiV
        Dfze4dCy62kIFBUf6xk+eN0=
X-Google-Smtp-Source: AAOMgpeF6eUM6AC8DKLxvLKlcnAenIpp1grjl6U4M04hvQ3EXTSTOlMyBnGzuEm64FiVHLxJTfuj7Q==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr17059304pgd.291.1531792421503;
        Mon, 16 Jul 2018 18:53:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 14-v6sm2049036pft.93.2018.07.16.18.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 18:53:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 18:53:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180717015339.GL11513@aiede.svl.corp.google.com>
References: <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
 <20180716225639.GK11513@aiede.svl.corp.google.com>
 <20180716232603.GB13570@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716232603.GB13570@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Jul 16, 2018 at 03:56:39PM -0700, Jonathan Nieder wrote:

>> The calling command in the motivating example is Android's "repo" tool:
>> 
>>             bare_git.gc('--auto')
>> 
>> from https://gerrit-review.googlesource.com/c/git-repo/+/10598/.  I
>> think it's reasonable that it expects a status code of 0 in the normal
>> case.  So life is less simple than I hoped.
>
> IMHO it should ignore the return code, since that's what Git does
> itself. And at any rate, you'd miss errors from daemonized gc's (at
> least until the _next_ one runs and propagates the error code).

That suggests a possible improvement.  If all callers should be
ignoring the exit code, can we make the exit code in daemonize mode
unconditionally zero in this kind of case?

That doesn't really solve the problem:

 1. "gc --auto" would produce noise *every time it runs* until gc.log
    is removed, for example via expiry

 2. "gc --auto" would not do any garbage collection until gc.log is
    removed, for example by expiry

 3. "gc --auto" would still not ratelimit itself, for example when
    there are a large number of loose unreachable objects that is not
    large enough to hit the loose object threshold.

but maybe it's better than the present state.

To solve (1) and (2), we could introduce a gc.warnings file that
behaves like gc.log except that it only gets printed once and then
self-destructs, allowing gc --auto to proceed.  To solve (3), we could
introduce a gc.lastrun file that is touched whenever "gc --auto" runs
successfully and make "gc --auto" a no-op for a while after each run.

-- >8 --
Subject: gc: do not return error for prior errors in daemonized mode

Some build machines started failing to fetch updated source using
"repo sync", with error

  error: The last gc run reported the following. Please correct the root cause
  and remove /build/.repo/projects/tools/git.git/gc.log.
  Automatic cleanup will not be performed until the file is removed.

  warning: There are too many unreachable loose objects; run 'git prune' to remove them.

The cause takes some time to describe.

In v2.0.0-rc0~145^2 (gc: config option for running --auto in
background, 2014-02-08), "git gc --auto" learned to run in the
background instead of blocking the invoking command.  In this mode, it
closed stderr to avoid interleaving output with any subsequent
commands, causing warnings like the above to be swallowed; v2.6.3~24^2
(gc: save log from daemonized gc --auto and print it next time,
2015-09-19) addressed this by storing any diagnostic output in
.git/gc.log and allowing the next "git gc --auto" run to print it.

To avoid wasteful repeated fruitless gcs, when gc.log is present, the
subsequent "gc --auto" would die after print its contents.  Most git
commands, such as "git fetch", ignore the exit status from "git gc
--auto" so all is well at this point: the user gets to see the error
message, and the fetch succeeds, without a wasteful additional attempt
at an automatic gc.

External tools like repo[1], though, do care about the exit status
from "git gc --auto".  In non-daemonized mode, the exit status is
straightforward: if there is an error, it is nonzero, but after a
warning like the above, the status is zero.  The daemonized mode, as a
side effect of the other properties provided, offers a very strange
exit code convention:

 - if no housekeeping was required, the exit status is 0

 - the first real run, after forking into the background, returns exit
   status 0 unconditionally.  The parent process has no way to know
   whether gc will succeed.

 - if there is any diagnostic output in gc.log, subsequent runs return
   a nonzero exit status to indicate that gc was not triggered.

There's nothing for the calling program to act on on the basis of that
error.  Use status 0 consistently instead, to indicate that we decided
not to run a gc (just like if no housekeeping was required).  This
way, repo and similar tools can get the benefit of the same behavior
as tools like "git fetch" that ignore the exit status from gc --auto.

Once the period of time described by gc.pruneExpire elapses, the
unreachable loose objects will be removed by "git gc --auto"
automatically.

[1] https://gerrit-review.googlesource.com/c/git-repo/+/10598/

Reported-by: Andrii Dehtiarov <adehtiarov@google.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/gc.c             | 16 +++++++++++-----
 t/t6500-gc.sh            |  6 +++---
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..5eaa4aaa7d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1649,7 +1649,8 @@ will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
-	If the file gc.log exists, then `git gc --auto` won't run
+	If the file gc.log exists, then `git gc --auto` will print
+	its content and exit with status zero instead of running
 	unless that file is more than 'gc.logExpiry' old.  Default is
 	"1.day".  See `gc.pruneExpire` for more ways to specify its
 	value.
diff --git a/builtin/gc.c b/builtin/gc.c
index 2bebc52bda..484ab21b8c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -438,7 +438,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	return NULL;
 }
 
-static void report_last_gc_error(void)
+static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 	ssize_t ret;
@@ -449,7 +449,7 @@ static void report_last_gc_error(void)
 		if (errno == ENOENT)
 			goto done;
 
-		die_errno(_("cannot stat '%s'"), gc_log_path);
+		return error_errno(_("cannot stat '%s'"), gc_log_path);
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
@@ -457,9 +457,9 @@ static void report_last_gc_error(void)
 
 	ret = strbuf_read_file(&sb, gc_log_path, 0);
 	if (ret < 0)
-		die_errno(_("cannot read '%s'"), gc_log_path);
+		return error_errno(_("cannot read '%s'"), gc_log_path);
 	if (ret > 0)
-		die(_("The last gc run reported the following. "
+		return error(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
@@ -469,6 +469,7 @@ static void report_last_gc_error(void)
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
+	return 0;
 }
 
 static void gc_before_repack(void)
@@ -561,7 +562,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			report_last_gc_error(); /* dies on error */
+			if (report_last_gc_error())
+				/*
+				 * A previous gc failed. We've reported the
+				 * error, so there's nothing left to do.
+				 */
+				return 0;
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c474a94a9f..3e62df616c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -116,11 +116,11 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_config gc.autopacklimit 1 &&
 	test_config gc.autodetach true &&
 	echo fleem >.git/gc.log &&
-	test_must_fail git gc --auto 2>err &&
-	test_i18ngrep "^fatal:" err &&
+	git gc --auto 2>err &&
+	test_i18ngrep "^error:" err &&
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =-345600 .git/gc.log &&
-	test_must_fail git gc --auto &&
+	git gc --auto &&
 	test_config gc.logexpiry 2.days &&
 	run_and_wait_for_auto_gc &&
 	ls .git/objects/pack/pack-*.pack >packs &&
-- 
2.18.0.233.g985f88cf7e


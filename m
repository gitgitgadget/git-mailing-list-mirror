Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E1DC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0961861159
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDIAPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIAPq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 20:15:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD40C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 17:15:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g17so3713385edm.6
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 17:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SMiSS8GJgJomOsUZGf1Yl35d5OdLhUlzsWBc8Ur/tvU=;
        b=vJQblYsvKmDAZAocDrQkuy5hHToKwHMXHe6T64GzeZ2yzQf+cup8x0LWxpbqhpjuZo
         wOI4i1F6TG3Py4jOLZwszR15+sWCDzzGBPtgfDxc3l6oMibjjXrSh1W5ub+F0NaW2z1/
         FZXOWeC5yEe1mjrKy70xV8MG+eFXOVK1oxz4/qwryXEoO3cMFCzGJ4PMwVyZ6vmKHyv5
         cu8t474PviTX4Q5Ql5s6OzMH7AlnUYUjIwhbtDda07y68Hc8xTiMWh4p7V7ENJ47JaO8
         b1YE82Ibq+TyAvcp8UaV8mdlT0l/nPx4h8RwwgrTC0xf9qxwnbie8J0RUdIGoPA9QE6l
         5ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SMiSS8GJgJomOsUZGf1Yl35d5OdLhUlzsWBc8Ur/tvU=;
        b=dCrbGJNWE1CzUrWxusjQbq658HPus0TsY5zKkgVL8jGPkim/8FaMjGxk/BxYAQQtVa
         FPnrPH20DYwPUdeu63zPfigpYNna4hMT0hao/hlEJ4KsAY/EHcRk7UHBd2NyyqlP6wG6
         xt3qekWHOpR9lnLLkYNzwPTZId6YrpUpEAOg4e/zkaB8F56zJcXTPy79GA6P1fXofeDP
         xHfNzEHwo5mntb7wfrLAb1tv/UxmpxSuvbzaOf7ZfavghcJkEaFmyHsjDpNZCCkGBYQZ
         fazhcFkFUfn3hGc8aAjPHemo5MdAjSO6JiSw+jSLsCu31wYG2FYZqOQuNbN2DgiWfqyj
         WO9A==
X-Gm-Message-State: AOAM5324gvgk/dwSVMw0drW3vqyoHU3kJfgLvX+lDPeQ8mOxVdftAzGv
        P2tVl6WNeoJ1cEnZTtnAY+0=
X-Google-Smtp-Source: ABdhPJxcLuSpVi4yMcNkKTgPeIuQIuRJbUWuziLgh2T4scQo53K+MFwktjIGprFqTrSyxE2Tf1oZpA==
X-Received: by 2002:aa7:d353:: with SMTP id m19mr11774428edr.172.1617927332660;
        Thu, 08 Apr 2021 17:15:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bh14sm403893ejb.104.2021.04.08.17.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 17:15:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2021, #02; Thu, 8)
References: <xmqqk0pcqtxf.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0pcqtxf.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 02:15:31 +0200
Message-ID: <87r1jkgvoc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Junio C Hamano wrote:

Thanks, brief notes on my topics & some others:

> * ab/unexpected-object-type (2021-03-27) 10 commits
>  - tag: don't misreport type of tagged objects in errors
>  - object tests: add test for unexpected objects in tags
>  - object.c: add and use oid_is_type_or_die_msg() function
>  - object.c: add a utility function for "expected type X, got Y"
>  - tree.c: fix misindentation in parse_tree_gently()
>  - object-name.c: make dependency on object_type order more obvious
>  - object-file.c: make oid_object_info() return "enum object_type"
>  - object.c: make type_from_string() return "enum object_type"
>  - object.c: refactor type_from_string_gently()
>  - object.c: stop supporting len == -1 in type_from_string_gently()
>
>  Error reporting upon object type mismatch has been improved
>
>  Expecting a reroll.
>  cf. <YGBL88lYheyFmwCg@coredump.intra.peff.net>
>  ... we would be much better off to say something like "somebody
>  expected X to be a commit, but now somebody else expects it to be a
>  blob", which is all that we can reliably say.

I split this up and will have a re-submission of it soon.

> * ab/describe-tests-fix (2021-03-01) 10 commits
>  - test-lib: return 1 from test_expect_{success,failure}
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated-tag option to "test_commit"
>  - describe tests: always assert empty stderr from "describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>
>  Various updates to tests around "git describe"
>
>  Expecting a reroll.
>  cf. <xmqq1rcj6hzr.fsf@gitster.g>

Let's discard it for now, I was looking it at today hoping to re-roll it
and saw that it some of the test-lib.sh changes would be a hassle for
me/you to manage with other things I have in-flight.

So I'll either submit it after that, or another version which doesn't
textually/semantically conflict like that, but in any case let's drop
this version.

> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: support early exit in xdiff_outf()
>  - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
>  - pickaxe -S: slightly optimize contains()
>  - pickaxe: rename variables in has_changes() for brevity
>  - pickaxe -S: support content with NULs under --pickaxe-regex
>  - pickaxe: assert that we must have a needle under -G or -S
>  - pickaxe: refactor function selection in diffcore-pickaxe()
>  - perf: add performance test for pickaxe
>  - pickaxe/style: consolidate declarations and assignments
>  - diff.h: move pickaxe fields together again
>  - pickaxe: die when --find-object and --pickaxe-all are combined
>  - pickaxe: die when -G and --pickaxe-regex are combined
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - test-lib functions: add --printf option to test_commit
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib-functions: document and test test_commit --no-tag
>  - grep/pcre2 tests: reword comments referring to kwset
>  - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
>  - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>  Needs (hopefully the final round of) reroll and its review.
>  cf. <xmqqh7ksb5j7.fsf@gitster.g>, <xmqqa6qkb5fi.fsf@gitster.g>, etc.

Will re-roll this soon. Need to get to addressing your outstanding
feedback...

> * es/config-hooks (2021-03-10) 36 commits
>  . run-command: stop thinking about hooks
>  . git-send-email: use 'git hook run' for 'sendemail-validate'
>  . bugreport: use hook_exists instead of find_hook
>  . receive-pack: convert receive hooks to hook.h
>  . post-update: use hook.h library
>  . proc-receive: acquire hook list from hook.h
>  . receive-pack: convert 'update' hook to hook.h
>  . reference-transaction: look for hooks in config
>  . transport: convert pre-push hook to use config
>  . hook: convert 'post-rewrite' hook to config
>  . hooks: convert 'post-checkout' hook to hook library
>  . git-p4: use 'git hook' to run hooks
>  . receive-pack: convert push-to-checkout hook to hook.h
>  . read-cache: convert post-index-change hook to use config
>  . rebase: teach pre-rebase to use hook.h
>  . gc: use hook library for pre-auto-gc hook
>  . merge: use config-based hooks for post-merge hook
>  . am: convert applypatch hooks to use config
>  . commit: use config-based hooks
>  . hooks: allow callers to capture output
>  . run-command: allow capturing of collated output
>  . hook: provide stdin by string_list or callback
>  . run-command: add stdin callback for parallelization
>  . hook: allow specifying working directory for hooks
>  . hook: allow parallel hook execution
>  . run-command: allow stdin for run_processes_parallel
>  . hook: support passing stdin to hooks
>  . hook: introduce hook_exists()
>  . hook: add 'run' subcommand
>  . parse-options: parse into strvec
>  . hook: implement hookcmd.<name>.skip
>  . hook: teach hook.runHookDir
>  . hook: include hookdir hook in list
>  . hook: add list command
>  . hook: scaffolding for git-hook subcommand
>  . doc: propose hooks managed by the config
>
>  The "hooks defined in config" topic.

FWIW I commented a bit on the status just now in another thread here:
https://lore.kernel.org/git/87tuoggwmy.fsf@evledraar.gmail.com/

> * ds/maintenance-prefetch-fix (2021-04-06) 5 commits
>  - maintenance: allow custom refspecs during prefetch
>  - test-tool: test refspec input/output
>  - refspec: output a refspec item
>  - test-lib: use exact match for test_subcommand
>  - maintenance: simplify prefetch logic
>
>  The prefetch task in "git maintenance" assumed that "git fetch"
>  from any remote would fetch all its local branches, which would
>  fetch too much if the user is interested in only a subset of
>  branches there.
>
>  Expecting a reroll.
>  cf. <35fa99cf-ba24-f13e-0607-f9acce2905cf@gmail.com>

And, just to add to your note, also the back & forth thread about the
need/design for the new refspec.c API here:
https://lore.kernel.org/git/xmqqsg41ut72.fsf@gitster.g/

> * ab/complete-cherry-pick-head (2021-04-07) 1 commit
>  - bash completion: complete CHERRY_PICK_HEAD
>
>  The command line completion (in contrib/) has learned that
>  CHERRY_PICK_HEAD is a possible pseudo-ref.
>
>  Will merge to 'next'?

I think so, it's trivial :)

FWIW to your suggestion of completion instead checking *_HEAD: As part
of another (abandoned for now) topic of mine I tried to exhaustively
enumerate all the magic all-caps refs just the test suite generates in
.git/FILE, and it's quite a big list.

So I found listing a new known one less scary.

Also, even though the bash completion is pretty bad about it now, I
thinkw we should aim more for it not needing to hit disk for completing
a thing like "git show REBASE_HE<TAB>" (which it'll needlessly do now).

> * ab/send-email-validate-errors (2021-04-06) 3 commits
>   (merged to 'next' on 2021-04-06 at d7fb1dbde0)
>  + git-send-email: improve --validate error output
>  + git-send-email: refactor duplicate $? checks into a function
>  + git-send-email: test full --validate output
>  (this branch uses ab/perl-do-not-abuse-map.)
>
>  Clean-up codepaths that implements "git send-email --validate"
>  option and improves the message from it.
>
>  Will merge to 'master'.

Thanks. FWIW I kept hacking on send-email a bit, and have some local
patches that bring the runtime of t9001-send-email.sh from 30 seconds to
13, and a typical invocation time for git-send-email from ~250ms on my
box to ~40-60ms).

> * ab/userdiff-tests (2021-04-08) 9 commits
>  - blame tests: simplify userdiff driver test
>  - blame tests: don't rely on t/t4018/ directory
>  - userdiff: remove support for "broken" tests
>  - userdiff tests: list builtin drivers via test-tool
>  - userdiff tests: explicitly test "default" pattern
>  - userdiff: add and use for_each_userdiff_driver()
>  - userdiff style: normalize pascal regex declaration
>  - userdiff style: declare patterns with consistent style
>  - userdiff style: re-order drivers in alphabetical order
>
>  A bit of code clean-up and a lot of test clean-up around userdiff
>  area.
>
>  Will merge to 'next'?

Please :)

But perhaps Jeff King would like to look it over first...

> * gk/gitweb-redacted-email (2021-03-31) 1 commit
>  - gitweb: add "e-mail privacy" feature to redact e-mail addresses
>
>  "gitweb" learned "e-mail privacy" feature to redact strings that
>  look like e-mail addresses on various pages.
>
>  Waiting for reviews.
>  cf. <xmqq5z19k9wu.fsf@gitster.g>

FWIW it seems it's now past that per
https://lore.kernel.org/git/xmqqblaoqtjf.fsf@gitster.g/ and this note
was added before that update to the thread.

I know you know that, just noting that for the benefit of others who are
following along.

> * en/ort-readiness (2021-03-20) 13 commits
>  - Add testing with merge-ort merge strategy
>  - t6423: mark remaining expected failure under merge-ort as such
>  - Revert "merge-ort: ignore the directory rename split conflict for now"
>  - merge-recursive: add a bunch of FIXME comments documenting known bugs
>  - merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
>  - t: mark several submodule merging tests as fixed under merge-ort
>  - merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
>  - t6428: new test for SKIP_WORKTREE handling and conflicts
>  - merge-ort: support subtree shifting
>  - merge-ort: let renormalization change modify/delete into clean delete
>  - merge-ort: have ll_merge() use a special attr_index for renormalization
>  - merge-ort: add a special minimal index just for renormalization
>  - merge-ort: use STABLE_QSORT instead of QSORT where required
>  (this branch is used by en/ort-perf-batch-11; uses en/ort-perf-batch-10.)
>
>  Plug the ort merge backend throughout the rest of the system, and
>  start testing it as a replacement for the recursive backend.
>
>  Will merge to 'next'?

I'd like that, some of the ORT code is over my head currently, but
having it tested by default would be very beneficial to smoke out any
bugs sooner than later.

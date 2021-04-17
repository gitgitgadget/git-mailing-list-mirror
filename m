Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB84C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AA961027
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 13:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDQNUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhDQNUG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 09:20:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42603C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 06:19:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g5so39382108ejx.0
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LqJ5lUk3Dyc+2IPJOEu7xsxMIsYRi7gx+G9m4Gozk38=;
        b=hZgm1XASgcH3pm+HXbFgFD/99OrxFE5IT5PBTZ/LB1YdV6bktqqsTDjD/wqT15lmTm
         7n8mI/9Q2slsHQqIKu6gB16znz0vQnn2tzLWGa6O5sXNeXa7UlDfOobv/AsOGhn3gLQU
         WrNnsD6t/dqP6NPSt7DiMLfeJidEVv3sYOUfmsV3Cm6jCjrSpaRocPmm97F89OzadeX9
         JfubhkzY407oRHnKC9cmNDwwYSGCnlJssRvUJ3eyB1HHWXIX0J93yt77FafclMKDfW7N
         PytLcDLd2r5bj01q+X5dnujIyif3E9efNs4Lg56utgzUILO8ovziIzXGKhe4Pq6C4GOn
         P8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LqJ5lUk3Dyc+2IPJOEu7xsxMIsYRi7gx+G9m4Gozk38=;
        b=YA4iXVhDLC/TwsfqMbcqIQFora/M6F7eR87rCxpFlZa0VwQIQGSE6hiYVEqyWVyI+q
         7sJ8do+dxTpPq0ofMgU/MOYHojjoV1D4Mu+51RoygGUT3Coz4d89j13IRmLtEt4sqE9+
         2ZmFPJQmh2YzV3/s6EvE97rgNVhNH5k9mzYHXo/QDa7lei8nfUnPaJqTa3rldjL497my
         l8M4+uYx58tYEbhUNPv06Z3q/uCFoLSKZAOZIt1/gGl9Ikoc9LJOoa27/55EsIE0vXgN
         pyhyrtiLq9v671jCCg9bVs4ygaAxXT6RI9ro4c/KtaR2blkaunCDDASYvgJ2XI5eH+ix
         tkQg==
X-Gm-Message-State: AOAM533xRsGl71P4mf+5cRxi9ErCHEJss+w3fZoiYIxpycgyRuKklxPH
        1cUTQ12C6NLiCwdK5Pg/QrI=
X-Google-Smtp-Source: ABdhPJx0ZXOLZ8PQzfpjN3cHsmqaVc5Y4jje5B878S1Ys3oq89ktAJTsfzyfsBSrJRpSWDa5t0ln/g==
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr13419745ejy.350.1618665577915;
        Sat, 17 Apr 2021 06:19:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d1sm7249629ede.31.2021.04.17.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:19:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
References: <xmqqa6pznlgq.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6pznlgq.fsf@gitster.g>
Date:   Sat, 17 Apr 2021 15:19:36 +0200
Message-ID: <87mttx121j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 16 2021, Junio C Hamano wrote:

Comments on my outstanding to clarify/help things along:

> * ab/fsck-unexpected-type (2021-04-13) 6 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object typesn
>  - fsck tests: refactor one test to use a sub-repo
>  - cache.h: move object functions to object-store.h
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.

There was a discussion on the v1 about the now-gone bug() v.s. BUG()
function, but the only comment on this part was a trivial commit message
suggestion from Johannes Sixt.

Jeff King: Did you read/review too & had nothing more to add, or is it
unreviewed?

> * ab/usage-error-docs (2021-04-13) 3 commits
>   (merged to 'next' on 2021-04-15 at dbbbaa5eea)
>  + api docs: document that BUG() emits a trace2 error event
>  + api docs: document BUG() in api-error-handling.txt
>  + usage.c: don't copy/paste the same comment three times
>
>  Documentation updates, with unrelated comment updates, too.
>
>  Will merge to 'master'.

The series-that-used-to-have-bug()-function noted above.

> [Stalled]

So the below of mine is "stalled", understandably since much of it
relied on some just-re-rolled test-lib.sh changes. Notes below:

> * ab/unexpected-object-type (2021-04-14) 11 commits
>  - fixup! object.c: stop supporting len == -1 in type_from_string_gently()
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

I have a re-roll of this, sorry about the semantic conflict, the re-roll
fixes that & more (the "more" makes it easier to merge/coordinate with
othen in-flight).

I'm waiting on a re-roll of this on some comments from brian m. carlson
to my https://lore.kernel.org/git/8735vq2l8a.fsf@evledraar.gmail.com/

I.e. the changes I have now would conflict with his
builtin/hash-object.c, but those changes seem like they could be done in
a better way (and my RFC of that alternate approach makes a TODO test of
his pass).

> * ab/describe-tests-fix (2021-04-12) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"

This depended on my just-re-rolled:
https://lore.kernel.org/git/cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com/

But for this series I've got nothing new to add, and I think it's all
been reviewed already, so hopefully this will get it moving.

> * ab/pickaxe-pcre2 (2021-04-12) 22 commits
>  - xdiff-interface: replace discard_hunk_line() with a flag
>  - xdiff users: use designated initializers for out_line
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: allow early return from xdiff_emit_line_fn
>  - xdiff-interface: prepare for allowing early return
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
>  - pickaxe tests: add missing test for --no-pickaxe-regex being an error
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - grep/pcre2 tests: reword comments referring to kwset
>  (this branch uses ab/test-lib-updates.)
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.

Ditto for this series, i.e. it needed ab/test-lib-updates. There's no
outstanding comments on it, but of course that could just mean "not
enough review".

If anyone here cares about "git log -G" performance review this, because
it doesn't make it better, but is needed for a series of mine that does
improve it.

> * ab/doc-lint (2021-04-10) 7 commits
>  - docs: fix linting issues due to incorrect relative section order
>  - doc lint: lint relative section order
>  - doc lint: lint and fix missing "GIT" end sections
>  - doc lint: fix bugs in, simplify and improve lint script
>  - doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
>  - Documentation/Makefile: make doc.dep dependencies a variable again
>  - Documentation/Makefile: make $(wildcard howto/*.txt) a var
>
>  Dev support.
>
>  Waiting for reviews to conclude.

FWIW I think the earlier version of this got thorough reviews, this
version is the same with trivial changes, plus two patches at the end to
add another lint check for doc section order:
https://lore.kernel.org/git/patch-6.7-8c294afe2a-20210409T145728Z-avarab@gmail.com/

> * ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
>  - rebase: don't override --no-reschedule-failed-exec with config
>  - rebase tests: camel-case rebase.rescheduleFailedExec consistently
>
>  "git rebase --[no-]reschedule-failed-exec" did not work well with
>  its configuration variable, which has been corrected.
>
>  Waiting for reviews to conclude.

Phillip Wood helped this along, and it looks good to him now:
https://lore.kernel.org/git/63774b95-7de2-b160-385b-6c7d99e867ed@gmail.com/

> * ab/svn-tests-set-e-fix (2021-04-12) 2 commits
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>
>  Test clean-up.
>
>  Waiting for reviews.

Eric Wong looked the pre-split v1 of this over and it looked good to
him: https://lore.kernel.org/git/20210228211407.GA3214@dcvr/

The v1 has no changes except the specific s/touch /> / pointed out to
him, and a commit message update:
https://lore.kernel.org/git/cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com/

> * ab/test-lib-updates (2021-04-12) 16 commits
>  - test-lib-functions: remove last two parameter count assertions
>  - Revert and amend "test-lib-functions: assert correct parameter count"
>  - test-lib-functions: use "return 1" instead of "false"
>  - test-lib-functions: normalize test_path_is_missing() debugging
>  - test-lib: modernize test_create_repo() function
>  - test-lib: do not show advice about init.defaultBranch under --verbose
>  - test-lib: reformat argument list in test_create_repo()
>  - submodule tests: use symbolic-ref --short to discover branch name
>  - test-lib functions: add --printf option to test_commit
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated-tag option to "test_commit"
>  - test-lib-functions: document test_commit --no-tag
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>  - test-lib: bring $remove_trash out of retirement
>  - check-non-portable-shell: complain about "test" a/-o instead of &&/||
>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>
>  Test clean-up.
>
>  Waiting for reviews.

As noted above, re-rolled just now as
https://lore.kernel.org/git/cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com/

> * ab/userdiff-tests (2021-04-08) 9 commits
>   (merged to 'next' on 2021-04-13 at 35fb0e853d)
>  + blame tests: simplify userdiff driver test
>  + blame tests: don't rely on t/t4018/ directory
>  + userdiff: remove support for "broken" tests
>  + userdiff tests: list builtin drivers via test-tool
>  + userdiff tests: explicitly test "default" pattern
>  + userdiff: add and use for_each_userdiff_driver()
>  + userdiff style: normalize pascal regex declaration
>  + userdiff style: declare patterns with consistent style
>  + userdiff style: re-order drivers in alphabetical order
>
>  A bit of code clean-up and a lot of test clean-up around userdiff
>  area.
>
>  Will merge to 'master'.

Thanks!

In this window I also had this trivial git-send-email series:
https://lore.kernel.org/git/cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com/

You had a comment on it, but per my reply in
https://lore.kernel.org/git/8735vwfvln.fsf@evledraar.gmail.com/ I think
it makes sense to just pick it up as-is.

It will make Drew DeVault's work in the still-outstanding
https://lore.kernel.org/git/20210411125431.28971-1-sir@cmpwn.com/
easier.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF61EC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A786113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDTNxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhDTNxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:53:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F9C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:52:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w23so42590707ejb.9
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4p9QkTtXaUVBN2Ajlv374RoZDXwJhJWIoi5u17ElbeI=;
        b=dSjJhPkAeAFhmPXGGzOglQhJKHj+5AHO+qME81L31rdsAvwdEttB//DI3MyTvPTGdo
         0rgjVx/s0VoPjoRCoVxTQ8OPSqXBBVw0pqUb5cTOY2zhSKI3HEMMFan88ddnEZBgZmch
         HsB124lupObUSgHvLpkmbAO+T/r5lVhJV0r23s311duSxnoNbnRGhH2ucFVzoZJXcb7F
         EiGGA8Ny3RF+aufryF6mzYCYoRwDNXRgZdmFOUXFW9ZbBEPcQQwRgrPS3diyNcSZK/AM
         UuGDPsWFkuJ/tUNwZnYp7QbwgccpuWNHx0zWTmzxGG9Aakpql1GST8K87U0GYTx16BEj
         BfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4p9QkTtXaUVBN2Ajlv374RoZDXwJhJWIoi5u17ElbeI=;
        b=N2JnsvHYrtCqWoXdvb+3kADK5puIdMRxjet9bXgL4o4lDz5UdsQP0XFzBmyRz50jYA
         E/RFaSf/ICnTS9uEfittwiVX4tNiMQ4HM8qKnIOVRIJncRcqM0vx7O0vPyDCJkK/1Qci
         kKX7D2xqkj9AuJ7wWTgCthAmzU1OH81qXmuSWxVjdF9nYiNZznVMnIGXNq5Iz2LgbH/j
         eOOmcee2YTnVDLbpGSsnTyxctm8vSfhFZ1QbAd7GQiAgxL8KXaHONXnL3xqyizvR9pPg
         NBp93WnVRQLxyqFKeOpPm/dr7NUmDYNj8KCzS4Mf7P6TosBYu9rBJ6J+ElinyzTHVAMe
         pe3A==
X-Gm-Message-State: AOAM532Kj+jY94oi10vZdkKb2qXxOtFTz5AKOX2bbXqsSx55HzqKU9ci
        Q0AYRBZueov8RctDuIldwLU=
X-Google-Smtp-Source: ABdhPJzodfaTh6jUdYY2uEBdNMdMv/81XoRr4SU3MmFGJ5CcPjh1kMA10QfeZ/4NfxxqqUO2Z7QXXQ==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr27348134ejb.542.1618926754282;
        Tue, 20 Apr 2021 06:52:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m14sm16033362edd.63.2021.04.20.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:52:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
References: <xmqqtuo17t6t.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtuo17t6t.fsf@gitster.g>
Date:   Tue, 20 Apr 2021 15:52:33 +0200
Message-ID: <87mttt2hcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 20 2021, Junio C Hamano wrote:

Comments on my outstanding serieses and related (you've indicated that
this summary was helpful, so I'll keep doing it).

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

For the v1 of this I see you picked up the middle of 3 serieses I
submitted one on top of each other, and of course the need for the
"fixup!" commit on top.

I've just re-rolled these three at:

 * https://lore.kernel.org/git/cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com
 * https://lore.kernel.org/git/cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com
 * https://lore.kernel.org/git/cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com

Hopefully you'll see fit to pick up all 3x this time. As noted before
these are all prep changes for some larger fsck changes where we
misreport object types in various cases.

> * bc/hash-transition-interop-part-1 (2021-04-19) 17 commits
>  - http-push: set algorithm when reading object ID
>  - fixup! hash: provide per-algorithm null OIDs
>  - hex: print objects using the hash algorithm member
>  - hex: default to the_hash_algo on zero algorithm value
>  - builtin/pack-objects: avoid using struct object_id for pack hash
>  - commit-graph: don't store file hashes as struct object_id
>  - builtin/show-index: set the algorithm for object IDs
>  - hash: provide per-algorithm null OIDs
>  - hash: set and copy algo field in struct object_id
>  - cache: compare the entire buffer for struct object_id
>  - builtin/pack-redundant: avoid casting buffers to struct object_id
>  - Use the final_oid_fn to finalize hashing of object IDs
>  - hash: add a function to finalize object IDs
>  - Always use oidread to read into struct object_id
>  - cache: add an algo member to struct object_id
>  - builtin/hash-object: allow literally hashing with a given algorithm
>  - sha1-file: allow hashing objects literally with any algorithm
>
>  SHA-256 transition.
>
>  Expecting a reroll.
>  cf. <YHzmjhLy2QjDefXy@camp.crustytoothpaste.net>

This has a textual conflict (no longer a semantic one) with the above
ab/unexpected-object-type etc.

As noted in
https://lore.kernel.org/git/87mttx121j.fsf@evledraar.gmail.com/ I had
questions about the approach in hash-object.c, in particular I have
POC/WIP patches that make one of brian's TODO tests pass, by doing the
"we are in SHA256 mode" earlier, which is also less code as we won't
need to add special handling to a large part of hash-object.c (or, in
the future, other such commands).

> * ab/describe-tests-fix (2021-04-12) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"

As noted in my reply to the last "What's Cooking" at
https://lore.kernel.org/git/87mttx121j.fsf@evledraar.gmail.com/ this
depends on ab/test-lib-updates.

I've re-rolled that today at at
https://lore.kernel.org/git/cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com/

But AFAICT this topic is ready & needs no further changes.

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

From my last reply to WC above:

    Ditto for this series, i.e. it needed ab/test-lib-updates. There's
    no outstanding comments on it, but of course that could just mean
    "not enough review".

    If anyone here cares about "git log -G" performance review this,
    because it doesn't make it better, but is needed for a series of
    mine that does improve it.

> * ab/detox-gettext-tests (2021-04-13) 1 commit
>   (merged to 'next' on 2021-04-15 at db0da2903a)
>  + tests: remove all uses of test_i18cmp
>
>  Test clean-up.
>
>  Will merge to 'master'.

Thanks.

> * ab/fsck-unexpected-type (2021-04-13) 6 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object types
>  - fsck tests: refactor one test to use a sub-repo
>  - cache.h: move object functions to object-store.h
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.

Jeff King: *re-poke* per the mention the last WC: I.e. did you review
this?

> * ab/usage-error-docs (2021-04-13) 3 commits
>   (merged to 'next' on 2021-04-15 at dbbbaa5eea)
>  + api docs: document that BUG() emits a trace2 error event
>  + api docs: document BUG() in api-error-handling.txt
>  + usage.c: don't copy/paste the same comment three times
>
>  Documentation updates, with unrelated comment updates, too.
>
>  Will merge to 'master'.

Thanks.

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

From my last reply to WC above:

    FWIW I think the earlier version of this got thorough reviews, this
    version is the same with trivial changes, plus two patches at the
    end to add another lint check for doc section order:
    https://lore.kernel.org/git/patch-6.7-8c294afe2a-20210409T145728Z-avarab@gmail.com/

> * ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
>  - rebase: don't override --no-reschedule-failed-exec with config
>  - rebase tests: camel-case rebase.rescheduleFailedExec consistently
>
>  "git rebase --[no-]reschedule-failed-exec" did not work well with
>  its configuration variable, which has been corrected.
>
>  Waiting for reviews to conclude.

From my last reply to WC above:

    Phillip Wood helped this along, and it looks good to him now:
    https://lore.kernel.org/git/63774b95-7de2-b160-385b-6c7d99e867ed@gmail.com/

> * ab/svn-tests-set-e-fix (2021-04-12) 2 commits
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>
>  Test clean-up.
>
>  Waiting for reviews.
>  cf. <87mttx121j.fsf@evledraar.gmail.com>

From my last reply to WC above:

    Eric Wong looked the pre-split v1 of this over and it looked good to
    him: https://lore.kernel.org/git/20210228211407.GA3214@dcvr/

    The v1 has no changes except the specific s/touch /> / pointed out
    to him, and a commit message update:
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
>  Waiting for review discussion to conclude.

I think with my re-roll today at
https://lore.kernel.org/git/cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com/
there's no further outstanding issues.

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

Thanks.

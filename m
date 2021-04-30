Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74721C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C961151
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhD3KNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 06:13:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5617C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 03:12:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id zg3so22819809ejb.8
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:newsgroups:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pSwuauQf3P9R88ipkWgC6qbRdBwfQ3UIM9K7JubYMiA=;
        b=NeoRx5VvtYN9B2FA6poC8Z4d7Yf+dfUU0QpSZfg6bqrYrkfBw0YRkbb1rdQv3+gtXG
         IRyZaSJBDS1uIoYIj1pE82rMCgr0hlgWpyOyzikJ5VFWnWrlOU74n769f6Q7VnCT4uT2
         LIWeAE6eJe05x18JmIMXj3gBsMID+KZKQbQ6hIApNjvB4iT3waMpb/G+BMGSYwREqBx7
         mAouA/IiDG8q5ejC0nyFsCQAzJBcqwjAsNqv+xYBPojbhV3mJQFxfdHr0SEs84BpDc21
         77Em53uOGtcbrLL9YvSAoCUnr/Ub/qfDn6PPq4DSjM/b1clJSYzNFrNIuKQWj/9VhkyH
         O7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:newsgroups:to:cc:subject:date:references
         :user-agent:in-reply-to:message-id:mime-version;
        bh=pSwuauQf3P9R88ipkWgC6qbRdBwfQ3UIM9K7JubYMiA=;
        b=XDKN0WCBerfnrZEXq3DniitD0sADDQfotTBv3KSe5X5Gf6kvUcDo13QTl5HY6g3S28
         mv0BW28ODwR4FtI6dWumiGo1MYo+J73YPTIx8Hd8NQS3DoqdhKgKFyVEDrT5gxLiezPv
         Q7WnEsDGtIL5w8Dwlew86t27S90c3SMaRHjTp6hOP1XG7XvqIMINF5CBIlvYDgM1edfO
         IWbzWAnFq9pg1ei0/DOv5p9C59OKynbusUSN15cAZdpJ1GRyckwShcDIf/CbF8vwHJ6J
         0Rx3SBPpIs3QOICEsK1dSxLyNgxgVVh6mk9qABWd7sE8angfpZRezjQ6qn476yO3r2wJ
         HZEg==
X-Gm-Message-State: AOAM533jubXZxT4vayD9PzaRNbSAJgtweKTURH52UFbL1PMTlrrqjn7e
        RXWawRKFU5RjppnTmh5N9tA=
X-Google-Smtp-Source: ABdhPJxYE/NsmjdVe5zW6hUQTXUEvIg8hfOd8DIerc3sXnguuYtxGX0gl3+sTdCQjRg4/8Py7yvKfw==
X-Received: by 2002:a17:906:c0d6:: with SMTP id bn22mr2698835ejb.267.1619777539372;
        Fri, 30 Apr 2021 03:12:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h15sm1612390ejs.72.2021.04.30.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 03:12:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Newsgroups: 
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
Date:   Fri, 30 Apr 2021 11:34:39 +0200
References: <xmqqr1itfo41.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqr1itfo41.fsf@gitster.g>
Message-ID: <87im44xerh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 29 2021, Junio C Hamano wrote:

Updates on my topics & other things I have comments on:
> * hn/reftable-tables-doc-update (2021-04-12) 1 commit
>   (merged to 'next' on 2021-04-13 at cdadb2c621)
>  + reftable: document an alternate cleanup method on Windows
>
>  Doc updte.

In case it makes it into release notes: s/updte/update/;

> * dl/complete-stash-updates (2021-04-27) 4 commits
>  - git-completion.bash: consolidate cases in _git_stash()
>  - git-completion.bash: use $__git_cmd_idx in more places
>  - git-completion.bash: rename to $__git_cmd_idx
>  - git-completion.bash: separate some commands onto their own line
>  (this branch uses dl/complete-stash.)
>
>  Further update the command line completion (in contrib/) for "git
>  stash".
>
>  Will merge to 'next'?

I think so, I reviewed this and it looks good to me.

> * ab/pretty-date-format-tests (2021-04-27) 2 commits
>  - pretty tests: give --date/format tests a better description
>  - pretty tests: simplify %aI/%cI date format test
>  (this branch is used by zh/pretty-date-human.)
>
>  Tweak a few tests for "log --format=..." that show timestamps in
>  various formats.
>
>  Will merge to 'next'.

Thanks. Good to know not all my "I read this series and here's some
small patches ..." are a distraction :)

> * ls/subtree (2021-04-28) 30 commits
>  - subtree: be stricter about validating flags
>  - subtree: push: allow specifying a local rev other than HEAD
>  - subtree: allow 'split' flags to be passed to 'push'
>  - subtree: allow --squash to be used with --rejoin
>  - subtree: give the docs a once-over
>  - subtree: have $indent actually affect indentation
>  - subtree: don't let debug and progress output clash
>  - subtree: add comments and sanity checks
>  - subtree: remove duplicate check
>  - subtree: parse revs in individual cmd_ functions
>  - subtree: use "^{commit}" instead of "^0"
>  - subtree: don't fuss with PATH
>  - subtree: use "$*" instead of "$@" as appropriate
>  - subtree: use more explicit variable names for cmdline args
>  - subtree: use git-sh-setup's `say`
>  - subtree: use `git merge-base --is-ancestor`
>  - subtree: drop support for git < 1.7
>  - subtree: more consistent error propagation
>  - subtree: don't have loose code outside of a function
>  - subtree: t7900: add porcelain tests for 'pull' and 'push'
>  - subtree: t7900: add a test for the -h flag
>  - subtree: t7900: rename last_commit_message to last_commit_subject
>  - subtree: t7900: fix 'verify one file change per commit'
>  - subtree: t7900: delete some dead code
>  - subtree: t7900: use 'test' for string equality
>  - subtree: t7900: comment subtree_test_create_repo
>  - subtree: t7900: use consistent formatting
>  - subtree: t7900: use test-lib.sh's test_count
>  - subtree: t7900: update for having the default branch name be 'main'
>  - .gitignore: ignore 'git-subtree' as a build artifact
>
>  "git subtree" updates.
>
>  Will merge to 'next'?
>  Unless somebody familiar with subtree speaks up soon and causes a
>  reroll.

I had some nit-y comments on it, I more skimmed it than did a full revie
on it, but overall it looks good / reasonable to me.

> * zh/pretty-date-human (2021-04-27) 1 commit
>  - pretty: provide human date format
>  (this branch uses ab/pretty-date-format-tests.)
>
>  "git log --format=..." placeholders learned %ah/%ch placeholders to
>  request the --date=human output.
>
>  Will merge to 'next'?

Looks good to me.

> * ab/describe-tests-fix (2021-04-29) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"
>
>
> * ab/pickaxe-pcre2 (2021-04-29) 22 commits
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

Hopefully the ab/test-lib-updates moving forward will un-stall these
(comment on that below...).

> * ps/config-env-option-with-separate-value (2021-04-19) 2 commits
>  - git: support separate arg for `--config-env`'s value
>  - git.txt: fix synopsis of `--config-env` missing the equals sign
>
>  "git --config-env var=val cmd" weren't accepted (only
>  --config-env=var=val was).
>
>  Will merge to 'next'.
>  possibly with minimum fix-up?
>  cf. <YIKcZxEDsG7qsE4G@coredump.intra.peff.net>

I also looked this over, LGTM.

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
>
>  Expecting a reroll.

Have a local version of this partially re-done for a re-roll...

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
>  Will merge to 'next'.

Thanks, I have some other doc improvements waiting on this.

> * ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
>  - rebase: don't override --no-reschedule-failed-exec with config
>  - rebase tests: camel-case rebase.rescheduleFailedExec consistently
>
>  "git rebase --[no-]reschedule-failed-exec" did not work well with
>  its configuration variable, which has been corrected.
>
>  Will merge to 'next'.

Thanks.

> * bc/hash-transition-interop-part-1 (2021-04-27) 13 commits
>  - hex: print objects using the hash algorithm member
>  - hex: default to the_hash_algo on zero algorithm value
>  - builtin/pack-objects: avoid using struct object_id for pack hash
>  - commit-graph: don't store file hashes as struct object_id
>  - builtin/show-index: set the algorithm for object IDs
>  - hash: provide per-algorithm null OIDs
>  - hash: set, copy, and use algo field in struct object_id
>  - builtin/pack-redundant: avoid casting buffers to struct object_id
>  - Use the final_oid_fn to finalize hashing of object IDs
>  - hash: add a function to finalize object IDs
>  - http-push: set algorithm when reading object ID
>  - Always use oidread to read into struct object_id
>  - hash: add an algo member to struct object_id
>
>  SHA-256 transition.
>
>  Will merge to 'next'?

This looks good to me. An earier version had some hash-object.c changes
that conflicted with a series of mine, that's now no longer there. I
still need to get back to seeing what (if anything) I need to do to
follow-up on that alternate way of specifying the hash version via an
argument to "git", or if brian was going to tackle it...


> * ab/svn-tests-set-e-fix (2021-04-12) 2 commits
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>
>  Test clean-up.
>
>  Will merge to 'next'.

Thanks.

> * ab/test-lib-updates (2021-04-29) 11 commits
>  - test-lib: split up and deprecate test_create_repo()
>  - test-lib: do not show advice about init.defaultBranch under --verbose
>  - test-lib: reformat argument list in test_create_repo()
>  - submodule tests: use symbolic-ref --short to discover branch name
>  - test-lib functions: add --printf option to test_commit
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated option to "test_commit"
>  - test-lib-functions: document test_commit --no-tag
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>  - test-lib: bring $remove_trash out of retirement
>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>
>  Test clean-up.
>
>  Waiting for an Ack before merging them to 'next'.

Is the ack a reply to
https://lore.kernel.org/git/xmqqo8dx7dv4.fsf@gitster.g/ (or here, I
suppose)?. Sorry about the in-flight hassle.

But yes, I think from the reviews etc. this is ready for "next" at this
point.

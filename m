Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB1C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AA06135B
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhETMbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhETMbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:31:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA3C0363D8
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:32:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p24so23456982ejb.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CcmkPabBZbQdKm2BE5KZC+9KH92VaDHilX8P25yyb1k=;
        b=AnXh/vzHMc4UKpFnJuN+GjmGSXrLSEr4xpFkDKjbjP6TqAkAf/ArgsYqVzk2baTa77
         H0ASGBJNG+x+BeGQfN6kJOGpacer5vvweXKadygVyT5qEMUor5OkDHZhQP/+SCQv2L7i
         Kv3SBQHfHovcfCMbC7P7VHf4bVb85YjdT/Dq3jJ1ap2MMss863sEuTCbmkKKmX3n/Iuh
         q0/yKWyZ4gvRJK7pBOm15xMrTbSAS2PgAumyyBRSyYEdYc9Dl54egaQov2ywq0Tepfty
         UKNq5isleSCY/+XetdSKSmWjBSNs+hyelFM9HhoW7dOkD1cx+VFruMgbIfl7t/MgvWD5
         2MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CcmkPabBZbQdKm2BE5KZC+9KH92VaDHilX8P25yyb1k=;
        b=Nul/ELHZJON0aWzRTWe2Jdl6uqRJt5qR3beA0LB8AQEb2Ftt4tB9/QerzbgHj6lTWy
         BAjyAVepKjU1iRLFGg10r8K0514ODf42DgHqewAUx7VW0WSho+cCZ2BLnrWfQRE/lYXj
         WhcloqEXBAdHaKimgVLNHUmilulx3VjjP0Q+QAJ8e9Ab6WtRlY1bLTe4OXyjVeIhiwbP
         OsR+5Pb58okSYnFjtfc9mcUlbs/sJ36gB9plmNzx3gtrbL54dkorN3F0p50WlFOjSt8N
         blDmcLU1ZTXKM2tNT1MbSQPHVRk5IvoElYbkpbEra92PZKnTnQprsl3qe/qt2QTL4/Oo
         ZXJg==
X-Gm-Message-State: AOAM5317Z+MnWOt+0Dn2AnC18X5O2iN03qWp1h22wTHKv556AFoqYXUl
        kK4e0A5X5d336LRdktzyvsh63KFK0wwLGA==
X-Google-Smtp-Source: ABdhPJyLgVw1RNwxjuu991qk5zOztU7acjN9Nf+cvBeXG/zLcV12v3VHHLqTuJipvq2y9iDo2CGWVA==
X-Received: by 2002:a17:906:ae10:: with SMTP id le16mr4187439ejb.296.1621510328894;
        Thu, 20 May 2021 04:32:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n17sm1335232eds.72.2021.05.20.04.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:32:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2021, #03; Thu, 20)
Date:   Thu, 20 May 2021 13:25:03 +0200
References: <xmqqtumyulv8.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqtumyulv8.fsf@gitster.g>
Message-ID: <87cztlr688.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 20 2021, Junio C Hamano wrote:

A brief summary of my outstanding stuff:

> * ab/perl-makefile-cleanup (2021-05-13) 5 commits
>   (merged to 'next' on 2021-05-13 at 6cf377a1bc)
>  + Makefile: make PERL_DEFINES recursively expanded
>   (merged to 'next' on 2021-05-10 at 23b48398e6)
>  + perl: use mock i18n functions under NO_GETTEXT=Y
>  + Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
>  + Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
>  + Makefile: don't re-define PERL_DEFINES
>
>  Build procedure clean-up.
>
>
> * ab/sparse-index-cleanup (2021-05-06) 1 commit
>   (merged to 'next' on 2021-05-10 at bbb0239571)
>  + sparse-index.c: remove set_index_sparse_config()
>
>  Code clean-up.
>
>
> * ab/streaming-simplify (2021-05-06) 5 commits
>   (merged to 'next' on 2021-05-07 at 0992a78c75)
>  + streaming.c: move {open,close,read} from vtable to "struct git_istream"
>  + streaming.c: stop passing around "object_info *" to open()
>  + streaming.c: remove {open,close,read}_method_decl() macros
>  + streaming.c: remove enum/function/vtbl indirection
>  + streaming.c: avoid forward declarations

Thanks!

> * ab/send-email-optim (2021-05-13) 9 commits
>  - send-email: move trivial config handling to Perl
>  - perl: lazily load some common Git.pm setup code
>  - send-email: lazily load modules for a big speedup
>  - send-email: get rid of indirect object syntax
>  - send-email: use function syntax instead of barewords
>  - send-email: lazily shell out to "git var"
>  - send-email: lazily load config for a big speedup
>  - send-email: refactor sendemail.smtpencryption config parsing
>  - send-email: remove non-working support for "sendemail.smtpssl"
>
>  "git send-email" optimization.
>
>  Looking good.
>  May want to update with Eric's suggestion.
>  cf. <20210512180517.GA11354@dcvr>
>  I've squashed in typofixes while queuing.

Sent a re-roll just now in
https://lore.kernel.org/git/cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com/

> * ab/update-submitting-patches (2021-05-13) 3 commits
>  - SubmittingPatches: remove pine-specific hints from MUA hints
>  - SubmittingPatches: replace discussion of Travis with GitHub Actions
>  - SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Expecting a reroll.
>  cf. <xmqq4kf7fueq.fsf@gitster.g>, <20210512235136.GB10785@localhost>

I haven't gotten back to this yet / seen what the status of my patches
v.s. Dave Huseby's are.

> * ab/describe-tests-fix (2021-05-11) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"
>
>  Waiting for the base topic to solidify.

...

> * ab/pickaxe-pcre2 (2021-05-11) 22 commits
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
>
>  Waiting for the base topic to solidify.

...

> * ab/trace2-squelch-gcc-warning (2021-05-11) 1 commit
>  - trace2: refactor to avoid gcc warning under -O3
>
>  Workaround compiler warnings.
>
>  Expecting a reroll.
>  cf. <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>

Re-rolled as
https://lore.kernel.org/git/patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com/
(but as of writing this lore hasn't picked it up, but I'm pretty sure
I've sent it...)

> * ab/test-lib-updates (2021-05-11) 11 commits
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

I think per the v6 discussion at
https://lore.kernel.org/git/cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com/
this is ready to proceed. I.e. there's an ack + some discussion about
wording of "deprecated" not directly relevant to that topic.

It would be great to get this un-clogged, so my other topics depending
on it can proceed, but of course the rc period and all that...

> * ab/fsck-unexpected-type (2021-04-13) 6 commits
>  . fsck: report invalid object type-path combinations
>  . fsck: report invalid types recorded in objects
>  . object-store.h: move read_loose_object() below 'struct object_info'
>  . fsck: don't hard die on invalid object types
>  . fsck tests: refactor one test to use a sub-repo
>  . cache.h: move object functions to object-store.h
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Retracted for now.
>  cf. <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>

I re-rolled this just now as
https://lore.kernel.org/git/cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com
but ditto about not being on lore yet..

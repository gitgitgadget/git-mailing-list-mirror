Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEAAC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiDMUZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiDMUZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:25:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49E811BA
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:23:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so6286373ejn.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=83wVCR9sTQQT2MXGAbFiJYoHX9K0ACoa2R/ZqnInbB0=;
        b=DBAn4wgCmUPbsJZn36ibRFKLsJB1sRwzOIIzftYKY0QXR0yKMt6t0gb9MmzQ2zg16t
         GJW4K7f99KPd2gfZqYdKrhu9Htj0xDQ0hjoweTrmCpDGik6pGumniK6hud2q7rTnV2o8
         JE4wpcLQaVrl9NWC3FVBxX1br/gYZETiNeh+Dj/A8KurpIM9zHnvwm6LDCVZ/8lgfell
         ggHBAwR4pu6xb1Dbt2aqb/hDbtuG4S2oUT3An8j4agZi5WUkXfQl04xw8bzwL10ll/OI
         pz0Hz4qVN/0PHV8QbFWkpkwh2dwzHizDAu06VJcFJNew619FlfrPeSg4RHlFnXdLZ5OQ
         dZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=83wVCR9sTQQT2MXGAbFiJYoHX9K0ACoa2R/ZqnInbB0=;
        b=ukEEaIhO0jBwvmnvfiswFyu/V6GF8+r6L5crIkz1dEhGqG3me/t9aKFBd+TvAYsn66
         Oaitc6auyrAWvsEbXdbO5/ZPGENf8BqAAC4Hj15+cdghX2hd1Hr/TFvNdQf6yK279qt9
         lATr8GunnsgR2AKKfG++zUfLV7Q+2SuGp9D8TQx0uQACSbRks5cKByvrWwxdB+LpcZPt
         F+tU6VGsV8ZoAZ4TWSv6ivnD3/6a2jXPiD5e9inyHhnZPAhE85M1ymylK3V9bT54Rg3v
         zZiq+FZvFD7ujfnfxE3D0YIc2RgkcMqYDdX4eKPVWi21aIxAF23gQYMWeicSqrbYwkb1
         meDA==
X-Gm-Message-State: AOAM531SFJ0U9xyEUe+5/DOWXFspL35BpdGtwaTwuxGZvYdrJcJqeck2
        L2maV941QEoCa1GOHJBzcPE=
X-Google-Smtp-Source: ABdhPJxQb+kqnM2PE/tvAJLeCB7FeHd7DJ9iLlDRzVfviIrGdWCOAQed8IkR4GiSUNG+Ij0vRzoMJA==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr41281336ejy.220.1649881380816;
        Wed, 13 Apr 2022 13:23:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm313458ejm.69.2022.04.13.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:23:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nejVz-005CRh-Rw;
        Wed, 13 Apr 2022 22:22:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: ab/ci-setup-simplify etc. (was: What's cooking in git.git (Apr
 2022, #03; Tue, 12))
Date:   Wed, 13 Apr 2022 22:11:50 +0200
References: <xmqq8rsab5do.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rsab5do.fsf@gitster.g>
Message-ID: <220413.867d7senrw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Junio C Hamano wrote:

> * ab/ci-github-workflow-markup (2022-03-27) 7 commits
>  - ci: call `finalize_test_case_output` a little later
>  - ci: use `--github-workflow-markup` in the GitHub workflow
>  - ci: optionally mark up output in the GitHub workflow
>  - test(junit): avoid line feeds in XML attributes
>  - tests: refactor --write-junit-xml code
>  - ci: make it easier to find failed tests' logs in the GitHub workflow
>  - Merge branch 'ab/ci-setup-simplify' into ab/ci-github-workflow-markup
>  (this branch uses ab/ci-setup-simplify.)
>
>  Build a moral equivalent of js/ci-github-workflow-markup on top of
>  ab/ci-setup-simplify.
>
>  How does this compare feature-wise with js/ci-github-workflow-markup?
>  source: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>

...[covered below]...

> * ab/ci-setup-simplify (2022-03-27) 25 commits
>  - CI: don't use "set -x" in "ci/lib.sh" output
>  - CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>  - CI: set CC in MAKEFLAGS directly, don't add it to the environment
>  - CI: add more variables to MAKEFLAGS, except under vs-build
>  - CI: narrow down variable definitions in --build and --test
>  - CI: only invoke ci/lib.sh as "steps" in main.yml
>  - CI: pre-select test slice in Windows & VS tests
>  - ci/run-test-slice.sh: replace shelling out with "echo"
>  - CI: move "env" definitions into ci/lib.sh
>  - CI: combine ci/install{,-docker}-dependencies.sh
>  - CI: split up and reduce "ci/test-documentation.sh"
>  - CI: invoke "make artifacts-tar" directly in windows-build
>  - CI: check ignored unignored build artifacts in "win[+VS] build" too
>  - CI: remove "run-build-and-tests.sh", run "make [test]" directly
>  - CI: export variables via a wrapper
>  - CI: consistently use "export" in ci/lib.sh
>  - CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>  - CI: have "static-analysis" run "check-builtins", not "documentation"
>  - CI: have "static-analysis" run a "make ci-static-analysis" target
>  - CI: don't have "git grep" invoke a pager in tree content check
>  - CI: remove unused Azure ci/* code
>  - CI: remove dead "tree skipping" code
>  - CI: remove more dead Travis CI support
>  - CI: make "$jobname" explicit, remove fallback
>  - CI: run "set -ex" early in ci/lib.sh
>  (this branch is used by ab/ci-github-workflow-markup.)
>
>  Drive more actions done in CI via the Makefile instead of shell
>  commands sprinkled in .github/workflows/main.yml
>
>  Unless "doing more in Makefile" is fundamentally undesirable, I am
>  inclined to take this, together with ab/ci-github-workflow-markup
>  to replace js/ci-github-workflow-markup
>  cf. <xmqq4k361a57.fsf@gitster.g>
>  source: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>

With the RC period hopefully the timing of the re-rolls I submitted is
more helpful than not (since you were considering things for "next").

I think this should be ready, the main critique of this series on its
merits I think has been[1], I was a bit on the fence about adding
something on top of it, but hopefully the re-roll at [2] helps address
that, i.e. by explicitly adding the support for running things "CI-like"
locally, which was the logical conclusion of this series (in addition to
improving the GitHub CI UX itself).

> * js/ci-github-workflow-markup (2022-03-01) 9 commits
>  . ci: call `finalize_test_case_output` a little later
>  . ci: use `--github-workflow-markup` in the GitHub workflow
>  . ci: optionally mark up output in the GitHub workflow
>  . test(junit): avoid line feeds in XML attributes
>  . tests: refactor --write-junit-xml code
>  . ci/run-build-and-tests: add some structure to the GitHub workflow output
>  . ci: make it easier to find failed tests' logs in the GitHub workflow
>  . ci/run-build-and-tests: take a more high-level view
>  . ci: fix code style
>
>  Update the GitHub workflow support to make it quicker to get to the
>  failing test.
>
>  Waiting for discussion to settle.
>  cf. <220309.86tuc6lwpj.gmgdl@evledraar.gmail.com>
>  cf. <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
>  cf. <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
>  source: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>

Feature-wise v.s. ab/ci-github-workflow-markup one thing I noticed after
submitting the initial re-roll is that my re-roll has the end of the
"prove" output immediately preceding the expandable toggles in
js/ci-github-workflow-markup, but in js/ci-github-workflow-markup the
"prove" output is hidden its its own "toggle".

It's an artifact of how the two combined, the
js/ci-github-workflow-markup way could be re-introduced, but I find the
combination quite helpful actually. I.e. we now see the general summary
of what tests failed, and then the set test-by-test failures below.

As for the overall status some of the UX/slowness issues remain
unaddressed, which are issues in the original
js/ci-github-workflow-markup carried forward in this one.

Victoria Dye had some suggestions for addressing the slowness in [3]
that I think should be followed-up on. It was also noted that part of
the output was duplicated in the series (didn't dig up that reference,
sorry).

1. https://lore.kernel.org/git/320b3dde-a84e-0074-bed8-57061293b2b0@github.com/
2. https://lore.kernel.org/git/cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com/
3. https://lore.kernel.org/git/6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com/


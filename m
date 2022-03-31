Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1006BC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiCaKJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiCaKJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:09:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DC202172
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:07:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h4so19774614edr.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/xcZ7QS8gmdpQg6BD3d2VVoBuO/KnyjQ/GG02oNG2n0=;
        b=aJKS1PaiPyprhlmEoX5JTRvRDFE6MUlk1tdkpJXxSjK4WV4ZSKYVaOx/YZWtB/aaPy
         m3tVl+HjN4ZBWZqqJsjxSzik7H/gpw3CJquI7hv42UFi3LENtw11BOrROx+s85CqZqTi
         hU8HKgyn+4wrV/P938z9qrwQGYPlfIiho6ZdUkwgyvQND1o5ajiTKMRciRCBPG8+0wYd
         W3zS70TZUakn/VAmOGLNXRtHbwut/tDwY4d9bLW5kw2yPyKmXwWZ1DeW+VIzxqeNX+4k
         ae0U06mFs3JiEa4+bxZdfxVLFHkOY7BskJB6LafULSnH2Pm8d+2z+KrqQxpRCnqAhgYF
         ue7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/xcZ7QS8gmdpQg6BD3d2VVoBuO/KnyjQ/GG02oNG2n0=;
        b=o5IcevqVXD7MprbBEW8cssa3ynTf2EFwHR85hMW66CogmnzZMgg2sFW7F2APq31Y/N
         gzTUfFTltPMNN/q0vHhfsTCdiUxQaIbNBVT5zGsxe/VtTdgLsANW1jSHfa9L0Zc8YZnn
         g1oQxH0MVH6mPKZhqV26bhAiiHtwtyZBUWt0G/DYTcZ4TKQ0WtWzAy+do8fdnpZZHE3J
         OgF6FVA6/60EjsiKBcKq36JHx/b9a56aIGaSbMlNs8qFqA5zlaqsc1JZD7UeoBDOgugv
         bmlY2oazbq7fdZeKZUMdYAhc1DOmc1iopxhU4Riq5ZJoNwPUWKF0fpyzZZlOhtpiP/Zd
         ZKJA==
X-Gm-Message-State: AOAM531s/4OELZtw0jgJ823bWjCIrgHJ84DEDn1O3SF5jxeIr7z9/l3x
        hyyhjJByL1Gkd5YfpGXXE6Y=
X-Google-Smtp-Source: ABdhPJxMSMpRb8PdACqCk4ZFOZ8AQb+MoyKuxJg5qSRb9e3ch5vn/QM89l3Jd6yNTyiw+N0rVGhzDA==
X-Received: by 2002:a05:6402:207a:b0:419:3e9f:494f with SMTP id bd26-20020a056402207a00b004193e9f494fmr15700496edb.397.1648721253362;
        Thu, 31 Mar 2022 03:07:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d24-20020a1709067a1800b006e021f4c1c3sm9258905ejo.166.2022.03.31.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:07:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZriG-000LBz-2p;
        Thu, 31 Mar 2022 12:07:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: ab/ci-setup-simplify + ab/ci-github-workflow-markup (was: What's
 cooking in git.git (Mar 2022, #07; Wed, 30))
Date:   Thu, 31 Mar 2022 11:57:21 +0200
References: <xmqqee2i50h9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee2i50h9.fsf@gitster.g>
Message-ID: <220331.86zgl6qvtn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

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
>  Waiting for discussion to settle.
>  source: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
>
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
>  Waiting for discussion to settle.
>  source: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>

For these two topics: I think that the discussion to settle was around
the performance/UX of the smaller topic on top.

For my larger "base" cleanup topic I think that RFC re-roll on top
clearly shows that whatever the larger UX changes to CI will look like
that they clearly don't semantically conflict with unrolling the "make"
invocations to the CI "step" level, and actually make things there much
simpler as well.

And, on top of master the diffstat looks really good in itself (and
e.g. ci/lib.sh is *much* smaller & more easily understood):

    21 files changed, 346 insertions(+), 577 deletions(-)

So I was hoping that the "base" topic could be merged down sooner than
later, particularly as aside from two lines of changes to Makefile &
shared.mak the changes are all in ci/* and .github/*, or in the case of
~30 lines of top-level Makefile changes to two new targets that are
exclusively called by the CI:

    git diff --stat -p origin/master...gitster/ab/ci-setup-simplify -- ':!ci/' ':!.github/'

And unlike changing code that will run on various computers we don't
have access to, the only target for these (the GitHub CI) is already
running the changes, and because the nature of these changes is that
they're going to badly textually conflict with pretty much anything else
done in the ci/ directory (e.g. addition of new targets, changes to
flags etc.).

Thanks!




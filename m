Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A753C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 10:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiFBKnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiFBKm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 06:42:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C452B1955
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 03:42:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v25so5707902eda.6
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CXCFsCLvI19evy9XSR1o2O6v985zssQSk7K8ZM9zlMQ=;
        b=VC6wwkd+Q1Ge1iScoMG0pXUBiR5GbMnSq+iyErnm8oCyDDmX6EDKJkcZwpnhuHizBE
         w3C6ORrUtXP3YpAKOnDgqmrh7haC6rCQxLCdD8YjHk9sIG8AptdvnDZ52+NDKP9g0jPM
         aWCsmoCrfRqjk3DdgBEGYtdjqEWFfKfJZ5PoWufstebp2+KdCkj0EgwywKEJGMy/bA4n
         THWHU+HVggEKdZK+H+BuqFbvT36lCnmUCcJGmdJaeLZVJnYiEinYhx8fvKnSnxn0l/Li
         zqX3wfrnjhh4ypIys4okfNJb0VFWGooNr9b8ki0cz6uZ+pSZmFnSxIjVlbdgXvJtJSHd
         SQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CXCFsCLvI19evy9XSR1o2O6v985zssQSk7K8ZM9zlMQ=;
        b=RXrJyVTL10IhgeP9DoZ6qpwBQNXuAN04JzIBA6UyYrGtCKunEr0uF1Ifo5bgGzvJHv
         OsYRjpVjYWWYUBenq0uQeptpqfzBXNcrKJL6aTRsj8uWTAvA+5BfLjcYIfW0PT2GTV8J
         Ia/snkvJPOYbHDCYhx7F945jsgfVbXH003qdzJxObhgqUJaicvvpntUdcvSOMqLyqWoC
         UODj2DgOB8As+zbgm4IJw5k1nQC6pdjCgd2ZMDY2P0hJk0rkHXxsaPxOK+tIbY2Mnre1
         1s12CeuvWDbE/vT9+Q57cLvcYOmLkOj8VAsWLurns4AJVmr5iAMVoG7G96d2I2Dy8n2C
         /D1A==
X-Gm-Message-State: AOAM531T6Hmstnkhsl8VaIAr5ub1owm+LAVACRWx2G21A5Ej4Te0sc8w
        JxkNfbFeLE9jINUJdei6vms=
X-Google-Smtp-Source: ABdhPJzDIsBKv/hhLFycHmQbQmVvxMNVsk4X+sD5sJM1tCFaPpL6jOcl8Bj72U0lTFu+byxS4SN+4Q==
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr4673619edc.88.1654166573863;
        Thu, 02 Jun 2022 03:42:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bv21-20020a170906b1d500b006fe98fb9523sm1631522ejb.129.2022.06.02.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:42:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwiI0-001Qyf-BM;
        Thu, 02 Jun 2022 12:42:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci: also run the `scalar` tests
Date:   Thu, 02 Jun 2022 12:24:25 +0200
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com>
Message-ID: <220602.86ee07z6qb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 02 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
>        run: . /etc/profile && ci/make-test-artifacts.sh artifacts
> +    - name: build Scalar
> +      shell: bash
> +      run: |
> +        make -C contrib/scalar &&
> +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> +        cp bin-wrappers/scalar artifacts/bin-wrappers/

This seems like it belongs in the Makfile and/or
ci/make-test-artifacts.sh, why does the GitHub-specific CI step need to
know how to appropriately move scalar build artifacts around?

More importantly, this is the "win build", which uses the Makefile (as
opposed to cmake-using vs-build).

We already invoke ci/make-test-artifacts.sh which does a "make
artifacts-tar", which builds them & packs the "git" binary etc. into a
tarball.

But here we're after-the-fact building the scalar binary itself (we
already built scalar.o), so at the end we're left with a tarball that
doesn't contain scalar, but then a ...

>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts

...zip file that does because we manually re-do it here? Or maybe I'm
misunderstanding this....

> @@ -161,6 +168,8 @@ jobs:
>        run: compat\vcbuild\vcpkg_copy_dlls.bat release
>      - name: generate Visual Studio solution
>        shell: bash
> +      env:
> +        INCLUDE_SCALAR: YesPlease

...doesn't it make more sense to just have the Makefile understand
INCLUDE_SCALAR instead of keeping all this logic in main.yml.

I don't really see the logic of insisting that we can't put scalar
special-cases into our Makefile because it's "in contrib", but then
doing that in our main.yml CI.

>       run: |
>         mkdir -p artifacts &&
>         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
> +    - name: copy Scalar
> +      shell: bash
> +      run: |
> +        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
> +        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
> +        cp bin-wrappers/scalar artifacts/bin-wrappers/

Ditto duplicated from above. As the context shows if the "artifacts-tar"
target knew how to include scalar this & the above wouldn't be needed,
we'd just run those shell commands.

>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 280dda7d285..661edb85d1b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -51,4 +51,6 @@ esac
>  make $MAKE_TARGETS
>  check_unignored_build_artifacts
>  
> +make -C contrib/scalar $MAKE_TARGETS

At the start of "make test" we create t/test-results, that also goes for
contrib/scalar's "test" phase.

Then if we have failures we keep it around, if not we rm -rf it, and
when we run "test" again we rm -rf the old one.

Have you tested what happens when e.g. one/both of scalar tests & "main"
tests fail? I haven't, but I'm fairly sure it's one of:

 * We racily run both, and they'll rm -rf or trip over one another's
   t/test-results.

 * We'll end up with one or the other, but we want the union of both
   (report on all failed tests & their output at the end)

 * We run one at a time (because we don't have "make -k"?), but now if
   e.g. one scalar test happens to fail (or the other way around) we
   won't spot failures in the tests we didn't run.

So I'm not sure, and haven't tested this, but what I can't see from
being familiar with the Makefile logic involve is how this would Just
Work and do what we want, but maybe I'm missing something.

I don't know if we touched on this in particular in past
rounds/discussions, but this edge case is one of many that led to [1],
i.e. if we simply run the tests in the top-level t/ (as other stuff in
contrib does, like the bash completion) we avoid all of these caveats.

> [...]

1. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

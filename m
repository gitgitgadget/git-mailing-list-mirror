Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54704C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 04:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiCaEV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 00:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCaEVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 00:21:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A652241E2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 21:09:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so39255207lfj.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 21:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rnCeme54k7RDMKIyuC/fhTT8ymDf/DJBzuWstV1symQ=;
        b=Oc/nNZt0yyuk80InFTxw7SBtCg5YLkpp6F/JnfC7C8aG6GC+kTOwY0euBbWBmBQFxY
         6wec9ZALrYnb2u1Ykq+5WuTkZ5rxM2tsGtLi1Vh7+xqMCJIEBy74k/qtf7uLqLXnW/DH
         nShKA7h19VMGbzU85HPNOxSm/SzdotPFL1FVvcL8cLcIuII8W8WjtDcPhU4G9NYZiMqj
         a+TlG7ABc0b+YpAw4eLSLXoT1OC/BpvHAOJbBz3xtzT522+0D+B89lGtMMmrQ36aCYQ9
         A1COSmPaAqvxjgcaHeqEUTExj3WwGdv8pUjtTFcDWQ/qhECc3O0AX7PFY9JfOOmepvIW
         uNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rnCeme54k7RDMKIyuC/fhTT8ymDf/DJBzuWstV1symQ=;
        b=uWupeeEapjri6gvWQu4cAsTN1q7CjVozmttIvfBD1cfZBSpnhHhKVUuurrvVQwQgeM
         QAxfqqdw1UkJnFZkswY9VavkaAxbXrHilw+kJFgjoLWEpxhAyU2t81wQBLzslFwSxecw
         Vi+fUBynKu4LWWsQwmNKPFWED2toyPKVJf7ub0iIZwPOtAAtP6Gkq32mTL0wqeBkG8X3
         dMokniUm68l0/egap9z15GWBZcWCrOULPMTteOtmjC18nHzW2Ca6utTYeDKWpawQO0Yq
         MsqSS+XKyZmDWpt8FLmIpF7J2AQbXQefdEDZFlIJxgngaQ4N/kgcNNAWvU2sAOKhgYxP
         QMXA==
X-Gm-Message-State: AOAM5330s0+tT3xaYtkry+Fzap5cuAU9AdTu728MRvT+RXEdUy4x71DQ
        X3qesNIfxXDFqRiWGKczRWuDppTNNrTIL6SQTbE=
X-Google-Smtp-Source: ABdhPJzkmF9UfGhOaefbjOldXmbMVc0r0h/rhm0wFW0ggDwhalInhMUm60LMK+Zyv5W2Bpq4ss0JWuoQDlwwBM4up5o=
X-Received: by 2002:ac2:5dfa:0:b0:44a:15d4:9e60 with SMTP id
 z26-20020ac25dfa000000b0044a15d49e60mr9730138lfq.241.1648699781068; Wed, 30
 Mar 2022 21:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <26be6ecb28bc1f76fba380fdd10acf59820df997.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <26be6ecb28bc1f76fba380fdd10acf59820df997.1648616734.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 21:09:28 -0700
Message-ID: <CANQDOdea6Ejnsj1r6GhSvR+6ZMBGkRo8yr-GpOv-Gcsc8hEf6w@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] core.fsyncmethod: performance tests for batch mode
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 10:05 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add basic performance tests for git commands that can add data to the
> object database. We cover:
> * git add
> * git stash
> * git update-index (via git stash)
> * git unpack-objects
> * git commit --all
>
> We cover all currently available fsync methods as well.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  t/perf/p0008-odb-fsync.sh | 81 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100755 t/perf/p0008-odb-fsync.sh
>
> diff --git a/t/perf/p0008-odb-fsync.sh b/t/perf/p0008-odb-fsync.sh
> new file mode 100755
> index 00000000000..87092c2627e
> --- /dev/null
> +++ b/t/perf/p0008-odb-fsync.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +#
> +# This test measures the performance of adding new files to the object
> +# database. The test was originally added to measure the effect of the
> +# core.fsyncMethod=3Dbatch mode, which is why we are testing different v=
alues of
> +# that setting explicitly and creating a lot of unique objects.
> +
> +test_description=3D"Tests performance of adding things to the object dat=
abase"
> +
> +. ./perf-lib.sh
> +
> +. $TEST_DIRECTORY/lib-unique-files.sh
> +
> +test_perf_fresh_repo
> +test_checkout_worktree
> +
> +dir_count=3D10
> +files_per_dir=3D50
> +total_files=3D$((dir_count * files_per_dir))
> +
> +populate_files () {
> +       test_create_unique_files $dir_count $files_per_dir files
> +}
> +
> +setup_repo () {
> +       (rm -rf .git || 1) &&
> +       git init &&
> +       test_commit first &&
> +       populate_files
> +}
> +
> +test_perf_fsync_cfgs () {
> +       local method cfg &&
> +       for method in none fsync batch writeout-only
> +       do
> +               case $method in
> +               none)
> +                       cfg=3D"-c core.fsync=3Dnone"
> +                       ;;
> +               *)
> +                       cfg=3D"-c core.fsync=3Dloose-object -c core.fsync=
Method=3D$method"
> +               esac &&
> +

In last round, I said I'd go with =C3=86var's scheme for iterating over
configs.  But when looking at the test output I decided that I wanted
a shorter label for each config rather than the actual command line to
make hte output more readable.

> +               # Set GIT_TEST_FSYNC=3D1 explicitly since fsync is normal=
ly
> +               # disabled by t/test-lib.sh.
> +               if ! test_perf "$1 (fsyncMethod=3D$method)" \
> +                                               --setup "$2" \
> +                                               "GIT_TEST_FSYNC=3D1 git $=
cfg $3"
> +               then
> +                       break
> +               fi
> +       done
> +}

So here I split the 'git $cfg' invocation off of the actual command
being executed, since it wasn't clear to me the best way to structure
this shell script.

The overall effect I want to achieve is to be able to iterate over
every config for each test case so that the different configs of the
same test appear next to each other in the output.

> +
> +test_perf_fsync_cfgs "add $total_files files" \
> +       "setup_repo" \
> +       "add -- files"
> +

I initially tried not substituting the $cfg variable in a test like this:
'git $cfg add -- files'

And then using eval in test_perf_fsync_cfgs to get the variable
substitution to happen later.

Is there a better way to write this?

Thanks,
Neeraj

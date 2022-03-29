Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D2C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiC2RkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiC2RkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:40:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC67BF7A
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:38:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt26so31541398lfb.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRXgiEHKxm+yVgu1OJp5V/59rw+txBJRq2Z6rZWMKxY=;
        b=OEHGb6iW2J2iE76j8iOtSYKadOGedrgm6j9nC02w+w2VW6j87PodkMAqdYKGdy6eN0
         uZCRvkB+rlCPTJLNvn6gooOfHA2gmF6Gk3n6PLc3Z6AfPNw2JcyMf3K3OrX4euTZdzro
         Ubm75apHR7jsgj87QSAWcZd7SKKCC8XmSQkV2u5Bj/z7lZyRHaCEhWlGyz08Z6XI0kOV
         lfubXVFC1snxoonqxHcsvanmk0aOr59ZkGO27UiJNNVGPjZdTRxoKqsz0oZJG9LuZ0eE
         +f6afVJxURX9JceVm79wpSW3h8a+FTU/9XixO/i7FJQSrrsN91CNrZvsTmGDTRoMl7UI
         qBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRXgiEHKxm+yVgu1OJp5V/59rw+txBJRq2Z6rZWMKxY=;
        b=DW6KxRdHXGXbx/mVqlyoRPBY2iJ3/RzcCd5y0PzB6BJUgwomyedXVIuP/Us7F6R4pZ
         WJIYW/hZetucIAh+ajyDH+GKORPsic4Sntw0/ZM0B/6LAOTyyj97anB3Egqu1y+JamXH
         +fMeVmeoQqR4SSzkYn3JRuipej4hZiXI03Rd4vb7IkDku2DxECQQhYXcE98b/r5D+XBR
         EAZYVZPd1gWQ/SwzYmV0nuBrVLlwIiJMfV+lMYFz9zCqVZU/aJxnuEqN4+V2ZgN3nqNI
         i4TCURR8n7TlF192bccwtyK8UugBEHfG+V2j/T2HvSW00b8wG7GbofYIGP8pHDoq7HHQ
         /RWg==
X-Gm-Message-State: AOAM5315IQUk6dr+9hpf+f/JECUafGJcPp0EvKujXVHSq8qQJU4cY2bs
        ToVdnNulX6RDS2QVa4IYgMiMmOKIula55kh2AIE=
X-Google-Smtp-Source: ABdhPJxIkZfZ1OmCFMP7UCtdh71CBo5Xb4aRBplwctUs3vzr9XqJftWbzp3mSsAuYpk9irKW3bb4rjFuU7PkX9Olqes=
X-Received: by 2002:a05:6512:1151:b0:44a:6d05:8d2d with SMTP id
 m17-20020a056512115100b0044a6d058d2dmr3756148lfg.442.1648575514076; Tue, 29
 Mar 2022 10:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com> <fdf90d45f52d72cf2ff7fe6b620853da9fafc1b3.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <fdf90d45f52d72cf2ff7fe6b620853da9fafc1b3.1648514553.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 29 Mar 2022 10:38:22 -0700
Message-ID: <CANQDOdfm9cuP=_+rErsBj97hw6QSyaJ6oQUoVkcaDSqZObGdiQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] core.fsyncmethod: performance tests for add and stash
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

On Mon, Mar 28, 2022 at 5:42 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add basic performance tests for "git add" and "git stash" of a lot of
> new objects with various fsync settings. This shows the benefit of batch
> mode relative to full fsync.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  t/perf/p3700-add.sh | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100755 t/perf/p3700-add.sh
>
> diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
> new file mode 100755
> index 00000000000..ef6024f9897
> --- /dev/null
> +++ b/t/perf/p3700-add.sh
> @@ -0,0 +1,59 @@
> +#!/bin/sh
> +#
> +# This test measures the performance of adding new files to the object d=
atabase
> +# and index. The test was originally added to measure the effect of the
> +# core.fsyncMethod=3Dbatch mode, which is why we are testing different v=
alues
> +# of that setting explicitly and creating a lot of unique objects.
> +
> +test_description=3D"Tests performance of adding things to the object dat=
abase"
> +
> +# Fsync is normally turned off for the test suite.
> +GIT_TEST_FSYNC=3D1
> +export GIT_TEST_FSYNC
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
> +for mode in false true batch
> +do
> +       case $mode in
> +       false)
> +               FSYNC_CONFIG=3D'-c core.fsync=3D-loose-object -c core.fsy=
ncmethod=3Dfsync'
> +               ;;
> +       true)
> +               FSYNC_CONFIG=3D'-c core.fsync=3Dloose-object -c core.fsyn=
cmethod=3Dfsync'
> +               ;;
> +       batch)
> +               FSYNC_CONFIG=3D'-c core.fsync=3Dloose-object -c core.fsyn=
cmethod=3Dbatch'
> +               ;;
> +       esac
> +
> +       test_perf "add $total_files files (object_fsyncing=3D$mode)" \
> +               --setup "
> +               (rm -rf .git || 1) &&
> +               git init &&
> +               test_create_unique_files $dir_count $files_per_dir files_=
$mode
> +       " "
> +               git $FSYNC_CONFIG add files_$mode
> +       "
> +
> +       test_perf "stash $total_files files (object_fsyncing=3D$mode)" \
> +               --setup "
> +               (rm -rf .git || 1) &&
> +               git init &&
> +               test_commit first &&
> +               test_create_unique_files $dir_count $files_per_dir stash_=
files_$mode
> +       " "
> +               git $FSYNC_CONFIG stash push -u -- stash_files_$mode
> +       "
> +done
> +
> +test_done
> --
> gitgitgadget
>

=C3=86var suggested that it's a bit funny to have a stash test in a file
named 'p3700-add.sh'.  So I'm thinking that I'll move these tests to a
p0008-odb-fsync.sh instead, and add a test for unpack-object and
git-commit as well.  I'm also going to adopt  =C3=86var's scheme for
iterating over the configs.

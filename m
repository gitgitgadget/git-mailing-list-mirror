Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4785C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EF261165
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhHTV7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTV7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:59:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44045C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:58:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso17229169ott.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUIU1KvGpg0dUugZFpn93eopGwfY9NRzQ8to9FR3iow=;
        b=IpqRRCyz+vMxkAZk1COG8+2f5S+cXLRjm4engZBDM0Q6BRSXUu93C1kADpkZiy3wlU
         dQuPPeoCz/yElNTgc6cKVps/fjM4+OyYEBGEHni8SdX5yy8X3DDZWnzdC1hcv1Eg4Lsk
         r5Jwv98wO49PY/HhHZ031U10bW/zkZIBGqOx/hc2rPSWYekva4jD3yhXFoZFAbYjJJus
         l/n/oG2LAJNvd+5FMk/P8ld3FEhJQ8vf2FBjIdT6h7EpMIQZ020BYKzhf1ZxFpyWA+Cm
         8UVrXATjdTdwCYZAUJFfqYE1Zn15Tn8EXMUWlV5yqDRiB3uuQU5j5z4l85e65JNFI1fW
         S10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUIU1KvGpg0dUugZFpn93eopGwfY9NRzQ8to9FR3iow=;
        b=GYZYzRN36C3NL8fH+nMCOe/O+PlhrwALWta2nlEA2+8LM/Bo7JtgnxKwIwEDVQAsY9
         Voqo+C1EC6b3NqKyRt8O0i1+Etpe9Q7/qGqQis5b9GQypP89KamvyT+b7Hkkhrsi6JAC
         WslsfQaDFIZdAcTzeBdC6CJXgLvULAOmhymIVEyw2UBMI8crvuAMPHgbIYmc/Uw8I3OD
         WZcT8fhGYSFBAP8gQdiADtyjkTBzbgtokyEeIW+zoyCfLoRD0IGJcR9BpJr9uMRTFGhF
         +T3skUVKEtSxPG6V212Eok59sxZTlGAb0osuD3lKVUIwjuAgTbassjrEsqv5rZ67IFX+
         efgg==
X-Gm-Message-State: AOAM531fF0kapYTwcAEY6FOVyIdo6xnguMFq2ksrKjEU+OA5guTWP1yB
        0LwzXaac49NjkvJdzqTOdCKQfLqPNsExbm9Pdrw=
X-Google-Smtp-Source: ABdhPJwixO517H68VXO4gUVj85sswxmIDiYQRdv6rV2CThC0Q2bsdflt/5sHAdwV08tAzPUOVEtNrjPk4P6RshiLc+U=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr4553902oib.39.1629496711722;
 Fri, 20 Aug 2021 14:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <ca23bf38bd9a88c6ab8461e703165c550cf7b955.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <ca23bf38bd9a88c6ab8461e703165c550cf7b955.1629220124.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 14:58:20 -0700
Message-ID: <CABPp-BHGP5aARirfuS8xZspTk1Fkgq310=MrPiJcXe782LjgHQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] t1092: add cherry-pick, rebase tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add tests to check that cherry-pick and rebase behave the same in the
> sparse-index case as in the full index cases.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a0ed2bec574..a52d2edda54 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -486,14 +486,17 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>         test_sparse_match git reset update-folder2
>  '
>
> -test_expect_success 'merge' '
> +test_expect_success 'merge, cherry-pick, and rebase' '
>         init_repos &&
>
> -       test_all_match git checkout -b merge update-deep &&
> -       test_all_match git merge -m "folder1" update-folder1 &&
> -       test_all_match git rev-parse HEAD^{tree} &&
> -       test_all_match git merge -m "folder2" update-folder2 &&
> -       test_all_match git rev-parse HEAD^{tree}
> +       for OPERATION in "merge -s ort -m merge" cherry-pick rebase

You're explicitly testing the ort strategy with merge, but relying on
GIT_TEST_MERGE_ALGORITHM for cherry-pick and rebase?

It'd probably be better to set GIT_TEST_MERGE_ALGORITHM=ort at the
beginning of the file and leave out the `-s ort` references.

Or, if you really wanted to test both algorithms, then in addition to
leaving out the `-s ort`, don't bother setting
GIT_TEST_MERGE_ALGORITHM.  (That works because automated test suites
will set GIT_TEST_MERGE_ALGORITHM=recursive on linux-gcc, and
GIT_TEST_MERGE_ALGORITHM=ort elsewhere).


> +       do
> +               test_all_match git checkout -B temp update-deep &&
> +               test_all_match git $OPERATION update-folder1 &&
> +               test_all_match git rev-parse HEAD^{tree} &&
> +               test_all_match git $OPERATION update-folder2 &&
> +               test_all_match git rev-parse HEAD^{tree} || return 1
> +       done


>  '
>
>  # NEEDSWORK: This test is documenting current behavior, but that
> --
> gitgitgadget
>

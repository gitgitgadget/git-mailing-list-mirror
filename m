Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905FC43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F8C61426
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 15:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbhDUPPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhDUPPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 11:15:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 08:15:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h36so13223256lfv.7
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmalWzkENsLRc8ns3m+C3TQIKQAFchMlG25mYqimGnY=;
        b=Dx74+Ge2WnIFGRBsB3stQE6y3S7Tm4eVu5vhXh+xPEBvT5HBC4bYH6a0uEhozq39EJ
         jL5KOXZdd2fjQxbHWbeJhn+6r7oppcKdU8kdFPeV7IyqlXnl2iJosrkXZ9fmPYXtotMW
         yjx7RK6lJgXjUsNlWehcZADaxwC5RHky7dX0eK7tf3JbISGoZx+sIteCaIAn389163Qy
         gQJ8WM4ubV8vPR7S1EFWmE1wRwE8Hx5xfbPIa9amlN8XCKOpiVMnw7TEX7Ne/Czw22dl
         cWezLi3BvSG2EI/OA8jo250W2lO/7g1zcDawovr5lK553BsChcDdY3LHcVWcAzHQmnco
         WHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmalWzkENsLRc8ns3m+C3TQIKQAFchMlG25mYqimGnY=;
        b=H+3Z7/NvAJKYfYB3qaDgpk+nXe2HE3DT4R9gspF9VZcQT6M77lfnzSibeB4wNEKeBF
         mt8L7P9JUgRWfWvSXe9ZMMlKAGTbDVaPBbg54voy9ERriA9iyvk2S+M5OibRC5UGaD+i
         7FCv7Pf/8Z9eEFra7ZL1jObGjvgGMs8P69Xozi0xKcxbn0esfcxKs5YGI93QwYb9iOZ0
         hZGFOQ/loRfVYDBxYYtq/GtKHHenxhsQdQWO1SqfjXenqDkLehNar3TvHtAt96m+Hi2F
         A9dpNOwjahRzvFbmpqz0l7Y9JHrRqGPG7/U5wG4cj0sPl31Tv6VHivfpvG7/qZ+4JyJ+
         4wtw==
X-Gm-Message-State: AOAM533raGg5MgaEUN+/nL/sG0rMFLBPTzjO8vVRTwRLm2S2znlBd7h1
        +OPDQIGb1SIxBrAY9tkimOW5FYizz2XPImRwhDn6ZA==
X-Google-Smtp-Source: ABdhPJyG5V8AY4SHe11TjRhFnm8D35H39JsDVhzgcMCiUrPybahzqQ3iXdjntPvyXmho3tT20MqdbIT/BjOsPuf9oEs=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr20061984lfh.2.1619018109772;
 Wed, 21 Apr 2021 08:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 21 Apr 2021 12:14:58 -0300
Message-ID: <CAHd-oW4wq6T1kmBGXUfEO4R8h0dfUAGudKvO0xLgCgm2bQt=qA@mail.gmail.com>
Subject: Re: [PATCH 01/10] t1092: add tests for status/add and sparse files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Stolee

You already said you will make changes in this test to make sure
git-add's sparse warning is kept on a sparse index (BTW thanks for
that :), but I just wanted to give a couple suggestions that came to
my mind while reading the patch.

On Tue, Apr 13, 2021 at 11:02 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 12e6c453024f..6598c12a2069 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -232,6 +232,42 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> +test_expect_success 'status/add: outside sparse cone' '
> +       init_repos &&
> +
> +       # folder1 is at HEAD, but outside the sparse cone
> +       run_on_sparse mkdir folder1 &&
> +       cp initial-repo/folder1/a sparse-checkout/folder1/a &&
> +       cp initial-repo/folder1/a sparse-index/folder1/a &&
> +
> +       test_sparse_match git status &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +       run_on_all ../edit-contents folder1/a &&
> +       run_on_all ../edit-contents folder1/new &&
> +
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       # This "git add folder1/a" is completely ignored
> +       # by the sparse-checkout repos. It causes the
> +       # full repo to have a different staged environment.
> +
> +       test_must_fail git -C sparse-checkout add folder1/a &&
> +       test_must_fail git -C sparse-index add folder1/a &&

To make sure the output is the same, could we collapse these two lines into:

test_sparse_match test_must_fail git add folder1/a ?

And additionally, I think we could repeat this check with `add
--refresh` and also after removing `folder1/a`. The reason I'm saying
this is because the check currently succeeds when `folder1/a` is in
the working tree (maybe because `fill_directory()` ends up expanding
the sparse index in this case?), but not under the two other
circumstances I mentioned (as we've discussed in [1]).

[1]: https://lore.kernel.org/git/CAHd-oW7vCKC-XRM=rX37+jQn_XDzjtar9nNHKQ-4OHSZ=2=KFA@mail.gmail.com/

> +       git -C full-checkout checkout HEAD -- folder1/a &&
> +       test_sparse_match git status --porcelain=v2 &&

Hmm, shouldn't this be `test_all_match`? IIUC, we've resetted
`folder1/a` on the full repo to make sure the status report is the
same across all repos, right?

> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/new &&
> +
> +       run_on_all ../edit-contents folder1/newer &&
> +       test_all_match git add folder1/ &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/newer
> +'
> +
>  test_expect_success 'checkout and reset --hard' '
>         init_repos &&
>
> --
> gitgitgadget
>

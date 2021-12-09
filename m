Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB6C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhLIF1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhLIF1a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:27:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DBC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:23:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so15401721edb.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vv0+zmS+vafkOyK3y2cS4g9a6CsTC0ZBvtnt9v2OY7Q=;
        b=cNqQ8RVzq7+zpS/9HA+HcCjUuXstYIGuPukwJq2FgfAHnVbe2Mu673e+PDJ8uwS1pz
         6L+iixu+4xjLDjBvOJNqddNuCDqGWmMZWerxV/RO8b9yOuPtImrbDtxZmbUmUGtfa5ID
         Um1aMONoa7IZUnhPG2d0k/gMIhCpDNE/PeseAO0F8gVt1pDimGfkmdIozFxJacoEpdKR
         Y3PLWKDRe/cFvFaSuMbEGkjts3Zei7qqRgwq5RD3gpRGEHt9NO5XyScYyXBbzqmnR0+a
         QumM+umIbzTTU8myd5TlbQ7B91TPhfDq+pkc74SmgCwFfPO9Vv91qdYR1oC3wVdVOtok
         tSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vv0+zmS+vafkOyK3y2cS4g9a6CsTC0ZBvtnt9v2OY7Q=;
        b=RorVDIMQaVxIAAjaAdwD0m4Xb3HqQlkY+UGYC4SMIrqrsYwv1bxezHSpuWA5RWOx3t
         CSEatKHNW+c7W/Jjo5xohqdXLeRRuNZfVS0ccTCV9BgUriz/HEEt61L2GRgVhy+K8/K9
         eqguMZUf8zY3kaEGQr5nUdxoWJpcQaREMf4CE3z0RaDPlf2DHlHKZ2+PWjWj+i7Js6by
         9r38bb0cRS8muYKyQC7EUkSMJqndElAZCrH2Ozyi8iF1Mu2Jxqo5b1HSL08fitpO9j1p
         vFrZm0JlCaS5wrj30gXWdex/9NUBLJf1rmC7b6E5PCXg7GJEK0PJI5uZdNdOHDtdrzVu
         BNMg==
X-Gm-Message-State: AOAM5318YFrfJxxhylhrngUIot7HtUOv4ZQ5Upf5TuA+to5lTmtsMwpN
        oK+y4uUGtBi3zfg8aFb6m2d8uhK5s3FKgasyFYo=
X-Google-Smtp-Source: ABdhPJwn+d/2yrjHf70YKCLm9ZQZB+5v9JMiGiqlPRynpSAoG1vLXh+We3Wwp1bn9D+Zzqc6RHGGHyDsTSwwdRvOcSg=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr26626669edf.72.1639027435233;
 Wed, 08 Dec 2021 21:23:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com> <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 21:23:43 -0800
Message-ID: <CABPp-BH1y1DccvqW58WBui7kwj0Z2HrvzrRoQhdG3YLJkGX=KA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse index: fetch, pull, ls-files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ld/sparse-index-blame (merged with 'master' due to an
> unrelated build issue).
>
> Here are two relatively-simple patches that further the sparse index
> integrations.
>
> Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
> have been an integration much earlier in the cycle. They read the index to
> look for the .gitmodules file in case there are submodules that need to be
> fetched. Since looking for a file by name is already protected, we only need
> to disable 'command_requires_full_index' and we are done.
>
> The 'ls-files' builtin is useful when debugging the index, and some scripts
> use it, too. We are not changing the default behavior which expands a sparse
> index in order to show all of the cached blobs. Instead, we add a '--sparse'
> option that allows us to see the sparse directory entries upon request.
> Combined with --debug, we can see a lot of index details, such as:
>
> $ git ls-files --debug --sparse
> LICENSE
>   ctime: 1634910503:287405820
>   mtime: 1634910503:287405820
>   dev: 16777220 ino: 119325319
>   uid: 501  gid: 20
>   size: 1098    flags: 200000
> README.md
>   ctime: 1634910503:288090279
>   mtime: 1634910503:288090279
>   dev: 16777220 ino: 119325320
>   uid: 501  gid: 20
>   size: 934 flags: 200000
> bin/index.js
>   ctime: 1634910767:828434033
>   mtime: 1634910767:828434033
>   dev: 16777220 ino: 119325520
>   uid: 501  gid: 20
>   size: 7292    flags: 200000
> examples/
>   ctime: 0:0
>   mtime: 0:0
>   dev: 0    ino: 0
>   uid: 0    gid: 0
>   size: 0   flags: 40004000
> package.json
>   ctime: 1634910503:288676330
>   mtime: 1634910503:288676330
>   dev: 16777220 ino: 119325321
>   uid: 501  gid: 20
>   size: 680 flags: 200000
>
>
> (In this example, the 'examples/' directory is sparse.)
>
> Thanks!
>
>
> Updates in v2
> =============
>
>  * Rebased onto latest ld/sparse-index-blame without issue.
>  * Updated the test to use diff-of-diffs instead of a sequence of greps.
>  * Added patches that remove the use of 'test-tool read-cache --table' and
>    its implementation.

I still think a couple things in patch 2 deserve some comments about
the expectations.  Other than that, though, the series reads nicely
and I was only able to spot a few other very minor items.

> Derrick Stolee (5):
>   fetch/pull: use the sparse index
>   ls-files: add --sparse option
>   t1092: replace 'read-cache --table' with 'ls-files --sparse'
>   t1091/t3705: remove 'test-tool read-cache --table'
>   test-read-cache: remove --table, --expand options
>
>  Documentation/git-ls-files.txt           |   4 +
>  builtin/fetch.c                          |   2 +
>  builtin/ls-files.c                       |  12 ++-
>  builtin/pull.c                           |   2 +
>  t/helper/test-read-cache.c               |  64 ++---------
>  t/t1091-sparse-checkout-builtin.sh       |  25 ++++-
>  t/t1092-sparse-checkout-compatibility.sh | 129 ++++++++++++++++++++---
>  t/t3705-add-sparse-checkout.sh           |   8 +-
>  8 files changed, 165 insertions(+), 81 deletions(-)
>
>
> base-commit: 3fffe69d24e4ecc95246766f5396303a953695ff
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1080%2Fderrickstolee%2Fsparse-index%2Ffetch-pull-ls-files-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1080/derrickstolee/sparse-index/fetch-pull-ls-files-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1080
>
> Range-diff vs v1:
>
>  1:  451056e1a77 ! 1:  f72001638d1 fetch/pull: use the sparse index
>      @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
>
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: blame' '
>      -  ensure_not_expanded blame deep/deeper1/deepest/a
>      +  done
>        '
>
>       +test_expect_success 'sparse index is not expanded: fetch/pull' '
>  2:  e42c0feec94 ! 2:  58b5eca4835 ls-files: add --sparse option
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
>       + test_all_match git ls-files &&
>       +
>       + # With --sparse, the sparse index data changes behavior.
>      -+ git -C sparse-index ls-files --sparse >sparse-index-out &&
>      -+ grep "^folder1/\$" sparse-index-out &&
>      -+ grep "^folder2/\$" sparse-index-out &&
>      ++ git -C sparse-index ls-files >dense &&
>      ++ git -C sparse-index ls-files --sparse >sparse &&
>      ++
>      ++ cat >expect <<-\EOF &&
>      ++ @@ -13,13 +13,9 @@
>      ++  e
>      ++  folder1-
>      ++  folder1.x
>      ++ -folder1/0/0/0
>      ++ -folder1/0/1
>      ++ -folder1/a
>      ++ +folder1/
>      ++  folder10
>      ++ -folder2/0/0/0
>      ++ -folder2/0/1
>      ++ -folder2/a
>      ++ +folder2/
>      ++  g
>      ++ -x/a
>      ++ +x/
>      ++  z
>      ++ EOF
>      ++
>      ++ diff -u dense sparse | tail -n +3 >actual &&
>      ++ test_cmp expect actual &&
>       +
>       + # With --sparse and no sparse index, nothing changes.
>      -+ git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
>      -+ grep "^folder1/0/0/0\$" sparse-checkout-out &&
>      -+ ! grep "/\$" sparse-checkout-out &&
>      ++ git -C sparse-checkout ls-files >dense &&
>      ++ git -C sparse-checkout ls-files --sparse >sparse &&
>      ++ test_cmp dense sparse &&
>       +
>       + write_script edit-content <<-\EOF &&
>       + mkdir folder1 &&
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
>       + git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
>       + test_must_be_empty sparse-index-out &&
>       +
>      -+ run_on_sparse git sparse-checkout add folder1 &&
>      ++ # Add folder1 to the sparse-checkout cone and
>      ++ # check that ls-files shows the expanded files.
>      ++ test_sparse_match git sparse-checkout add folder1 &&
>       + test_sparse_match git ls-files --modified &&
>      -+ grep "^folder1/a\$" sparse-checkout-out &&
>      -+ grep "^folder1/a\$" sparse-index-out &&
>       +
>      -+ # Double-check index expansion
>      ++ git -C sparse-index ls-files >dense &&
>      ++ git -C sparse-index ls-files --sparse >sparse &&
>      ++
>      ++ cat >expect <<-\EOF &&
>      ++ @@ -17,9 +17,7 @@
>      ++  folder1/0/1
>      ++  folder1/a
>      ++  folder10
>      ++ -folder2/0/0/0
>      ++ -folder2/0/1
>      ++ -folder2/a
>      ++ +folder2/
>      ++  g
>      ++ -x/a
>      ++ +x/
>      ++  z
>      ++ EOF
>      ++
>      ++ diff -u dense sparse | tail -n +3 >actual &&
>      ++ test_cmp expect actual &&
>      ++
>      ++ # Double-check index expansion is avoided
>       + ensure_not_expanded ls-files --sparse
>       +'
>       +
>  -:  ----------- > 3:  5ffae2a03ae t1092: replace 'read-cache --table' with 'ls-files --sparse'
>  -:  ----------- > 4:  b98e5e6d2bc t1091/t3705: remove 'test-tool read-cache --table'
>  -:  ----------- > 5:  f31a24eeb9b test-read-cache: remove --table, --expand options
>
> --
> gitgitgadget

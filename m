Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FAAC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9A860E54
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhIOUUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhIOUUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556CC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:18:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso5292712otp.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdOJRZis+VtupprnkP53huRzOP0Rhfsn54wjKXSJkMQ=;
        b=gaCt8v/Nvnxo8VItiksZML8v2NDGYseVVWGVHNDKcLYcjZiMgr/wlVOUZB8fS6XxZR
         NP1IGWRskRo1WnVU94yIrTP1IjiJh+4oeSn+WOqQ/5Q3WXMluqZ4MrJSP/eug7FHdYaF
         3nK72IXLEdI/Xe23xTga6b/Y6iwAoxreXMc4HsKDL5Djo5WwakjWtV3iUks78/Wun/WW
         SscHOztKQQlKvsWoWQ4vfLNg+L8KzmJL10YG5AVAx2NGr6xkHT4G2rDy8K0Eet8vtwUA
         s7lPPlpcc+dkZ5vetQzUr36CUGgCzw0xNIaZzIT3sR8G477IREKloNJe2FQsCkwgtW1P
         Ta3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdOJRZis+VtupprnkP53huRzOP0Rhfsn54wjKXSJkMQ=;
        b=vS22UZTZQcR+OLAycAvMpXhMnpVtWxybHf3IwTORkQ8RvPqOjKM0traLSwqR0Qgmpz
         MevqCTD7GmZRGFfadu546R7tKA5I8qXoRaEdtsqtrfvHiWXoS4udMz55M/QH7le6ZBQe
         oRQ8yarNHxIc24HNGxDbvVUs/V3GmbSJixqKwGy9MxLGQk2s26KOrnHAeh7QICeK/HWz
         UcwFXfhJLQq90ao5thvwkaEkrQz6R8wZFxaNBPQJUugJE1VTFtREkKwV2ruwA9lvsPc3
         zVp90aWqZJkd/K7468nz4Z79XW3D7paPGFbkQ8sIoVFGZ/JGTeWPtcsqHKMDXR8NXfqi
         pMGg==
X-Gm-Message-State: AOAM533JbiUR3ixxqVkhetsQnjnCVnpozpMJVL6b3wIGmwJtbnJcKYbu
        Tx48f8GOXpPgASOJhIZMShXn2kVGKpugqkVDUZU=
X-Google-Smtp-Source: ABdhPJx/0aPnHk5keUehd+5I98f9AxwqkfrrnKHR/M+MABe8524gqb5RH/bjfkQjbUlCMhuFgjGKVw3OaVs51TJ4rzg=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr1645453otj.276.1631737134657;
 Wed, 15 Sep 2021 13:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Sep 2021 13:18:42 -0700
Message-ID: <CABPp-BHCovLmjpHG0mhYJ5CSR0p2kMqmLaKq4GihyokJ5YnJoQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm', and
 'git add' behavior
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on ds/mergies-with-sparse-index.
>
> As requested, this series looks to update the behavior of git add, git rm,
> and git mv when they attempt to modify paths outside of the sparse-checkout
> cone. In particular, this care is expanded to not just cache entries with
> the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
> definition.
>
> This means that commands that worked before this series can now fail. In
> particular, if 'git merge' results in a conflict outside of the
> sparse-checkout cone, then 'git add ' will now fail.
>
> In order to allow users to circumvent these protections, a new '--sparse'
> option is added that ignores the sparse-checkout patterns and the
> SKIP_WORKTREE bit. The message for advice.updateSparsePath is adjusted to
> assist with discovery of this option.
>
> There is a subtle issue with git mv in that it does not check the index
> until it discovers a directory and then uses the index to find the contained
> entries. This means that in non-cone-mode patterns, a pattern such as
> "sub/dir" will not match the path "sub" and this can cause an issue.
>
> In order to allow for checking arbitrary paths against the sparse-checkout
> patterns, some changes to the underlying pattern matching code is required.
> It turns out that there are some bugs in the methods as advertised, but
> these bugs were never discovered because of the way methods like
> unpack_trees() will check a directory for a pattern match before checking
> its contained paths. Our new "check patterns on-demand" approach pokes holes
> in that approach, specifically with patterns that match entire directories.
>
>
> Updates in v2
> =============
>
>  * I got no complaints about these restrictions, so this is now a full
>    series, not RFC.
>
>  * Thanks to Matheus, several holes are filled with extra testing and
>    bugfixes.
>
>  * New patches add --chmod and --renormalize improvements. These are added
>    after the --sparse option to make them be one change each.

Sorry for taking so long, but I finally read through the series.  Only
had a few small comments here and there; the high level direction
looks good.

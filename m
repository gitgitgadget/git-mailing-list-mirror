Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9EC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D990D610C7
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFISPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:15:03 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34411 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 14:15:03 -0400
Received: by mail-ot1-f51.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so21757782ott.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFgU3pyilBQdEITPkU4zAQVORyL3t2E1NLCnAJicLEY=;
        b=OukObsMphQPWVOdVbxVRGBA4HubOSsrMFEchRWDWPgDrDIN3R8rD6TrnmgbAKfkm1x
         IpqyhoLrHXQbtWr9gFftUrbislVArBpgA7lYADi5cKeGgu+d5nT/2kLjniR3iIUtuZ3J
         EzL5c3t6TCVsMC231oWJ7p/3F7ysheT+xH6q+posCwnD5NHBoKHxfNxwIPmGX8NuDj6E
         5jKT7G+llIcs6BM03QvfsWfIaAfJP3NSFVGlPwxDuwtSaiXPnrs/S5NTJL6YTcbtnoqR
         tezeB51W+Wc7QpR6WY9Hr4pPo9VPpjszYrWItRQSmw0B3AbpeGVTOvX+THhWWK59ZQ2s
         QO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFgU3pyilBQdEITPkU4zAQVORyL3t2E1NLCnAJicLEY=;
        b=mz9VfIacAg1oKBbMiJ22szroj5TnFcQUqX9WS4Yw53SNcBmN24nlksgEqdXNeVVHdA
         PU14hPZWFnXnKHCR2VxDeKG1SMYfm+sUVFAGbg8j4Nwj7ocVBMdyKYfp0i0k8iCxq3HB
         x/wTtL+aR48oizFSg5GU0QjkXYgCJL4Ob9A1yEchaeGXf5uqpo7XcyelL/2BLW8liUTF
         rmLmeVJ7X8mnWy+Q36EwS/KmQtrBBqkYZI60ueZr5vfdLj7wqBTQFtUjSoHMjxo9utPd
         Fzskaw9m1D0lem0W6G/HaIjsCaYsw1inT9pgarIb5BSt+Ao2lao+oRIKPmTOZnumcfRj
         9OAw==
X-Gm-Message-State: AOAM530jW7FyFFh6+Ux2oBZg2RBc7UiqjA8KcKsbjmKPfU48QeeY+kpV
        tQmRqInWgxbGPXeIa11Wx81+8rNkASOtqir1tOk=
X-Google-Smtp-Source: ABdhPJyGQHweQsTeMtAvObipbqsBJLxL7mHeSZvrA/RxKpprF4dZ/vERt9DZhLTxJ5TDBNr6dgy+oltbDlIf1YzXk5M=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr580384ote.316.1623262316170;
 Wed, 09 Jun 2021 11:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <8aa41e749471df3bd9d593b8f55db6506eafea12.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BGrAU==rEjtX5DNXs05_pcSVzAZBTFxGgGEA+xUO1oS1Q@mail.gmail.com> <23508662-37f2-97a4-3cf0-916a3705a272@gmail.com>
In-Reply-To: <23508662-37f2-97a4-3cf0-916a3705a272@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Jun 2021 11:11:45 -0700
Message-ID: <CABPp-BEFdFngS7++u7Bw4BBAC+ja0-2AdkRjxcD21FoAJAHjzA@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] sparse-index: include EXTENDED flag when expanding
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 9, 2021 at 10:39 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/8/2021 2:56 PM, Elijah Newren wrote:
> > On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> When creating a full index from a sparse one, we create cache entries
> >> for every blob within a given sparse directory entry. These are
> >> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
> >> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
> >> correctly written to disk in the case that the index is not converted
> >> back down to a sparse-index.
> >
> > In our previous discussion on this patch from v3
> > (https://lore.kernel.org/git/cb9161ca-dc6e-b77b-1a41-385ed8920bb2@gmail.com/),
> > you said you'd explain the reason for this change in a bit more
> > detail, but the commit message has not changed.
>
> Thank you for the reminder.
>
> > Could this be corrected?
>
> How does this sound?
>
>     When creating a full index from a sparse one, we create cache entries
>     for every blob within a given sparse directory entry. These are
>     correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
>     flag is not included. The CE_EXTENDED flag would exist if we loaded a
>     full index from disk with these entries marked with CE_SKIP_WORKTREE, so
>     we can add the flag here to be consistent. This allows us to directly
>     compare the flags present in cache entries when testing the sparse-index
>     feature, but has no significance to its correctness in the user-facing
>     functionality.
>
> I have this in my local branch for now, but can update it before the next
> version.

Thanks; this looks good to me.

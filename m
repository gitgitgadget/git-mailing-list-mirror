Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFC5C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257F26138C
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFCOQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:16:04 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36478 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 10:16:03 -0400
Received: by mail-ot1-f41.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5876581otl.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34b0cg1cuXn+h6Pe9//LnEhOJd1CvITd7snsszAKMLE=;
        b=i10IUIxqRep+/859J1Fh5J3Z9ayUxaYoKJT9v9vOQGTxYRyhgfIBRpIKrFTkcA8bnD
         zC4VrR6KJajbnCaZfmUwwZkDOJ+gIA6ZSZqI9EDsNkwlXE6/EPEvm/X/nRtH752NGsz3
         7sIvm0tlORi0B2t3df23j4ccLvt3ra6dcs/zwCZ84zcPcQTvW7k7a/CVEeB8SQ+HuLbS
         18Dh2319T8TCjOaEJ1KC944X0V4LIXyPGNkiNN9DqcE9AYkF7Em7bt4Yg0e+FYi6XzKX
         PXObW+zmXG8xgPc028Rm9osjWQMTBsAdHoiyqbF+oeFfKpHcWlVobHkKsWxVXOqaZsos
         MbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34b0cg1cuXn+h6Pe9//LnEhOJd1CvITd7snsszAKMLE=;
        b=TDcsYfUnRusr9ZKScnVQ53KzWAdcw7V0fW+/dHbfR0tgmOT1lyIG8R2LWCne0u6Pgv
         OkVZy+Hu92CwqfnCq6caU5BueNtDdIlFsGXgDtZ6N7JikgKob6Xq/crHPGpB3ajkqBDG
         +b2VgeIhtuoEq+bRIQw8KGolXs5kAcOOLWRTbEwQzCTbfiPdbt4gOlUnf77vpZbXKrdL
         qSe//ce/yI+r/XSVXnBJyOpVmVkOfxByCriuGoFbRK/AUvcLdgH3Hrodnmv62d6LHlbh
         z13fzm2p1oojdzd+7qKCRQ+3JpzoCjjk8gOWSpDI8zpaheUdzc872sKsTX2/vHmPOQQ1
         ik3Q==
X-Gm-Message-State: AOAM530gSQil9kzxI3TVH+h2NJ8jZYotAY1n+LGpPksYdfQpjVBsuZ2l
        GdwwJRshsEWP8BDmClfqJZpzkmuPWQawBqWzTss=
X-Google-Smtp-Source: ABdhPJz/ZH8uWChrZpgyCone2uqQypRZtUdS645jn30KY/1C8dCtFkAL+n87zEZQhR/C5Uey38iMLJmGQqg+VOJjMyA=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr2742639ote.316.1622729598866;
 Thu, 03 Jun 2021 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <pull.962.v2.git.1622559516.gitgitgadget@gmail.com> <45e1de5fe7808f5297d5e33d14c239d74de33bdc.1622559516.git.gitgitgadget@gmail.com>
 <1016e500-8169-7bb3-8428-b5ea35d19630@gmail.com>
In-Reply-To: <1016e500-8169-7bb3-8428-b5ea35d19630@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Jun 2021 07:13:08 -0700
Message-ID: <CABPp-BHaGEKYKCbwJxYgk7mY_mx6h9dSReRn=PXEpd0xCzqsdg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] diffcore-rename: enable limiting rename detection
 to relevant destinations
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 5:54 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/1/2021 10:58 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Our former optimizations focused on limiting rename detection to a
> > pre-specified set of relevant sources.  This was because the merge logic
> > only had a way of knowing which sources were relevant.  However, other
> > callers of rename detection might benefit from being able to limit
> > rename detection to a known set of relevant destinations.  In
> > particular, a properly implemented `git log --follow` might benefit from
> > such an ability.
>
> I would be interested in seeing such an improvement. It could also
> help the batch-download of missing blobs in a partial clone situation
> because it would only need the "deletes" portion of the diff, since we
> only care about one "add" (we'd need that blob, too, of course).

Oh, good point.  And in order to work well with the new prefetching
improvements (which will be the next series submitted), I should
really rename remove_unneeded_paths_from_src() to
remove_unneeded_paths() and add a relevant_destinations parameter and
use it, instead of having the strset_contains() check in
diffcore_rename_extended.

> > Since the code to implement such limiting is very similar to what we've
> > already done, just implement it now even though we do not yet have any
> > callers making use of this ability.
>
> However, I'm not sure that this change is warranted without such an
> integration. Perhaps keep this patch here on the list as a reference
> for anyone who wants to do the `git log --follow` speedup? This person
> can include "you in the future".
>
> I'm just worried that without a consumer, this code has no automated
> validation and can either be buggy now or become buggy in the future
> before someone starts trying to use the logic.

Fair enough; I'll pull it out.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A4FC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A9161374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhHWRzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhHWRzP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:55:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AB6C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:54:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso33482476otp.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAOjcGUPasDdUcDy70/Ty/v3ZNkkEyAoztz18dlu2Ak=;
        b=veeqLPrSRYv7t9mjQTE5Z4hagK2o4ob/dTEABjgj6/yriR5L6Cy9ylq/dMqDWPJqyK
         JfilsWtOBEocSnQNdMz0crcIs20AhegOMmasP/urX4LTLZC3i6f6qSa5OXwxsrLato8w
         YjGtS9bt4VhH/+fVTjnAha1FPUIW7TRTX44USD9KobumwOBRaGk12BAc0QbKWU9TaoKs
         f2CxtAHh/zsjs44tqE6TytaoRoB6UBIUS5+5LYWtrSvTCuc8VUUU3FoglKi+YA0A10Qb
         u8aH6DIxf4/ibcFewlDWN6siOHtI5xZO5AyuyMTePmQHJPI+J7388SN8C88V392E+MdX
         yRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAOjcGUPasDdUcDy70/Ty/v3ZNkkEyAoztz18dlu2Ak=;
        b=Kgywea0eLESAdNwFK9M6IcVvqZaqqvwQfRiqT83D2ZA0NpNjfg0PK+WV1V0oW9X5S9
         3lgs0zrPlZGBdMLABmnfIOUk0FC7NSOwrdgBxnmfGEpnqxmzvyPmThngCHseNG/A7+kO
         /PiZKJiWM/BMM11zPZSwElSs0hfOjGDfnt63WZUk8pf8M1kwkj8AZs+TdRIyKYiCls9y
         C69TQg/KNa/ayFIjaR7XpDey6IRZ9JuWxZBceXZhbu4uhHJW87IhMHDdKWOEIVInP6y0
         jRWxfJw+HnjIgFSbi1cSZtfGMDODglqiwzxhhRP2zaZXLg+BAvupRIVyI/dGhdv0VbCQ
         OJyg==
X-Gm-Message-State: AOAM5335mC4x//jw4gqTbx0Cc8vb8RRMthJrBeJhiiZ+MoNprKQ1WAqf
        qZj/xYiCl5VOoDjwR41TYDqROejV/UFghJPuxYg=
X-Google-Smtp-Source: ABdhPJyFyn6RejO10YMz1o6/v6TLEohho1dHsNnumLMI2JH/RYJO3t216kZuOXmNbTx1FfP0w/PfqD/p1q149OToG7U=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr12370974oib.39.1629741271919;
 Mon, 23 Aug 2021 10:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com> <5c0f41fb-e8d2-0aa5-66a3-6a61a98e8381@gmail.com>
In-Reply-To: <5c0f41fb-e8d2-0aa5-66a3-6a61a98e8381@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Aug 2021 10:54:20 -0700
Message-ID: <CABPp-BFF4S13NUjznqYfZ01ceJT7aGV3ybz8Yx2TWTcg3ri+eA@mail.gmail.com>
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 6:14 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/16/2021 1:48 PM, Derrick Stolee via GitGitGadget wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Copy the 'index_state->dir_hash' back to the real istate after expanding
> > a sparse index.
> >
> > A crash was observed in 'git status' during some hashmap lookups with
> > corrupted hashmap entries.  During an index expansion, new cache-entries
> > are added to the 'index_state->name_hash' and the 'dir_hash' in a
> > temporary 'index_state' variable 'full'.  However, only the 'name_hash'
> > hashmap from this temp variable was copied back into the real 'istate'
> > variable.  The original copy of the 'dir_hash' was incorrectly
> > preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
> > the stale version (in 'istate') would be corrupted.
> >
> > The test suite does not operate on index sizes sufficiently large to
> > trigger this reallocation, so they do not cover this behavior.
> > Increasing the test suite to cover such scale is fragile and likely
> > wasteful.
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >     sparse-index: copy dir_hash in ensure_full_index()
> >
> >     This fix is an issue we discovered in our first experimental release of
> >     the sparse index in the microsoft/git fork. We fixed it in the latest
> >     experimental release [1] and then I almost forgot about it until we
> >     started rebasing sparse-index work on top of the 2.33.0 release
> >     candidates.
> >
> >     [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp
> >
> >     This is a change that can be taken anywhere since 4300f8 (sparse-index:
> >     implement ensure_full_index(), 2021-03-30), but this version is based on
> >     v2.33.0-rc2.
>
> I sent this patch on the day of v2.33.0, so I'm not surprised that it
> got lost in the shuffle. Could someone please take a look?
>
> It also has not been picked up for the What's Cooking email.

Explanation and the code make sense to me.  This function uses some
pretty low-level knowledge of how index_state is structured to do its
job, and if index_state is updated in some significant way (which
isn't likely), then someone would have to update this function.  I was
trying to think whether there was a way to future proof this function
against such possibilities to ensure the need to update it is noticed,
but I'm not sure there is one.  But index_state doesn't seem
particularly likely to change, so this is probably fine.  So, here's
my ack.

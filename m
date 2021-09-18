Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A676C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97AA6044F
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhIRWGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhIRWGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 18:06:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB29FC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:04:40 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x10-20020a056830408a00b004f26cead745so17976042ott.10
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7iQmW2FL1rD4lIzFDY1Lu/RxzCXxEi63sN0WVrNCV4=;
        b=MFY8qdHWvGDBVfQvE+wFfLM5GjgAlsVr2tvz76lficwktQHfPICou5vCE416raz8sO
         MwXvZ+HiLta3t3g+96Sy7uWtVEgcRW8cyzV2XgJqY/h2BQkauHy8eNVnRZi2nvyiw4mL
         MLVEE8iehBX+DdsVCPE/n+3Oh0WSSt4Lh8OgTZgNGIq+BxbgLunUD1+CWsxWiZxhj63R
         o7GCdaLvjghBD/QeH5S3iUh4BE4QVBN2gE4zwhncHpX3PqCkN8JtT32jkSUz4+fZ/J+g
         VHef2JqmGwi9ugnNA+9DSLfX536FFk+xYP/xnOxCrmkVtf1au9jB90XjilzUG1IrKMjO
         zVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7iQmW2FL1rD4lIzFDY1Lu/RxzCXxEi63sN0WVrNCV4=;
        b=BYYNwXU4K0QUdChPLnndjBviUCyD7MHuvS6QcdALlycAPpV0tt9nUFwUsmpEFJGKeX
         NzPAv+ZHe4o3WoxFQnkJ06hm5hbakkzRob2ti8NBT6EQICcA+MXN2KZwCCq5wruDx6Y1
         MDdf80wEee54FybiDJ6M6CC5SptBo+YKEaSS1oSbN2toy83ih1IBND7SPJHQ2+WH0Ivt
         ObQd4HZ56teG+wOiyy01jbJhcfr6EtChXGFDS/bmL9nkiVpmQsxpm3uSFTGY/HZLpYen
         97eUfk9ZIiKCRW5XBmgvFO9Z+8YuvqOGUiJlZ2PXEuo5FrzvrXG3eE0IsDplXmZ+YarK
         Desw==
X-Gm-Message-State: AOAM5316l1pzmf9O187UhzW0Tw4HJICa0ILVweO8ettCqCWCIwhWdzR8
        kq7t/YFWpCXsWvckC90K20m/rfdt5GzAdZPciRGj/x48
X-Google-Smtp-Source: ABdhPJyp2dIx2NJZL8zMH6wIVIa00Q48EOz1Mrs8IRJthS6RyTg7icKBY+kYXD9+/KlJ772HNSdqDrZTDOGgRsh7Gf8=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr15353681otj.276.1632002680143;
 Sat, 18 Sep 2021 15:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com> <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
 <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
In-Reply-To: <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Sep 2021 15:04:28 -0700
Message-ID: <CABPp-BFQ8wDinW9MuOU6FuGq_h5W=4nv2hVhO0R6bbCxzv_Vyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, Sep 15, 2021 at 3:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 11/09/2021 18:03, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
> > index 25c4b720e72..de9c6190b9c 100755
> > --- a/t/t6427-diff3-conflict-markers.sh
> > +++ b/t/t6427-diff3-conflict-markers.sh
> > @@ -211,4 +211,60 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
> >       )
> >   '
> >
> > +test_setup_zdiff3 () {
> > +     test_create_repo zdiff3 &&
> > +     (
> > +             cd zdiff3 &&
> > +
> > +             test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
> > +             test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
> > +             test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
> > +
> > +             git add basic middle-common &&
>
> interesting does not get committed

Well, that's embarrassing.  It also explains a lot too; I was
attempting to replicate a weird case I had seen and was surprised I
wasn't able to get it and saw some new really weird behavior instead.
Turns out that new weird behavior was just the fact that zdiff3 wasn't
kicking in because the file wasn't even tracked.  If I had added it,
it would have duplicated the original case I saw...

> > +             git commit -m base &&
>
> adding "base=$(git rev-parse --short HEAD^1)" here ...

Don't you mean to add this below inside the next test_expect block,
where it is used?  But yeah, good idea.

>
> > +
> > +             git branch left &&
> > +             git branch right &&
> > +
> > +             git checkout left &&
> > +             test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
> > +             test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
> > +             test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
> > +             git add -u &&
> > +             git commit -m letters &&
> > +
> > +             git checkout right &&
> > +             test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
> > +             test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
> > +             test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
> > +             git add -u &&
> > +             git commit -m permuted
> > +     )
> > +}
> > +
> > +test_expect_failure 'check zdiff3 markers' '
> > +     test_setup_zdiff3 &&
> > +     (
> > +             cd zdiff3 &&
> > +
> > +             git checkout left^0 &&
> > +
> > +             test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
> > +
> > +             test_write_lines 1 2 3 4 A "<<<<<<< HEAD" B C D "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= X C Y ">>>>>>> right^0" E 7 8 9 >expect &&
>
> ... and then using $base rather than $(git rev-parse ...) would shorten
> these lines. It might be clearer if they were split up something like
> this as well
>
>         test_write_lines \
>                 1 2 3 4 A \
>                 "<<<<<<< HEAD" B C D \
>                 "||||||| $base" 5 6 ======= \
>                 X C Y ">>>>>>> right^0"\
>                  E 7 8 9 >expect &&

Yeah, that looks a lot better.

> > +             test_cmp expect basic &&
> > +
> > +             test_write_lines 1 2 3 "<<<<<<< HEAD" CC "||||||| $(git rev-parse --short HEAD^1)" AA ======= EE ">>>>>>> right^0" 4 5 "<<<<<<< HEAD" DD "||||||| $(git rev-parse --short HEAD^1)" BB ======= FF ">>>>>>> right^0" 6 7 8 >expect &&
> > +             test_cmp expect middle-common &&
> > +
> > +             # Not passing this one yet.  For some reason, after extracting
> > +             # the common lines "A B C" and "G H I J", the remaining part
> > +             # is comparing "5 6" in the base to "5 6" on the left and
> > +             # "D E F" on the right.  And zdiff3 currently picks the side
> > +             # that matches the base as the merge result.  Weird.
> > +             test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >expect &&
>
> I might be about to make a fool of myself but I don't think this is
> right for expect. 5 and 6 are deleted on the left so the two sides
> should conflict. Manually comparing the result of merging with diff3 and
> zdiff3 the zdiff3 result looked correct to me.

You are right.  Had I managed to add and thus track 'interesting', I
would have seen this correct zdiff3 conflict for it, and I hope I
would have figured out why I got the 'expect' file wrong here.  But
either way, thanks for catching and fixing both my bugs in the
testsuite.

> I do wonder (though a brief try failed to trigger it) if there are cases
> where the diff algorithm does something "clever" which means it does not
> treat a common prefix or suffix as unchanged (see d2f82950a9
> ("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We
> could just trim the common prefix and suffix from the two sides
> ourselves using xdl_recmatch().

You seem to understand the xdl stuff much better than I.  I'm not sure
how xdl_recmatch() would be called or where.  Would you like to take
over the patches?

Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DFFC33CB1
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A332206A2
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgA0QFe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Jan 2020 11:05:34 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45306 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgA0QFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 11:05:34 -0500
Received: by mail-wr1-f42.google.com with SMTP id j42so11955271wrj.12
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 08:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=viyqDWguB11yJ2DbgZCZIjKHxdnAYJbpXF1oc19U98Q=;
        b=ck1NUPu+ukxhXkXtO0mEAsxPAiYHhg6UUoAfih+usXha5sLrOdJ3tpq61gT69gwZIE
         vWvXnYB0NSr8PEym9211gbR/CJxEfk+J94D/mUF9i7Y7wjljTSzOBHCMA84lrNbIL08F
         N4t6V//k26yqPiHvA3Y9cr3t6K6l/nBSZG0BDNYvojJ9/WaXX8ZXtMWcGSKXeomLNBSx
         uu0c1GntCkK1js9dKRTf3NN42v1sVJIOKMkPhpfP3i3eaCfNXbsSYd6PBQI0i7//L3pI
         QBLw2Jp0+crmaY2cgtfCptYGpP5d4NYyxklTnq70nymuYEbSj+c5o+wXRnq57KHfBQAG
         hotQ==
X-Gm-Message-State: APjAAAVhUn3n6mp+locdELGIWZYIRs7rOWjw1ARXw86i1CD1ZjlGZQUC
        TxIa95rKQ9ALjKkRAC41aROZuIhOJm8C/C18XAx7emqX
X-Google-Smtp-Source: APXvYqxPj0pBVCmWLCHHSCxbl3HosoAiRxAsIvhdmaNni7SplIjj+CTQNpsPrf5mKcYhpZJ146oifmyFORAuLSga68E=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr9431929wrw.277.1580141132119;
 Mon, 27 Jan 2020 08:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20200125173744.4334-1-me@yadavpratyush.com> <20200127122610.GB10482@szeder.dev>
In-Reply-To: <20200127122610.GB10482@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Jan 2020 11:05:20 -0500
Message-ID: <CAPig+cS_H+FTcZkBz4dA94bAcxv0CZ8UG=P8jOGvD=HXzf8ODQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add shorthand '-d' for detach
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 7:26 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Sat, Jan 25, 2020 at 11:07:44PM +0530, Pratyush Yadav wrote:
> > Often someone might want to checkout an older commit in a separate
> > worktree to test it out without having any intention of making any
> > changes. Simply using 'git worktree add' means that a branch will be
> > created based on the name of the worktree folder. This branch will then
> > have to be deleted by the user once they are done with the worktree.
> >
> > An alternative to this is to create a detached worktree which doesn't
> > lead to a branch being created. This can be done by the '--detach'
> > option. Add the shorthand to make it more convenient to use it.
>
> I don't really understand what this commit message is trying to say,
> especially the first paragraph, or how it relates to adding short
> options.
>
> It could just say something along the lines of "'git worktree add' has
> a couple of long --options without corresponding -o short options, you
> wanted to type less, so let's add those missing short options."
>
> But then why only '--detach', and not the other long --options as
> well?

To answer this, it probably would make more sense to bundle this
change together with one which (from [1]):

    [...] improves git-worktree documentation to do a better job of
    pointing people at -d/--detach as a way to side-step unwanted
    branch creation [...]. That is, at minimum, enhance the
    "Description" section to prominently talk about throwaway
    worktrees (created with -d/--detach), and add an example to the
    "Examples" section (perhaps as the first example) showing
    creation/use/deletion of a throwaway worktree.

Toward that goal, adding the '-d' alias for '--detach' helps promote
throwaway worktrees as a first-class concept supported by
git-worktree. As mentioned in [1]:

    "git worktree add -d foo" is about as easy to type and remember as
    "git worktree add foo"

[1]: https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/

> > -'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
> > +'git worktree add' [-f] [-d] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
>
> '--detach' is still an accepted options, so please write it as
> '[-d|--detach]' instead.

I'd have no problem leaving this as '[--detach]'; readers can discover
the short alias easily enough where '--detach' is discussed without
mentioning it here.

> > If <commit-ish> is a branch name (call it `<branch>`) and is not found,
> > -and neither `-b` nor `-B` nor `--detach` are used, but there does
> > +and neither `-b` nor `-B` nor `-d` are used, but there does
>
> Here I would prefer to keep '--detach', because "detach" is a real
> word with proper meaning, while 'd' is just an abbreviation.

I fully agree with this assessment and was going to say the same.
'-b' and '-B' are special in that they don't have corresponding long
option names, thus they must be shown in short form, but long name
'--detach' is much more informative in this context (and the reader
can discover short '-d' easily enough without mentioning it here).
So, I'd drop this change (and the other similar one).

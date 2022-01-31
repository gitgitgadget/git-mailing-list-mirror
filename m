Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0491C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381015AbiAaRpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiAaRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:45:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DDC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:45:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so28464563edn.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwDGYtDnZqPgftDNT8078lqpIFYuBAAehWB8vsCTpW4=;
        b=RupT8LtrWvEzgie544cWggjosxaYGzJrEZ21NjC+wFqRfgOv7RK5S3jt0/xmJCQ+DT
         lXMXg9C9SbDNymFZFubJIf68iehOIFDgVJPH5V5mXi9WAlav9rC1dhht+uZ6wQ5zyyfv
         /BmvbnRbKOAYlXbut9xerFZ5oE7gvq+8ix9pE650A/q36HwwBVZ1QH5JXNiFNQuWKuYe
         Gitqw821OTLCOxbfRiFXEDTzIyi091+WrHy5ELCBRUMmGjANY2WE5Y0sEeRb4EB+3EXc
         4mXv/NnSNL/tFflAl1EoXQ5bQsw9sClM7uPMSgmzqLjbUxUbRBwrg9jK7c74C0r7tMV4
         BxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwDGYtDnZqPgftDNT8078lqpIFYuBAAehWB8vsCTpW4=;
        b=KcHvLD38kvYShtz/Wlza9ALXd5EmBzNeaAZTK1Pea5mRkM40kmpt+RRqfWNlxEsfc/
         8wPk6APsNVVG0Rvtk4QJp7jOo/M6OP2+AiuPr98UuiAyWt4TPI3xSXkU/yCDWiA/gQQ6
         wkWOmpkMCYEUFFSe9IYSInNYx6ixhdc+94qpJuacW3MCj5xd97vQGuPIbICSl/BXq7js
         qsa1mxAdA4SRkxhPCdRjQ/+qyKr0oE/TicP1qOCrhGUoEBCX+jg6EQTDHyzoQRPX8Ks6
         6moNo30swSizn0Ang5BQyjD8P8ErdLggyxgN3SzD8d+7RxlYxbjR4rbH81zkTWl+rJPA
         vhTA==
X-Gm-Message-State: AOAM531r9+W1/k6dUmhSebTIHueo5r1r289TioBOMP3DgQJbj4QlatBh
        6R7cxTRk3bNKgRN2wzS76PLk9RYj6C+6u0OmxFs=
X-Google-Smtp-Source: ABdhPJwMGKDRwgWsRUdU0vZFhagyPJCGf8FRNkfSjyQ649iOC9uRudetQr8bjMdnDqwokXpp9XF96jybxx26YUaoXj8=
X-Received: by 2002:aa7:d313:: with SMTP id p19mr22439710edq.380.1643651122185;
 Mon, 31 Jan 2022 09:45:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
 <CABPp-BH2sWWwy5bgn+R0hnnYQ6o0+1R1=VB-LYzDM+p4NMRhWg@mail.gmail.com>
 <CAP8UFD243zGGderSFtH5WxOhidAv6566Df6vdUfKRiBb1qu9tg@mail.gmail.com> <CABPp-BGYAgUbfJVMXTOTq3mMcBsFvrvRKA6KpLkcdDj7NvFEhA@mail.gmail.com>
In-Reply-To: <CABPp-BGYAgUbfJVMXTOTq3mMcBsFvrvRKA6KpLkcdDj7NvFEhA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Jan 2022 09:45:10 -0800
Message-ID: <CABPp-BFovPdTa6yXTbu2QvnD6a+DV5LAZ+CPNEcKD+5=dgsYfg@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 29, 2022 at 9:43 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Christian,
>
> On Sat, Jan 29, 2022 at 12:18 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Sat, Jan 29, 2022 at 8:04 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Wed, Jan 26, 2022 at 12:48 AM Christian Couder
> > > <christian.couder@gmail.com> wrote:
[...]
> > > > The reason is
> > > > that I think in many cases when there are conflicts, the conflicts
> > > > will be small and the user will want to see them.
> > >
> > > I'm a little worried about the assumption here that conflict size is
> > > measurable and visible via diffs.  That might be true in some cases,
> > > but a UI written with that assumption is going to be very confusing
> > > when hitting cases where that assumption does not hold.  For example:
> > >
> > >   * What if there is a binary file conflict, or a modify/delete or
> > > rename/delete conflict, or failed-to-merge submodule conflict, or a
> > > file location conflict? (For these, there is no diff relative to the
> > > first parent and hence this conflict would have no diff output for
> > > it)?
> > >   * What if there was a simple file/directory conflict?  A diff would
> > > show a rename (even when neither side did any renames), but not any
> > > conflict markers.
> > >   * What if there was a rename/rename conflict (both sides renamed
> > > same file differently) or a distinct types conflict?  The former
> > > results in three different conflicting files, none of them with
> > > conflict markers, while the latter results in two different
> > > conflicting files both without conflict markers?  Showing individual
> > > per-file diffs totally loses all context here -- it'll show no-diff
> > > for one of the files, and totally new additions for the ones.
> >
> > In those cases we just tell users that they cannot resolve those
> > conflicts in the user interface, see the following doc:
> >
> > https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#conflicts-you-can-resolve-in-the-user-interface
>
> So...I think you may have just convinced me that my fears were
> justified and that I should probably NAK any attempt to add diffs to
> the merge-tree command.  I won't jump to conclusions but you've
> provided some pretty strong signal to me against going down that
> route.  The list of limitations in the link you provide do mostly
> avoid the broken cases I listed above, but it enshrines those
> limitations on that webpage as fundamental rather than just as current
> implementation shortcomings.  You may not be able to remove those
> limitations on that webpage without either expunging the diffs from
> the UI or exposing the brokenness of the various cases above.
>
> If you do propose a diff option in the future, come prepared to
> discuss how you'll avoid accidentally leading others down into paths
> with the same fundamental issues, and/or how the above types of
> conflicts might still be meaningfully handled.

Actually, after having a few extra days to think about it, I thought
of something that should have been obvious to me, given my other
in-flight series that this depends upon...

If you used the same trick that remerge-diff does to include the
CONFLICT (and related messages) headers in the diff, then the kinds of
conflicts that are normally either invisible or misleading/confusing
to show via a diff would suddenly have the extra notices needed to
explain them, and make this problem tractable.

Further, it'd only make sense to do the special diff as part of the
merge-tree process, since it has the conflict messages strmap needed
to do this.

And there's not all that much work that would be needed to take
advantage of this, especially since this series already depends upon
the remerge-diff series.

So, maybe this is fine after all.

> Also, the list of limitations you have may not be quite comprehensive
> enough to avoid all problems (though it certainly avoids most of
> them).  Can I ask a couple clarifying questions about your list of
> limitations in that link? :
>
>   * When that page says the file cannot already contain conflict
> markers, is the check performed on the version of the file in the two
> trees being merged, or is the check performed on the 2nd and 3rd index
> stage of the merge result (these are not equivalent checks, even if
> they often give the same answer)?
>   * When that page says the file must already exist in the same path
> on both branches, is the check performed on by checking the path in
> the two trees being merged, or is the check performed on the 2nd and
> 3rd index stage of the merge result (again, these are not equivalent
> checks)?

I am still curious about this either way.

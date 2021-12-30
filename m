Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB71C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 17:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhL3Rkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 12:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL3Rke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 12:40:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E705C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:40:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so101908647edc.0
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JSW0/CI5fDYt1cXkvZI+ZryQo09Ar84A+yykiF488I=;
        b=obcjENJQSvDmGOBHjbssoEPWLmlEViX239W4VfWbAiAs/SzDGixvOqoZ5g31Xk0LI6
         q/z2eFZ2DK4+pp8RJc4N+oTtM9BqiKbHu41ozAsALD41ZCyj9CvBuNcvgVxdPHzXvgnU
         nv3up3WgMNazCx5rpn+Cm68r2D/dQbgMQ+Z/OBGuYZptuRXGIBTtXLGWLKTl6ZnDqa07
         92Dsi79zwzAvY2jvRpoS1aARQb0RtGjb7Y8j3S9mBe4tq3wb4lsUTN7Al5zfX0nYBBjB
         ZJRkN/QhiDuSsG/0calJ5GQ7+wWGhU0Azi2pqyljg+JgaptQFHMcII2tQhIJHE2E697T
         hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JSW0/CI5fDYt1cXkvZI+ZryQo09Ar84A+yykiF488I=;
        b=77VZPVqXC7FRuKxD37XmZHte7qdRwNnUTg+NqxSs1vSw9zV61QhSDLTc8s02YroWMg
         +HF8tyTRvNZ2brPcOXgfS5ykavlpbDmSSCVu5uyg7Fcmy/Lwp/D7PwiT4451UXxo0T9j
         CLj7bDON3gzLt17gdsRkyLKSuCmddles3SI5gN55q9WOTMgKE6kg9ezDIjCaJgTJlI9h
         Y1Y5uBj4OeNZm3KANMrknpNWku2mXIcFOIG97ZtsdOrSEGSzKcozIv0r8Q7J+WCTv/Hd
         nxyn1SeNq44dbJ2ak2EBxpWMcmb+yxs7Oye7iUlvOoKU/9O30CY1TLsYuPnoD1lerpC9
         RBLQ==
X-Gm-Message-State: AOAM5309qaskiGmVgtxibO86LiDbqkhmAVYtKAffrsNqYee+m5DTXRnp
        J+eF3cFcC6oQYkHLeAwzSVFfy8gfF+QMxZmAipc=
X-Google-Smtp-Source: ABdhPJzghmvc91tyUGleNo59TNzENA9HfwRsrLx2m3Br1l1tkDQbRzIku+yN78hai7qliTKwKGgMXNn9QJf+hFaa0Ko=
X-Received: by 2002:a50:da48:: with SMTP id a8mr30530937edk.146.1640886031785;
 Thu, 30 Dec 2021 09:40:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com>
 <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com> <CAPig+cRs4Vvp4rQ_EhMxB_qe4YAh3+NnqETTpYyMnAjsRhAUbg@mail.gmail.com>
In-Reply-To: <CAPig+cRs4Vvp4rQ_EhMxB_qe4YAh3+NnqETTpYyMnAjsRhAUbg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 09:40:20 -0800
Message-ID: <CABPp-BEtMLXqRUTO4TiVqMrGo51L2EOPLNz5CRf-L_rtPiqLHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 10:22 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Dec 27, 2021 at 3:16 PM Elijah Newren <newren@gmail.com> wrote:
> > On Sun, Dec 26, 2021 at 11:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Your proposal is _almost_ the same as my suggestion of eventually
> > > making per-worktree config the default. The difference is that you're
> > > only making it the default if `core.bare=true` or `core.worktree` is
> > > set.
> >
> > Indeed.  :-)
>
> I mentioned previously[1] that I needed to find a block of time to
> really think through the topic before I'd be able to respond to this
> email. So, today I spent some time trying to reason through the
> various cases under discussion, and I came back and re-read this email
> with the intention of trying to summarize my understanding of the
> situation and my understanding of the points you were making. However,
> you did such a good job of summarizing the various cases at the very
> end of [2] that it probably makes more sense for me to respond to that
> email instead.
>
> [1]: https://lore.kernel.org/git/CAPig+cTFSDw-9Aq+=+r4sHSzTmG7s2T93Z0uqWTxHbKwGFaiYQ@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com/
>
> > > But do we need that distinction? If people are comfortable with
> > > that, then are they comfortable with simply flipping the switch and
> > > making per-worktree config the default today regardless of `core.bare`
> > > and `core.worktree`?
> >
> > This is tempting, at least if we leave core.repositoryFormatVersion as
> > 0 (see 11664196ac ("Revert "check_repository_format_gently(): refuse
> > extensions for old repositories"", 2020-07-15)) when core.bare is
> > false and core.worktree was unset.  However, for that case:
>
> I had seen 11664196ac when researching one of my earlier responses,
> though it took more than one read to (hopefully) fully understand what
> it is saying (i.e. due to an oversight, it's too late to enforce the
> `core.repositoryFormatVersion=1` requirement when extensions are used,
> as originally intended).
>
> > * This is a case where operating on the primary worktree was not
> > previously problematic for older git versions or third party tools.
> > * Interestingly, git <= 2.6.2 can continue to operate on the primary
> > worktree (because it didn't know to error out on unknown extensions)
> > * git >= 2.19.0 could continue to operate on the primary worktree
> > (because it understands the extension)
> > * git versions between that range would suddenly break, erroring out
> > on the unknown extension (though those versions would start working
> > again if we migrated core.bare and core.worktree but just didn't set
> > extensions.worktreeConfig).
>
> The significance of versions 2.6.2 and 2.19.0 is unclear to me. What
> context or criteria are you using to identify those versions as
> meaningful here?

We had been discussing how certain config settings "might break
external tools OR old git versions", but hadn't brought up which tools
or which git versions.  I don't know which all external tools might be
in play (though I mentioned some in use at $DAYJOB in another thread)
but in this email I had just thought that I'd mention where the cutoff
point was in terms of git versions which understood
core.repositoryFormatVersion and extensions.worktreeConfig.  If other
folks also want to test how things behaved before or after these
patches with "old git versions", those were the switchover points that
are relevant and which I tested with.

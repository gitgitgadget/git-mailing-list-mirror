Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0126BC433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF24B20792
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 07:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDZSQhFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgG1HHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG1HHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 03:07:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61831C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 00:07:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b13so11588417edz.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Z9ybqLhLJWfWIssyFjjQ7zRuxZYsMp230gsCEk1SRs=;
        b=RDZSQhFOQZ7WlY+lhRcIi5FHzRBwSNfnMQg8GLZDcI1tFFkeD1DAb2Q8e/ghFBENQK
         f1COGxOrL3suA9tK1b2ZSB+1CD+g2bjb8nlCyxPBX6+5h6i1Z+t0Y3w8HNlseqXsTVoY
         nGpR5UUbQTQk8YFQE0/zbeMoHGKrcD/1Qzmee4zr2x5bV7wucOjxFBXYS4+pwwmwIs2I
         aCn0RtwO3jp9/bGp4jgawv/zRnvDZwl+eBoEIiPZEKeUjOQG35WGNeLgW3yjDLP8Cmmk
         5g8uwLF1KE50qyU057dmNA3Hdrgo4dg6GYiLJNzgUaBCqIv/Mmo2dC1xJM8M1OfP+PVd
         NqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z9ybqLhLJWfWIssyFjjQ7zRuxZYsMp230gsCEk1SRs=;
        b=m5eQj+gcl/2BHGWqUxYwSr7W8TjvqNCtxI4PO1eNvOInVCfQlfog9GzifghsXFgWp7
         qNO4j3xkxAir+O1k1alHYulKugn1fBgv8aIeQGXYKCAcGDts41Jkm1NofRnBTA+FM/8j
         pXWBbT5HaA6NilHdn+W/frV39p2cCOcfUwOkfBIhXTGHXcs93572xW8JGGAMkk+kXvkK
         inj8gW3Q+ntYlTpVW4bj2BrFzOdZKImIGEzxbABWwor5WpWkaSvoIQvb3WKMRiL26a6E
         nLTVdTOj7/4EavXpKsOaEG6lq6xIDruzMa3NNkQGRgO7VKJyr3QnoXWW5HezCFkOBARL
         fWyQ==
X-Gm-Message-State: AOAM530QrxUuiyCZQksa9Tyji/eDu77EOusv0Le7KOAmmhwfjDHPfYjP
        b+Lvf+CviU63rA1UMvd+lS33VgH1st2T1vIhiZA=
X-Google-Smtp-Source: ABdhPJzM18eKJz6d6OngQKSlTIxRSRy4eV7sO27Xd33rtGIGcq3w6ucmFY00gno3kPyvXuaAIKFW3kj1V4s46T4+0yw=
X-Received: by 2002:aa7:cdd2:: with SMTP id h18mr17837679edw.387.1595920050013;
 Tue, 28 Jul 2020 00:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
 <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com> <87a6zkr5z7.fsf@0x63.nu>
In-Reply-To: <87a6zkr5z7.fsf@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Jul 2020 09:07:18 +0200
Message-ID: <CAP8UFD1JZhNVDJ=fe-FLzmBqSbAwyaJuABK-G+-keL4LanZbpA@mail.gmail.com>
Subject: Re: Questions about trailer configuration semantics
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 11:41 PM Anders Waldenborg <anders@0x63.nu> wrote:

> Christian Couder writes:

[...]

> >> > Then there is the replacement by config "trailer.fix.key=Fixes" which
> >> > expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
> >> > which seems to be expected and useful behavior (albeit a bit unclear in
> >> > documentation). But it also happens when parsing incoming trailers, e.g
> >> > with that config
> >> >  $ printf "\nFix: 1\n" | git interpret-trailers --parse
> >> >  will emit: "Fixes: 1"
> >
> > Yeah, I think it allows for shortcuts and can help with standardizing
> > the keys in commit messages.
>
> Maybe what I'm missing is a clear picture of the different cases that
> "git interpret-trailers" is being used in. The "--trailer x=10" option
> seems clearly designed for human input trying to be as helpful as
> possible (e.g always allowing '=' regardless of separators
> configured). But when reading a message with trailers, is same
> helpfulness useful? Or is it always only reading proper trailers
> previously added by --trailer?

I guess it depends on the purpose of reading a message with trailers.
If you want to do stats for example, do you really want to consider
"Reviewed", "Reviewer" and "Reviewed-by" as different trailers in your
stats?

> The standardization of trailers is interesting. If I want to standardize
> "ReviewedBy", "Reviewer", "Code-Reviewer" trailers to "Reviewed-By" I
> would add these configs:
>
> trailer.reviewer.key = Reviewed-By
> trailer.ReviewedBy.key = Reviewed-By
> trailer.Code-Reviewer.key = Reviewed-By
>
> Seems useful (and works out of the box as a msg-filter to
> filter-branch). But the configuration seems a bit backwards, it is
> configured a 3 different trailer entries, rather that a single trailer
> entry with three aliases (or something like that).

Maybe taking advantage of the shortcuts and using only the following could work:

trailer.review.key = Reviewed-By
trailer.code-review.key = Reviewed-By

> >> > This in makes it impossible to have trailer keys that
> >> > are prefix of each other (e.g: "Acked", "Acked-Tests", "Acked-Docs") if
> >> > there is multiple matching in configuration it will just pick the one
> >> > that happens to come first.
> >
> > That's a downside of the above. I agree that it might seem strange or
> > bad. Perhaps an option could be added to implement a strict matching,
> > if people really want it.
> >
> > Also if you configure trailers in the "Acked", "Acked-Tests",
> > "Acked-Docs" order, then any common prefix will pick "Acked" which
> > could be considered ok in my opinion.
>
> Yeah, that works. But that dependency on order of configuration is quite
> subtle imho.

[...]

Yeah, I agree that documenting this would be nice.

> >> > * Should replacement to what is in .key happen also in --parse mode, or
> >> >   only for "--trailer"
> >
> > I think it's more consistent if it happens in both --parse and
> > --trailer mode. I didn't implement --parse though.
>
> Keep in mind that the machinery used by interpret-trailers is also used
> by pretty '%(trailers)' so whatever normalization and shortcuts
> happening also shows up there. Is shortcuts useful in that case too?
> There the input is commit history, not some user input.

Pretty %(trailer) was added later by someone else, but I guess it also
depends on the use case. Is it going to be used for stats? Is it
interesting to distinguish between very similar trailers in these
stats?

And again if people are interested in very strict processing, then
adding an option for that could be the right thing to do.

[...]

> There is also some inconsistency here. If one use '%(trailers) the
> normalization doesn't happen. Only if using '%(trailers:only)' or some
> other option.
>
> (because optimization in format_trailer_info:
>  /* If we want the whole block untouched, we can take the fast path. */)

Maybe that's a bug. Peff, it looks like you added the above comment.
Do you think it's a bug?

> I guess the fact that expansion happens also in these cases can get
> confusing if I have configured a trailer "Bug-Introduced-In" locally and
> the commit message contains "Bug: 123".
>
> 'git log --pretty=format:"%h% (trailers:key=Bug-Introduced-In,valueonly,separator=%x20)"'
> would pick up data from the wrong trailer just because I added
> configuration for Bug-Introduced-In trailer.

Yeah, I understand that it could be an issue.

> >> > Here is a patch to the tests showing these things.
> >
> > Thanks for the patch! I would be ok to add such a patch to the test
> > suite if it was sent like a regular patch (so with a commit message, a
> > Signed-off-by: and so on) to the mailing list. While at it some
> > documentation of the related behavior would also be very nice.
>
> Should I keep the "test_expect_failure" tests, or change into expecting
> current behavior and switch them over to "test_except_success"?

I think you should switch them over to "test_except_success".

> I'll see if I can do something about documentation.

Thanks,
Christian.

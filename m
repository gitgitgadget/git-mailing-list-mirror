Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448BAC54FD0
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202452064C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 12:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbYNQNTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgDUMR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMR1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 08:17:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A74C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 05:17:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id r7so10050140edo.11
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/e9K2pF8y7h0a8uFu3dqpXacEcF30kL4Ko92IDIb92Y=;
        b=DbYNQNToaECKs8SYDco5I+QsPbUtKaq7bqEnHNRgOhgjo+EyxTT532UqW4FnZbSMmd
         HqMz6Wy++R7Ty1uSRdbDACfoM/CLABP9HaCGt6SbytTq9ewkwrdY9xqQ52HME2DKeP9f
         fAV2En1DZab8u+oIyTqhJs6y1xELFIDQsvO4UJQ6XpBi8sEu6v/r6JFwSC1q6kmSrzRE
         pdzfvVgQEdepKqkHoPyfwQiWsNCyMZzZAKbmu365mgtTwExnqrntVuVHzVGf8uUGGBUi
         2lZfEpUmx5lRDtktALv07rTYuqqHJw2RwYLL+oLvtz69kRus2gCvEjUhcZl4MloR6QQW
         wtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/e9K2pF8y7h0a8uFu3dqpXacEcF30kL4Ko92IDIb92Y=;
        b=U56HDGEEqgJZuWhdqxLWBq0c6L6UCe+/EMIRroVnMa6eM8CG6r04W5lyUk6QGk5C0T
         Rmp9IP8BS8BXLXdYVELgYR8Q54zG39MhdjA6VqmVZ65++wFbfti4agNpmU5Ssn781KY7
         4f3mEoBRZwaWUw6JzUO0GNX+ABbOBIb2Ik7NwkPi8ee1ZWfw21Rq78uOtLum5cGfTPPe
         ARJzsmYXpVgED5eHOekHMcf8db/QWhR6JEgdLT/eBCyUBNiYv/9IJSttT3yM24Rxi7av
         Ri+XC2Y9DU+96+ZlZ+NVoT9GmQ1IZT9pRhyoGJ9oNBah6tf0oIIvbY9Xe5CBl7WhBIdb
         La2w==
X-Gm-Message-State: AGi0Pub3StRqWoaCP1omia5DvwlcifSIupK0EzJwxEktCA0WGo9nEJ5w
        qlZVTfrq3lRwz3N0FEbS8Z0fMpr9Aiif9GxjDYiNk4dqH8s=
X-Google-Smtp-Source: APiQypLQAAnAemxLbxERlkmh99+23BM1U+/ql/1I3kXG7w3COhzdq33Nnkr7y03zs+Agn9aHFOJCcpP+D5TI2jcr/po=
X-Received: by 2002:aa7:cc88:: with SMTP id p8mr18530572edt.387.1587471445514;
 Tue, 21 Apr 2020 05:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com> <20200417174030.GB2103@syl.local>
In-Reply-To: <20200417174030.GB2103@syl.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Apr 2020 14:17:14 +0200
Message-ID: <CAP8UFD1Yb+8Ox=dDkMfdBqBqW20FLfSnOY9hWhvx=8dx8OfXrw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        James Ramsay <james@jramsay.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 7:40 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Apr 17, 2020 at 11:41:48AM +0200, Christian Couder wrote:

> > What do you think about something like:
> >
> > [promisorFilter "noBlobs"]
> >         type = blob:none
> >         uploadpack = true # maybe "allow" could also mean "true" here
> >         ...
> > ?
>
> I'm not sure about introducing a layer of indirection here with
> "noBlobs". It's nice that it could perhaps be enabled/disabled for
> different builtins (e.g., by adding 'revList = false', say), but I'm not
> convinced that this is improving all of those cases, either.
>
> For example, what happens if I have something like:
>
>   [uploadpack "filter.tree"]
>     maxDepth = 1
>     allow = true
>
> but I want to use a different value of maxDepth for, say, rev-list? I'd
> rather have two sections (each for the 'tree' filter, but scoped to
> 'upload-pack' and 'rev-list' separately) than write something like:
>
>   [promisorFilter "treeDepth"]
>           type = tree
>           uploadpack = true
>           uploadpackMaxDepth = 1
>           revList = true
>           revListMaxDepth = 0
>           ...

You can have two sections using:

[promisorFilter "treeDepth1"]
          type = tree
          uploadpack = true
          maxDepth = 1

[promisorFilter "treeDepth0"]
          type = tree
          revList = true
          maxDepth = 0

(Of course "treeDepth1" for example could be also spelled
"treeDepthOneLevel" or however the user prefers.)

> So, yeah, the current system is not great because it has the '.' in the
> second component. I am definitely eager to hear other suggestions about
> naming it differently, but I think that the general structure is on
> track.
>
> One thing that I can think of (other than replacing the '.' with another
> delimiting character other than '=') is renaming the key from
> 'uploadPack' to 'uploadPackFilter'.

I don't like either of those very much. I think an upload-pack filter
is not very different than a rev-list filter. They are all promisor
(or partial clone) filter, so there is no real reason to differentiate
at the top level of the key name hierarchy.

I also think that users are likely to want to use the same filters for
both upload-pack filters and rev-list filters, so using 'uploadPack'
or 'uploadPackFilter' might necessitate duplicating entries with other
keys for rev-list filters or other filters.

> > > For reference, the patch I was thinking of was this:
> > >
> > >   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
> >
> > Are you using the patches in this series with or without something
> > like the above patch? I am ok to resend this patch series including
> > the above patch (crediting Szeder) if you use something like it.
>
> We're not using them, but without them we suffer from a problem that if
> we can get a SIGPIPE when writing the "sorry, I don't support that
> filter" message back to the client, then they won't receive it.
>
> Szeder's patches help address that issue by catching the SIGPIPE and
> popping off enough from the client buffer so that we can write the
> message out before dying.
>
> I appreciate your offer to resubmit the series on my behalf, but I was
> already planning on doing this myself and wouldn't want to burden you
> with another to-do. I'll be happy to take it on myself, probably within
> a week or so.

Ok, I am happy that you will resubmit then.

Thanks,
Christian.

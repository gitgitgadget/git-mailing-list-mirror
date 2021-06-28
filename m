Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA39C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C0A61C2E
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhF1DyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF1DyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 23:54:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D3C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:51:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h15so29799081lfv.12
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ+KNTw6JDWKGlVrLWnSP4jybv83V5n39TPkJDY6bk4=;
        b=ZivwzoEoeivin+DTweGrxi22vucZ9BB9t9UO9clklk/dZEIeQVPiy5uH4UFh9ygJ6v
         IXtlJe8O5s9V8mb4L7Fo4prnPdXHuIuxZ8huVBooqrcbpUm6j/i1FDSIM5/PAY7uy5He
         CeFG5FBK7Rc9X6eboFHx+YtNKmO97iPwjvgOJVeNCfaZ4SEGjPDBlFFPGHv3QbdP4fX5
         BxNTYKMkIEJvGOJbk1ozWRcGYI56onXqL7/E6dgxHKk87WkKTCojmseBzZxLZfnn4bOf
         o0pRMmr1hNqCY+raGwf5LfFWkmRoP9DqWnq1o8f8D83QwjALaUKB2T75os1Ib0hCZG9l
         EDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ+KNTw6JDWKGlVrLWnSP4jybv83V5n39TPkJDY6bk4=;
        b=qSHqiktXB5/FL+ms3MJ8bMaQLjMhh9L2E8mz8OlmRcqf49zAd7p6cRJXcHl3uCLHLp
         oaYrjtxTGq9cfe69B09IfSx6xnrlBem1H3gfCdmIW+5F5ElEXDtztMIviscWjmLJiFAc
         zPjrnhNjU7yzsNl9GzxSAhocn1XpgPuOxPlzhmDDllmNTEG92F7nNG/VwdrCT/rau43/
         I7Iz6LQvJxeG4+sEMXfzma31zyKkDIzSuLX1UXpoPhJuDY7E+AZtXpUMtvmlqY7T/Vz/
         9lcu+fWd1pO920vIUe+UCbjSWBifwrwHNfoTwqcC7rRbDmsgpiZYHr5IstwuQ/V/Rip6
         BOjA==
X-Gm-Message-State: AOAM533ZGRSgHlCZgWJibsUTlOQo4SwGPTz7lD4FaunKVZPbg5DJmd0j
        1yc6yLlNl8m3jsYcb5y6LFAADHnoYntvvGkUj1U=
X-Google-Smtp-Source: ABdhPJw2aWj2l4fcyURmQ2fXWfqhC22S4jUPBGPLGDINXUdoxD7UYGF+LrYJkLatrgoudUPAQ2uFzAjDJePa0Em7E3M=
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr17194688lfd.148.1624852302117;
 Sun, 27 Jun 2021 20:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210628031642.699156-1-felipe.contreras@gmail.com>
In-Reply-To: <20210628031642.699156-1-felipe.contreras@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 27 Jun 2021 21:51:30 -0600
Message-ID: <CAMMLpeQ9BVNHqk2p748+4+ufuWJ46fYUnVvMvwFPxh3N--ASPg@mail.gmail.com>
Subject: Re: [PATCH] pull: introduce --merge option
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 27, 2021 at 9:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> The idea came after a comment from Linus Torvalds regarding what should
> be the default mode of "git pull" and why [1].
>
> [1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/

Oh wow, I didn't realize that Linus gave his opinion on the subject
back in 2013, and he suggested doing nearly exactly what we are trying
to do now.

> ---no-rebase::
> -       Override earlier --rebase.
> +-m::
> +--merge::
> +       Force a merge.
> ++
> +Previously this was --no-rebase, but that usage has been deprecated.

I don't think --no-rebase should be "deprecated", at least not yet.
After all, the equivalent config option is still pull.rebase=false.
Also, --merge doesn't necessarily force a merge because it does not
imply --no-ff. I would prefer to list --no-rebase, -m, and --merge
together on the same line and leave the description alone.

But other than the documentation and the commit message, I like the
idea here, and I think it will make Git a lot more user-friendly.

-Alex

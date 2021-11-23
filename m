Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C47C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhKWXQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhKWXQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:16:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277DC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:13:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v1so1822931edx.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrGzvdJ3iNlSiNIQ7ASk5bV3832fdDF5TB9bOdEFT+Q=;
        b=gS8jBoSLw/MqGd71ue/qUQl0pVHhEjMKs9yHHH3iwHs7F+YKtIv6JvzcM53Iy09f0N
         0uzc3wJsVHhKbcozgUkFitnBhbbuaVIsMWROZW7VKFPp3xiBBJl3N98Hfu7A1LPKe4lM
         hYcKqw2NwdgCTE69tIK0+sjs3kP+FjBCdz+9GkdylSQFrNrg6eivITVMOtbo/Jnqr0a3
         622uH6JN9Q9uKHb15PZf/DOVBW3utvXABl/fyJXr42BE+bJYdMVfczT0k6jinhtjo25C
         JT4QFOpHCSJbDA6LiJsJn67QjpCHXqazysm0QrDwhMKGI6TfsJ0L/50WwprTY2GuEFqH
         IbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrGzvdJ3iNlSiNIQ7ASk5bV3832fdDF5TB9bOdEFT+Q=;
        b=S9MNTxPWJH4oaDktfJoKusODR8hWyGIzIsfNxWtS5IUGpDg7NGzWI8SVx5S9TOinRD
         lhFsUVH95j/NWtSwavJjqEJgBVNAXbs+LgXgGqrrqO8c1r+zM9EgU1LP5OiD7SrNctHp
         WZ/1cEUQQSrBmJCtj6HybgMMDfgNNifj2K8wBA8W/CqVMWsl60KwYNWsa0QbqTswtllZ
         Y9mAZRK+CFh3liwYZ8qvBihzhLiLgRXxFxWARbfvx2N05/gDxMyofNkxtklrhWkXEwpT
         JrulKZiSn9P2Z3uhmxAyerMSME8PtbtB0YmKBfrLnGBeapTFXq+NOA262+1c30Ba/G3h
         NB6w==
X-Gm-Message-State: AOAM531FDdxSLFwdZFHXWyznPNVpO42TGBrhZUhBacBZXH6J8T5WhkAE
        5rs3CgQYt/vIbzHZ2rXHSVR3J076S7heCCyllQg=
X-Google-Smtp-Source: ABdhPJz7pdF0qsJVlVlZFL8gxdNWY8R/DlAhpOTkjdJWSzfokeLobzIHTEHWRYdw4r2sQwQjn467WWKsAytIc7PfiHg=
X-Received: by 2002:a50:d6d9:: with SMTP id l25mr16431591edj.41.1637709202557;
 Tue, 23 Nov 2021 15:13:22 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com> <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 15:13:11 -0800
Message-ID: <CABPp-BHn0bE4ZSx25+28GD58sae=FVs63eQW-Fp8zwFAALcKFA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     Glen Choo <chooglen@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 12:33 PM Glen Choo <chooglen@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I agree that most, possibly all, of our commands should prefer to die
> >> than to remove the cwd, but that doesn't justify adding
> >> application-level concerns to a general-purpose utility function. Even
> >> if it sounds overly defensive, having an obviously correct utility
> >> function makes it easier for future authors to know exactly what their
> >> code is doing and why. And surely if we're imaginative enough, we can
> >> definitely dream up some possible use cases for remove_path() that don't
> >> want this dying behavior e.g. other applications that link to our
> >> libraries, or some new merge strategy that may need to remove + restore
> >> the cwd.
> >
> > Sounds like your objections here are based on a misunderstanding.  I
> > totally agree with you that adding dying behavior to these functions
> > would be wrong.
> >
> > My patch doesn't do that.
>
> Ah my mistake, that should be s/die/'stop gently'. Even so, that is not
> at the core of my objection, mixing of concerns is.

If I were to introduce a new function, say remove_path_not_cwd(), to
avoid this claimed mixing of concerns, what would that buy us?

I've looked at every single caller of remove_path() in the git
codebase.  If I did introduce a new function, as you seem to want, my
series would include two more commits: one that would replace _every_
call of remove_path() in the codebase with a call to the new function,
and one that would delete the remove_path() declaration and definition
in dir.[ch] since they would be unused.  The net effect would be
merely forcing git developers to learn a different function name.
(I'd probably also follow it up later with another commit to rename
remove_path_not_cwd() to remove_path(), for simplicity, and so I don't
have to remember the longer name anymore.)


I haven't yet found or heard of any potential callers, even
hypothetical, that would be harmed by the modified behavior.  Every
case suggested so far actually sounds like a good candidate for the
modified behavior.

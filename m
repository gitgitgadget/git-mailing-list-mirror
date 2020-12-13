Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D2C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 06:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0775323138
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 06:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgLMGIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 01:08:00 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46242 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbgLMGIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 01:08:00 -0500
Received: by mail-ej1-f52.google.com with SMTP id j22so68833eja.13
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 22:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpemVYvZrmOM0AhSoWkbPhjqxY2JbC+HXTzYlsyibGo=;
        b=Yoay3NnBysvG6KoyLRqiLnqofSwIfAYTh7tK4kj41IN/SWSPp1hG6prnPSNAUPnKlI
         /QfyR/qh+/Uq0yKfH/64KNH5FGoS+lmMFJWgacjmYn7pDp4O7AHgTuaLr7V6i2AbjXaD
         x/eflw8FFrSTBB096A2PpD4hnF2Y1TztaluTtm7krOUGwwIY8n0/ophQ/p62N5EpwaPZ
         OQkDDGfQYKf8hKmkwSkOK05h+Ry00ZMVFl5sDDeVDmb7ILZoDhuQLgzFbs+FW9lt+iAr
         SXStg6xKwRF5/mzGEmAht9naqWeCnBA1MDU6yVJiSHBUqhUUQNVgQlsGFadPu2cKkle5
         Jxog==
X-Gm-Message-State: AOAM532sU+yy/YCn/1zXwSSpLqTfZdT51xEIJpBHRWwfZpEv5tpuO6a0
        li4LwuTvwM+VKeaAZoK6SBV0GHhKYIlT+DFUmzwmT0d7
X-Google-Smtp-Source: ABdhPJwzTdHUG8q2c1aoc6Fn7YL9SplewN6yXafQ/8wZAMDDrrYsXKRIki0BuhWExnNaD6YxJqyBZRq2enBBR4ZMq8c=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr17697920ejb.168.1607839638860;
 Sat, 12 Dec 2020 22:07:18 -0800 (PST)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
 <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com>
 <A462326B-505D-4A92-B789-21BB8FE6AA16@gmail.com> <CAPig+cQad_yyVgwQQ-NZyy7SergM-fUMeMAm9RsV4zEqNt9TDg@mail.gmail.com>
 <CACsJy8Dq9Lz1YkkqvR0Fa1PLUBJhNJTmLtnRssi=DDpWAQTWww@mail.gmail.com>
In-Reply-To: <CACsJy8Dq9Lz1YkkqvR0Fa1PLUBJhNJTmLtnRssi=DDpWAQTWww@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Dec 2020 01:07:08 -0500
Message-ID: <CAPig+cRZ-018Krj2fGq0hx5qNptW8qUiwhkws8ixvk242Z_b0g@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Ganriel_N=C3=BCtzi?= <gnuetzi@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 4:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 9, 2020 at 2:27 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > What I was suggesting was that it might be the case that the only way
> > to solve this would be to store the location of the main worktree
> > somewhere within <repo> in some file, and then `git worktree list`
> > would consult that file to learn the location of the main worktree.
>
> Not that it matters because I don't do Git anymore. But when I was
> doing this I imagined unify main and secondary worktrees. When you
> switch from single to multiple worktrees, there is no main worktree
> anymore. The place that is main worktree still has your files, but it
> has the same status and treatment as any other worktree. And the repo
> is tucked away somewhere safe.

I had some vague thoughts along those lines, as well, but such a
change is outside the scope of my limited time these days.

Superficially, the idea I expressed above, of storing the path of the
main worktree in some file within the repository (let's say
`.git/mainworktreepath`) doesn't seem like it should be too difficult
(though I haven't really thought it through). And, if the main
worktree does get moved, the file could be fixed up or kept up-to-date
by the `git worktree repair` command.

(By the way, thanks for responding. It's nice to hear from you again
after your long absence.)

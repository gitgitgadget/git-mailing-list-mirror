Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC8C001B0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 16:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjHPQb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbjHPQbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 12:31:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A811980
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 09:31:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bb99fbaebdso11542521fa.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203465; x=1692808265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgTvJRpsvyKNBAqmJmDhZlcyMkn20ApwxoOEGev1qy8=;
        b=pxELjP/WRFvwBJk/3/zIXFkC/SEGDvqN9vRUPRgcS/Pal5pZOhEJOXfaT7a4AcYad5
         sLVGAiW/NluM42pRS+LzawVSV4lDmdUP5QneHUkEL2YctD7Q1qmQMhTqKEZ/c0LoOgGv
         3Th1qiot7lOmYPK3ZtIXRZ2NvrO6gqEA/2u9hbyfCVtBuFPUlBsG+QCnLlmDLu9fx+8r
         iY8Ajkr9pHD5bLlDrRXdaMPWNTyTCRcUIDdDrAX2McQslq6W7b1tTXtmfCPXCqyFFfr6
         6bH7jqt7z3GiJtHbUQb9wa29SZXZdNZqiuMz1Lj7kVyrXCURInVE1lJoJjuri8zEU5Tg
         b21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203465; x=1692808265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgTvJRpsvyKNBAqmJmDhZlcyMkn20ApwxoOEGev1qy8=;
        b=ga3o8lDX3Rl8NMK7T23SREn9CpidmYtNUf/xlynbZEt/ctAfn918K5NnEOa74vs+n2
         wEB9YYN2yk6Qmrs60lkeGLvoxuqpJg9r7psQG/PdupDIrg9yy7U+Fd+YMDK3lMnTioCn
         ZfiwYt/O2NtmJacjJb7uvXJkBwtAwMJGHoN3gCES96Lr+9UUanCR0/MJEC56Cd7jjQS7
         ylTdTw1S8oM11a6nqOYADWjNGIs4a8TlAOhbnEdY1LwCNaGKebkKo95DASCXe6BjT+aN
         0u8ABi6vmJS/aZfnFV9XiDQSE/dwmQSUdSc1SpV9nFSEa+DLqh2hNAfEaIBnZlJflFK1
         S6vA==
X-Gm-Message-State: AOJu0YweNLkMGNUtqipnrnXM37Zez7lzyF00cF1ZKx1PPUoa1G13oU9J
        kGfPyHoUxsA8LBfHo8X3PGCYdZglkI7qLtPQ3Wc=
X-Google-Smtp-Source: AGHT+IEodCMIjY2ElmnZUAXRsK7fvHh7CxuWh3AAtikp6bTIpNe6YGfa6iBO3aY3xTbssQN6LfzWR+fswF42lu6yf7g=
X-Received: by 2002:a2e:4952:0:b0:2b9:eb9d:cc51 with SMTP id
 b18-20020a2e4952000000b002b9eb9dcc51mr1679208ljd.49.1692203465139; Wed, 16
 Aug 2023 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
 <20230816025715.GB2248431@coredump.intra.peff.net>
In-Reply-To: <20230816025715.GB2248431@coredump.intra.peff.net>
From:   Patrick <patrickf3139@gmail.com>
Date:   Wed, 16 Aug 2023 09:30:38 -0700
Message-ID: <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, thank you for your expert and thorough response!
You make a good point that users usually pipe the output of a prettier
tool to a pager themselves. In the case of delta, delta can be
configured to selectively pipe to a pager itself, so delta's docs
doesn't tell users to pipe: `core.pager =3D delta` (source:
https://dandavison.github.io/delta/configuration.html)

However, for diff-so-fancy, it might not work cleanly because users
are told to explicitly pipe it to a pager. `core.pager "diff-so-fancy
| less --tabs=3D4 -RFX"` (source:
https://github.com/so-fancy/diff-so-fancy#with-git).

I haven't looked at other tools but it's clear this approach is not
guaranteed to work for all configurations so I should look into
something else.

Jeff, would you be so kind as to elaborate more on the
interactive.diffFilter approach? My understanding is that
interactive.diffFilter is only used for git add -p or git reset -p.
However, the limitation for my use case is I need to use the pager
for git log and git show so that won't work. So then, you are
suggesting that I ask my users to opt in by setting an arbitrary git
config like fzf.pager and then read out the pager from that git var?

On Tue, Aug 15, 2023 at 7:57=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 15, 2023 at 05:09:13PM -0700, Patrick wrote:
>
> > I noticed there is no option I can pass to git to use the pager set in
> > my gitconfig even when piping to non-TTY. Is there a workaround? If
> > not, may I request this as a new feature?
>
> I don't think there is a workaround. We have "git --paginate", but it
> really means "paginate this command using the default rules, even if it
> is not a command that is usually paginated".
>
> Looking at the code in setup_pager(), I think the check for "is stdout a
> tty" is fed directly into the decision of whether to use a pager.
> There's no way to override it within Git. You'd have to trick Git by
> opening a pty in the calling program and pumping the data through it
> (which is what our test suite does; see t/test-terminal.perl).
>
> So I think it would need a new option. But...
>
> > Use case: integrate tools like Delta or diff-so-fancy when building
> > wrappers around git commands. See
> > https://github.com/dandavison/delta/discussions/840 and
> > https://github.com/PatrickF1/fzf.fish/discussions/202 for examples.
>
> I'm not quite sure that's what you want. When a user configures a custom
> pager using a prettifier tool like that, they usually further pipe the
> output to a pager like "less". E.g., I have:
>
>   [pager]
>   log =3D diff-highlight | less
>
> in my config. If you are trying to save output that looks like what the
> user would see on their tty, you want the first half of that pipeline
> (the diff-highlight here), but not the second (less). Of course it
> mostly works because less is smart enough to behave like a noop "cat"
> when stdout isn't a tty. So it might be OK in practice.
>
> I think your script might be better off doing the piping itself. In
> theory you could ask Git what the configured pager is and the run it
> yourself, but:
>
>   1. You can use "git var GIT_PAGER" to get the default pager, but not
>      command-specific ones. So you'd have to check "git config
>      pager.log", etc, yourself, which means reimplementing some of Git's
>      logic.
>
>   2. You'd get a string like "diff-highlight | less", and then you'd
>      have to decide whether to parse off the "| less" part yourself,
>      which is obviously error-prone since the string can be an
>      arbitrarily complex shell expression.
>
> When we were faced with a similar situation within Git, we ended up
> adding a new config option: interactive.diffFilter. This is used by "add
> -p", etc, to filter diffs that are shown to the user. It does mean the
> user has to repeat themselves (I have to set it to "diff-highlight"
> separately from my settings for pager.log, pager.diff, etc). But it's
> unambiguous, and it gives the user the flexibility of configuring
> various outputs differently if they choose.
>
> So depending on what your script does, you could use a similar config
> option. Or even just use interactive.diffFilter if your use case is
> conceptually the same.
>
> -Peff

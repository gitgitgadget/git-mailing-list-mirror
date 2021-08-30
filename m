Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF88C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9596C60F42
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhH3UYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhH3UYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:24:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BAAC06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:23:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r26so21785605oij.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OgPSCpvZ2h7g5Es2Y8YhIlMHRKyXugd8eZK278m8Fk=;
        b=RCpEnS95Qxe6mvG74zcd6L0/kce9b0rDJaUufh8HhvFVvm2OaqbzUNVdPJLMbdHSKH
         3kx/kCiAPWntUblAWdykMhWMfeV4jfJdoZdJKlaGXnqKF0J4G1mj5DhOfQ7h1WcwMwE0
         RWmXpcG8qfoJ1MMtxzRqHfw8BfwWAoLqVA5Q9qscfpJ2kegtKB9ZfAKc1H4twJzxZCQ2
         s1BjHQ4F/7KzeQiEwcg31Z0d9G3lxE7d1tofX5jUSMvIk1bNaPTTiuBWUUj6KHkeo1Ae
         qsmEmXZRKBdWs88uYp9XGNDWdYDpbY+AtPWX17P27Av+9XYAlFwREp4OrWi4bng5WGml
         zF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OgPSCpvZ2h7g5Es2Y8YhIlMHRKyXugd8eZK278m8Fk=;
        b=LPQ5neHYMm8lIvURlvLF+E4jAPBqV2xURU63hoFDVPgZITY/PX8/rkvGr+OquTR7Ro
         QYFznJ860gwRvIXpA1we/0p6AMaVk9IxW7UC9TssXtX3eryAOSCrfI0mQNPpxiCRX1iB
         Vkc9+5OviKQf3hiPqKlI3zrXoRayaRO3PE5MyZwP5Ir7qREk+Zdlu53r79FjEahxzLuh
         4hHhtDNBPVWDAnzsNtzgE1iCDHgDEe3sDyfm93XeFUe/kSe/ifwNLwKL7m4jO5fF2Zyl
         hymNsdc9zYrcy1Eeb+9RFVTZsOtlFhz+3m+RZMWVULcshTFvRtR+DOfsocQRxtsW9MJL
         FQSQ==
X-Gm-Message-State: AOAM533eX+zT+UPD3aMU6GWNM8QkkmxJE4EOsLn2YiWaj6xkkyQAVzFc
        2Ru0EzI4Mk5ABq5qY3S6+fp1JMCIhDLbSfQAW+s=
X-Google-Smtp-Source: ABdhPJyUQevOxVPzrQGUroF0x4syH86kCRYPItuUn+dIou+sMHm6J2C98D9GC43TYhyG/lpglKEIvvWg/tsY2kLsiIM=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr696561oif.167.1630355035273;
 Mon, 30 Aug 2021 13:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
 <d55363df-c2e9-3847-d98c-3d07e22d8a5d@gmail.com>
In-Reply-To: <d55363df-c2e9-3847-d98c-3d07e22d8a5d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 13:23:44 -0700
Message-ID: <CABPp-BFUnxp3sCOQWRa8C_gda5B19duFiOvHKCRCppS2Git_jg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 6:54 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/27/2021 5:56 PM, Elijah Newren wrote:
> > On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
...
> >>   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
> >>      @@ Commit message
> >>           the sparse directory. This depends on the indexed version of the file,
> >>           so the sparse directory must be expanded.
> >>
> >>      +    We must take special care to look for untracked, non-ignored files in
> >>      +    these directories before deleting them. We do not want to delete any
> >>      +    meaningful work that the users were doing in those directories and
> >>      +    perhaps forgot to add and commit before switching sparse-checkout
> >>      +    definitions. Since those untracked files might be code files that
> >>      +    generated ignored build output, also do not delete any ignored files
> >>      +    from these directories in that case. The users can recover their state
> >>      +    by resetting their sparse-checkout definition to include that directory
> >>      +    and continue. Alternatively, they can see the warning that is presented
> >>      +    and delete the directory themselves to regain the performance they
> >>      +    expect.
> >>      +
> ...
> >>      ++When changing the sparse-checkout patterns in cone mode, Git will inspect each
> >>      ++tracked directory that is not within the sparse-checkout cone to see if it
> >>      ++contains any untracked files. If all of those files are ignored due to the
> >>      ++`.gitignore` patterns, then the directory will be deleted. If any of the
> >>      ++untracked files within that directory is not ignored, then no deletions will
> >>      ++occur within that directory and a warning message will appear. If these files
> >>      ++are important, then reset your sparse-checkout definition so they are included,
> >>      ++use `git add` and `git commit` to store them, then remove any remaining files
> >>      ++manually to ensure Git can behave optimally.
> ...
> > Thanks for the extra explanations; those help.
> >
> > You haven't yet addressed how this choice will interact with
> > .gitignore files, though (as I commented on v3).
...
> The difference between the .gitattributes and .gitignore files is that
> we don't need to do anything with the .gitignore files to prevent Git
> from accessing them with their contained directories don't exist. The
> .gitattributes change in attr.c is reachable from some code path even
> when the directory doesn't exist, so it needs special logic to avoid
> that expansion.

Ah, this is what I was looking for and couldn't quite work out --
whether .gitignore files might need to be loaded (and whether our
other UI decisions were affecting that).  Sounds like you have it
covered.

Thanks for patiently explaining these various items I was not
understanding or missing.  Sorry I missed a couple key things despite
reading the earlier rounds.  Anyway, looks like we're in pretty good
shape and there's only a few minor things left, mostly stuff you
brought up yourself that you wanted to tweak for v5.

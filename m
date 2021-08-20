Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14842C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35D96113B
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhHTPvA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 20 Aug 2021 11:51:00 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33660 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbhHTPu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:50:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id s25so1917544edw.0
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LR0nAc4DehtmJx2h7cvHlR6nElLhgkjpJm/7iSRtBnc=;
        b=Wzm6Lv5aMIHRSx30DiopFIA5SOg4iw9zOgLX/YppflbGe5Z0wyNyXmJFdNkFytR85f
         qdM8cUgn3iVt1BOI8vEdjBb3g68TeaW6IcS0F+NTIfo4tAIafLA72mPcKJc8NwZIWJ4U
         Pqm+vrRoCYsuGjDh2llfiqhm4BTstZ+Oi35lePJVUC7l+NNYq3kqpX+8DFzAd6naYvf6
         aJOv7Er1gGQyb+IjAI8cfMVceqvVVc9RCODv1YpyebZhz372QTKrQxoFttYJSTLxF4cX
         tuVt9I4YW7oxk2uCX8EMz39cPS2fDPcb8MW1vXtAl+u+uQ/O/7wdRPXOxVlAvMI0s1vs
         i1ng==
X-Gm-Message-State: AOAM531dSjXg4RteTz148BMFcCCFjrz+Y4yM6naengERieSQzoDpGga1
        +XsIkpUsBUzsGcV0q+yKMITMBx7LZuO5wRWr1G4=
X-Google-Smtp-Source: ABdhPJzJnYexBigbPUZJQok7oi/0Nnn1u2bmJsQsRehuwGZgZ4pOvK9KKB+lAE6Hv1GVbZ9HSeiFSB5x7ps0dsTjbAk=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr22770640eds.233.1629474620711;
 Fri, 20 Aug 2021 08:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
 <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
 <CAPig+cRk-BB79+pO83A6Qov9W75_91gzaHY4Le1MYKDUWagugg@mail.gmail.com> <53752b7d-c294-9507-a7f0-af2aee491251@gmail.com>
In-Reply-To: <53752b7d-c294-9507-a7f0-af2aee491251@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Aug 2021 11:50:09 -0400
Message-ID: <CAPig+cR7HhWN8F1G7_rWpD_jXfaKqaj7c4fMbkgAGvcjf1pX6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Carlo Arenas <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 8:12 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> Le 2021-08-19 à 16:11, Eric Sunshine a écrit :
> > Oh, indeed. I didn't mean to imply that HOME is the only problematic
> > one; they all are since, as you say, they can impact correctness and
> > reproducibility of the tests themselves. I called out HOME specially
> > because of the potential danger involved with pointing it at the
> > user's real home directory since it could very well lead to clobbering
> > of precious files and other settings belonging to the user.
>
> I also did not think about the implications of changing $HOME that could lead to the
> test framework overwriting stuff in my home. I checked the tests and there are only
> a handful of them that seem to reference HOME, but still, for those tests it would be
> undesirable to reset HOME.

It's not just tests which reference HOME explicitly which are
problematic. Git commands themselves access files and configuration
pointed at by HOME. Worse, Git commands invoked by tests can alter
configuration, so the potential for damage is wider than the few tests
which reference HOME explicitly.

> In light of this I'm thinking of simply adding flags to 'test_pause' and 'debug' to signal
> that one wants to use their original TERM, HOME and SHELL, with appropriate  caveats in
> the description of the functions:
>
> test_pause     # original behaviour
> test_pause -t  # use USER_TERM
> test_pause -s  # use SHELL instead of TEST_SHELL_PATH
> test_pause -h  # use USER_HOME

A (very) stray thought I had: Rather than mucking with the environment
variables -- which can impact test reproducibility and correctness and
can potentially damage the user's precious files and configuration --
another possibility might be to detect which shell is being used
(whether it be bash, zsh, etc.), and then enable certain useful
options specific to the shell, such as tab-completion, colors, etc.
This approach doesn't give developers the customized shell experience
they're used to (it wouldn't have their aliases or configuration, for
instance), but it at least might make the test_pause() experience a
bit more pleasant.

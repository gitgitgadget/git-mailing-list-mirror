Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E332C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 14:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiEIOzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiEIOzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 10:55:45 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FACC24D58D
        for <git@vger.kernel.org>; Mon,  9 May 2022 07:51:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d22so11369109vsf.2
        for <git@vger.kernel.org>; Mon, 09 May 2022 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJnzyBuLCpRkYmvobx56aIwB+liTiLJZDU5Kwr8/7Rg=;
        b=HRhynrK4d2AgRpcYZ7J4Ky4A+QIUjLc/jxfW/N+39YIam++clxm6rkSoDNZcGNfiUM
         RmwXQEBkrRzItRB/26zvsTLpgn95kywsM/iiUTl5AR1RI77smMPZqs4K4g8Un4j45Grz
         ZthN9Wbkx2F4/ybhbTYVJ5qUO1W7wZ43b8P5dq28D9s4Oa+4n1zj95fvxiUL/gWdnQni
         Xtq5sBsymTDL7YPrkKlWDVtMl2j2cF0ze8JvRs7TUkOLfYfXhgQud4C+1DXgWRe1vRQ0
         k+gqqzcF1JSxt+LseB+4qnoCn5g8ChdMw+LaIoZ+MI6VyDDTxG3YxKwzIKAFPdPeN+fm
         PJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJnzyBuLCpRkYmvobx56aIwB+liTiLJZDU5Kwr8/7Rg=;
        b=SjNY2xUMnSNgnutbCxnyMKe49pIWkcKcTQkqUAFKtdngiwny9z+OKUcH0laEDvmUIU
         tM1wJgz64FwuFh/j92T2FFeVUByRJeRVWxpQ90D40axtD/7w1nolEvS8Q/US+XTaIbhV
         5tohT15dcdJ/ZgD2OT4c0m7zUe2kXggAToiDfIP9/rsqQCTGnfCzbEe7r3TeyTcjjQNn
         CFYO58YdyQn+elQ/HB/6TikGLotLFS0PWuQX5i/Upk529aJt/ggBtDvtwMPI3vB4vDkx
         LuuvWzpVPUQZ3uuj5WvskwJjugpjELygBg4skXjiuastMCi+SBEaGbpbFrv4tY5cSKe+
         OhgQ==
X-Gm-Message-State: AOAM533exMjcLFGI+JR4+t7kk8+p7NbyG8Vw8MSj8y64WSG5ijJOjCIY
        BAKZ75vY7JGU9aso7a2vNMthlnoPqvKZe6c+n5Y=
X-Google-Smtp-Source: ABdhPJzlvi7gXsNCUWTkp11UtymOSP4rjTB3cx6F4vzi1vlMreXE+X3oB43hLfRjhgQaL5OpaJg32Swh+hUXpPLQSbo=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr8163890vsa.38.1652107910143; Mon, 09 May
 2022 07:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
 <xmqqlevfesnu.fsf@gitster.g> <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com>
In-Reply-To: <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 May 2022 07:51:36 -0700
Message-ID: <CAPUEspiX4FJc4-1DGCek1iWMYL7M7Xir9PSXbFAwQy7xTFKxYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 1:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 05/05/2022 19:33, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> Hmm. I would like to suggest that we can side-step all of these issues
> >> (and the ones I outline below) by considering a similar approach to the
> >> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
> >> variables to pretend the exact scenario we want to test for.
> >
> > Perhaps this may be a way to pretend we are running a command under
> > 'sudo'?
> >
> >       test_pretend_sudo () {
> >              GIT_TEST_PRETEND_GETEUID_RETURNING_ROOT=1 \
> >           GIT_TEST_PRETEND_LSTAT_RETURNING_ROOT=root/p \
> >                  SUDO_UID=0 "$@"
> >       }
> >
> >       test_expect_success 'access root-owned repository as root' '
> >               mkdir root/p &&
> >               git init root/p &&
> >               test_pretend_sudo git status
> >       '
> >
> > That way we can avoid having to run "chown" while preparing for the
> > test fixture, and running "git status" under root, but I am not sure
> > if we want our shipped production binaries to have these "pretend"
> > knobs.
>
> Lets ask ourselves "How could an attacker use these knobs to facilitate
> an attack?".

That is not the question raised by having those "pretend" knobs in the
production binary, but instead how can an attacker abuse them to get
themself and UID he doesn't have and therefore additional access.

The fact that the current code requires you to be root to even enable
the logic makes it more difficult to use SUDO_UID that way, because if
you already got root, you don't really need them, but take into
consideration that this discussion starts with (how can we run these
things as a the test user and avoid sudo, hence root).

Carlo

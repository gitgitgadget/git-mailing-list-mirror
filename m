Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5409DC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444232AbiEFRnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiEFRnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:43:10 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231B35AA9
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:39:26 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e19so7853930vsu.12
        for <git@vger.kernel.org>; Fri, 06 May 2022 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CgHRNuoY6nfGQsjMkwyCrU08ss6ThqejPo3cqZgftGQ=;
        b=FnCrDVmzMhAJJOhsemS05OgoG+Oey1r3Qo82YGbhMDkkOtKNRH4FFjy5k81581H14M
         6ddFr243C2RekiHh5NS+suBwv4xaJrn9GVY0GZCCq58yYoY/NKElnAbnLfth+8/3YBly
         NDCIMCFFeSHSfHQvliUeljulsSm+Um1DhTGz9yeF4w02+LfKsnqaNeEDFekG+TFdFxZi
         5rA9W+Ucu3WOYZIylxUiwUc1EFTyh+2SeeYxt6iOShXRlQRs0pFZYKUYAJjM3SEhM10P
         ZEuQ2hvc33pIiK5oLG+LLaJfTtgWL7rrU4vqdBDAALR1BNUD2P5y151k/um7yYT5Afp3
         1n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CgHRNuoY6nfGQsjMkwyCrU08ss6ThqejPo3cqZgftGQ=;
        b=Yue53CaZFzb+HdzYyIi8XmPoFmgUQCA9ubrfGCS8KK7OMHpd8QqeeZoQMwVQFJxfEG
         JCL38b7S30XrcnAZK0XVzrbtRxEoeYQ9UxJJ82c08QPtOBjmlGhj6HsmiXlyTOL5xLLJ
         TT2Gm3xnCY8DtUCY8AZgJ6+pj37XmiYWSuXUOWIN7Us5/hn/Ab49/9/utRfx3tEuyh5k
         6OpZtPx1046eh9d91UiX5r1JXaWK9Dn8WaRS1f5J409VW0etmaxB46kc6Rwm4lYWPQJ8
         Hv+x0b8KA83RMWPjBZLthnJ0gdpndhiQdmqBVTtPBoMsfKxAQRxHqKYBA/MdNKQjvCY1
         vZhw==
X-Gm-Message-State: AOAM531wnhe/pY8AHbuILvVjR1yau3ym2rg2QqN1SdklzZoN+oIGmeCf
        LIKss+3x5/tYx8mH+0F8McLWu2IlP+rN76iEkj4=
X-Google-Smtp-Source: ABdhPJzlxfVyOh2W7be/5rLZWSlhS+OAX+WcNucNKlbP+ZLpAa39upGuQ4CPJ+eeLkY5wMgWqcBOm0A+cF4tpU2gufI=
X-Received: by 2002:a05:6102:1519:b0:32d:8834:f17a with SMTP id
 f25-20020a056102151900b0032d8834f17amr1509862vsv.1.1651858765931; Fri, 06 May
 2022 10:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 10:39:12 -0700
Message-ID: <CAPUEspiNpNSiasswXK_SWPUPR=m8Hq2vq3b_XisnVz3zbTy8MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 6:44 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 2 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> >
> >   $ IKNOWWHATIAMDOING=3DYES ./t0034-root-safe-directory.sh
>
> Hmm. I would like to suggest that we can side-step all of these issues
> (and the ones I outline below) by considering a similar approach to the
> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
> variables to pretend the exact scenario we want to test for.

I wish we could, but I think it is not possible in principle because
it would break the trust chain that we are relying on here to make
this work.

As explained in the commit message from the next patch, for this to be
useful as well as safe our ONLY chance is to trust SUDO_UID hasn't
been tampered with, which also requires that we run through sudo so
git is running as root and not as the regular user the test suite
would use.

If we remove the (I am really root, before I trust SUDO_UID)
requirement from our code, we have just opened ourselves to a way to
weaken the protections that were added with CVE-2022-24765.

to be frank while Junio mention this "weakens" the checks, I consider
I was strengthened them by introducing a mechanism the user could use
(only when he is root) to safely tell us that he wants to trust a
repository that is not owned by him without having to create an
exception, and also improving the usability of it, but "magically"
detecting which uid they are most likely to trust.

> It took me a good chunk of time to figure out how to run these tests, and
> I will have to remember to revert the temporary edit of `/etc/sudoers`
> file. This is definitely not something I plan on doing often, so I wonder
> how these regression tests can guarantee that no regressions are
> introduced if they are so hard to run ;-)

by running in the CI (at least the macOS hosts, and maybe others if we
decide later to butcher their sudoers config as well)
I am adding more instructions in the commit message from the next RFC
to help anyone that might want to run this locally (which I
wouldn't recommend myself)

> This would be more canonical as `test_when_finished "sudo rm -rf root"` i=
n
> the preceding test cases.

correct, but I was attempting not to do that to make it less of a pain
to write more tests since (probably incorrectly) I assumed it would be
simpler to remember that there is a test at the end that does the
cleanup and at least one at the beginning that does the setup than
probably having to take care of those 2 things on each test that you
write.

Ideally, the test framework would be able to know that this test
creates files as root and cleanup itself, but that was specifically
punted.

I am keeping this for the next RFC, but I am open to changing it to
whatever you would prefer, until a proper integration could be written
to clean that mess up.

Carlo

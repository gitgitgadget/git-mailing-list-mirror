Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D706EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 16:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjGNQTz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 14 Jul 2023 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGNQTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 12:19:54 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE41FD4
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:19:53 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63588812c7aso9444296d6.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351592; x=1691943592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87/IKSaS47qCn8aEruJnjAfuW74TOK5PFa347JPf3ik=;
        b=el0FeZi835CMZfr8Ng/QwzjJmVbCgMdDmObvrDWJwbaXhuGqLMGKorBytwnklXHvo1
         JrDQOuDZHmfWTN9K8QwbpXZGQUL8NjCAmc+FIj8/+pbSZprV0H+7cqU6xammaama1Jnf
         6rBFMhVJGEobTXbYFehdVmJPqiwrUowQUNAYb6rQilSmBZeh9uwyZgnrx/vhfyjDgTVK
         MH3AJpv+9/dRWD+x+kx2waujiZt21KFEm2tRpUBcvkAPbLys2RU47/mCJhZzjQyJax6g
         DFIG+62g6mpmwH2puXidIMk/iC3r5N9LMh5yS3uwdb/PRniwRaPkCGMryvzY4DEE2Fch
         lhxw==
X-Gm-Message-State: ABy/qLZNO0RuTvFqPJtYOVWNPvz7wl3mBxTj/OhCBz7w/ERXIsrbxchI
        GLRecaWa1INVVeWywotVJdmEvXOMliz2kP4zm7blddf3f2w=
X-Google-Smtp-Source: APBJJlGBwbBREYeNBz4M1JBO4GWDxhxZrZV8wWpKqqcNJAwMl3f9qq7sw9gVd8BFS7IScJoRvwqkZ3Z0DQtv/QI/RZY=
X-Received: by 2002:a0c:e514:0:b0:62d:ed66:7ad1 with SMTP id
 l20-20020a0ce514000000b0062ded667ad1mr4104808qvm.28.1689351592626; Fri, 14
 Jul 2023 09:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
 <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
 <xmqqfs5ro8v7.fsf@gitster.g> <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl>
In-Reply-To: <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Jul 2023 12:19:41 -0400
Message-ID: <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
Subject: Re: t2400 on freebsd12
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2023 at 2:30 AM Jacob Abel <jacobabel@nullpo.dev> wrote:
> On 23/07/13 01:27PM, Junio C Hamano wrote:
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> > >> t2400-worktree-add.sh                            (Wstat: 256 Tests:
> > >> 227 Failed: 27)
> > >>   Failed tests:  50-52, 91-93, 107-109, 123-125, 139-141
> > >>                 159-161, 175-177, 191-193, 207-209
>>
> > I do not offhand know how well the FreeBSD port has been maintained,
> > or those who have (or had once in the past) stake in it are keeping
> > an eye on it.  Anybody?
>
> I wrote these tests[1]. All the tests that are failing are:
>
> - running `git worktree add` without `--orphan` or `--quiet`.
> - running in a repo with 1 local branch with a valid commit.
> - running in a worktree with an invalid/unborn HEAD.
>
> 1. https://lore.kernel.org/git/20230517214711.12467-1-jacobabel@nullpo.dev/

I haven't been following this thread closely, but I wonder if the
`grep` introduced by patch [3/8] of the cited patch series is
problematic:

    grep -E "fatal:( options)? .* cannot be used together" actual

since BSD lineage regexp (including macOS) historically did not
support the "?" repetition operator. Perhaps an easy fix would be to
simplify this to:

    grep "cannot be used together" actual

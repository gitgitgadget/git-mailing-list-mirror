Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2615C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCLVEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:04:33 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA423DBB
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:04:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bi17so8140326oib.3
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoKdraokeIBRvCZP5v4/9dB0IIUs90PWXKBI39VcMDs=;
        b=b5RQXtETVUuvA0mY5vp1hIkbjbpLKuKwR3Cg+J3A1XdmfFBE8ba6b9uKC6KGIFKeAw
         Jyqft3FpQ4bt0lV6J+CZdXP2LPgUEI4evxE9joCgq9XC1c7tAOGylqrFNuQetFETrH8h
         RurUXBHLmYAN3ENkwTSqlHkaZjItSwabTIdjJ1jkdjyKXDdE7H8jOVAZyVyPzXC0acae
         ESjdpY6kLz/HeoU6JnWJXiFNh4R5LTh180ZCsOkzHHjZnD+ZGoA01kCxYtgT6uw+kNVr
         uGqd4pfDdAJgo4XpuOULhJdGBUQ/JJtyBkWe5p0UOvq0sUBWUI7wKSNfKYdxOWRoRVtn
         JUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoKdraokeIBRvCZP5v4/9dB0IIUs90PWXKBI39VcMDs=;
        b=FeTjbwvCkO2JilbRrf1dTIOL7WUDqGwylbPrsPdJ3k9cYUplZhRRaoXaWKozMkf3PV
         /Lr49LYvmj+bV03YhtcrJBjUb4gPGyZDB8xbESW8hRMkP8sZhlBGNMW8OdWAz66QlxjF
         +hGP/b1sSnJhmcrTjWK0Qbf+u9LiHKcHRWKq9lgLLn1Bf9wn1U2gM+4EM72JB5Hmadjt
         WSKKtuAszxuk4LPmw8AbvJcdXo1ZOLrl09vIhN13KtTABwMsg0vlX+HnbLIfo6Unu5it
         akYbA+R9+MnyNj7p8yw3V4d+g75JwlBB1/ip6sxDbnYILJzcZGh8FtYzycOGf2Z9AEZb
         /PaQ==
X-Gm-Message-State: AO0yUKWfgT2Lvo0m6HdOt/6Td4nEITeaAZ9iupgTfWbnTpcQjpQVVxy5
        3A8q+X6SCh7ZSvfg25XbMgpXUF2NZaeYpBy4blE=
X-Google-Smtp-Source: AK7set8/f0KYLq6Ly7tujMn++91uJBj5MM6prA6QBUOqZ9ymC2weUchFkI8bej5WhN/QrEFCVoP3Gt8ZAcTAZxnXQA0=
X-Received: by 2002:aca:2111:0:b0:384:e145:e8b8 with SMTP id
 17-20020aca2111000000b00384e145e8b8mr6491842oiz.5.1678655071575; Sun, 12 Mar
 2023 14:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 12 Mar 2023 15:03:55 -0600
Message-ID: <CAMMLpeSYYDX2Jjet0wZFuMtpq03QZYHNr310-pHp8BsJ=izL_w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2023 at 5:02=E2=80=AFPM Glen Choo <chooglen@google.com> wrot=
e:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:

> > +test_expect_success '--rebase-merges=3D"" is deprecated' '
> > +     git rebase --rebase-merges=3D"" HEAD^ 2>actual &&
> > +     grep deprecated actual
> > +'
>
> I believe this used to be on 2/3, i.e.
>
>   https://lore.kernel.org/git/20230225180325.796624-3-alexhenrie24@gmail.=
com/
>
> but your cover letter suggests that it was removed. Mechanical error?

I removed it from the second patch but accidentally added it back in
the third patch. Thanks for catching that.

-Alex

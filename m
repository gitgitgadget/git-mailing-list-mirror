Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67443C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425F5613F8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhGPSm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGPSm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:42:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F33C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:40:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10863870otl.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOTCPnevGqY7PRJsLX3pDK0LbpiQMDVRzL4Vl2mn2i0=;
        b=dfJfIx1SmWnWUHJ+/ar+JLO7E5KmJ9VW6C27G+fCxtHtUoyFIpeDoMEM59nHlCi59z
         WSPww2j4dqJaSOy14KJU94ud2HqLQ0MrteAtrejqMx65dpeXH5jAuXMpY6miI90/DKS0
         1Moy7ydwo33+dFgsffhoqUWpREm7fW8l6F7iSDXxeg00CVje5Xg7fbuLqpSE7tbnsJTd
         34MDJJlEz9d2gTQ9C2MsL5H4N2jQ/jgpV9VYoGM6eNsOwM7r9WtJ9ARZP8di+ZS0KIDx
         yCJonvcq4eb45IsOOkSoWTcc1gm1/DNZslCWeSQiGwBZjANmgCxqKfXyfiWUw6edGIzk
         Tz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOTCPnevGqY7PRJsLX3pDK0LbpiQMDVRzL4Vl2mn2i0=;
        b=TBN9hFDgXsnK5YWnjU1kOZb2wysbZoPVVkb2AyceRtFyrALQSNn/OFdMwbAsqjYJwy
         trWhJm805Fgq/uFGjjFI1ST06dPnj0/Y3j9uMWshnUTYygT4Qpq/kpOtxdEU9u2nm2VU
         kDmPPjYOlpKCrMNMASqJl+v1w4uBLoNj1GMSW3a7KZfZBrepPFg0MqTcvu5Ws2xycts8
         wFGVz1leLHsHcRFroUvYlYGRsBoUrx11x0Jgppa1USzXcEaTDpzbJSbimEMeTZrGLlTw
         36BqUDztJXMlrysAvsFsaPoDDaGr8KVztWm/FHkQD7cETcLyo9/Z78zZxTSfGkvhdKGj
         RmbQ==
X-Gm-Message-State: AOAM533UVhsmoO0ikkMaQxV4q5eLqwoBOeJS1k+aCwDP9Jy2VwCNpTvO
        kDfY4KXwFjQnG1Hd4Fk46LnpKG8Kj3d+3X7eULM=
X-Google-Smtp-Source: ABdhPJyQm2PcN3DcVYPJhvAhmepgtCCsvEuYrI468nR/8UDaHpAGicDJHgv4KxtXXlKPzjwR9/4+M3My4Fc/nVoV+0Y=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr9327019otd.345.1626460801993;
 Fri, 16 Jul 2021 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g> <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
 <xmqqpmvjs61c.fsf@gitster.g> <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
 <xmqqh7gvs2mu.fsf@gitster.g>
In-Reply-To: <xmqqh7gvs2mu.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Jul 2021 11:39:50 -0700
Message-ID: <CABPp-BEHNpfm6mJBDZ30wCEraT03p+2-gGZyZcnUV34trAzAzw@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 2:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jul 15, 2021 at 12:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > Let me ask two questions:
> >> >
> >> > 1. When is it beneficial for users to set both pull.ff and pull.rebase?
> >> > 2. Is it harmful to users for us to allow both to be set when we will
> >> > just ignore one?
> >> >
> >> > I believe the answer to (1) is "never", and the answer to (2) is "yes".
> >>
> >> I agree (1) never gives you anything, even though it does not hurt,
> >> and (2) is "meh".
> >
> > Okay, let's drop this series then.
>
> Not so fast.  I did have problem with some combinations you hinted
> (vaguely---so it is more like "combinations I thought you hinted"),
> but making sure various combinations of options and configuration
> variables work sensibly is a worthy goal to have, I would think.

It may be a worthy goal, but I cannot implement correct behavior if I
cannot determine what correct behavior is.

You've only specified how to handle a subset of the valid combinations
in each of your emails, and from those individually or even
collectively I cannot deduce rules for handling the others.  Reading
the dozen+ recent messages in the various recent threads, I think I've
figured out your opinion in all but two cases, but I have no idea your
intent on those two (I would have thought --rebase override there too,
but you excluded that), and I'm rather uncertain I've correctly
understood you for the other ones (I really hope gmail doesn't
whitespace damage the following table):

   pull.ff  pull.rebase  commandline            action
     *          *        --ff-only --rebase     fast-forward only[1]
     *          *        --rebase --no-ff       rebase[1]
     *          *        --rebase --ff          rebase[1]
     *          *        --ff-only --no-rebase  fast-forward only
     *          *        --no-rebase --no-ff    merge --no-ff
     *          *        --no-rebase --ff       merge --ff

    <unset>     *        --no-rebase            merge --ff
    only        *        --no-rebase            merge --ff[2]
    false       *        --no-rebase            merge --no-ff
    true        *        --no-rebase            merge --ff

    <unset>     *        --rebase               rebase
    only        *        --rebase               rebase[2]
    false       *        --rebase               ?[2]
    true        *        --rebase               ?[2]

     *          *        --ff-only              fast-forward only[1]

     *       <unset>     --no-ff                merge --no-ff
     *        false      --no-ff                merge --no-ff
     *       !false      --no-ff                rebase (ignore --no-ff)[2][3]

     *       <unset>     --ff                   merge --ff
     *        false      --ff                   merge --ff
     *       !false      --ff                   rebase (ignore --ff)[2][3]

[1] https://lore.kernel.org/git/xmqq7dhrtrc2.fsf@gitster.g/
    https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
[2] https://lore.kernel.org/git/xmqqpmvn5ukj.fsf@gitster.g/
[3] https://lore.kernel.org/git/xmqq8s2b489p.fsf@gitster.g/

It appears you, Phillip, and I all had different opinions about
correct behavior and in a few cases though the documentation clearly
implied what we thought.  So, I'd have to say the documentation is
rather unclear as well.  However, even if the above table is filled
out, it may be complicated enough that I'm at a bit of a loss about
how to update the documentation to explain it short of including the
table in the documentation.

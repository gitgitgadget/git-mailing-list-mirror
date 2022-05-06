Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE01DC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444552AbiEFVoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444577AbiEFVoF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:44:05 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB5BC9
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:40:20 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id p1so3262367uak.1
        for <git@vger.kernel.org>; Fri, 06 May 2022 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cM1u0ywz3RRSod53cvKMIQneiutFd/orG1FOahxQ/a0=;
        b=RIuKU/0Y6pBp4pnNCbTK4zyFhePyGImwvQsuM0QER0HupyaBhyH169g0ciT+o0doT4
         8l1Gh3NG7pTJXLlcB5LxWKhedv7w3+LvOQdjQTLWqyV/ENpjkH6UW6UFzCsE6HeFgSUe
         hitNpOidrRvqodAhklEt0Kw2vWeA8+SMIPgJ2MafU/6PiXwHYTj73g7FhCHgfYAEc5cb
         N8clARvCM9fNoEPR8qWXtwq1ayPk4oBwwmFGB39myXMtj7eME3mVvha7BY/WQL4dxEt7
         TmiDahYMUhmAYn+knUw/C9/nSEHyiwkvvTLM6nBzdwjhjXUFiRm8upElnaCAs7Nz6YQn
         1beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM1u0ywz3RRSod53cvKMIQneiutFd/orG1FOahxQ/a0=;
        b=OpqGk0Ornq0gY4n+mm9RdIpmytXScX2xSuzk5OxVXlcmCH0k7HluocBmkckTDwhBag
         u+UATPavfAt0j3OzyEhuPwUaz5CtWRjblPaf0PG5691zgf/tzxs90mdP9xwtcqzbUOGp
         6mlPgFqhfcxsNJOcpb1/vW+ianNZFsnNayk8JCR1PYlACpB+8LctwsjdqfpU/aKoyVnN
         N4YbSn3Llz582pBL17jqMzP9utQuPLVnkf/uXdVcupt/sYckOLoQI3uF1C4jhk/ntGEU
         ftK6pCg7YUqNvG0/2B+sCz1vW8NkUGqds7teRJhVXEJYjJ5AzCTRrEEbh7DoYU5sHZcI
         Ugng==
X-Gm-Message-State: AOAM531Wkq/9bQbXlI0j+TltoPdoZC3uoRf1VI7hng/J36vUEcX8s19t
        UIrmUCA7bR8ZFWYwfD5p1YI5dVzXP9Cksz6mI5Iu6n1dNLA=
X-Google-Smtp-Source: ABdhPJz4ShdDtt28Za/Ptf8Qabm1MF3BYshFObBLXQqTX/AizCOuQZsRO8ORKKlC91UYMXEHzLmjEMsNYrWAoTUkFaY=
X-Received: by 2002:a05:6130:3a1:b0:365:84fa:2f57 with SMTP id
 az33-20020a05613003a100b0036584fa2f57mr2174473uab.62.1651873219202; Fri, 06
 May 2022 14:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
 <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com> <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com>
 <xmqq35hml9cs.fsf@gitster.g> <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
 <xmqqh762js1j.fsf@gitster.g>
In-Reply-To: <xmqqh762js1j.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 14:40:05 -0700
Message-ID: <CAPUEsphoG75eY-SmRfFvv-sfo7pwxtaWoeWN0QbsYK7M01XyVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 2:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Fri, May 6, 2022 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Carlo Arenas <carenas@gmail.com> writes:
> >>
> >> > which is also why we can't use it, any possibly bogus or suspicious
> >> > value we get from SUDO_UID MUST be ignored.
> >>
> >> I do not think I agree.  If we have a strange value in SUDO_UID, it
> >> would be much better and safer to err on the safe side.
> >
> > ignoring it is the safe side; for example if we replace the current
> > function with the proposed one then some user lucky enough to have
> > access to the latest linux supercomputer that has been patched to have
> > a 64-bit uid_t (because who makes 32-bit supercomputers nowadays)
> > would get root[1] access by simply faking his SUDO_UID to be UINT_MAX
> > + 1.
>
> Since we do not pay attention to SUDO_UID unless euid is root,
> anybody who can attack by faking SUDO_UID to affect what Git does
> can already become root on the box.

Normally yes, but they just might be too clever and found instead a way to
fool sudo into generating a bogus SUDO_UID with the hopes that whoever
implemented this forgot to check for bogus values and used atoi() and
therefore grants them uid = 0 for whatever nefarious objective they
might have.

While we can't protect against a buggy sudo, we can't do the next best
thing and that is to NOT let a would-be attacker still get their 5 min
of fame by reporting a vulnerability in git, because they just made it
crash through sudo.

Especially when the impact of just ignoring them and going our merry
way is that (with the current code) we will use the euid of the user
that started sudo and "do the right thing" (tm).

> In any case, if we notice that SUDO_UID is not a valid number and
> die(), we deny the access anyway, so there is no need to write more
> code to ignore.

not sure which additional code you are referring to here, but
currently the only code to ignore is embedded in the one that is
needed to read the value, so it is not additional, except maybe for
the (uid_t)-1 check that was discussed before[1] and that is what
protects us from overflows when sizeof(long) > sizeof(uid_t) &&
UID_T_MIN >= 0, which are likely most of the systems we are expected
to run on.

if you are referring to the whole function that could be replaced by
using instead git_env_ulong() as dscho suggested, additional code
would be needed anyway to make sure that we truncate it appropriately
as what we really need is a git_env_uint32() which I am really glad to
add if you would rather go that way, but is definitely going to
require more code than what we have right now.

Note also that we will need to add a flag to it, so it doesn't try to
be helpful and allow SUDO_UID=0M to sneak in.

Carlo

[1] https://lore.kernel.org/git/CAPUEsphFb-=BcV-mxS5RZpJQ8UVq23ni0Lo8tQ4J3TP04B4KQg@mail.gmail.com/

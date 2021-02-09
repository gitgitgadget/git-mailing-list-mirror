Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17DCC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FEB64EC2
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 08:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBIIet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 03:34:49 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43553 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBIIee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 03:34:34 -0500
Received: by mail-ej1-f53.google.com with SMTP id y9so29880507ejp.10
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 00:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqC2lwyDqPrLhWaPQNQqLeO/DdQ7ik8shNSCLsx9/e0=;
        b=VFfpDVQHYwizdIhFO5Z1t+2CdKsptWu2E9vUVqcUOArB9qWB57gqfhKHRW0YHVHOJu
         Tvcho3tsFoMn9FwoaQlUgLbLShcK2sWRc16ddbVjTw7OILx4ougefSNuS/yQwdk00Vy7
         66PVDDWc7sCzXPda11vzQaw3VlQRA6rJTHw4qE/T3zUnZ99hqyO+pakTPKT2izgU/anw
         lHYu2+8NUHjzMnVH4GuFDHRYt5UtNVm6w3Ab+o/w9Lcg//3ppJtspmtocNk/WzGm3c2k
         DL1DtFKw+hVkf7rcouGhfFNosxD6P0aQoYD/UMqL2zxRJCyWJVsG9JoHEHhlep4DLYpi
         lxSA==
X-Gm-Message-State: AOAM5317CRfESphmWbghxMukhnYt9iFJlsJnuqoE/L1PJbzORtiWWTH4
        /CoDyflDBTHlg5hqZ7oT5ipl2yh0k5zUXmDuHW8=
X-Google-Smtp-Source: ABdhPJzoEjz2XTZfEwDVY8dNdEJBLu8v9DbCCE6L5AqoZReyypUgHZhszwG7cdNZd7PVqi+miKSe8rdKyZ0MkP1X+Zw=
X-Received: by 2002:a17:906:488:: with SMTP id f8mr20505765eja.311.1612859631605;
 Tue, 09 Feb 2021 00:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-4-charvi077@gmail.com>
 <xmqq5z325k3j.fsf@gitster.c.googlers.com> <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
In-Reply-To: <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Feb 2021 03:33:40 -0500
Message-ID: <CAPig+cSoa4Vw0N53vJgMCWiW5yVS0j1H0ejS_01xs1WDF2d82g@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 2:13 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > The goal is good, but I am not sure if this "the commit" -> "this commit"
> > is an effective enough way to fix the issue.  Here is my attempt but
> > I do not think it is not 10x better to be worth replacing yours X-<.
> >
> >     use only the log message of the "fixup" commit, discarding the
> >     message from the previous commit.  While "-C" uses the message
> >     as-is, "-c" lets the user further edit it.
>
> Okay, but in this patch we are also removing period and capitalization from
> rebase to-do help of commands. So, maybe we can replace it like :
>
> f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
>  "                  commit's log message; use -C to use only the\n"
>  "                  log message of the "fixup" commit, discarding the\n"
>  "                  message from the previous commit; while -C uses \n"
>  "                  the message as-is, -c allows to further edit it\n"

Here's another more concise attempt:

    like "squash" but keep only the previous commit's log message,
    unless -C is used, in which case keep only this commit's message;
    -c is same as -C but opens editor

Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB01C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6967D2253D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUXUdaRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgAWLCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:02:46 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:40293 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgAWLCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 06:02:46 -0500
Received: by mail-ed1-f50.google.com with SMTP id b8so2873936edx.7
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=84765DuoST0pHLENKjOtFfS17CAp9U3aQfiEd6H8R+U=;
        b=hUXUdaRveMdxEXACnG8r9ei9zIqwpEamRjZqjmm9/jq+J8xzHLmjLhcDFM8f8jpBQh
         EgPwrnffTnIxOxEHpIfROsrz+21ZBnYEitTiIU9nWE9wf3oZItEdsD8r1n0n28sAr54m
         8M1A8os7ppyZpoXwYBaClSpRA/JzjH/BjQi3jBvjSeTroI6aO7GZEAjvq5HB0YKY15iq
         YQ5CLfDJH5aNaae/MKB9OPFqGw1OuV8BBlz5S99TOx6lRvhprn3YoolXQrzqlD3ekeoc
         271E9h5DArcGqHnQ0rHmNMe0N9djQDl5J0ZHznhPwftPsq4mDE6jeZhybiFx7owcRM0x
         f6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84765DuoST0pHLENKjOtFfS17CAp9U3aQfiEd6H8R+U=;
        b=P4vXEo/R29Bbs1rMspfNt10iQRRqQNolphB5dixdTxAuCzf2PZFOJSOv0r3QQ6QHs6
         i+8uTKOV2TDNfEbfharJHZuPqfLyJKdEVLG0ey+VMzlgtVtCSETt7WzlvPf6nRCUPyLL
         olpfBgKhxJFpQNPUiCHnXjbVUmAq0ZjK3ic14qPTEiUiBfFNVHZ/ShnoqJEXDWnpkH82
         rxvnUPxpfAEdDW966KFvYVZ4HZtRRx3DVtvUAIw1s2afx5fOWv8FGtuPtWlsvBNjxv43
         0WbcocE3S6n6jHMV+5B0qS9NiPL8mLWsWHSuhY4ACUU+B+6JoXUQJhbph75Z7cG45PwU
         d+cg==
X-Gm-Message-State: APjAAAW04Cl5aYGERMXUy8jpoNGsfgySbrT4ntxsQcgRHzETLYgXR9cn
        61B1ODAOzdaPO4aQ8kDyRPnpeEcjgDWCYQt3puKrpjJp9vk=
X-Google-Smtp-Source: APXvYqzBrJrabgne5q6B6HtQGE/JytQ1OKvjMV0H36UrZfwjIu6M4BnVjYJJfXlfSDMQWOEyfEMdJO47pzkpk3QhPXo=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr6596854ejj.6.1579777363855;
 Thu, 23 Jan 2020 03:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20200122204212.13004-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200122204212.13004-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 12:02:32 +0100
Message-ID: <CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Wed, Jan 22, 2020 at 9:45 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Greetings everyone!
>
> I am Shourya Shukla, a Computer Science And Engineering student from IIT =
Roorkee.
> I am very keen on contributing to Git via Google Summer of Code 2020 (GSo=
C 2020).

Nice!

> I have worked on a microproject(I saw it here[1] and thought I'd give it =
a shot)
> and submitted a patch regarding the same[2], which has been accpeted by J=
unio C Hamano[3][4]
> and will be queued shortly.

Nice that you have already done a microproject! It would have been
better if you already added [GSoC] to the title of your patches so
that we could more easily find them.

> I have become familiar with mailing lists as well now so it isn't
> an issue. I want to know in which direction should I proceed now.

In https://git.github.io/SoC-2019-Microprojects/ you can find the following=
:

"If you=E2=80=99ve already done a microproject and are itching to do more,
then get involved in other ways, like finding and fixing other
problems in the code, or improving the documentation or code comments,
or helping to review other people=E2=80=99s patches on the mailing list, or
answering questions on the mailing list or in IRC, or writing new
tests, etc., etc. In short, start doing things that other Git
developers do! Alternatively you can of course focus on your project
proposal."

So I would suggest you follow the above advice.

As we haven't proposed projects yet, you can perhaps look for a
project that you would be interested in. As we say in
https://git.github.io/SoC-2019-Ideas/ the ideas we will propose will
be just =E2=80=A6 ideas, and the list we will propose will not be exhaustiv=
e,
and also we are more than happy to receive proposals for other ideas
related to Git. Be sure to read the "Note about refactoring projects
versus projects that implement new features" though.

Best,
Christian.

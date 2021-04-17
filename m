Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C48C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 19:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4F761245
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 19:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDQT5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQT5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 15:57:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36522C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 12:57:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x20so19631484lfu.6
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l98xm6Tdur/0588BfpFhyAGwxJ9plzVrPs4WmBtnK9k=;
        b=SelBFE4UMNsiTGlyeBpxXI+YAiICzzWLL2EI+Z4Ezos1cec5EgaWMWjSiKKdxIzJ6d
         47PS8KlL7tR4hFkLkNDAHNWy1NbFLlOoJLyLgFuD+xTMoaZ1R+QvAZ0TVrY8rjYw4wWW
         nT3gGRSlJaofMCnyqMgFTX4Bag2WgrRjWFpr00OyS8v9Oc9W05q50eO/U0sawn8RpQLq
         FGw+YT11FkQtf6FBZEEn/8bzXEWpBdk8CRa26ZScYGM5zCmdiR8UK0rtsQFiVmGQFPzX
         jta9gbMuj3yed5P8WMOttwFy69I/iZfpr5TiSza717+1F0uj0Vr/3oWfqBqS4TfTiHhs
         XxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l98xm6Tdur/0588BfpFhyAGwxJ9plzVrPs4WmBtnK9k=;
        b=Nwvqc/iuliF0l1zJZ4oHkf/k7BYbp/Cuv1DP8HPBUI/xAiTA/LG9JDwkFjWvAgZI7t
         UxejNKHqFz9gVXxLIpcLY453OCfHgttHjRccBi1lzDNkFAc0y1UMSr2xXIZsF/Pe0cIp
         N4QhcDcIA/UKn9Dqb8vGT1fhQeqwR0K10uP1yOMmzU43p/sVCyQM+Uk/gxUXqXiW3vpd
         HcYinOxydSWS+wbcOP1PRd4ox1dxYEIuE+gYVm55J2SkKJL7HYnbF5NAVcqN6wBUNjbR
         PGN/2U+6PbKgeYPEeum7e22NlUpvQah1PwtPaPYDfTYF1Y+WAvfE6wR0yCEEJuqKDAv9
         aVDQ==
X-Gm-Message-State: AOAM533zF/cw9htzbhw1M5ua0g0M95RdfGw/cmz7ycQMzHX8MeKLgQML
        g8E70SbBugzI5QD/UdmFvOXDhqDkVxNEGr9QV6y4QbFjPV4=
X-Google-Smtp-Source: ABdhPJxO2UNNgxXC6shrjCX9fG61F/OEzBET6tFyD9Q4hOgECUsafIlC7v9QR1pB6r8ByH5k9WOBnJm5j4m8lFXnp0s=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr7152758lfd.354.1618689434565;
 Sat, 17 Apr 2021 12:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
 <cover.1617893234.git.matheus.bernardino@usp.br> <xmqqpmytkis8.fsf@gitster.g>
In-Reply-To: <xmqqpmytkis8.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 17 Apr 2021 16:57:03 -0300
Message-ID: <CAHd-oW4qdVTQyEeUB5_78iDoK-QWMNXOZ5cN9HuONYASvw6zpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Parallel Checkout (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 6:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > This is the next step in the parallel checkout implementation. As
> > mt/parallel-checkout-part-1 is now on master, this round is based
> > directly on master.
> >
> > Changes since v1:
>
> Now, I do not think we've seen any response to these messages.
>
> It seems that review comments for the earlier round cf.
> <CAP8UFD1stvx=2hBWyxmu75SXRzX-bHBfGr2jxWKgHdc85cfxRg@mail.gmail.com>
>
> have been addressed?  Should we merge it down to 'next' now?

Yes, I think I've addressed all the comments from the previous round.
There is just a minor change that I made locally yesterday, so I'll
reroll the series with it now. Nonetheless, the change is quite small
and trivial, so I think the rerolled version can be merged to 'next'.

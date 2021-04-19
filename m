Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB140C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E73161165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhDSJmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhDSJmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7EC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:41:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d21so19752983edv.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkqhLUHdD+LrsCM6h797UAAY+lJ/9jubCsToRtmHxCI=;
        b=Xym4sle1n86FdmanYc5rMhsR0roa27myiz+UDFKm83iRZlrcaYNa9gfVVkr/5+IBk/
         8KzAt8Y+BozgZNuxr7YmeqxlLGMDx8QHqxyNsGGxnXFMeoSPOwxY56CvgQoFAsukI5m0
         2RKdkzkV+XVdHRzkOLGJQu+FyoS6LHqb4gT9Cj5ILJIGWaiXU+NjcR3BAjzYcYwzxh2a
         JP6YNnXXmuznd7ZcfKme6TTs7CHUnqHzUPJfSi7hYRfxZnSrhKJ+Qdij5QnRcvSV7siE
         Q/OSoqa0e0tZizgtOxIs6zpkRkIJDhNCInsxeWRVChkhugSQId1GD+Q2UrXyaYHzhuUs
         hMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkqhLUHdD+LrsCM6h797UAAY+lJ/9jubCsToRtmHxCI=;
        b=EDdyjVk3k9xN+N1VfJEBV3srI9AhJPy0++0q7AqtO1AhQLSqIGeSN4LaXcOWapJ3qX
         iIoYreL2y7jLLdrUwxhM0b5Erhb+/c9Y/BnR88AsKmUZULO2+ngxk5n1wdGbco7eJXCa
         NVpuHqz5KpBsB1ySv1vRcpUeBlGTCtINmcPZE8vPckmR3/xf82fa62qqorKB7A1rwI38
         6LJ5IUZKCm7oQFxzUZmQUe7ch3IxSvcFfzf3LjUCGDPbZmXrUmaUNiC9Qbvbj0pPSduz
         Qr3yBnISZjdwreTKN4CVSBaNbpUXesXpqFXybzW+9AjtNgpnrYblWbjblYNQ7jBpK8fX
         lbyg==
X-Gm-Message-State: AOAM533lrHI9GIvuV/g71AQo7nbpb214wQDiyYgKul+mbgeERw3IZSmP
        b3Em7CFUk4rInB607zaSMhdfTXHOa396gKCYbhkl8HzTMNfvxA==
X-Google-Smtp-Source: ABdhPJwzkG1G+ORvX5VKAcL8fMq+NXz/s6IuytsucDmUpAmc5fR2yLWYUyEjgoTK5vAkDbUGXP8mzMMlN19Dm9GH2ms=
X-Received: by 2002:a05:6402:270a:: with SMTP id y10mr17828778edd.387.1618825305874;
 Mon, 19 Apr 2021 02:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
 <cover.1617893234.git.matheus.bernardino@usp.br> <xmqqpmytkis8.fsf@gitster.g>
In-Reply-To: <xmqqpmytkis8.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Apr 2021 11:41:34 +0200
Message-ID: <CAP8UFD1=a8BOd-jFz3ByfHGiLZ=7uZn7BjrO9Tqd9C56nLG6Ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Parallel Checkout (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 11:43 PM Junio C Hamano <gitster@pobox.com> wrote:
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

Yeah, my concerns in v1 were all addressed. I took another look at v3
and found only small nits in the documentation patch. For what it's
worth, with or without the small nits addressed, the v3 has my:

Reviewed-by: Christian Couder <chriscool@tuxfamily.org>

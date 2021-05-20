Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F6C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441B660FE6
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhETPBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhETPBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:01:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A31C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:00:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l1so25807551ejb.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3imv30Oq5Q81Dnc/7PSKbHbOhwKlfUBZ7QZNHBZyEJ8=;
        b=queE9wqH+SEna7PxS6VNy/P41R3YK6UId6m59gwm6ZHxMGbE79/rhfDzs/2GSU6t5C
         9EboPg+j9d6cPHxg+dqpXzWX02QJRSW+EYyKdIv5tlZCaQmZgBzXETWW5jVnVXpSxqHk
         ev5BHK+wHoXWdu9/pjbpG4Va54M2RmrQvhkO2r3yZLBTu9HMVBdj96KZXA20EUH3IZg4
         d/hUux3svdhJdIOITOhCYpBbYWjSPM2rkZBw5xLfCTK/2TVzvhUnhNWMPphghrHqlUmK
         Z1QL1e1Lmq/ldyOX20BBi6W0Pp8btBHLjN6rX2+YS7NtmClMI8OOxJefMbUVxZSOCfnP
         07nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3imv30Oq5Q81Dnc/7PSKbHbOhwKlfUBZ7QZNHBZyEJ8=;
        b=hpxMERgT32Vu7r09iH3zHQeeXXlNOuRKpdIaKSKjIOIzrtUMg2I/VNpgQ+V9voSs/l
         Mav7FH8+GnxMOUyEdD2yqFSXQNJ6ww7LrP0KpLuEW1OXKO+UUEdlJT7oLBJV7iLTQsLi
         jo2G7GkIdcw79bAmMV44pqxuhZsOOpGZsigPN9JgBeiSG3KoGDNclNHXf6CYwEWpS7xX
         D8wrhPO/cBMOIX80UxN6A0cI7A/2IwMPrx4Bzf1+4KiKkFxTykxA5d45ZL8kXTZrjjEs
         krpTV8hl9XkzqQo/lHWcF632G3YyFczwFnEYrb2GxTs4ljs/va8g3wZl8vZ4U8NmzulR
         VK7A==
X-Gm-Message-State: AOAM530sm4P6IwGIKIbTMlY+op0X5drG/Vww0MEQ3N+m7s0D6vRTQKp9
        G7+36ToPnpUcOunCPf7z+8ZnlOzMy3y7jYz9K8c=
X-Google-Smtp-Source: ABdhPJwxV5/Y0HzMElDyZD8c6emJKHJpMilJORqCt3QOb8h2o6IN1pZVSDvk6/kykX2eBRJzhq9WU+afim6mpJeiZhM=
X-Received: by 2002:a17:906:18b2:: with SMTP id c18mr5097506ejf.160.1621522810102;
 Thu, 20 May 2021 08:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
 <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com>
 <CAOLTT8TRqn5=SqEEnHdFaYi1U5XJXM_MrULfPVzAGPH9AjXk-w@mail.gmail.com>
 <CAP8UFD2_PWKzwuYACH2MkjzCqO4VWm1EwReOZjgnsXAgpFcZtA@mail.gmail.com> <CAOLTT8QO6RsScmvxrvNo5SisWtm9BhfPiK3T8Ez-exwMwOUT_Q@mail.gmail.com>
In-Reply-To: <CAOLTT8QO6RsScmvxrvNo5SisWtm9BhfPiK3T8Ez-exwMwOUT_Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 May 2021 16:59:59 +0200
Message-ID: <CAP8UFD2FuGDqiDUpZohvn9WnBqGwTfak6AfB4pGuh7ATY6o4rA@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jiang Xin <worldhello.net@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 10:09 AM ZheNing Hu <adlternative@gmail.com> wrote:

> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:00=E5=86=99=E9=81=
=93=EF=BC=9A
> > > Before that, we have to make ref-filter support "%(contents:raw)"
> > > (similar to Olga's "%(raw)") and "%(rest)".
> >
> > Yeah, please take a look, if you haven't already, at
> > https://github.com/git/git/pull/568 where Olga already worked on that.
> > It would likely help if you can reuse her work.
>
> I have check them, I want to use "%(contents:raw)" instead of %(raw),
> https://github.com/gitgitgadget/git/pull/958 tell the reason,
> I will submit it later.

Great, thanks!

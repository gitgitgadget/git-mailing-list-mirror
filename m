Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB132CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjJJMug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJJMue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:50:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF1A9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:50:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so950147466b.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942230; x=1697547030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO0yKYC3El4IGBSoKBYCpO1nPhrHRi0ir1FtWZKnQGM=;
        b=Zitx9ScA2+20yaDzxb2NOgRfuMMuqtMkE/D5XpzI/D4PcZxdwCFTAdUnpxxkEwe10e
         a6SfUn16ky28LyEHa3vbQtCm5zSlZ3t14qG+bOpBtqC5Fx60HdEpaiwO2rJL23W4VdgH
         STl8MsGHwi3jj5FYdq+CbyRvgBpEuKM1Qv2jGtJ9Ta5FmdCyt8Ak2XoUT5wP/ymUWGV7
         TcYSRrLQsG+/QiCnnk4XdGssZH7+MXWgK6Y6kCNdum4aAKAu/rPRxBKtumt3HeS4TcoL
         jXJrfHquayWgFoC1PXKi9sZoJ91ub3WGWw9uVoER1M6PRuT4Mp+h+psMTMHQtydVBXRK
         1egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942230; x=1697547030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO0yKYC3El4IGBSoKBYCpO1nPhrHRi0ir1FtWZKnQGM=;
        b=VHvPeG/Hn1VZ9X/JdCkyjvK5Td+CixSDktNtWBfJG+yY25/+E+7+5OyhscJ//jsgKY
         PD/gY9i6UfsJYYBXyB0UdVh4LpifKgBlJ8yBz9UKeA4icqmTcT0kGflFp05dlGIfK2k4
         FobZcWdbXFsr7ie8U0Mu+6XITgM14UXrP3Q9h0euAlz7rcqNSksLhXqYsisc5OFnkogY
         t5cM9AbHPLQ0MRckrZFDO68+BG8+GJ6cKrhHsPYTFB4SvXOIkJm/NCd5byS6dMeelTEF
         9/Q1L9AmDDez71MXeHjPHU1zwjWDNVDPUyW67mbtpKwDpSnFpp+IX5E4orOXiXgwaUjJ
         CtLA==
X-Gm-Message-State: AOJu0YxgLbQteNDn1xR31HTpX7u5KDIM+vMTytkPRgth0ZyfH1nA6WFD
        4vZyjKfxh4N0jFhdc4ID30jUZy8e0hA74/lvi5Q=
X-Google-Smtp-Source: AGHT+IGlAPkBlOqQm5kRzDKEZjz9YIM9L27AqlaqUCMUqCQoeP0yeJdN+umpYfgIBI3NoOMA6WZKml6g2gm9PR/uCsg=
X-Received: by 2002:a17:906:20c7:b0:9ae:5db5:13d with SMTP id
 c7-20020a17090620c700b009ae5db5013dmr16334047ejc.72.1696942230326; Tue, 10
 Oct 2023 05:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <d07487c2-4ee6-3ffa-014d-418793a5a584@gmx.de>
In-Reply-To: <d07487c2-4ee6-3ffa-014d-418793a5a584@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:50:18 +0200
Message-ID: <CAP8UFD327jQwTQLTfVe8CDaDiYHDB0t+as=rjeWQpjmE-iZQEg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Introduce new `git replay` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 7, 2023 at 1:04=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian,
>
> hope you had a restful vacation!

Yes, thanks! I hope you had a good summer too.

> I left a bit of feedback and think that once my concerns are addressed, a
> v5 will be ready for `next`.

Thanks for your review!

I think I have addressed most (if not all) of your concerns in version 5.

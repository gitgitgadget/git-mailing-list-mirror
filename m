Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B9C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581932067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfXUKSoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgAHSGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:06:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33283 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgAHSGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 13:06:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so3377143edq.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK7HPb9tlVpCGLS6uUd9fo+OrtB3AIi6aJC1zJYeQBU=;
        b=ZfXUKSohJ1U9xdN2Av2UpPnlCjMKDgJ4OTtLqZ30akWWy3+bdJPcTbTcsO3G2W8RKp
         nIuAUW2hPoJlytSQSrazVvUt9OyZBAv0oKqZUHpWMgOEC6v3B3zuD9fz/4ZW/UY70a6Y
         Ec1e1idpEgSyeUDNKMySUHJV5NNkzANGzMmi6VVG7gAqH/aK/1UHIM1vQQ5j/wLWLO2c
         7dlrvEmQII0itKtrcO9k3GEI8gcHmWR9yDvSicTZjkfbhApX/ORZsw5kSFhwDxR24L/O
         ya/801ASB5vAuJlpl8VGdQDzQt3bO8wXBGOhTZoLo3ahXSCvi6/44Zal4CbTGEDmKtOs
         n81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK7HPb9tlVpCGLS6uUd9fo+OrtB3AIi6aJC1zJYeQBU=;
        b=Cemh1ys9xlYcgRgl419s6RW5ldZJk31uXexEPAa+NSjLfE84zA3lUbld3bnDT8Uvaj
         gbo1uTOASPuMQ9GRfn+uG6hdjf5YCCjv0vrh8numx4zCgqjej0+QnpJx4GaGoCWjYOUc
         rlD/eOjkiKRJfcLGRnuI5GuGW3sgkNnBZD7AwQmWeyx7sB16akHYjt8lWZIYkbTP5QaM
         drQZobclalTNoCUhU8YKdxG1h/GmzV6E/qiZGk1bRA5hzPaoE0e9x4wqrWE/vhqcS9dJ
         luOxsjLEwRAsThtSMQV+2VDUhc/zusuR2qo/MxEUacPKJyYZO5OOdpsAiPPorxaqWQem
         Wg4Q==
X-Gm-Message-State: APjAAAWaMfBvkI8bCmAoH/CaOoFKyXT9Z3HKXnwhjR16pwSly8gN0kbP
        ePpbmVk0ttuzMNWS1w80F8FuthcY/zoN99uI5DQ=
X-Google-Smtp-Source: APXvYqxLW0ZJWfmpj8ZCvjFQu/4VWWXDH8DjHLtPoFLag4ON64KJ91llHrAtHLAB2Mr//qut3G7bM9tAoRqIhSHs0z0=
X-Received: by 2002:a17:906:580a:: with SMTP id m10mr6069362ejq.296.1578506797544;
 Wed, 08 Jan 2020 10:06:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com> <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
In-Reply-To: <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 9 Jan 2020 07:06:26 +1300
Message-ID: <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 8, 2020 at 10:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> advice seems simple on the surface, but every new piece of advice
> means having to add yet another configuration variable, writing more
> code, more tests, and more documentation

This raises a question though, do we really need a new configuration
for every new advice?
So a user who's not interested in receiving advice will have to
disable every single advice config? It doesn't seem scalable to me.
I imagine a user will either want to enable or disable the advice
feature all together. Why don't we have only one `enable_advice`
configuration that controls all the advice messages?

Thanks,
Heba

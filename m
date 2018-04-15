Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830F31F424
	for <e@80x24.org>; Sun, 15 Apr 2018 09:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeDOJzS (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 05:55:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36923 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDOJzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 05:55:17 -0400
Received: by mail-it0-f66.google.com with SMTP id 71-v6so8130471ith.2
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=50O8nxv1nl9tSG0/y3hah++Wbvg2jmJa8ON2/GJHto4=;
        b=jxn6wkTbFu5DFkT4RyujjpJ4lrNxjl3OhJ/p4U0voUx6biTaoEJn+8kpGTm+F3m2Wb
         KKwPMQO7Npt0KzSO1DAobx1OvJvRS82dj6ausRqZtrMXaCxc489vA6iol6x2Tl5JpoZP
         4dvI3odnzcnKDAdAfjMdoxQSMcWa8FMr8BR5S0Ymby17Q9BEP3LOLeBA+mws0Fkc/Bc2
         Kkap9yMEEgjGoawZSoMXUZpSkZ0l3MHm9i6KZAuh2RATAy+caIzChaoNhX2MTwynt/Qn
         0a0z5vls1CqwRR2hNnJefhxGPiBiEl/qMajmgwQP3tb2d2mpiUSRhtE6NBWUEWG/3JGL
         MjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=50O8nxv1nl9tSG0/y3hah++Wbvg2jmJa8ON2/GJHto4=;
        b=nX+159VV6YvvVnbNuCnxlG8OZjQh3+26fZv1Et/ty9FTV4NMf5ZKeWblb0PYua7IzZ
         CyXnaAFG5vAC/iabXsyXBcIcKl8+kp28I3VeaU30nPBcPX1mRKhN2uqo+XKeqBCb860/
         XKPFwk4qOBzctxR6UpIjiQSzIO5IH1dvV1n+mMmK8bIJ1Qpu+++/V0WEpuLdb64c3frn
         qeTluytGZC0JwyA2GJRh8pLwtrpPZmilzbX+Tj2UdI6LqKdSzq22xl9yIy29p5iXQmT2
         AY2UtpDDiZ5A6KwmuR5TWpsZX69gunoQRSg6Jd+tADQN/CURwuTUEWrT2hUQ10LBEOMj
         Xqaw==
X-Gm-Message-State: ALQs6tC/kkFgl/7sJJFz09WjzfckvJzjmSjDrnAxwbfUr5BTUVKzDNXs
        mNjSWGz+3ov0X6/vPMqFuwCTncNEuZzTApEmdb8=
X-Google-Smtp-Source: AIpwx488kw59dQSy3Ilgvb+C12CFqutuZQ8yXhdZpXMgyLAq80BlR8buLhw9cJBP/dKVePBCre0LcbWVoyS8dnUAcI4=
X-Received: by 2002:a24:538a:: with SMTP id n132-v6mr11165827itb.129.1523786116787;
 Sun, 15 Apr 2018 02:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 15 Apr 2018 02:55:16 -0700 (PDT)
In-Reply-To: <20180415085841.1269-1-haraldnordgren@gmail.com>
References: <20180415085841.1269-1-haraldnordgren@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 15 Apr 2018 11:55:16 +0200
Message-ID: <CAP8UFD3uz0kQ7s6MyRG=hXg8tYbu7QbRNqMZPstrtmXBZ6eTCg@mail.gmail.com>
Subject: Re: [PATCH] Create 'bisect_flags' parameter in find_bisection() in
 preparation of passing multiple options
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tiago Botelho <tiago@gitlab.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Apr 15, 2018 at 10:58 AM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> ---
>
> Notes:
>     Preperatory patch to enable either Tiago Botelho's or my patch, to do bisection on first parents / merge commits

It would be nice if you could move some part of the above note into
the commit message (above the ---). For example:

"Make it possible to implement bisecting only on first parents or on
merge commits by passing flags to find_bisection(), instead of just a
find_all boolean".

While at it maybe the subject line of the commit message could start
with "bisect: create 'bisect_flags' parameter ..." so that we can
quickly tell which area of the code it is about.

>  bisect.c           | 21 ++++++++++++---------
>  bisect.h           |  5 +++--
>  builtin/rev-list.c |  6 +++---
>  3 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index a579b50884..d85550fd89 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
>                                              int nr, int *weights,
> -                                            int find_all)
> +                                            int bisect_flags)

I think it's better to use "unsigned int" rather than just "int" for flags.

>  {
>         int n, counted;
>         struct commit_list *p;

[...]

> @@ -19,6 +19,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
>
>  #define BISECT_SHOW_ALL                (1<<0)
>  #define REV_LIST_QUIET         (1<<1)
> +#define BISECT_FIND_ALL                (1<<2)

Is BISECT_FIND_ALL really related to the other flags, or is this
mixing rev list flags with bisect flags?

Thanks for working on this,
Christian.

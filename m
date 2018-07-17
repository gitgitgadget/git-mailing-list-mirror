Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507261F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGQLWc (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 07:22:32 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34544 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbeGQLWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 07:22:31 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so229874ybq.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 03:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYRIkUpp0ORmXViJ3xwVFjXKJiZw9i75z6N+0SIbN4o=;
        b=jiGQ6+CnK+LXcydaIclWF+SiqaRMVyi01d5JkcNmJL+GtG6RA1IHnIuDXxfkuMeMEF
         5R6haXUN3v3NmFNRurQ7tERtxbi+Enz5AX1HLgBQLp+kf9FygrNouSfIT1oVxREiQGLr
         U/RwzZTwVtypsVRZN47tk/AK92eGuWiHWisPOcdOZVhB1B8VHfFk/VZR9vRYK1ZBsvZV
         TZ+eFk8AE1BTpyNDfdgSS6KdqXKLqY15l7YrREqX8cX8OZw5fjFkf/7083qJYVRkAbL0
         O6UUK8TwUYLLtWadwX3lHL4xqA73cXBVvYy3zybvsUTSwKiQgh5IeH9C2LGCdT2Af4cV
         6xgQ==
X-Gm-Message-State: AOUpUlHHKGbrfMl8cdi2gy4qBQX0nc75IsvcSi1X41hp6v7HyxDwAH4S
        3syDL47F1FifgmpwbLy2XC7SzEfOREn2VeBRLS8=
X-Google-Smtp-Source: AAOMgpf9f02Q6zOFvE3OUrrHb/eC9d3C5a94AWliTDzhZ7e/3prONP1+XI7sgQ2lEoYBOurrCD3kMvOZaidnA47l/T0=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr483920ybq.295.1531824629335;
 Tue, 17 Jul 2018 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-4-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171243410.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807171243410.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Jul 2018 06:50:18 -0400
Message-ID: <CAPig+cRXBjvgC6gmnQcYT85kGcE+Aaq1fRuQN-WqoNHQkam=aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] format-patch: extend --range-diff to accept
 revision range
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 6:45 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 30 May 2018, Eric Sunshine wrote:
> > +     if (strstr(prev, "..")) {
> > +             if (!origin)
> > +                     die(_("failed to infer range-diff ranges"));
> > +             argv_array_push(args, prev);
> > +             argv_array_pushf(args, "%s..%s",
> > +                              oid_to_hex(&origin->object.oid),
> > +                              oid_to_hex(&head->object.oid));
> > +     } else {
> > +             argv_array_pushf(args, "%s...%s", prev,
> > +                              oid_to_hex(&head->object.oid));
> > +     }
>
> This would be easier to read if the order was inverted:
>
>         if (!strstr(...))
>                 ...
>         else if (!origin)
>                 die(...)
>         else {
>                 ...
>         }
>
> Otherwise, it makes sense to me.

Thanks, I re-wrote it that way in the re-roll already.

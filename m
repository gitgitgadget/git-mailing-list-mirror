Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20461F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 16:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbeKNCFY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 21:05:24 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36484 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbeKNCFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 21:05:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id u62so2908444vkb.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 08:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2omIqCFOzq0nELxSWrbJ6Rk1tU+BZerLoJBsk3iaglg=;
        b=FF9OnMAngfDHIWnxMAbOd6YDWqbpjQ6lgBYg6p/6kR6GKiprczYS/xiWQHdwQzDrlN
         yJXFVjqE18ZhQyhGh3YSElo8MqD+CoiG3bXyn4aJ4WlZb/bdcTBs1wLYtqQhpePtcpyh
         IxkiMdmU+EgIS/TUFcYE4cz4UtG3Iiv6hUtJGRXNS7U9rlejXrx+3iC6FTeDQmkPmqBx
         A3qOS9bb8pRADqVvKvnY/EQ6l1+ixAx+AMH9yRUXKwPka626NT+arr1644g+Azr4MjPA
         vL1OV+XfiMQSxb4pdCyXk7RzJGFVz8IAj9361VxYt5FqQXwN+zf2Z8YHrcr+XVabQg2q
         4+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2omIqCFOzq0nELxSWrbJ6Rk1tU+BZerLoJBsk3iaglg=;
        b=Gr6101+vYzB7mcz/9l87C97wexiUQcGAlPUi/4WvE+cno+UEcK8RccxQW8Mo7QK3cs
         JlMb91XS8yHKsfgAOLZKPNjvjnjxQDV6T/Rf87JAdBbeHG466ugStpvihCpSKWzyrm9m
         5G8HvGjUMYPtC+MXlWuli5iPrgsmZqjPtN5j8GRa+Y2smEjJRhBtd7UYRpWLWqQn6/s5
         y2vHGFK6H8cmycFy8APhM8b9ZIZ822x7gZIDUHSP2lFGMloHZmP9TpH94apyy9jlnHHh
         WcGJ04cSWwAhPfsojuy7fuDj7qR5bRQLsylV6iyxxEobOKTv7zNkWB8/hP41rhUQkW1T
         GtWA==
X-Gm-Message-State: AGRZ1gLqF3gynGB2VHvnmiDnUp8Ia3czwfkW117n1L5yPg3NvSW+OWJY
        aMBVtmPbIFknezROBtwYPa33eqfJRAgyQmFWsGY=
X-Google-Smtp-Source: AJdET5dKPxPO7V+dmsQKF4ZAgFRxs8Qihv90BMK9JqNP1H2o/BEz8zRjgwt8DMM8IM43/eBaQ2GGZlvPO9FwY7XhQyA=
X-Received: by 2002:a1f:2d89:: with SMTP id t131mr2459046vkt.27.1542125199503;
 Tue, 13 Nov 2018 08:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com> <20181108060158.27145-3-newren@gmail.com>
 <nycvar.QRO.7.76.6.1811121614190.39@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811121614190.39@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Nov 2018 08:06:26 -0800
Message-ID: <CABPp-BHBh1ubHvB=oHFeqiQyfDWuCO_r93hL82y7HkNXLDOUTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: Implement --merge via git-rebase--interactive
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Thanks for the detailed review!  I'll try to get back to all your
comments, but for now I feel bad that I didn't see and respond to at
least one sooner...

On Mon, Nov 12, 2018 at 8:21 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Thank you for this pleasant read. I think there is still quite a bit of
> work to do, but you already did most of it.
>
> Out of curiosity, do you have a public repository with these patches in a
> branch? (I might have an hour to play with it tonight...)

https://github.com/newren/git/tree/rebase-new-default, but ignore the
last two commits; they are separate and haven't been brought up to
date despite having been minimally rebased.

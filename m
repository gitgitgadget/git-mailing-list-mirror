Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2BC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B0B61139
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhEJTQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhEJTQe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 15:16:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88BEC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:15:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c21so14024303pgg.3
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=USOgnRf64leWqrj3KPb1XpgxS6nNpbhf4DAvDYiYQE0=;
        b=QzF1plTf82XqIhw5SR75aFZX3RKuX87Sr+4fHnTFdQMq1wNmujA+iJlBWEzskDCnNv
         0/VaZxkNrAPDYqB8Z8KUmdJUk6jfuvDkgV0QmliGaumhlk2wsylbMWqBEWe7BHV+0VId
         8Dm+q15QyWe2YyRmUSjXCNM4Iu2GTqQOCN7Uzd+OoWAyy8ex1AMHPT1LwJ7lcM4yI0qx
         mK5jGSd3ljXBdopklmC5/lVa1VEiWfKP3C8rrffn9+APmgVYyZTJV9JfUIF2jEMRsOc/
         EcewJPuKxO1rxnFFvyaqKedcm1X5eXCPMrVwA1iELXsZB7n3imb/IjafVNZCbz/KSwU+
         axzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=USOgnRf64leWqrj3KPb1XpgxS6nNpbhf4DAvDYiYQE0=;
        b=euqm6bAQtV1MDbTmCZ2+mNlt+9Lbk/7p7UWltMopIoXwzfeGtVlKZI+S+cCSEnvN4x
         Z2lLnR0kiNiXL404EhT+cLSNoooNBbMYC4u0eXX9uk6tVHuPVGruMM9WN0T8sXKJCkLy
         5oc9ywxGj8T9Qcwm4ajehS5iCBIS2+Gz4UvXGBpTWH2r8bipnzq8uCOTO8Ey+jjh/y2u
         8cVeVmv/rE6+4NQy0E59r6bn7OdkvgICe0RMUY+xAxLCECN2aLDl8KSAy/9qF16Z4b3t
         maHvKqCa9sK6z/cLvJHHL7RMcGKIX0Ylo/APIBDp58b5wl3w8Op7lRgnrzsMUQmvombV
         rKBw==
X-Gm-Message-State: AOAM533mqBItdckJ6WqvubJa5BO/joMVdPuJIqXwAax3BmlOY7p8Iofi
        8TBD4kWxk3wD1rDA8zWjMHZEWybES5mqWd/RKZc=
X-Google-Smtp-Source: ABdhPJy3t/6iasuw4lqoAw6wIrimW0BBYUhfx6OWq4OxHUgRG7nlW65HLa3tX/BAo4PWw7gsWbmQmuAtFI9/OIUEgRM=
X-Received: by 2002:a63:2c92:: with SMTP id s140mr26974970pgs.39.1620674128260;
 Mon, 10 May 2021 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
In-Reply-To: <20210509213217.449489-2-lenaic@lhuard.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 10 May 2021 21:15:15 +0200
Message-ID: <CAN0heSqN6Pdxap7JVN_L-BKJmbKhLiuzNVvmdC87vZjitv6eWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi L=C3=A9na=C3=AFc,

On Sun, 9 May 2021 at 23:37, L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> wrot=
e:
> The default value is `auto` which chooses a suitable scheduler for the
> system.
> On Linux, if user systemd timers are available, they will be used as git
> maintenance scheduler. If not, `cron` will be used if it is available.
> If none is available, it will fail.

I understand your reasoning for going with systemd-timer over cron,
especially the part about knowing that the thing is actually running.

> +--scheduler=3Dauto|crontab|systemd-timer|launchctl|schtasks::

This says "systemd-timer"...

> +       By default or when `auto` is specified, the most appropriate sche=
duler
> +       for the system is used. On MacOS, `launchctl` is used. On Windows=
,
> +       `schtasks` is used. On Linux, `systemd-timers` is used if user sy=
stemd

... this says "systemd-timers". Should those two be the same? (Which?)

> +       timers are available, otherwise, `crontab` is used. On all other =
systems,
> +       `crontab` is used.

So to be clear, I don't have a horse in this race. A few years ago I
would have foreseen all kinds of reactions to the implication that
systemd-timers would be "the most appropriate scheduler [...] on Linux".
Maybe those times are behind us now. In the commit message, you say "a
suitable", which reads a little bit less opinionated (to me).

That's just a minor point; feel free to disregard.

> +For more details, see systemd.timer(5)

Missing trailing ".".

A cursory grepping of our docs suggests this should be monospace
(`systemd.timer(5)`). There aren't that many places where we refer to
non-git manpages, thanks for doing so.

That's the only nit I found to make about the markup in the
documentation. Thanks for your attention to details. :-)

Martin

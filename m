Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE7C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480D42072B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NofspIt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBETx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:53:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41052 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 14:53:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so1308245plr.8
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYTZNbZG98PwUqaTOcvocibJzOJwxLEg10ab+EUQTzQ=;
        b=NofspIt8AjpWxwmLie42HaEpO9XuMn8n8Vm82ruk5+aONlZeHmxmtff9C3Dbp7syj4
         Aa9CMSUB4565FBvcexN1hweS1QYJhkto6YDOe3rQv6pkOB3/h3rBGUmSc/k7xjRI6Lo2
         aop3fhv8gj10y4FTC0v2fU2ZsJ0TUWrXT2u1864Yk9y0uTDpLXtWm71H1VvBEwvCpKGA
         RbU72h3XWziJIGA0gLIzV7GCDzejhHp6KlUmWjDAmOthZ/u+bVSHr96Nuf3Dp8vDQNJl
         6GD/DkYog2t/ni0USf+M2hIuuKSRDblqgC3jRxD/jpuQVuKMWPfsv9shet4LDWNBoivz
         RTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYTZNbZG98PwUqaTOcvocibJzOJwxLEg10ab+EUQTzQ=;
        b=DgwAA74m5qk9884/8Mnu8CLjNKb19UzKiopG9GdLuAaLwotbTjR1NkpOFm5znHap40
         pRdMSopUkQg7Sw6mA56Gdgmashfl+DuZVLiSb6BqvCZfCdObuqOAjgxuqUcFKH1KX7kt
         hfonb1m2n/9smq5VM+fHLP9T+d9TLxpgM6xn0rNXIiLWSWrmFjEy2wE7+55Y65+Rjq1f
         pazkrxizkMhUQ2tYEHZR1CFKxcEVHuWff384soQhDqRxgX5pow7grYg78zEwGhyI0qng
         7lrkMYuJq2EalgBFbZt3Ff0wANcKk3bkEUb18ZqRQXkuoEKY/JtHFiAkyctJisYKV8yg
         ZHVQ==
X-Gm-Message-State: APjAAAUbY2K2eM3V4TlZdhULlx363Djh++tWSvibMXYT8Lhwaa4+AirG
        t0767hkP0LPzlMjrfR6VVfy2UaN/Vc3nGTJyd2s=
X-Google-Smtp-Source: APXvYqxRSTBQyqE0NUPItRRelnMtbDcI6jh1ZxZQnJBzXQMWwoqTV0ai9hH75taGor29n+wfaZjftKr4A3X4p/JeAvI=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr35709155pln.178.1580932406672;
 Wed, 05 Feb 2020 11:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-10-emilyshaffer@google.com> <CAN0heSq_i4EitqYH-qrZyXBU+=PUNcSXOOJDHLSnJ1ufV0WtaQ@mail.gmail.com>
 <20200205004455.GI87163@google.com>
In-Reply-To: <20200205004455.GI87163@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Feb 2020 20:53:15 +0100
Message-ID: <CAN0heSq89F+Z+osLFQBrQEZAEEnfK19tpana044WZ6BYPKi9OQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on docs
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Feb 2020 at 01:45, Emily Shaffer <emilyshaffer@google.com> wrote:
>
> > I sort of wonder whether safelist/blocklist is to prefer over
> > whitelist/blacklist, or if it's the other way round. The former are new
> > to me, whereas the latter are the terms I would have used. But that's
> > just me, of course. I was a little surprised, that's all.
>
> Eh. I think the following things are true:
>
>  - Whitelist/blacklist has a "smell" of discrimination, whether that's
>    the true etymology or not.
>  - Those with experience in the field can easily understand what
>    whitelist or blacklist means.
>  - Safelist/blocklist do not "smell" the same way.
>  - It is easy to tell what "safelist" means: "a list of stuff which is
>    safe." No experience needed.
>
> So, while it's new, I think it's not harmful. I see only a no-op or
> positive impact from using this term instead of whitelist/blacklist.
> Computer science seems to have quite a few terms which fall into this
> long-standing but potentially negative area, so I don't mind looking for
> alternatives where it's harmless to do so.

Ok, that all makes sense.

Thanks
Martin

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E64C64ED6
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBRIAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 03:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBRIAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 03:00:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE14DE3E
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 00:00:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jk12so499259plb.5
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 00:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUlcDv0bD2L0mVammk7BxV8gOWRsdeUC5nIVZAXxplI=;
        b=ao9DGFoInXwa54Vas+oZY+kLA9NTGGwiFodsprozAGQz8eOSr6Z0YuL3fQVnMnInxB
         7SldDjabNox7TU7Iodak6SoLdWQNeG2Rm7FkO12WCyuFx2YcamJv1F2QiQKmWYn3vAxO
         JscpDkBr40d5ervBToH5ie/ODndaqPorDpFILzpaEBtkQEzCnG+PlNaKB5grPCCsklEF
         +VJFcDi0kg2G67IyvLkSrE1y5kGANR3sxYMXlfqo75ke8S1CaG8qWqr3inet03TLiT+G
         QMmXj4JmQwudUZCBpJGOz3h9kQMWiLU8SKnGuVU3oM5Yotdk8YZJ15Zgawkim0mZXA/k
         77iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUlcDv0bD2L0mVammk7BxV8gOWRsdeUC5nIVZAXxplI=;
        b=wwC63R3E5bb0k3eeyroeIeC9bHcvCassM8T0/AaFgN8fVHhpJJCTvQnhYoF6pUZvM6
         cu2eBx1E1KhmvGk2dzy8ChO9cIni21O2sGDITXOUJzIFjw0IahaAJF0LXge/U3kU6EcE
         q9Dzs1Y+KUSbpDhmPpSBhUdfnywWOgnwnkvd+/xPjVYt1txQW5XbdiScp1YYIFRow4ML
         A1iiGD7oEgd713e6nuU6BftmpBm7lneb1JjVfFDFBej3kWS6ur7pP5UWymJzPawN0JYS
         C7fh/ATy9TpXNiqqWKcz/kkENxGZmhuegH1Y+ix0wzxMyY5wktja69qX9TAnZFEwBR21
         ormQ==
X-Gm-Message-State: AO0yUKWKUoLgj/sEbU/YNwUKCi7aWz3LRzArcgy5CYSuKo0TarE1a9Wp
        LmVC5M6wtF/K5ySc+cZByoGDtYf5Rdpq6pnoFaA=
X-Google-Smtp-Source: AK7set8wriCRNlPJCz7YNcUYHjVvCzBAEe30Y+riudILH/Txh3kcN4r96z0EEbjcYOeprG9htR5S8l3JqeiTvrjLFu8=
X-Received: by 2002:a17:90b:2789:b0:234:80e4:81c0 with SMTP id
 pw9-20020a17090b278900b0023480e481c0mr2046597pjb.94.1676707239411; Sat, 18
 Feb 2023 00:00:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com> <20230216191644.315615-1-calvinwan@google.com>
In-Reply-To: <20230216191644.315615-1-calvinwan@google.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 18 Feb 2023 08:00:00 +0000
Message-ID: <CAGJzqskx8+vkYKL6w8Pq98ZJQ3mTv12pZYBkmf=Q_2nB=A8_Sg@mail.gmail.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
To:     Calvin Wan <calvinwan@google.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Feb 2023 at 19:16, Calvin Wan <calvinwan@google.com> wrote:
>
> >  static int run_credential_helper(struct credential *c,
> > @@ -342,6 +352,10 @@ void credential_fill(struct credential *c)
> >
> >       for (i = 0; i < c->helpers.nr; i++) {
> >               credential_do(c, c->helpers.items[i].string, "get");
> > +             if (c->password_expiry_utc < time(NULL)) {
> > +                     FREE_AND_NULL(c->password);
> > +                     c->password_expiry_utc = TIME_MAX;
> > +             }
> >               if (c->username && c->password)
> >                       return;
> >               if (c->quit)
>
> I see you null out c->password in the expiry if block so that the
> following c->password check in the following if statement fails.
> While I think it's neat little trick, I wonder if others on list
> think it's better to be more explicit with how the logic should
> work (eg. adding the c->passowrd_expiry_utc check as an inner
> block inside of the c->username && c->password block).

It's important to reset the expiry date as well as discard the expired
password so that fill accepts a later password without expiry (see
test cases). I'll add a comment in patch v4.

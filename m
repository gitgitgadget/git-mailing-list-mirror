Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3456FEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbjFNPM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjFNPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:12:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C11FE4
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:12:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d55ac17bso132773966b.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686755542; x=1689347542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo6GmnaToLhDp0reEpwr3dE70pQ0HSOJEWrsA82JPgY=;
        b=MVZV/W9X7Fo9yuDWpUGyqleKQggjyNgpLjkmWulsGIqOsYskIrYX4uD019SvMPdA+f
         gZfOMVnDMWY1Yrgx95RuZtW3qNsfiTdbC1I9duwSAS3VDgqXaO2pcFYzDJPwYarar8Ot
         ccSnzS8SEhCXbNgjChpPWqPX0t3sEJXvTmCfSwx/i2oVr7kFDGY4GbAe1EYMazWByB/F
         hP6XabAvJdjCiNAmiUo8LJx8mNyvGnY7GrshPUw3oLY0rruVX5zRKABzR8omJ7Jsp1PG
         mHnwufRhwm+5W2gh7mYlt7YuqXJefbEGfxFJvKPzruC6/CWlGmNkPlC22edq71Q7xklg
         O7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755542; x=1689347542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo6GmnaToLhDp0reEpwr3dE70pQ0HSOJEWrsA82JPgY=;
        b=lgzXKLYtCX6EHTu/1JayksQxPSI9dipskYZznOQDALUe8vFAj39PlnHq9MdtQvvZdC
         dLpJiSkY3SMlbHfgOBaLjaQF6Wv9yS40T/K0co+36/1bZBhmFjPNiAiBJHF9FSfLEeca
         rSYoHx8spiDKus+VzPV97rR1uFlx7LhZuVrbnYOUjlK2wqhPDjoC9P4F7kELYLyN4HdB
         d4AmkfFEaQBLK0C0frslmOGSCjwYKkrEFJUdSr/I/q4QvIImhq4k+OhaMidPKcYvMqiP
         L+9akTbQHNWRxXiHonv81EwTgAsstXksLHF6K2/FLsGEPjcMH1HZMVZaDrnBCgXVnZPb
         DJeQ==
X-Gm-Message-State: AC+VfDwW9GieN5fc7EnnUO5IWRxI414/3+uKq69yReSwv7FNKHcN1+JB
        RzPyEn6ACaNzEnPRSIgjwLmuqzR0hcDdWwaUNPA=
X-Google-Smtp-Source: ACHHUZ4/IeH2/rEGgzXxp1XnW0OyjsnPoIbuvoVs0bhds0v34t2bfJzUeTnWQlJ6q72wWr0B/AxlzX4yhE8CXCSn/MQ=
X-Received: by 2002:a17:907:2ce5:b0:94a:845c:3528 with SMTP id
 hz5-20020a1709072ce500b0094a845c3528mr16144110ejc.45.1686755541767; Wed, 14
 Jun 2023 08:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <52f7d29f509070a17a32a6f1c888588cc87e6cb9.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <52f7d29f509070a17a32a6f1c888588cc87e6cb9.1686017304.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Jun 2023 17:12:10 +0200
Message-ID: <CAP8UFD30qxHdyeOKXOuP7cE-9VB4f2mLWB2DLZz2Vskwt4QBDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] doc: trailer: examples: avoid the word "message"
 by itself
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  $ git config trailer.sign.key "Signed-off-by"
>  $ cat msg.txt
>  subject
>
> -message
> +Lorem ipsum dolor sit amet, consectetur adipiscing elit.

I am not sure this change is clarifying anything. If you want
something clearer for "internal body text inside the commit message",
you could perhaps just use "body" or "body text".

I am not against using such latin words, but then why only in the body
and not in the subject too? And if it's used in the subject too, then
I am not sure it will make it easy for users to understand that the
example is using a simple commit message.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9BC433FE
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3297A60D07
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhIQQWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhIQQWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:22:54 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2ECC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 09:21:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id n17so9289726vsr.10
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jBqKTWGpLj8TDQkwWLnM0swWxtSfSNjBTDQ+XCcnOw=;
        b=KLgkhKNYPl+gvO/86G+yuSzn3zfSbJj+MTvBwLmvYNRKhi5Lxp+HxGAorxj5dLh8pa
         4mG9AvYJm5NO+TpRHp1LEGoL88cFBM+0WeeGQES5ATff38nfVTz6LchfYu2Sqsk55h2Y
         0nHsRKSlB+npcJRULvn4qzMPx6PmlLwqyXR1I8uK8GHoYnVqYACj2a+4lwrKItury/Pu
         IVTHamQ0N8eohfzaKPC3p0XvNGLOF+05loP0uG7GpR+cV3jYw+2Snnkuz4Hxo7nvyzty
         PFHraUdvwW8jgP72jzvnvW8/Sk6wWu2GYoEH1uwMn0h+dHm8B4ymdsChiztcbDpdA7Kl
         P7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jBqKTWGpLj8TDQkwWLnM0swWxtSfSNjBTDQ+XCcnOw=;
        b=NkDGVax6bzC9pGjy8zW7cQnJuTab+vuqIZzBndxnZU2WT0dx4r0eGKwmMoDVexQHry
         49vZmKlKv6plt5i5JA99KVb7jKhierobfHW8uCvFWRpel/NpcNhoWNctwQF/QIejC0h/
         cuzW0FhLArCm71Jt6mjcxD2au2MjzD0DomNnZTDda5uzJWiSq9WECNeHmumRFiYEBkpP
         dX8Kiz2jPfniTL/tPT6Gj1Z12GdwwLzucvvTXeXFjdWsOQlHrnqLdu2p0JZVYjHLrfs3
         Ykqce6VxVhX9AzBUcHfGTk4FvomolDg+mwBWsUhiREeCu9JZYJuec8CZv/hMrUQKKinf
         ztkQ==
X-Gm-Message-State: AOAM5312aLBteydi6s4nG1KxYKgGTk/tCr/Hbtd0apK0i751HjV3VYEy
        svEuS/+RN9Caglx1xJX2CrJOPcN6J+jhjdXn4R0DA0ljr2I=
X-Google-Smtp-Source: ABdhPJw9lxigwXAAnA6ty9tMq0aqLFFn0KVsh2eMNmn9IhFF1FhwuCFPPjAzoRzeSOwoMEsN3bxf0NBr/Dw6HJchW5M=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr9307397vsj.46.1631895690930;
 Fri, 17 Sep 2021 09:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
In-Reply-To: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 17 Sep 2021 09:21:20 -0700
Message-ID: <CAPUEspgv49ppMbwHMPjF6_4FBU1_tYk_DdXXOTDuWwAx74UL8Q@mail.gmail.com>
Subject: Re: [QUESTION] How to add new configuration variable
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

you might want this in --global instead, but assuming it is ok to be
repository specific:

$ git config foobar.something baz

and in your script

  baz=$(git config foobar.something)

Carlo

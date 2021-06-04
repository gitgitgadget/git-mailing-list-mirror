Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E9C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6768610C7
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDM4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:56:40 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37627 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDM4j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 08:56:39 -0400
Received: by mail-ed1-f48.google.com with SMTP id b11so11027270edy.4
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiS3PrxyAkkoeEE3SnewRYYp93nsZ/muZbmyX+c9oic=;
        b=N6s9PV6IcpSw8CT/sx7zI8JXoDf86cJZnK0RydjczgA1rmK2a8xjp5hiojl0VjAx5F
         4WiwwXTr7FX/EX2PYDcz+sXqL2vew/afKuGbYHdMsTBaOKC9OLSFTLqiRQFwyoMPp+Ox
         hSmz+/qOVhi84ZaTTLa/YbjY4StOUb54Bt1bsRQFXzxeepOcfFt7A9/eQ3/zpraj6v5b
         n7PO65ZLVvjtuRA2M2cLn08HEbVy95OLMWekZHbICGZUIXXWIsCOWxzUMQL0e4Rg6+OT
         OM9MbYhPpGOL/BTsFbQsBJtqExYwTXarSpWAuqujhHrTtUiE4y8OWF6QPkt/cVlmHAi0
         niiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiS3PrxyAkkoeEE3SnewRYYp93nsZ/muZbmyX+c9oic=;
        b=IbThsB9nLsj1tuexBwC9TNcrhV9M91DTiDTsomatJjlqWP4BUbw7EgX4Gtg1p7xVrP
         FF6hXuLrI6xMZhuWsL2jgLaSlxEAT06U4YrM3fYI6qVlqtCARmfGXWUIowY2BoaZ0k3F
         X1qt2Yek5Tf3OBQsTZmLNDvrI6sTNQbFbPbw+ErymKtQ05cX41ax8E/V2BklgeyvCdR6
         B/xiTCXMGCv1th5fOm9fwM4gPCrTgAyIoDNRWKMHqfQOie3XhWnvGTuP5vf2G+z45+fm
         S9NrDvR7z9pZIU3n+fd2fjKMEYLriEWprg1Gxtm6HcKzFkZxxikpvP4nFVFkQcwtPNRa
         i9Lw==
X-Gm-Message-State: AOAM532s3gyIHzceqD88N9UrlBD+UHnaeotF4zs7LDhmyH8vdRz2xXxY
        Pb4/YUp1gryNt18rpu4KciAZsC/rZ71c32Wf4P0=
X-Google-Smtp-Source: ABdhPJwldaAoPAkfyX2JDP7tDu0jOd+iJwS2oErKesy3u1cfhawmV1hpe0i2t+tLyA3wNbqFZ3+JJFX5EpHjscL8pBw=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr4499547edu.273.1622811217785;
 Fri, 04 Jun 2021 05:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com> <pull.966.v2.git.1622808751.gitgitgadget@gmail.com>
In-Reply-To: <pull.966.v2.git.1622808751.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Jun 2021 14:53:26 +0200
Message-ID: <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to resend as it's a cover letter, but just in case there is
another round and you copy things from this cover letter:

On Fri, Jun 4, 2021 at 2:12 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> In order to make git cat-file --batch use ref-filter logic, %(raw) atom is
> adding to ref-filter.

s/adding/added/

> Change from last version:
>
>  1. Change --<lang> and --format=%(raw) checkpoint to verify_ref_format(),
>     which make it more scalable.

s/make/makes/

>  2. Change grab_sub_body_contents() use struct expand_data *data instread of

s/use/to use/
s/instread/instead/

>     using obj,buf,buf_size to pass object info which can reduce the delivery
>     of function parameters.

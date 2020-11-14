Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97093C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588D92222C
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbqdO2IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKNRfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 12:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKNRfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 12:35:17 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E8C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 09:35:17 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id w67so2824297vke.10
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OLpyXKJiz+RtPuUYwcuhp39mBz26b8v5akPYDXXHZJ8=;
        b=IbqdO2IU34MHP9VjhVqiB6cfXWzRzd3sw721h8Ntfwlr3BjJwH2jWSJVeRYLeNs2Tt
         vzUYtY5DukRmCykMkjx/MdUGRx29ncHJ7GcodKqaw2/SIP42XTBU+erOXiRRDlnqGS9C
         /Q8vaYbzzSB4EQXyTdwY62L2hCL2O0xWVpk2j2wWK3BqskIvu/2xIum9vIK0TtzTKSQ1
         bgbmQh9nnRrOewhX2+QdzD7RLfNU2MyA5KM+Fw/gQPDM47JB9WFWp2hDAxPZaefodGXg
         dthZvBPr0P9IF9DCZPdRC+g7Z3MN72TkcocMicPdBCAe3HLqx+zENRiCejsAWg01Dgz9
         khYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OLpyXKJiz+RtPuUYwcuhp39mBz26b8v5akPYDXXHZJ8=;
        b=mEBrFIU31B+bErRNkLgiqZPjqPn3FaTAQ3vrsc5IPrTP8EOyfONu/XjMQL/LvZZDuh
         +1p3fOEAVpqeotlvRlPt1xuryJLoBynayfXOu4384J+AcJ/S9nDsw3QhZXQQFclC5gtW
         qs/+ij7Ytl1gKvl0byFJ7VWO6t4+2UEiQuZGZAOymKnB6OPuuK+FnvhDteqIDZqKCqHE
         799eWHy3uwMjVUmDNz9crxPHLcG1nCip0ciHQWocLiO2OtS/2yxcGdt8cLLjYTaGAdbQ
         /251ItdgdZN42jfBqmJ4IixPe9hVMZr9cOx1euhem5GlHtmjt63GQDtX2DXhnILD1Zvg
         vwsg==
X-Gm-Message-State: AOAM531R1FCWez9st0mcWi+3Sm6w+p+aKnbHiX2zjkhwjWq897iB8ZmK
        vxMFhho3PKEWqytiidwKO695X0XM0uHlcujEYhYhtBBOl6yigg==
X-Google-Smtp-Source: ABdhPJzPkNytkT/CwiMIgPG1vNv1uup0NOYJtpFwp42nZ0LXZJC9pgozvM5++jleopVKUZ+bsHWVDbeUnJWHUR/d5hY=
X-Received: by 2002:a1f:5587:: with SMTP id j129mr4609337vkb.0.1605375316934;
 Sat, 14 Nov 2020 09:35:16 -0800 (PST)
MIME-Version: 1.0
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
 <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com> <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr>
In-Reply-To: <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 14 Nov 2020 18:35:02 +0100
Message-ID: <CAN0heSr9=_So-sUhQN86vawBEkJhnrHHsd3OcSYZMZ-idZGFAQ@mail.gmail.com>
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Gr=C3=A9goire_PARIS?= <postmaster@greg0ire.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 14 Nov 2020 at 16:55, Gr=C3=A9goire PARIS <postmaster@greg0ire.fr> =
wrote:

> > In the end I think your best option right now is to give explicit line
> > numbers for <end> and <start>.
> That is indeed what I currently do, I plugged that to vim's visual
> selection with
>
>    vnoremap <leader>l :<c-u>exe '!git log -L'
> line("'<").','.line("'>").':'.expand('%')<CR>
>
> and it works great!

Great!

> I also suppose the issue is the same for any other language that has
> documentation above function declarations.

Yeah, you'll see the same thing for C files, e.g., using this in the
repo of Git itself:

  git log -L :strbuf_swap:strbuf.h

It will follow the lines from the function definition all the way down
to the next function, but just as you saw in your example, it will not
match the comment immediately *before* the function. That is, these
lines will be followed:

  https://github.com/git/git/blob/v2.29.2/strbuf.h#L125-L138

Martin

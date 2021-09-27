Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED640C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D895260555
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhI0KxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI0KxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 06:53:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE4C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:51:43 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b65so35818310qkc.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EquBb3WM1+oB+y7nEzzv0N6MSjwXdR0btiFZs/SnQas=;
        b=YxWQdSicLnSfgj2PPMgW+Pv8On73OY1a/S7uwTop5PQgVws3RrAWmdVuV0e5zntxY2
         OTp1UkYyljVbt5Jok2cEVX71spRAgLyOksl0mh3VyRLbcBwuDggTVRilvI0VXB0Up32G
         h7DXQ416H1c6Z0ur2udWgIdKK5MLdFVEbAI8wdbsdQ5ffryJBf75fx7vXJ4cpbMR5hW+
         jQI0CxIWtKY/Uw9QeLXEdgUszCQ/wJ+iS2VsCkclc3Yz4DCoFIJcYA/W80qZTteSuBWY
         rTQLCJh3mUnsdh5HexWzW4N3ZOIiR+M4GtW1fbgU1CLhIi148RFNm6EFRV9RpItaXfn0
         B0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EquBb3WM1+oB+y7nEzzv0N6MSjwXdR0btiFZs/SnQas=;
        b=cDjwCYhuqID3oyJp8s15NWS2fvtrPZ+eC19I0vgzlhQPAO7mI9i/eVzZzOx0Lg3C0+
         K4hzcl97wyQXQRQfEwN7jujTF7gVdP78610lbmhsOl4HW7nsrDwSWKkmX3e389DLuzg+
         OBKlhUTeLNuuPe7fpE2kQr3K+acDQ7nAmsk2/FNfEvqnfB1qbZK2RRONwJo/NlzfTBOt
         dZwubIjboJgm0pMOon2ZggqRaHkJiGA3vYAW03TBkyMk+IYTXTxS2SkE0DFX081SJK/X
         bShNkZkBvwbxWmkSjFau869Pd/CQ6zniEgIIZsq6YQ4cKo1lBsdq+HnBFgg+3oUynHxS
         ITBQ==
X-Gm-Message-State: AOAM530o4qb35rGDZbYz/XhKJFM3Pprl/g6R0a+amCd3iLKrt5/lt6Vs
        wWfg/EO3zXfQYsF3QIrh1LOg3R4AzQkuDgFHInuiTYysgciJVbQG
X-Google-Smtp-Source: ABdhPJzkjxyGW98y9bpLl52bawl4sspDKWJto2lncpsQ4eIeMJZNI/5hbwwthwmnxB+XpDL8WjaKIEAvoL/qwG8FTns=
X-Received: by 2002:a37:92c6:: with SMTP id u189mr543157qkd.521.1632739902306;
 Mon, 27 Sep 2021 03:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
In-Reply-To: <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Mon, 27 Sep 2021 16:21:33 +0530
Message-ID: <CABkJDHHeYkq-xF8pFweMtO0Xzm6FqHobSTTHzTN1KPQr2MEDNw@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to mention that we also have an alternative.

We can completely ditch C++ idea here and instead remove the native
title bar or border that the Window Manager gives and instead draw our
own title bar in Tcl/Tk. But that means rewriting the menu system.

So, I'm waiting for the decision of Pratyush Yadav here.

> Regarding GUI toolkit, you should pick the replacement carefully -
> tooling used in Git for Windows will need to be adapted in order to
> compile your chosen toolkit (whether it is Qt, GTK, or wxWidgets) for
> Windows.
No, I'm not choosing a toolkit. Whatever I will do, it will be in
native C++ without any other toolkit. It might be a little hard, but
it is better than including another whole library in here. Lightweight
is a reason I chose Git GUI and I will make sure that my contribution
does not make that go.

>
> CC also Johannes Schindelin for comments.
>
> --
> An old man doll... just what I always wanted! - Clara

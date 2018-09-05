Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACE61F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIEXql (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:46:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38872 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXql (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:46:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so6962586edb.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2NfehXYIJamaCgbF646oTgWBrUno7/ZGANJMg1KxiA=;
        b=TLHJrdI/u2tzcRm/oFi0pNOKM5n4iKq1jL438W0MfGWLjyy/v8Xlk3tvuByB2fyoo8
         4NnVK8fx7Hmjrp7UV0ERyolt5EeEKkrLKVBx+OVR6w+oTMHi+rhJdccjZ3qCvZMG82Cm
         wrPws1qFiLSo9sgdzol759L/NzNPuvrlBnx2xdveuR/oZJjdtRpDGH6U1irUuYYOxKs2
         Vae7+Y6QbkHZ3zYGtcq10TP8/irrmdjDF7nRt7IqUFk7mQBUgMOzgAcT9ZIuIVzyRkEv
         4nNJsobPtAUz0YrwtEA/h4ZQxfJUuogqSIjzptrUyvLBk2CI4pQFGbPJp2TsRLr8l4l4
         uW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2NfehXYIJamaCgbF646oTgWBrUno7/ZGANJMg1KxiA=;
        b=nyhdNz7919lUqDsTqkNFegwngFxERbeYxdsBy4/ryS4/M4ktr/YbpeqUzY3K+E9R6g
         WgIIei3L23BulL99PcQyhFCsW3HoIcSDedslQpuhmkGvWpKlsFPFBdn/0F4MGvWS23nP
         VYTgRSaj6p4BHX4l5oi5X6+n9TDmpFxduSFY5a46Gy3zaa65USgEEQ4JXFhpc8fG63mk
         urg8Aicjp/Fjw0Yeh4EBMnW8l/O9SFJ9ZpQjqEElvsJVWcEpKeIzsny0jZvNnn5QRLJ+
         0BTDRRc5ZQX9D4pDK79etxxjU0LyTaKlXxViRH+J3H7b6bGv0iMDwYUx0TB97XGHV586
         gCUA==
X-Gm-Message-State: APzg51DNkKbJw5sOPJnehB6N2TQM9HyWSdp12A4H0+f9tz4rKnSTONb7
        CEbZhI4P9/ixVM/Hpf/AT4DbU2KYh24y97ytMzmwyw==
X-Google-Smtp-Source: ANB0Vdbq0da2KAPeznvQBB5zqGwHQ2gfO9u4zONX/9txNUeDDSdthhd0N01+/GnZEA9xAICABycSpa+j1ZknA/qTVYI=
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr44133868ede.181.1536174907119;
 Wed, 05 Sep 2018 12:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.34.git.gitgitgadget@gmail.com> <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
 <CAGZ79kY7_RJfJomkpob85A4ubvXJt3BR8njkaozLgi-6ytxB9w@mail.gmail.com> <da7eaf92-57f6-8129-149d-4260d84b4eb0@gmail.com>
In-Reply-To: <da7eaf92-57f6-8129-149d-4260d84b4eb0@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Sep 2018 12:14:56 -0700
Message-ID: <CAGZ79kZHmCyRLur=DgLx2sHhD1hCXn3pU+0CggwFQgWRzTkp5A@mail.gmail.com>
Subject: Re: [PATCH 04/11] multi-pack-index: verify packname order
To:     Derrick Stolee <stolee@gmail.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 12:11 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/5/2018 2:15 PM, Stefan Beller wrote:
> > On Wed, Sep 5, 2018 at 7:46 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The final check we make while loading a multi-pack-index is that
> >> the packfile names are in lexicographical order. Make this error
> >> be a die() instead.
> > What is the advantage of having a die() here?
> > Would the midx work under normal operation when
> > not sorted correctly?
> >
> > This sounds like a hack for easy testability in this context,
> > so could you clarify why this helps the regular user?
>
> The multi-pack-index will not work as expected, since
> midx_contains_pack() may provide incorrect results, and thus we will add
> the "missing" packfiles to the packed_git linked list.
>
> This _should_ be a die(), as something unexpected occurred (the file
> doesn't match the format specification).

Thanks for the clarification.

So this patch actually hits 2 birds with one stone, as it fixes
a bug as well as adds the check for such corruption to the
verify step?

Thanks,
Stefan

Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757EC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A25722282
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq0L0FOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406570AbgJ0I7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:59:38 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:34106 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406440AbgJ0I7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 04:59:38 -0400
Received: by mail-oo1-f66.google.com with SMTP id f1so149431oov.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jR7n5mwpuNgqqqosAJ8SGXikipGnFFp23dguCSSQNJc=;
        b=Tq0L0FOMq5LT5gb/owSSKWAFILLBU3BJqbrUYgDzphtLisNTk2dfb7AzJ+viwVshrn
         etJWGBOvDU3IYPZsHzF53PXf/7ULSQL/64JkxnUcQ9mHyCSZSH3yJ01HLHuK44Y9QgsH
         R6IhPeAULWnkZ2nZ4SYJlzjb5h69CjaGseW72dAAinw5sMsdlRIKma9Xo6hl0Q5lcraM
         0u3qnPY65OH2167PlpXP47FkyVsvQan6QKviGCq+ZlJRjEOBRguV1IjDTidiC6dT05ei
         LrztBEi5pFdzD7Y9q1BT9QG60a9PVI7Ns2aA0fk6mAS7iBfZhp2PXTbXbCHxWrv9GtGs
         Ii+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jR7n5mwpuNgqqqosAJ8SGXikipGnFFp23dguCSSQNJc=;
        b=J78dZLTbw2eCeK5QzLn0Ap8fFILuRVmpPIWqvktk6Hr2bajDedOWSlKcym2VezxQ+J
         NIzhYoDt/isoqNXo85ACJREbTBzoEC52EwVVpzbvFRZpl8b6Bw39XFrAIkzDZWw4ZM6V
         5BacTd18R261OmEgIbTvBpf8488mszrgoIWj0d3OajsMLeoDxpVlO0lxyZKohyQEBfOH
         lJIUBrEmvHTmQojgXwK4mEVEZKMl80Il8/0gNXYXFJFeJnWV6gXrj8FLFsgvvKrAW20q
         hWbDzqWNpZ9trSCG0CSKv/PvwkSyxPdh1QQ+kKD5e+grmbkdx0nEcie5H4CF43A7ehu2
         zjHA==
X-Gm-Message-State: AOAM533Xd3ixEcjKZm8ieUwi81yxENUHOzBeP8ZxkRGUEkFJkqg3qs4r
        kRLTV3KkbV4hQPrPtJiYXVdzyhBxGQGVw1Hyz2U=
X-Google-Smtp-Source: ABdhPJyniWKEaYy+6F/k+b1XNr0ZRZk/EP233pu80jyHdGJzHHmnxLfdYkah90OuOw2BM4jyRTyufN1+ZPw39FAJY20=
X-Received: by 2002:a4a:5547:: with SMTP id e68mr920633oob.49.1603789177079;
 Tue, 27 Oct 2020 01:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com> <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
In-Reply-To: <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
From:   =?UTF-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>
Date:   Tue, 27 Oct 2020 11:59:20 +0300
Message-ID: <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an inexperienced zsh user it took me ages to understand why the
whole thing is not working.

Regards
Alexey

On Tue, 27 Oct 2020 at 11:32, Stefan Haller <lists@haller-berlin.de> wrote:
>
> On 25.10.20 4:29, Felipe Contreras wrote:
> >> The other hunk (adding compinit) is not so important to me; I suppose it
> >> was not in the original version because most zsh users already have this
> >> in their .zshrc anyway. But it's not wrong, and doesn't hurt to have
> >> here, I guess.
> >
> > If you don't have compinit, then how is the '_git' script being loaded
> > in the first place?
>
> I didn't say it's unnecessary to have it in your .zshrc. I just said
> it's maybe unnecessary to document it here because most zsh users have
> it in their .zshrc already anyway.
>
> (Sorry for the other empty mail, I hit the wrong button...)
>
> Best,
> Stefan

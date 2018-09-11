Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124E01F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeIKWsk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:48:40 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:46605 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKWsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:48:40 -0400
Received: by mail-yb1-f174.google.com with SMTP id y20-v6so9655124ybi.13
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTPR8N07SnrZC0URhUjNoVvs/0rs3MOu5pIvjr8JAdg=;
        b=pM1Y2YN5UYU3lzIT3QXkiSzx/FKj7A9bdl6wxbf+u8f+jFKOZYLvYhv3Bl6ADkYYOV
         vuWKJFUPvaTHRA04dWt+1LeRtXHibotVBboWGT8C82Tca5lD69LotrAwumaaTImXzImb
         5j3nVcVrjrElE1UAY6M99uQmr+VOk+3/RMDG7LdET4550sCCm04Ji9y1zL5x2jUqg8Z0
         uLtRQ+RP+ypEUMsgKEweM1p4+P9dHtEe6D6jupX7jGz0xs2Krwa6sGBtG1G/l7Y8qTHN
         04+83dh+QfpY2I1ANLay3va+jegWO+wbBz7N8QorjlVHp9BEHZ+tUte6w6umet3bfxj6
         eOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTPR8N07SnrZC0URhUjNoVvs/0rs3MOu5pIvjr8JAdg=;
        b=ukuHG2avbGaJqDUBSf99wUdDh05w+yDH0n6z6GQL0NFPQ3epoz22be+XcmCuN4V831
         gfF8Xt+g3oixvSPLmVy3HYNPXLyICuMQqNO1XdM3Tf38esS4/4qrI7/bRKICU2wGDeY/
         Xy5PvlDOp9bH1UdfUdaY+hBnB1X+7E8roaHGlSpGMP3zBOIlf6EavD0cJOfrLvsqbu31
         Tk+xkLRgXseIGhpP9bK7yLVeENFDwe6OVeMVq/+1eZVYRBKCsszN8aLTCVDVZ4Ds1Cif
         pXz17yy368UbjfZ7ptK0HltuaYVlwxHSmND+tOw1W69qtVnA8bZaikxvjJfBzYcR6Yw2
         12Og==
X-Gm-Message-State: APzg51B5PwId3AHhdJ66npUUnsgJt/WOJvvw+CoXm2J9jwPphddkee+h
        iJpGXVL7beyGRtA8BVA/CsgqcLaf9kzcwN6JKKFEqg==
X-Google-Smtp-Source: ANB0VdbvX/EZFOqQfDlcpQ6TuI4jH6EHa6Gt9dQBn5qwOMdGWQVHiJ3jaevvcC46BkqMpmhIVQJnxy+FPU76ls/xWQ8=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr3574899ybh.416.1536688096355;
 Tue, 11 Sep 2018 10:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
 <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
 <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net> <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
In-Reply-To: <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 10:48:05 -0700
Message-ID: <CAGZ79kb53jNAJagQ+nG0hoJiozKkR6Aw=oRLZj5xvjFY5Hx=Sg@mail.gmail.com>
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  [...] So this should be sufficient.

Yup.
Thanks for keeping track of this patch, as I lost track of it.

thanks,
Stefan

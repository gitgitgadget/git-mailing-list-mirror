Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723401F453
	for <e@80x24.org>; Wed, 19 Sep 2018 12:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbeISSOC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 14:14:02 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46797 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbeISSOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 14:14:02 -0400
Received: by mail-qt0-f194.google.com with SMTP id l42-v6so4838541qtf.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 05:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91UWALhEAR4gLZzOiA4GmwDKZDerqsgbN6doz5JpXZ4=;
        b=SoBcXrqw1KzFbDTzkBt5cgILgRccl+TqCI2zCFgiJW5fSZwtUFAzYhLI+zp7sbcPKC
         /dZnn9qhHmUfKG5QYDv/ncE4SU0hGKsGUlnE0b3IwDjzZQgQjBq15kREchTr2foVh6Cz
         ylWSA7DUwnpQFVWQ37npo40fi4xeVwWe5YU3VP+9snSOUc4yob/VyMReMdtITkDjTgJW
         WXC1UkpaF/LvFpdM3X58tuGoGQPBMr2Y8MqUP31+CbDQGtqNrbzUgHw3QQFk0VwBUur8
         O6HUBC9I/51I5b4yFcck61VBUQFDNjrg2NOAY+DURiWF2a/8n9FedX0WRpAR+uYE3AY1
         d9eQ==
X-Gm-Message-State: APzg51Bg83Sl6pHBD6te5AHz51aQwfZOK4Vsl/vlwxEm8hsMxZve2XVu
        RGmKFBAUSefuNSXPUTSWoVxLCNOBrgBCoUNyXW+7WQ==
X-Google-Smtp-Source: ANB0VdbBWL9W9tkuE7WZZZ7Cp2Uev+Z1BUM0IrMtcHb8mtEIMytwoqj/3+PlInGSbnx0G6UH67caezGqgM54SbbK5As=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr24552788qtc.50.1537360577082;
 Wed, 19 Sep 2018 05:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
 <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com> <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com>
In-Reply-To: <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Sep 2018 08:36:05 -0400
Message-ID: <CAPig+cRmeyEsa_GXe6q6uh=O-GD6b=jE3ZkX-+UwzeL_HvrLoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
To:     Matthew DeVore <matvore@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 10:11 PM Matthew DeVore <matvore@google.com> wrote:
> Yes, it's probably better to add a point about that. Here is the new
> documentation after applying your suggestions:
>
>  - If a piped sequence which spans multiple lines, put each statement

s/which//

>    on a separate line and put pipes on the end of each line, rather
>    than the start. This means you don't need to use \ to join lines,
>    since | implies a join already.
>         [...]
>  - In a pipe, any exit codes returned by processes besides the last
>    are ignored. This means that if git crashes at the beginning or
>    middle of a pipe, it may go undetected. Prefer writing the output
>    of that command to a temporary file with '>' rather than pipe it.
>
>  - The $(git ...) construct also discards git's exit code, so if the
>    goal is to test that particular command, redirect its output to a
>    temporary file rather than wrap it with $( ).

This all sounds better.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997031F597
	for <e@80x24.org>; Sat, 28 Jul 2018 06:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeG1H7b (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 03:59:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35267 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeG1H7b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 03:59:31 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so2877772ybm.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 23:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGdr5pEvqlb5K3RlrhtVZrnoDRw1HNyMxC0YiCejJp8=;
        b=Efpg5z3YAe7lqi7h/MJvjKKyvisOaHwHDrDseR6lkIHu3gvUjpm2bKeosq8nTnHwiu
         5BQRWwKAKBZpOD4QzPzpb1WDNZuFhDa1R+1QZTiebhQ7hje5epMokPiXRJ4CV6DnXqng
         qmzak4VeTHoHPdaTWCLUtH+tr8VqYO8KVgNjlOMEh2S4jMV4J7DqurHUYY65ysyMXBeD
         pQQNLba4c04ZoplsRkkVSrTRyqxoLAky8nSedueCfcMiwEMtw+VKFPp18dUF0KdBLVkM
         wOCw/SudDAzDcmb/orgsF5whbIG80wvwq4+AxBtLEOX9nJlO3TCeJdJ/1ZGusNL98Z3R
         bITg==
X-Gm-Message-State: AOUpUlFkvnUZQ9NbU7cHdHa9C9Y+Gi5Sp0RLBcch9qdWeJUjsrn9zFp4
        leuoe4v7EmUv///tYTgf9Rv8Yzaf5tQqJ4JtLe4=
X-Google-Smtp-Source: AAOMgpdqFU2ldRKkhCUw9cG2x75lwYYCawes0pCb1Bt3CEc/6oATSTNplC6ETVWLl1IOc9lEYNHluN3Ca+0iqeSEYPE=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr5012867ybl.12.1532759650674;
 Fri, 27 Jul 2018 23:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com> <20180728030448.192177-9-sbeller@google.com>
In-Reply-To: <20180728030448.192177-9-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Jul 2018 02:33:58 -0400
Message-ID: <CAPig+cQHPCeOigVoe1jOMuvKGTV-UgdNCTk+OyD1sBuGQJADRg@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 11:05 PM Stefan Beller <sbeller@google.com> wrote:
> emit_line_0 has no nested conditions, but puts out all its arguments
> (if set) in order. There is still a slight confusion with set
> and set_sign, but let's defer that to a later patch.
>
> 'first' used be output always no matter if it was 0, but that got lost
> got lost at e8c285c4f9c (diff: add an internal option to dual-color
> diffs of diffs, 2018-07-21), as there we broadened the meaning of 'first'
> to also signal an early return.

s/used be/used to be/

redundant "got lost"

> The change in 'emit_line' makes sure that 'first' is never content, but
> always under our control, a sign or special character in the beginning
> of the line (or 0, in which case we ignore it).
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

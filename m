Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5036D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeKMEmt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:42:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46262 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMEmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:42:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id b34-v6so8218915ede.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqDfDjyzOLjgC2kXdhR1JcsfBsYgZOVQj2EwOaYBF/A=;
        b=IEu80rF63/JfKKXF9srbhqZMOI3c2V/RjjahBqmDHVOUxFoOYoaSUNMkAZb9642HoU
         FbRj6HbRVbyFk5CGHEtUPNBv6OQ3ZB1wcpBW80Xzv/y6kQamI+DLzztTpvJ3cWteszrX
         PmjO1RYJQpimFsUAtaIjMMwl2Z3axhYEDHdTaEiYqOoSVTC0n8+B5H9+i/kbxeL/1vcV
         K5OhH0hd2uWIo8nRapQqxJ23A3Bv8KJu+KLZsDDBN36hVi8fJfqYM3TRr24vsedWlxhs
         hFFKAv6q5oBrFr6I5WUD4MVmh7bCx6MOEC/XADDT9tl7OoIDhIrfzOELjXhp2tLPy/fU
         eNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqDfDjyzOLjgC2kXdhR1JcsfBsYgZOVQj2EwOaYBF/A=;
        b=DFA1O3WjmOAABZdgdsAX+9X2vBZsSYU3V6nojZLyxhm5pvXKTrFZU8xLEWdJmIdTM7
         X0byDJqtM40C3gHlOeXPrH1sr2zgvMjj9lgX5llKHAYJ2HgG3W1klzPek9rJqS9/mlVe
         HDj1J0X0jVZEx33iHhntitpYjIQYHlJ7IToOstdKPpb92wo1M3dbj7QaWAwihjKHv2Ls
         NMrGCmNconPMW/S0LaPG8UCwHbkTxItLdHmzIqvRGNOnwX/RYgvWwHy0yeGi3uxS15xJ
         wy2vkcdFMHz2Cp43noMGkl4F2RnYMgQdfxnHBHH7qGF0/oGYmjW6j51Y02aozYrRRheQ
         kqCg==
X-Gm-Message-State: AGRZ1gLTmQjHtB93KmgcpkU0wjTbRYeULE5A2gS2PgUioswwNjRtySfM
        /cNEpY4+M03QThpL+unx40GMmjC3B9AsjUgS0wu21A==
X-Google-Smtp-Source: AJdET5d/94LY4C75FSsXoMkiLOTf5aYGO46W0VIxknLJUBCxz/tsJYoSYfQF/Wj2bmW9iDlwgUMGRofgKJ0FOxU6Jgc=
X-Received: by 2002:a17:906:5451:: with SMTP id d17-v6mr10096851ejp.65.1542048499622;
 Mon, 12 Nov 2018 10:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145039.GF7400@sigill.intra.peff.net>
 <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
In-Reply-To: <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 10:48:08 -0800
Message-ID: <CAGZ79kZ7GZZak0B9GALPCAJmwchiDe4jpjFAaP15ZwxQtJ3TOQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] sha1-file: use an object_directory for the main
 object dir
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, gerardu@amazon.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, tikuta@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 7:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>
[... lots of quoted text...]

Some email readers are very good at recognizing unchanged quoted
text and collapse it, not so at
https://public-inbox.org/git/421d3b43-3425-72c9-218e-facd86e28267@gmail.com/
which I use to read through this series. It would help if you'd cut most
of the (con)text that is not nearby to your reply, as I read the context
email just before your reply.

Thanks,
Stefan

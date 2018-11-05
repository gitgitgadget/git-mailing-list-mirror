Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C20F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 04:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeKENUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 08:20:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47094 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeKENUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 08:20:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id 74-v6so7833705wrb.13
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 20:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4sD1LwrNYMD/cBY26QZQ6Z7eqjNQxpmu1KwGo2Z3h9w=;
        b=ga3Jx9DDUh8xz805SXS03nnGYrAfy4PQl08XXrqpFU3DQJ6ZqcudrLdYi6G1UTYbFf
         M8B2Cq0yGWjVyT9YBOqhp4jNxeS4PTeN6Cy7GZCe8fqFUGOmHIdQfT51c2aDS2V46R4H
         d54VVw9kUzsbgaUkW5VzIaztWi256HH4z9RK7fGE+EQKkF/6iIzTvx4HFt5m/ziXty1t
         542px8xEzrqmJ1fQhPP7yi6b6OVTy9zx4ruhXnuSGbhK27PpcnnuuV+xthGqvV2oZB9l
         Gdu/1ofQUX1l7ZL+7S5CH2rVs3nAi8S4jO7ZFcvCxBcPulYbqUUdD0eW1TlLfT3O0/NP
         hBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4sD1LwrNYMD/cBY26QZQ6Z7eqjNQxpmu1KwGo2Z3h9w=;
        b=QT3ntnHa/kLrVfyFHA4yKO70BQXGlmZYQ7RK7w6hdxzfXc11+Xi3Rldw1cPv0Cg2/u
         xr1VhSU8i89PDFmlb/M3s8ruazBTS0ro3uyMMawEbuv87sMBCQ0Dc/zLQy1MgD/g9dhq
         qO810FUyXLM79rD+v8OjWAXa47kpMgdxmWyIkrvuyltMiL3ufxKViKNmEwUG5dbFgaAe
         SRaHQIqOTidshClTFW84fZEOy7KHTwWy/upcbuG7/b+QuC4IKSh+704vWpVicO/Nxvqo
         gjAesA3MHBCzR9QqEu6mVPfE7tmwKaZ3tY+cVMXziIWcNI19DzdPxkxJ8VHWNGQmwiol
         pjLw==
X-Gm-Message-State: AGRZ1gJUkRrvj9n2PPpDbBjl1VSfIEmQipUO6e+atR/6osASZc79ZHrJ
        3MU3fOgSbVCDBNPX4p8Y8qs=
X-Google-Smtp-Source: AJdET5d8RWwa0J14mufe1DQ8mkBaUWTylOV0P47bHm3LriCWXurRsCNfKwpUIl6h8b8Zvrd450juDQ==
X-Received: by 2002:a5d:4012:: with SMTP id n18-v6mr17472407wrp.185.1541390543302;
        Sun, 04 Nov 2018 20:02:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 78-v6sm24205688wma.38.2018.11.04.20.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 20:02:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, carenas@gmail.com,
        shoelzer@gmail.com, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
References: <pull.64.git.gitgitgadget@gmail.com>
        <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
        <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
        <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
        <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
        <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
        <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org>
        <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
        <CAPig+cRdaXdZPpmMKBwZziMZarr2+wrdpnyHPkSYAkoBDuvLnw@mail.gmail.com>
Date:   Mon, 05 Nov 2018 13:02:21 +0900
In-Reply-To: <CAPig+cRdaXdZPpmMKBwZziMZarr2+wrdpnyHPkSYAkoBDuvLnw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 4 Nov 2018 22:33:13 -0500")
Message-ID: <xmqq5zxcjho2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Nov 4, 2018 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>> OK, thanks.  It seems that the relative silence after this message
>> is a sign that the resulting patch after squashing is what everybody
>> is happey with?
>>
>> -- >8 --
>> From: Steve Hoelzer <shoelzer@gmail.com>
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> Acked-by: Steve Hoelzer <shoelzer@gmail.com>
>
> It's not clear from this who the author is.

Right.  The latter should be s-o-b and the order swapped, and
probably say "Steve wrote the original version, Johannes extended
it" in the text to match.

THanks.

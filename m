Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0821F453
	for <e@80x24.org>; Fri, 26 Oct 2018 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeJZWKJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 18:10:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 18:10:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so1463537wme.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V/BrP0cNA+PzrUh12v8Y4kJlPv+voJyG/CWcihlFYZs=;
        b=RGSus+e4AyOlvxxS7Z0oGKS6QCihTlb+Be5r054y+T1rNQgvBsbWBeqLS4Co0GgXyL
         UWfyIC7cGodCE5xFWB1nrx3zG+pGE/X2HneewZI58MXg6AfXpNH0/K7CcPGgwDja1jca
         F2XTk/JqhFq5j5QH4tQOHCEzAQY03RXWx0913JHy5kI+sbaSenYYMrvIyTX1DC55ofKn
         D/s8r0O0frsIrt+Gc233qkPtNWk6BuMu5fsp0dwCw6WuXWaT2D3HyMiG6R+YjTAclPd6
         /MiKRlMB1+Kl1r1aCuMz60ZvYGFSaoKIMV7q72isJeAF1ROts1d6FcuR9g0jvDBwcRR/
         MZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V/BrP0cNA+PzrUh12v8Y4kJlPv+voJyG/CWcihlFYZs=;
        b=cxJjCC2TIOmysyAdudWW4V5wRlT+M+/7d2GpE1EKac8iZhjFv1man9+KYhnVb6EhCm
         LLTMzup7eF8Mt87yGyWClbeWXSIFCACtOqXEhW3Pzyf+p0KqgmWQWVbqoOdjFjI+ETrd
         3dZ2xhRV1+qgG5mS1e3OO6jHIpdTtsABFotakORN73fGv/WgdVQ39mLzKMMNRXfNRaRs
         xeWIkK/3bByjvTbVdAYt9FFvrng8u8lg5uII8XYTvFJG+nt3ZmEqwNFdMvwfmyZqo/mk
         rhlQ7y8YYR/20jEv1MQ5ksvHQzjG/Gl6ozoKOHrYlI6nNm77suXLJaV8TyBvJm6WLocy
         qFdg==
X-Gm-Message-State: AGRZ1gJUqJKZw530L+J4n6oLihbMf0qPyuQbTcXfc0WVGT9p75HK3URs
        uImV5GA8Vng9Sc2uxDCcPdE=
X-Google-Smtp-Source: AJdET5fiY5xl13j2tH0FBRclv8x/BNWmDy0Lt8l+ZzCNVnABAToKKI89LlSXima4l/uEDmDbTE9qKQ==
X-Received: by 2002:a1c:ee05:: with SMTP id m5-v6mr5592453wmh.138.1540560781371;
        Fri, 26 Oct 2018 06:33:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j16-v6sm7855972wrq.89.2018.10.26.06.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:33:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/5] am/rebase: share read_author_script()
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181018100023.7327-1-phillip.wood@talktalk.net>
        <xmqqtvlah052.fsf@gitster-ct.c.googlers.com>
        <55a2a458-c71e-0018-5fd7-b66e349ddb3d@talktalk.net>
Date:   Fri, 26 Oct 2018 22:32:59 +0900
In-Reply-To: <55a2a458-c71e-0018-5fd7-b66e349ddb3d@talktalk.net> (Phillip
        Wood's message of "Fri, 26 Oct 2018 10:00:03 +0100")
Message-ID: <xmqq7ei4de9g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> I spotted a weird corner case buglet, but it seems that this one is
>> ready for 'next' even without fixing that "give it three times and
>> we will happily continue" thing.
>
> Well spotted on the corner case. If you're happy to hold off on moving
> it to next I can send a re-roll with fixes for that next week or I can
> do it as a fixup if you want to move this forward now.

OK, I'll mark it as "expecting a reroll".


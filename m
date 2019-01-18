Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273981F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfARRqY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:46:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfARRqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:46:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so16034225wrs.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rF0kq513qBKUsG2PZ5xSjgz5Vg04sv59CD1uh28dKgs=;
        b=CeRamT839W+O0bTU/Zy/bLUO6W/nDzHNA7vu1xOSbcXkq25eAGGiBklzMQQu/Td2hg
         D8r05e7ehGvibt0j70caZoGeF1JpEv6UW4xEKX4s+2iqSnuCsAnH2XXj/zJ8HMBbm882
         HFWsSaGd/U2WchTNly0GpfgZ+goQjINcSOcu5RDrqu4CxRAEgJWhgWHv6bLKAJ3dwqC/
         1bVSLVHWhRXj1xhoo21nNvJYzDkrFNcsrDX7y9Ex1t+giETvoqfSaxcEJyii7URDzWon
         86KHQamFRLroi00Mjt+ralgc/YuSIMO6UE0WESEUILV0HdTyygkHnjLQe+erAIFVTdzX
         DCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rF0kq513qBKUsG2PZ5xSjgz5Vg04sv59CD1uh28dKgs=;
        b=tvHHfUkGCJru2fJrwg1k4s/ORzoL4LwYyvIZTxhYvpjlN9cwLsddp6IY2CJUqVO9dW
         tI6HFgZsOeykS7yX3BBouk82MUNDGroOvBnbvqR112ZjQ0/uQjzLoDmtd7rJu5y7O4vT
         0+kPWjFbVBuDWdG+RW/RlE1qlr/M4cWnbAJO+5dxyAhZxsKEwjwN16FB+O08dI9Oz2cS
         68rqewrMfC13r/clioNBxcs0vRaCWf9FbPiS0yYubdM32h/U30hfbgSLEErGATO3Nbow
         Q9HF/b1JSOUbotARYoKASQTfgQdDWMmJl2qxUd5VBCfVZUdsxw8teQseXpbDEZdMoqsS
         tBlw==
X-Gm-Message-State: AJcUukfNyhnE8pf9wBzHNaXGE0lJwuzGXxByL4SROsaIzoGae3DxWCQQ
        qQPMRzBPnyEeXzrVwZIR1TQ=
X-Google-Smtp-Source: ALg8bN4vqziMzd/24ItaArmA5e1CpXFZ5jdb2bqBMWEXEh9OSi4mufjgJ3UTpGSzSMA/xzec7/icWQ==
X-Received: by 2002:adf:f009:: with SMTP id j9mr17223673wro.170.1547833582418;
        Fri, 18 Jan 2019 09:46:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j24sm102170016wrd.86.2019.01.18.09.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:46:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>
Subject: Re: [PATCHv3 0/2] git-p4: shelved change update with move/copy
References: <20190118093656.16521-1-luke@diamand.org>
Date:   Fri, 18 Jan 2019 09:46:21 -0800
In-Reply-To: <20190118093656.16521-1-luke@diamand.org> (Luke Diamand's message
        of "Fri, 18 Jan 2019 09:36:54 +0000")
Message-ID: <xmqqva2lluz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> This updates the patchset to support copy, as suggested by Andrey.
>
> Luke Diamand (2):
>   git-p4: add failing test for shelved CL update involving move/copy
>   git-p4: handle update of moved/copied files when updating a shelve
>
>  git-p4.py                |  2 ++
>  t/t9807-git-p4-submit.sh | 57 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 56 insertions(+), 3 deletions(-)

Thanks.

This has been listed among those that have been planned to be merged
down to 'next', which I wanted to do today.  I'll replace it with
this round and merge it in a few days.

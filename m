Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C993C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CAE23AF8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbhAOAVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 19:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbhAOAVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 19:21:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426C8C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 16:20:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f4so10870222ejx.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 16:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=I+uNB+NH47GnSHcPFnTHhmeQEV4/j9KIWSW7ZMIKsig=;
        b=squMyrqdbWyP5Tvywe+FlfyhupztcdNqRHfw7iPAy+npcAiMFUEUvMqkBCVA/rH3Iy
         bkz5RLXuPwIo45/peZSe6fXgaV/6+VtoToOlkeFz804To3xw/FG32GFZh6wP6quH2B8N
         5Ha2/7pAI/IkSciBqYu8Fwwy8E3HUIxBnfXEu+Z1J6KQcFHmCP+/98Cc15wxOJxTZDDl
         8ozHqsbDPdUHw7Zxfq+384B9E3jMFy5ivwSo6D4+v9Fg69ZaAAntdAZ7OF1e1opU71kx
         kvQmWPhvVc2V6I9rWVF2yQshqBrut9rRIfd2jSYEpn8QOOxTlv/NNqn5z5h9kFpPhakY
         jYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=I+uNB+NH47GnSHcPFnTHhmeQEV4/j9KIWSW7ZMIKsig=;
        b=ZVEj5Y5bk/+gNxxVwFNq21j3ERdeMgm+zc5lhaGtQiFnxm+7a/MDTv8kB9wSUmBkF5
         O8cmGI5/z1XTEqLkkRcsej7ucN1G9kKZ6ylC06ZSUp3uqXp+u2n7HWgDyKLOywpUiLp/
         SkydhWksieYsi2hoTxAlYJFTy+qXhJFTWRRSunw1XG+5u0ARlc120Dp6g/Hk+aA5zQhP
         1TcvKWNfEwCtquEifqirfUEl5ekgAerDlhB3st2ZdxGedUn8sOailSlmrSHUJUPkMU3N
         OUQtdpDR+BLs0QKtwfHzD1eMvBleGV4gQd6jRePl2ziLqNRqRqM1IX4p/13ljxGupN/H
         854g==
X-Gm-Message-State: AOAM533FWgiWrTcRSJJ4mf0ZY9uem9EPi8st8LamX78b0RoFfRCSXVkL
        DZyF2dYnzSuhQ4bfNSbWDpQ=
X-Google-Smtp-Source: ABdhPJz/aZobc9QJUVGhTeDTaRVk93nA3eJjyOYh39DJJGFbX8HhRDJ0yCq/KfSXBxhFD0POsySECQ==
X-Received: by 2002:a17:906:5ad0:: with SMTP id x16mr6965149ejs.135.1610670033966;
        Thu, 14 Jan 2021 16:20:33 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id h12sm2629452ejx.81.2021.01.14.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 16:20:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] t4203: stop losing return codes of git commands
References: <20210112201806.13284-1-avarab@gmail.com>
 <cover.1610665323.git.liu.denton@gmail.com>
 <b31347c9f5d70fd8479ba37d82c75d5131bc1ca0.1610665323.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <b31347c9f5d70fd8479ba37d82c75d5131bc1ca0.1610665323.git.liu.denton@gmail.com>
Date:   Fri, 15 Jan 2021 01:20:32 +0100
Message-ID: <87turj3van.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, Denton Liu wrote:

> In a pipe, only the return code of the last command is used. Thus, all
> other commands will have their return codes masked. Rewrite pipes so
> that there are no git commands upstream so that their failure is
> reported.

I tried to fix this in a much harder way today :)
https://lore.kernel.org/git/20210114233515.31298-1-avarab@gmail.com/

But this is both easier and obviously correct, thanks!

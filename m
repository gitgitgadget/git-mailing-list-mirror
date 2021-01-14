Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A26C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE0B2395C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbhANGbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANGbU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:31:20 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02011C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 22:30:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r9so4273810otk.11
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 22:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCmZVeHv43K+5afU1dU73FRpSqFH41JEBItFxFbJhtM=;
        b=Ek9SdxPJWZBf/GnbyWfW6RPtKX4UPgloJfRDvPiedUOEpP1wruzYTFEGv5uVpZfLKy
         06pCBBH294TTVE/MrY85oFpj0Ird59YstlnushrF+QCyPGmm7T1i+FsKjyFEMWUnDbM3
         DmAMpdfFVlnYdlDqalr6AatKqQQvC4o+9DIVLal806m6W92I73hcENmFzG9XvQ9ovTLy
         T45JEFeiodrzH/KUQnamsXcWeB/GAQwzM62egpG6iS202gWM8dydkaGg38rUbon+Hk29
         ZsfizRNqjsY1xvlcSvNFkuYXnZ3e4ev9nl4ziBZujpxFoNbbwLWwhmkI16e2TeQkd+xL
         lMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCmZVeHv43K+5afU1dU73FRpSqFH41JEBItFxFbJhtM=;
        b=VJZHiHr98uJ6pMvNPIrheysZcnGayiB+cbJ5OcQ7fuThmw3s/9qr3fHqtA8rDJxfLe
         wJWhyX5YwX3pYuq94hDUwb3Eiz77TMJpa/WRciEzUY90kD0MB+8978t2LD0QC/Jd/Ddz
         8dUFs+uWwT2f+1mSpljx5m2hHyPPucUxvKiXVZshN5snf62gGOoOtTuXMxuxoFCyZ7WR
         9keV7VoC0sUb84h3FKoq8OZgG/d8stb3SVi7aE4Na1XiCLgaZXGdpcJW02kRZ0qCUUto
         1BBc7gny1D4kVEe3gW4aZyEl18CfYTQwEOh0SEucjGNXts+m4yFEGbUaLhlUkC9r5FzA
         1rLw==
X-Gm-Message-State: AOAM532vcXuyK0jyVmXJRKOT9C/1a27PeXJNXiF530V2tNpLJrPtyBH/
        ap6hTOu0UDaP9c0SsweKXJsaibYI0x4kD0AQrxs=
X-Google-Smtp-Source: ABdhPJxygMt7lO4B44L7L7ELgXNxTz5QVrvBlfteObSeZs5hic6RXErvWpcETF/oYpZNZPFNWbNCIkolZJCYnYlunz4=
X-Received: by 2002:a9d:816:: with SMTP id 22mr3690536oty.164.1610605840283;
 Wed, 13 Jan 2021 22:30:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
 <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet> <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet> <87wnwordzh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet> <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet> <X/i7zvgMJHfOmyZG@nand.local>
 <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet> <xmqq8s90a6li.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s90a6li.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 14 Jan 2021 14:32:04 +0800
Message-ID: <CAOLTT8QqXOgtqxCa=yTz=GgBz0f00AVypZ5y=m+hSTUdhBMEfg@mail.gmail.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was Re:
 [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Looking forward to see a new feature that helps contributors to more
> easily ask help from appropriate people.

I'm a novice with lots of interest but lots of problems.

A week ago, I made the following submission:
https://public-inbox.org/git/pull.832.v2.git.1610116600.gitgitgadget@gmail.com/
https://public-inbox.org/git/0261e5d245ef0a5b9a717be1bc03492d7bc06c5e.1610116600.git.gitgitgadget@gmail.com/
https://public-inbox.org/git/a09a5098aa66ea0ed89fe0fcde3f016b4a65814d.1610116600.git.gitgitgadget@gmail.com/

Now I really want to find the right person to reply to me, but it
seems that no one has answered me yet.
Do I have some mistakes in the use of GIT gadgets? Please tell me and
I will correct it.

Thanks.
--
ZheNing Hu

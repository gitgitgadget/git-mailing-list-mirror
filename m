Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E951F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbeGIWYC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:24:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38976 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeGIWYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:24:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so6372980wmb.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xp+M91bP8wBgOPvFbnsS9mjXWU5ZXwqwt56I2QqQwRo=;
        b=c+XdK60pjAaflkGEdbKwPFACMaCiWdn3d2bjDqDwMf7sp2VTchjd7CjtQKC3TOr0t0
         5hRhLu5dr+cBIwiej2BHmgRxgS+iWWGv4qu1f9Ly15uiWjKFe/JRBdoGfR7tqX/pigdG
         Ys1MZtuthzs/z848G3YHap+M+PjhamlR9fhYQtOGkDNr4bJMkaIsZDHcUBzzfIhzEHUk
         kFzAzNq6PYX4K5pqcvcBIfrexddHq8HsXSK2Cj1wmYbnF40wDEsLidzFyL2AIY8U0UTN
         i5tegXUlByDbkPmFjGhnf4Ag5rsWRYlmNwPgDVTZjh6Tycm8c4/mqcNrrbdp81UokAzT
         xBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xp+M91bP8wBgOPvFbnsS9mjXWU5ZXwqwt56I2QqQwRo=;
        b=rMlU/lkCqUMPnW/aTOmpLp6bZYanFcncJ6ooLo87BZFIutFKFBcBVUg7j9FClcIxcD
         E2nAXavu9c+LTZXy5M8uad60VTu6iG0XJ0SZ0gG9zMgS+wqfZLAqvYsxh6RFNCP61eeQ
         tXk+gau6ziBt/H7oH0+IZeniJnkLYAfyFv173tUY0moYnGCNOSBRG+CS4kSca79uheUy
         rjecBgvrHk+hjkZwPWBSJUMo0zYuGTIjfa5NqLTUOsPBdAPr0VRA6+lynEDafu/CPJVH
         7/bCKz33OXtnDa15YwOlpOwbZL0c3z5cBOJluZm+WzQrLbbSTLF4tH2tcBWWWJ6RlZ60
         Cd5Q==
X-Gm-Message-State: APt69E3FhpDIjTJ1tHjLuysOBVR2arpjxMjawy/uy9KVQ1YBgjuoW7eJ
        DzBta2rbvk3s80oNUDtdma0=
X-Google-Smtp-Source: AAOMgpdZGH5dDLwnZM+q+q42VQQObk3FA7ZtRyl3KS6GR4U9y0vAcbboxQsopJLqz9uwlBm0wFyrnQ==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr12674614wmg.44.1531175040566;
        Mon, 09 Jul 2018 15:24:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m10-v6sm16895005wrj.35.2018.07.09.15.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:23:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Jul 2018 15:23:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 8 Jul 2018 00:23:39 +0200 (DST)")
Message-ID: <xmqq601oaw00.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Speaking of GitGitGadget: I just encoutered a problem with your
> `refs/notes/amlog` and I hope you can help me with that.
> ...
> When I ask `git notes --ref=refs/notes/gitster-amlog show
> 4cec3986f017d84c8d6a2c4233d2eba4a3ffa60d` (the SHA-1 is the one
> corresponding to `Message-Id: <...>` for that mail), it insists on
> outputting
>
> 	5902152ab02291af4454f24a8ccaf2adddefc306

It is not uncommon for me to have to do "am" the same patch twice
when attempting to find the right branch/commit to base a change on,
so the reverse direction that abuses the notes mechanism to map
message id to resulting commits would be unreliable, especially
given that they may need to further go through "rebase -i" or manual
"cherry-pick <range>" depending on the situation.

I am kind of surprised that the message-to-commit mapping still
records any data that is remotely useful (these days, I only use it
to run "show --notes=amlog" for commit-to-message mapping).  I do
not think I have anything special when amending the commit, but
amlog notes should be updated in both diretions for its entries to
stay correct across amending, I would think.



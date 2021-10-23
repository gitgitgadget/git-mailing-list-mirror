Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93919C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7782D60F23
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJWUxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJWUxr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 16:53:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C492C061714
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 13:51:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so3783133edj.1
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=O0IYwbq6jJnaJ/3qxCn/h753yhT4s0+oz7ImryO0EMo=;
        b=TipZShqSub8EP6o30S9HgCgvpvetDrlcLwlc7cQ6TkPjqycVjndUQpQgrFwNn24Shw
         aXdZ5x3zwlmMGE3VQTWT63daTxOASuwC9oQpgvBoK3zFaJ/vAo+MxQwTD90bixaQg/N5
         WSb1VB55XBF9J8z+Xowd5MmSv7lXi7EAScTeVGcoZrxb8MiIo78GImPW18Z3Q7RJduh0
         Y3uyNntxIKAEibEXsgNi79DMDFEP35F8IGZIK2KyCALqMZKxtkfySZGFmw4IMbU3qf9i
         Zipd1/gh0Sw6q2R35bdkd8q3CUwC6h6I5VvIBggUeusfltyd+DGW7krIR9Cc/m/o+683
         2CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=O0IYwbq6jJnaJ/3qxCn/h753yhT4s0+oz7ImryO0EMo=;
        b=he6zoWEQZidkCCYxEBq34TvQwXn4e+CvfdOZG1+ZdGouXIddJEX8XVZCsnVq/8qDQN
         nEC6eAbpl9bVCdeV0ayBhKs1cLDYqEX4f6NEMKLtSg8NhaqhY52Krqt+3TwgAn5/Eg0P
         cUuupBlJ1+R/LHhdBU2w+cXsuGzYBKsyRYwaU2Z35T3wtqDd7EBHJDsV7+W8MUYZR9i2
         ll8WybwYw/dqKQjWmsNnsQDiNA7pYMPrW2FjFxwP93f25F6TXH4h5xSZa0j2vpGLqShM
         /Vr46apIj3cmQYcvATzi/mIUbeGviB407KxC9gjYpItTMoBJQt/eHSJbQVxxvvqCJQ9e
         rNRw==
X-Gm-Message-State: AOAM5339Nz4sYHTMSanWqfJv2osQTO5IxCQh7dopleQB3NRFYdlIEycz
        XJz0OWp49T+D5fvIfXb2BZE2XYi6Ark=
X-Google-Smtp-Source: ABdhPJw7jTDz1O3QgAm5DbX+baex4MH8skhjvyVH2QyLlkuJ+wZg94vC5huZw42F21hHsSuafPDaAA==
X-Received: by 2002:aa7:c501:: with SMTP id o1mr11828142edq.99.1635022286667;
        Sat, 23 Oct 2021 13:51:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i4sm6471675edt.29.2021.10.23.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:51:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1meNzA-001SWv-OE;
        Sat, 23 Oct 2021 22:51:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Justus Ranvier <justus@opentransactions.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Rene Kita <mail@rkta.de>, git <git@vger.kernel.org>
Subject: Re: gitignore as symbolic link
Date:   Sat, 23 Oct 2021 22:49:05 +0200
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
 <YXLro/8c1Feg6TcN@kitchen>
 <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
 <fa4b28b1-9b5e-0201-5afe-2e8f294fa9b4@opentransactions.org>
 <YXP5rZT5IgFcMZs0@camp.crustytoothpaste.net>
 <e5a6dfa5-617f-5b5b-6803-45d36b3de53e@opentransactions.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <e5a6dfa5-617f-5b5b-6803-45d36b3de53e@opentransactions.org>
Message-ID: <211023.86k0i3ihwz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 23 2021, Justus Ranvier wrote:

> On 10/23/21 04:01, brian m. carlson wrote:
>> For example, I
>
> I'm glad that works for you and whatever organizations you happen to
> be involved in. I'm sure you're happy that git taking away this
> capability did not impact your workflow.
>
> Other people have different use cases and operate under different sets
> of constraints and are considerably inconvenienced when functionality 
> that has worked for many years is suddenly removed from a core piece
> of software like git.

I've workd on repos that had the union of every editor tempfile under
the sun in the .gitignore, it didn't really cause any practical
problems, they tend not to conflict with "real" filenames.

As for the .gitignore problem I think it's very much in the state of
"patches welcome", see a previous summary of mine at :
https://lore.kernel.org/git/87o8c34dq6.fsf@evledraar.gmail.com/

I.e. I don't think anyone should consider the current behavior to be set
in stone, and certainly not when it comes to potential opt-in
configuration.

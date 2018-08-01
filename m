Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D2D1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 01:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeHADNy (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 23:13:54 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52255 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbeHADNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 23:13:54 -0400
Received: by mail-wm0-f45.google.com with SMTP id o11-v6so5022006wmh.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V7W8WTQdxsbD4xXD0F+VhwCN2GKkMxn8sAl8k7YPBHs=;
        b=R1wALLPRtE/nQDkQA6VkfUbc326KSP2yaaoTTxDB1YGswMgHcImmEhAKPmA53QjfiV
         4qfsXvJn64nBgElY+5TdppqoIYfdZoV1tOGUOv50OyoOlN3e0mkafPu77JslKXPBZgsY
         +DvgBZzOxXxdlG/NpJjvDdpuAPtJohkdmtb8T6tyHFVvqrLRxWQR6vHE7nA+oNmmGuTi
         v3Q4GWX6Zzc85TfwN3EeTYBvnmvT7wYrcvk7bxOgMqMWciCZykPqYLlM6YYc45IMCfFW
         RTuFIy1ZEVn+ZBtIjSpx8Tx+bXq2T0GNYus5hVemGZFwZcRBtGkr0SaaurfYevc5hrB/
         xWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V7W8WTQdxsbD4xXD0F+VhwCN2GKkMxn8sAl8k7YPBHs=;
        b=PLtOEGp2+8SymeS6ycgpChwvo+BAhh5bzpIM0lql8BFJpY7ULQOup+C15VnVWEFCpM
         rJgpIES/uyvw4rdngivxU8/ukam9akRaDaEsyfqEejf6dSw16GM8nekEmdxYjtGmWYBJ
         e0whuao93QzIIP3nMJKtIBuyBzFc4PM/cz/snwvAVzaGjVoSTWier3sB6MtzwX9+aaOS
         qXgWdZ/BaAqBESNS9qm3Ch5XF/CiJPnM9L2OhJ6Try1aOldtkVNnZoBG6rOAcVeMeT8W
         1Q1lkkpEbd4v+KIC4NiKcvzPkVog4m/Keed+TQySNuiy4/FpBIglHQiI6LmYjvxyZixg
         rV5g==
X-Gm-Message-State: AOUpUlFQMMKiIsnq8lKi7Q0UHnT98RehEJAK77HG/c89/+eZ4/cGHXBj
        qHcSOObIY5TMVfEU5Tigb2vqs7Seq398tvdLNTw=
X-Google-Smtp-Source: AAOMgpeKIwN99U8JGMtjwHIHcZfi8EOojGC1Rl034h4aaWvCvNfelVg7pRGKon1okr0meCL0IpM5rF5K/pkME9W9liw=
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr1201618wms.70.1533087051212;
 Tue, 31 Jul 2018 18:30:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ee10:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 18:30:30
 -0700 (PDT)
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Tue, 31 Jul 2018 18:30:30 -0700
Message-ID: <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Users <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Jul 31, 2018 at 12:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This is a re-roll of [1] which fixes sequencer bugs resulting in commit
> object corruption when "rebase -i --root" swaps in a new commit as root.
> Unfortunately, those bugs made it into v2.18.0 and have already
> corrupted at least one repository (a local project of mine). Patches 3/4
> and 4/4 are new.
>
> v1 fixed these bugs:
>
> * trailing garbage on the commit's "author" header
>
> * extra trailing digit on "author" header's timezone (caused by two
>   separate bugs)
>
> v2 fixes those same bugs, plus:
>
> * eliminates a bogus "@" prepended to the "author" header timestamp
>   which renders the header corrupt
>
> * takes care to validate information coming from
>   "rebase-merge/author-script" before incorporating it into the "author"
>   header since that file may be hand-edited, and bogus hand-edited
>   values could corrupt the commit object.
>

Does this also fix losing the initial commit if it is empty?

Given

git init ; git commit -m 'Initial commit' --allow-empty ; touch
file.txt ; git add file.txt ; git commit -m 'Add file.txt' ; git
rebase --root

I would expect there to be 2 commits but the first one has
disappeared. (This usually happens with "git rebase -i --root" early
on in a new project.)

Cheers,
Hilco

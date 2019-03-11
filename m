Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC4420248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCKJYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:24:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKJYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:24:40 -0400
Received: by mail-io1-f67.google.com with SMTP id p18so3377189ioh.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfNcB3wzrQdknCjZES9nR8BXuEWfEnm/E0gWr3qQmnQ=;
        b=rYh+p/qWtc/ffGov99zusfU4bSSjOC7m0U3VoDASGz54piEuW4vuFOOv6MY2gRvE6l
         kxH36hA9E3/70XGkIx7xkCWHKeKai0WXNcWm0qkEpPisWnJ11e0ISXEqspfSIVi/prr6
         rGucQk3NqVbdSQgny6HqmkL3KEqudqLioyY3DWBzBAMAwdD3Yj0BdgjNoMN5Hqe1s8Rt
         XHS2pWwGTrg+igkfh7jfaL6LB4wnlUSPfsdaZkaMZ/Z5yWS/SLLh75eOgT1qvXiCd+0p
         flNFn1GbmFoPDpfAl6xrW5P4IuuN8z/TXKhI/Y0Wl1opLRY+cAkooSoIs8jsBwyeDyt2
         eCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfNcB3wzrQdknCjZES9nR8BXuEWfEnm/E0gWr3qQmnQ=;
        b=fEd2SLi/czprTNuLprrRO13CD0zJDBpI2+EcW5t5OgJTcRxPnp6UOy8M8BQcHP2OYb
         LLBLRP4l5w5CdvjY5SOzpEmx/ZB8hB1SrlT50vOccbOk7DLQVMtorJOb+1kD6M1OlZ9s
         NiLj0qbHM+OQIPmMVSnOIuDTAnxMPsN5LXm5wfwRagrj6VlGg5sBvNYazqv5b3N/rl4J
         OOdqvUH+NHENUEMbHkhdk8yy16VdE9mx/DiYioqIvezfRgHxIji9UDEPem5d1F50PQyj
         DQYKyfzkWQtDL93X20J5KX+dFlykOddvv2zDlR7IEEXdgtI6/DCnwjoOCTbbEis0wlTJ
         Vb8A==
X-Gm-Message-State: APjAAAXjKoQwtvKC4IV3F2656/6PXPrb22oFSBqCG3z7lJS5S5y2NP8C
        2T4PXZsVpe/AnSmJjdC0FiD2msKUU2tugBEMCUw=
X-Google-Smtp-Source: APXvYqxe/NQfF3iCrXYcucfAw4Pg76nPLqEMNj+tyFerZa+mkzjClDquRS4MGb24tfBrTja1b3aA/yRQT6986YhqlGI=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr1326303iom.118.1552296279500;
 Mon, 11 Mar 2019 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190305120834.7284-1-pclouds@gmail.com> <20190308092834.12549-1-pclouds@gmail.com>
 <20190308092834.12549-2-pclouds@gmail.com> <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
 <xmqqbm2ikk4q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm2ikk4q.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 16:24:13 +0700
Message-ID: <CACsJy8CqN=Uu-Fez7T9evazitVopXt2dkQ1rGzKwh94tdiUdvA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Yagamy Light <hi-angel@yandex.ru>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 1:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> >>                 case 2:
> >> +                       if (last == '.') { /* Refname contains "..". */
> >> +                               if (sanitized)
> >> +                                       sanitized->len--; /* collapse ".." to single "." */
> >
> > I think this needs to be:
> >
> >     strbuf_setlen(sanitized, sanitized->len - 1);
> >
> > to ensure that NUL-terminator ends up in the correct place if this "."
> > is the very last character in 'refname'. (Otherwise, the NUL will
> > remain after the second ".", thus ".." won't be collapsed to "." at
> > all.)
>
> True.  Why doesn't it do the similar "replace with -" it does for
> other unfortunate characters, though?
>

I think Jeff saw an opportunity to keep it cleaner ("." looks better
than ".-") and took it.
-- 
Duy

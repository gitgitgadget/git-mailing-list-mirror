Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7642D208B4
	for <e@80x24.org>; Tue,  1 Aug 2017 23:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdHAXzR (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 19:55:17 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:38402 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAXzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 19:55:16 -0400
Received: by mail-vk0-f51.google.com with SMTP id g189so12159314vke.5
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/k1jXnGwlRBsYdySMRA/Jc8qy86nMgP/z5wRLjU7xU=;
        b=Kx391hEAeTCmIXfV9ZZq9dOGPhxokW3zfDtDJgtjNTpQyjUx0rNZ8ruCSrDmRCgMJK
         4kiUqqrQacBf/QG7FurPsBUmfm7AX1iBmtM2dqFgLL2icqBptXSjlpLWA5GG1Bi9eymi
         NqyFtIDAgUZufswGJ3dqmD3yTCZcOdlNuzlJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/k1jXnGwlRBsYdySMRA/Jc8qy86nMgP/z5wRLjU7xU=;
        b=Sf3+v4BI+DAuMTsJuIN4U2/+xSatNl2cs2EXUzZcEYWr2Fd4GU1AFkyFDEqMCUA7U+
         59QqX6s2bl/e5zrJjsEU24126e4axi4dFXf3qBuB0mbViint3nPGPc8kJFTPFXOzwjcd
         5BJFSxXAVklRz0cqiBNCzI0SstuqEffwtWYmwgrdttOakkSm9WpjOSfURUJ80ACGEwsK
         uSuDXthPF9Uj5zedeNEdN5L2fOevGG57Vt0Dy0Jt4Z3AphriOxPNyTRSsBB9H9LdBRaQ
         HfI7dRYlmvQbLT6YvRo6d49uvcZ9Zav+plyWvM6MWg0oHb1w09pWyqvV8ILRGkNfAgEY
         w+mw==
X-Gm-Message-State: AIVw113dlUdvwofgoHj0nturPlVl8KiTaF+Y+Y8/SXf+hEsYjp7MGTAG
        C02xp5XZn6ILJHkCFvLEeE5inAt/ufOA
X-Received: by 10.31.195.3 with SMTP id t3mr14244783vkf.98.1501631715716; Tue,
 01 Aug 2017 16:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 16:54:55 -0700 (PDT)
In-Reply-To: <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com> <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 16:54:55 -0700
Message-ID: <CAJo=hJv3O98t+GXDmh99EwXziapSmGKKNk075MhP6E0USyMXqQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> 4th iteration of the reftable storage format.
>>> [...]
>>
>> Before we commit to Shawn's reftable proposal, I wanted to explore
>> what a contrasting design that is not block based would look like.
>
> I forgot to look at a 1k chunk size, as you suggested that might also
> be suitable. Here is the more complete experiment table:
>
>        | size   | seek_cold | seek_hot  |
> mh  1k | 36.6 M | 20.6 usec | 10.7 usec |
> mh  4k | 28.3 M | 24.5 usec | 14.5 usec |
> sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
> sp 64k | 27.7 M | 35.6 usec | 23.3 usec |

Argh. I got that mh 1k size wrong, its actually 29.4M (not 36.6M!).
Sorry for the noise.

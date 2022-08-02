Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A1C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 00:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiHBAN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 20:13:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C747B95
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 17:13:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v7so6358157ljh.5
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lMP2BiP5o9/nh6jbdltyI3WUHqGWMQFqFSaUdS109SA=;
        b=Cnkj0z1i978h19PZZUTgPQiREcrA5xTPzruqjiNpPyr6k5/lg1pkQvdPoj9ahcMNzp
         leBqCORnV8qjmTDR5k0v6vfZgXPY3fdFdyPjcaTKbzN5jMGoL6ggiq7Ew//E4mAWyqnK
         X73juP8hTcbQUAXDLY881zbrq0a/boC8zupujbQPWjiFOFS/h6Z46nNxdglnB/WL2y2X
         2NO3C6gsdmru0T7HiH259Vs6d3bedBXEsSFk1R93j/nZszlCx6wisYBNy/wbQGV9Svkr
         t9VTilpl+LxZ5tq9F3MeExdu/SwFpcVd5UU0LarAFV2/0daOeX1MqUf0Hd3J0AbHQ80G
         xdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lMP2BiP5o9/nh6jbdltyI3WUHqGWMQFqFSaUdS109SA=;
        b=y5ZgzQ9s1WQeg3IUbH/HoVfZ0myUWahh9Ju6HvzVZ/lBoGkWpQmdcQazJRsKZDMTTn
         M5tVyP4ZACfzLnfMN6314aAI0YKf4LMuY2TLiQqCZgHEffFFt6rKh0by/s5AfkSfNiv1
         vBmA+bwXkptYU/3iuCVe2pe27efHwlemKkbVPqg3iStvZd39DW8ido+9VUHHEGoY06nz
         eKIpNW8NLkEa19SeRxzczM4VP1sonmWdajDxMIviPOFB0bu0bR66fIeQes0FO4BGg2kl
         Lj7nzNIPfWf5ES1dBMu8fVwqPn2vCgpNpKdoiNDOR1UUwQKwXoZgeGps/cUssghrnbbk
         uYuQ==
X-Gm-Message-State: AJIora9kV3La4zntlXmhtkvuPU4KjAGwxTcZoLAU85YNDxL5uq/p6Gy2
        JRGRiJ5yICNcSpmqH2bQzMm7CZufylE7aZDXf4VU6g==
X-Google-Smtp-Source: AGRyM1uo2NsgVr/BuaUq341BadFD1YNDMyboeflLy4QiWScPItzkAQ8aY526gkSVN0eS0TCLOFQBYfuaNyD5UDPkwio=
X-Received: by 2002:a2e:8e2c:0:b0:25d:e021:ba8f with SMTP id
 r12-20020a2e8e2c000000b0025de021ba8fmr5628434ljk.491.1659399200772; Mon, 01
 Aug 2022 17:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659291025.git.matheus.bernardino@usp.br>
 <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
 <xmqqr11zoe6i.fsf@gitster.g>
In-Reply-To: <xmqqr11zoe6i.fsf@gitster.g>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Mon, 1 Aug 2022 21:13:09 -0300
Message-ID: <CAHd-oW4OWLqMXwJPAeb_UN6Rxj-8KXTnRyGfm_tfLTrGqnZo-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 1, 2022 at 6:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +             die("expected key '%s', got '%.*s'",
> > +                 key, orig_size, orig_buf);
> > +
> > +     buf[size] = '\0';
>
> I find this assignment somewhat strange, but primarily because it
> uses the updated buf[size] that ought to be pointing at the same
> byte as the original buf[size].  Is this necessary because buf[size]
> upon the entry to this function does not necessarily have NUL there?
>
> Reading ahead,
>
>  * packet_key_val_read() feeds the buffer taken from
>    packet_read_line_gently(), so buf[size] should be NUL terminated
>    already.
>
>  * read_capabilities() feeds the buffer taken from
>    packet_read_line(), so buf[size] should be NUL terminated
>    already.
>
> > +     return buf;
> > +}
>
> And the caller gets the byte position that begins the <value> part.

Good point. I'll remove the buf[size] = '\0' assignment.

> > +                             if (entry && !entry->requested) {
> > +                                     entry->requested = 1;
> > +                             } else if (!entry && always_delay) {
> > +                                     add_delay_entry(pathname, 1, 1);
> > +                             }
>
> These are unnecessary {} around single statement blocks, but let's
> let it pass in a test helper.
> > [...]
> > +                             die("Unknown message '%s'", buf);
> > +                     }
> > +             }
> > +
> > +
> > +             read_packetized_to_strbuf(0, &input, 0);
>
> I do not see a need for double blank lines above.

Oops, I will fix these too. Thanks.

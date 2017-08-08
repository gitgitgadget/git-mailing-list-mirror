Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469FF20899
	for <e@80x24.org>; Tue,  8 Aug 2017 23:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdHHXwv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 19:52:51 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36442 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdHHXwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 19:52:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id o85so21297327lff.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCCP7Q3sr42gt1pbOfOA6EimbMGDG2yFR1FSfHVZ7h8=;
        b=PBNJeucf4JGIg1BNF10TJKB8giq/xgblwUFndM2a+TPhKxSTEPCibb0Bv200uoVtUM
         5hCIAVnTpmT/tc3r5TCFVJBDfrmyXJbswd5pvgaqVD7JdBxsTaG17HtKO+AGAki9Ptky
         M1hRO1WNUjUdGjXW1KfEPDF8mTyBNCGxNSRNou6V+6kPG0F35RIlX+tPhBS/JwBZ2kXF
         YVP0IOiTSdpxttZozNXJMGUwwDR0vAWOVxEcWhXi6O38/5mmH8CNKzD1X6e30wtJuw9c
         pyYFIM/jyK6O+tyCQ0Nc5o842FSTwUdZCET6Pn0OpQOfXZO/ocfWwBJskM280y4Cs7cg
         Ii5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCCP7Q3sr42gt1pbOfOA6EimbMGDG2yFR1FSfHVZ7h8=;
        b=aWc/5SPoHv5a7tAbCWxYjg1V3nO3wpRqaxpm4IOeuq/gFCogKmC96ZKs5g8alBiqc+
         kMzFrDJN1eBdpVABHMMl+oKHtp30N8FRIf47DwA3Co+QBd8zlDi+y94l/qTBik3Lf4PW
         w1l8AfHtmLt5MCgvHGdAe8pH94GxFeg32GtGE4SRYltEBpt4kMBBJsGAQfQtgqMXV6Za
         7zf5Loz1Vfi59xdYHJZmP5DQMuD/EJuHzhfiPrdSS6oewLI4C9D3HCv2W76IvSgCu8pf
         R8P3wvVPeywxYx/3XpOLjt37GcU4OIMlq6y48YaLSITcnaRH55/fg/SR1riCBTeUx7Zx
         SC9Q==
X-Gm-Message-State: AHYfb5hnuM6Czlb+m4lEAeZ5QJdpEDD/2Kb6n+MQ52cM3wQOWcU7cruA
        KZdNvpIwRw0s4tDJlQZTK0KAnVnqiYqr
X-Received: by 10.25.232.41 with SMTP id f41mr2345865lfh.90.1502236368695;
 Tue, 08 Aug 2017 16:52:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 16:52:47 -0700 (PDT)
In-Reply-To: <CAJo=hJvsdkrv6uELF0BHxqk4+as8-tr1bdYNHiQ3paTmn=2sRw@mail.gmail.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
 <CAGZ79kZO517Bg+O2z3dr+oHqO_av1__FU3h9bP=rhXJUSDnRjA@mail.gmail.com> <CAJo=hJvsdkrv6uELF0BHxqk4+as8-tr1bdYNHiQ3paTmn=2sRw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 16:52:47 -0700
Message-ID: <CAGZ79kbZiUDmp64FLYPOvT-Y4a8+YJF=fanYTB8Urxif9h6ZTg@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2017 at 11:30 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Aug 7, 2017 at 11:27 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Sun, Aug 6, 2017 at 6:47 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> 6th iteration of the reftable storage format.
>>>
>>> You can read a rendered version of this here:
>>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>>>
>>> The index may be organized into a multi-level index, where ...
>>> which may in turn point to either index blocks (3rd level) or ref blocks (leaf level).
>>
>> So we allow 3 levels at most?
>
> No, its just an example. Large ref sets with small block size need 4
> levels. Or more.

A malicious (or buggy) writer can produce indexes pointing to
each other producing a circle. (Who would do that?)

A reader should  - instead of segfaulting due to unbounded
recursion or being stuck in an infinite loop - ignore the indexes
in this case and fallback to the slow non-indexed behavior,
i.e. while the file format allows for unbounded levels, a reader
should not.

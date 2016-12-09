Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0731FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 13:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbcLINJP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 08:09:15 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34399 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcLINJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 08:09:14 -0500
Received: by mail-io0-f193.google.com with SMTP id y124so6701816iof.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2cJQsc3o0I5d/zpP8hUl9OFphbSAOeXK6AMo2GzdRpQ=;
        b=fH/r8066fB9d9Buhh/FSZH6BBuQVTG2gyakZ+rgVOMmjNclVs5Op7w0wqAhCCtEgJZ
         IBpEHW9ufDjiA8uoZKv6kESKmyVydwV/OG2RAfGEIZtSEr8KKug8Ey1F97MisQrvPHwZ
         QL/hSsWceOwDC1PeRojeIsAfiPrH7Ex857eJt1qlwB/Zrfv4wwc8AUdRaQv3XjSHmH+0
         9ssD6bMBxdbXrtGhrRJx2+iBPEJ7hXJlhgKct9bVztoXw6afmxd5myh9mcQM0wHr44G4
         jawndZyLdjzfBLKfNtyXAM/X5dxd1kDqVvxqfnxEs29BRNEHhaY5T5RZDGHr9tNyN4ws
         yTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2cJQsc3o0I5d/zpP8hUl9OFphbSAOeXK6AMo2GzdRpQ=;
        b=RQy0eudfHSau0i014DxQBgyf7LW+Qq/S0ItIr3UXJTSYVjkpNv9bq0yynZ/EqDWVJ4
         VSvbav4BTwxOWGG+w1oEkC/G9dB64LN2IbDHMhkOdAbq+4C6kh7Y9m505lcfKhjeAtnF
         XdXOuXqyO5mmH7ccUsSfCvrBEAo8Cakwxs/56mADrbfIq26D3OH1yVdYn1ODaLB7oFxG
         WsE5lLpO7FwCReoThrwyQItDvDyzQ0yD+cy19gbMaznxL+3yacsug1YU69MxmGgzjjJN
         fYeM15yOrtHfqumF7KU5ZauZg639lx0Q/ptZaZu2+0sRoqmk3dRfn85u38Y2OfBXAfEU
         wLqg==
X-Gm-Message-State: AKaTC03yczgTNN+Hy+tXF/55jh8itGaOPFGgPSkCK/qULyxkccFf1mCClJaTY1NQfk1Tyy6pWZ6Bm2gN1rsgSg==
X-Received: by 10.107.132.74 with SMTP id g71mr69685238iod.19.1481288953498;
 Fri, 09 Dec 2016 05:09:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 05:08:42 -0800 (PST)
In-Reply-To: <20161208181957.GP116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com> <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
 <20161208000357.GJ116201@google.com> <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
 <20161208181957.GP116201@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 20:08:42 +0700
Message-ID: <CACsJy8Cc6hE1Rbqjrc93xDMc0UUm0yMh0A-fyu3dfJ2G1jhENQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 1:19 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/08, Duy Nguyen wrote:
>> On Thu, Dec 8, 2016 at 7:03 AM, Brandon Williams <bmwill@google.com> wrote:
>> > On 12/07, Duy Nguyen wrote:
>> >> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
>> >> > Convert 'create_simplify()' to use the pathspec struct interface from
>> >> > using the '_raw' entry in the pathspec.
>> >>
>> >> It would be even better to kill this create_simplify() and let
>> >> simplify_away() handle struct pathspec directly.
>> >>
>> >> There is a bug in this code, that might have been found if we
>> >> simpify_away() handled pathspec directly: the memcmp() in
>> >> simplify_away() will not play well with :(icase) magic. My bad. If
>> >> :(icase) is used, the easiest/safe way is simplify nothing. Later on
>> >> maybe we can teach simplify_away() to do strncasecmp instead. We could
>> >> ignore exclude patterns there too (although not excluding is not a
>> >> bug).
>> >
>> > So are you implying that the simplify struct needs to be killed?  That
>> > way the pathspec struct itself is being passed around instead?
>>
>> Yes. simplify struct was a thing when pathspec was an array of char *.
>> At this point I think it can retire (when we have time to retire it)
>
> Alright, then for now I can leave this change as is and have a follow up
> series that kills the simplify struct.

Do let me know if you decide to drop it, so I can put it back in my backlog.
-- 
Duy

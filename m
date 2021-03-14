Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E90C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07E564EB3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCNN7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhCNN6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 09:58:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B4AC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:58:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w195so25301412oif.11
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/MPpXreUBCcUV7/qmlXDr2abW8bWE3anCiS77/ujD4=;
        b=IXl08XfqSS+dei+CJQY+uMg7RpBSwWEoJ61m7ynQrkQPNmAo9KsMbcnGY6HI404XPx
         HvIO2ltO8vbwngqdYx+HC5hNQgPq/gZWRO0JLor09revMwmuWjeA+52Aey/Vdx1mnQj5
         zndSo7TMsfe339oHYpOM4MMtCTm6dT3HFYHKC8QSOuboMKDmvFcYArp9RFEZafKEcFsF
         DwvuJuFf3axJ8PVf1eslj8qg/FX4UtkZ3niSKd+92kCd6uP1NokiR8O+efGXedBoDiYT
         jFLL2kj32DddCqA57sDXtfhuJVTx7Pfl8Eo151K/Mfy1eCJoNY2RZrKGkSdhN3VOLB2p
         SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/MPpXreUBCcUV7/qmlXDr2abW8bWE3anCiS77/ujD4=;
        b=VumBVFxsjXcejPlkSe5f0Q5RNr139Yg0JEwXTFw9JJov+309AKt6APcgJuppZzUSff
         Tb5AXZ+950gR+X4Tqb/7o8PlrOg9VX4mBlOJv3b9wEwnBTlS35ZG5CgIsI1dj8lB0nBV
         foQOb4cRhReLHRKHxmcWSzr93p7UWvbfWU7l6lT4oaBF9CeaRnxOQNSW381uQW6BoDPT
         BFb1vItRtMZY6rsEkKwyvNBkd9ae0oWMyLoK1TcRijS0DYvU8rt02tSkYU3F2+fDtMwu
         PYpLRDPXuSp4E4eTC9LAlQc8WuUp4rPc4GpmWzm/w7zo8Rfm8PQVvFJfh/r4O0JLWnkC
         3yVA==
X-Gm-Message-State: AOAM533yBifvrRSXTjlJL9OuIbNA8BFFRySq4lwLaE8XHT0YIUYytKgd
        i7k93+viCy8iycGirpuqdSAUG03/RajiXpQqKts=
X-Google-Smtp-Source: ABdhPJxufxoZHgZ5ZMoJO1iA32eaMrJyzPaEYpNs3bs6TGBLTCfGikgY5YlE+hDaucIbXE9toSxfDg3+d7ltpXNyWNY=
X-Received: by 2002:aca:482:: with SMTP id 124mr1770476oie.98.1615730329800;
 Sun, 14 Mar 2021 06:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
 <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com> <xmqqft0y4gl5.fsf@gitster.g>
In-Reply-To: <xmqqft0y4gl5.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 14 Mar 2021 19:28:38 +0530
Message-ID: <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Mar 2021 at 07:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > The one thing that does bother me, however, is the name of the
> > function, get_alpha_len(), which tells you (somewhat) literally what
> > it does but doesn't convey to the reader its actual purpose (which is
> > something we should strive for when naming functions and variables).
>
> I actually think the helper function that is used as a building
> block the "subcommand parser" uses should be named more directly
> to represent what it does (i.e. look for a run of alphas) than
> what it means (i.e. look for a run of letters allowed in a
> subcommand name).  IOW
>
>         char *end = skip_alphas(ptr);
>         if (*end == ':' && ptr != end) {
>                 /*
>                  * ptr..end could be a subcommand in
>                  * "--fixup=<subcommand>:"; see if it is a known one
>                  */
>                 *end = '\0';
>                 if (!strcmp(ptr, "amend"))
>                         ... do the amend thing ...
>                 else if (!strcmp(ptr, "reword"))
>                         ... do the reword thing ...
>                 else
>                         ... we do not know such a subcommand yet ...
>         } else {
>                 /* assume it is --fixup=<command> form */
>                 ...
>         }
>
> conveys more information to readers than a variant where you replace
> "skip_alphas" with "skip_subcommand_chars" without losing any
> information.
>

I thought to just rename get_alpha_len() to skip_alpha() that returns
alpha length. But even removing the "len" variable and implementing as
suggested above seems a better and clear alternative. I also agree to
update it.

Thanks for the suggestions.

Thanks and Regards,
Charvi

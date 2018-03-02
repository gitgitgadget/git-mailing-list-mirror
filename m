Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06FE11F404
	for <e@80x24.org>; Fri,  2 Mar 2018 00:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163588AbeCBADD (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 19:03:03 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:39314 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163541AbeCBADC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 19:03:02 -0500
Received: by mail-ot0-f178.google.com with SMTP id h8so7282041oti.6
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ABOf6hTDJFzy6x2pMl+Wgl2ZDgPo4cnKy5UGE4tR+Ag=;
        b=gWFmLiGTi1MLitmtyf3UAxhp8na9OAhJ2a4EIkbNUVol6h0Qo2RNfHNnDOFz+Aoe1+
         M2dyVYmYn1Gnz1jemL8qC2pKAXajJUBR0PnoIjgqidnjIeysafcLSqlD84R/0eXRULRG
         ZpysYt5L0reNz/EHe4oMM6Cb63oE1ZAOHReI8wKZ4jMN4aaJY6C1kfGHiO9rv7Upk2g0
         d5bQcw2Na5H/BNf39nY8oM5MOs+tBnjlM/EwdhtXkBRcZtHE5+nlX4C17MUmue7DEBw0
         Wxl0ZIr4fFXxrh0qmlL6izAUmhl3MHVG5gpMsQiP0mBtXjOBZYDmhZzDc+FcE76Emtz4
         8ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABOf6hTDJFzy6x2pMl+Wgl2ZDgPo4cnKy5UGE4tR+Ag=;
        b=KXrWUJiERH0ioM+Tc3Evf8XoGl2GsLF6/UUHpIf8ZkcIoIYdHojPU1TMZAO15dWkUr
         khnZdxEphrP+KpwEnUOeHI2CJaVe1e024ThX6N6sZDd243HvbuVzVMz3t9ada8Eesktj
         4sOHy/0urMospClF0AqjGshOwVZfDGG+mLGfS3YMZA/FBgTTBhTI7wq0OUMiK48tJhRG
         TdqwzsLXwuNrPMnHoovIqzha59JoidZurpEUQW1o/5DXvpTse9WPQqURIasnrrMRSTx3
         84kDoBbazjQZGA3TiHSiwnwKAqqT9fpQLpIHtC9HwLn5EmACQ8qYWWdNQ4uIyFsNk8LT
         UDZA==
X-Gm-Message-State: APf1xPDQlE7yPnfY6pVIWtD7gqkB98vChgVpYQZTn6GyXK1QsZ1RXDNL
        sinbAchsG88uxcNTZs8T+FcqdlpSoUtJdlJbadE=
X-Google-Smtp-Source: AG47ELsBC+sgYbV0DQIfXaWrI6m9tpUKLxLDSbk1rv48g1rctkaXyBgYLuL+puBO9ecPX0F6krRkOJiSNnpaUlnI5Do=
X-Received: by 10.157.67.42 with SMTP id s39mr2903277ote.14.1519948981518;
 Thu, 01 Mar 2018 16:03:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 1 Mar 2018 16:02:31 -0800 (PST)
In-Reply-To: <20180301144942.GA837@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash> <20180301091052.32267-1-pclouds@gmail.com>
 <20180301091052.32267-8-pclouds@gmail.com> <20180301144942.GA837@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 07:02:31 +0700
Message-ID: <CACsJy8D1bRB2qkxmUhaZU3DLA-NF+D5Zqp+1tyUZqmEw88T0ig@mail.gmail.com>
Subject: Re: [PATCH 07/11] pack-objects: move in_pack out of struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 9:49 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 01, 2018 at 04:10:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
>> pack. Use an index isntead since the number of packs should be
>> relatively small.
>>
>> This limits the number of packs we can handle to 256 (still
>> unreasonably high for a repo to work well). If you have more than 256
>> packs, you'll need an older version of Git to repack first.
>
> I overall like the direction of this series, but I think this one is
> just too much. While you definitely shouldn't have a ton of packs, this
> leaves the user with no real escape hatch. And 256 isn't actually that
> many packs.

It was raised back to 4096 at the end (I didn't know how many spare
bits we had at this point).

Agreed on the escape hatch though. I think we could do better: if
there are more than X packs, we repack X packs into one and leave the
rest alone. The _next_ pack-objects will pick another X packs to
combine. Repeat until you only have one pack left.
--=20
Duy

Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED5C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0A5206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="FiYxLpye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgFNN6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgFNN6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 09:58:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D0BC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 06:58:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n24so14669001ejd.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d0DmXMniCgqr8uqipNz9cnVuR9z+uS1b23Q2EQGzQu0=;
        b=FiYxLpyebwcBaSOS7wgXXV1d9GZwtKqlb6BTEEB5+IN+u59B5WMiXSQOHm2QcVr9sR
         1VDmwony8Jfk21j2wggCe8P1TwsKg6VnzT0BYkN/1jQUx9TtQs0WULdjC7N6FM1Dweg7
         rRj8d8ApMSCsc5TIFMCxNAXGadIHasgwo8Ex67lZSed8oH0dQ8QmJgfIHuY6hSK507xK
         CH7vWHZT14zI2p8/+FLPCiAuRDKVfuzJkDYbF1ZhDlCUSjkFDc/In/7zgCbwBt+EbiW8
         AGSJ30NIREo89kz4IC58PS3fe5/V+aC0YQeLl+2349Iw9h5pmk8LSPY7ErtlEPvxyRHx
         S8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d0DmXMniCgqr8uqipNz9cnVuR9z+uS1b23Q2EQGzQu0=;
        b=PYTiwFoiUaZdFlgGgt1geIXURoMCGllxGIP3hv1bqRWbYT3gAPtdjxhxFMiRCNAbOv
         tZB7v6bp/0wCi6Rmrb1kQi53zCpieF5KFgbDMbB9WHuG0Y0NXncTAtoctnOlwHX93e6/
         GM+XX8YfUhQNUJMsyzvReYyCdpxz0U0ZCkZZK1iGsY5LNW/piagHl1/T2mWMKtZvmZ/0
         l1/vzXCRCH8GEqvYKJe3injN79X/WbsQBCeOcjxehjI90tEV7f6N4jVDQ5e9at8FiJJY
         xrLH4aPS2G53O6M1izAykvcM3y838v6TMsgQwaWg2J+jUm6QTY+KWr31AqkZkaKPIlr5
         x0EQ==
X-Gm-Message-State: AOAM530NFNl6zU2ZqtEJ3zV4Abl/Qoo1HhgyVETxxTa1KBPR0dBtd/TN
        uGQKSWRjtqmMklqrQsP4D3ows43B3Iea6cmVbGBJrw==
X-Google-Smtp-Source: ABdhPJyW3T2Tycu4xuRLt3OxmCBxObsJF7652Gs7w8qV9AaAzhBU74OA1GbcdayDaq3a3hrnVACwHAvwj+Xwqjl1Gzs=
X-Received: by 2002:a17:906:4c42:: with SMTP id d2mr22461698ejw.474.1592143125730;
 Sun, 14 Jun 2020 06:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email> <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
In-Reply-To: <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Sun, 14 Jun 2020 15:58:33 +0200
Message-ID: <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Cc:     philipoakley@iee.email,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        newren@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> MASTER IS NOT INHERENTLY RELATED TO MASTER-SLAVE RELATIONS.

1) There is a great deal of evidence that that claim is simply not true.
https://twitter.com/tobie/status/1270290278029631489
https://twitter.com/jpaulreed/status/1272064807345115137

2) It's beside the point. Many problematic words and phrases have
perfectly benign origins, but take on new meanings in new contexts.

I personally reject the kind of moral relativism that is being
espoused here. In fact, I believe that there is such a thing as
justice, and that we each have a responsibility to seek it out and
create it in every corner of our activities, big and small. You can
abdicate that responsibility, I can't force anyone to do otherwise nor
would I want to. But history judges harshly those who would throw
others aside. Of course there are more people in the world than just
Americans. But there are also Americans, and in particular Black
Americans. Precisely because git is the tool of choice for open source
and so much other development work, I believe we have a responsibility
to build a tool that reflects the values of _all_ that we want to
welcome into these communities. If you would rather exclude Black
Americans or others descended from generations of colonial slavery,
that's your choice, but you need to own the fact that it is an
inherently racist choice.

Don Goodman-Wilson

On Sun, Jun 14, 2020 at 2:20 PM S=C3=A9rgio Augusto Vianna
<sergio.a.vianna@gmail.com> wrote:
>
> There's nothing to be resolved because there is no problem. If someone
> reads "master" and gets triggered because all they can think of is
> racism, that person needs therapy.
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7391F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfFYKaT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:30:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44279 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfFYKaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:30:16 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so1976287iob.11
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upC59MnyeFsHXzxMaAKnjwkTNNMh3eStMkIrBNDCN1o=;
        b=ex+ZXHbpn6dvzKx0HMxSXvOnUlkEKy4QfnORHTAUnWolU6DwCqXV0mU8+gev7f30tZ
         doq9UhztQFztwRk1rPAsTuEuZ9IZORoPwgKD9JXK5NzVXP+5lHVlzK1sXutNYPSNpRwB
         DtCuPDVqNtDE024ZprZ8305GN6w7NveR5q2LE+BtGpZz7cDDUFmmx+f6ypnP5Ov4PCri
         xEFurfUYxfWtBwiJ7vEzHmutZ/QcuGFA+tk4ZebqhiGASAExkLe6S14WKIxm/a0HFRTO
         nEgL4Fos6V2J08UV41z32cDN44nJlQyD4MnMv5tXHX0IbWF7VmIUDm7SZ/RHz+2HJynY
         37JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upC59MnyeFsHXzxMaAKnjwkTNNMh3eStMkIrBNDCN1o=;
        b=qrDWZohAII+KvbscgniBUZ0C2cQVXwqVtg5tc4bFeB0dhSd1GEACThBmwHmjcF2/mB
         9w77T+nVJZGf6da4pM2TgD7FuS5176f83/rtC4G5m5QJPL9xl7t1W10GsP8mrLu0gm/E
         59o6q3o5diJtdQye7xb5ajTirjydV7owmN+L0gUXsy7FJdCbqQLrFLJmej+BQofuFBfk
         6WCz7vNKsN1lXSwuBaj7F8eQmEcvv7xcvUlgFePksF3orSR4d15SPY2HG1w3VehFu8Wo
         0++jZBLlWcFaV90zJXKM1ljGRe9tIFB9IU2oxZ1K42NrzlJXJrxvRHidmOz/ih7vHFmC
         uYVg==
X-Gm-Message-State: APjAAAXsth9pgX4V8VRaxG2PrQ79Ph5j1Wx5R0aemBzDbbQM+s5b9aRz
        nFgjldT8nmlIiiGCh9q7H4ZSY1SSP+gT7pqGoi2voA==
X-Google-Smtp-Source: APXvYqx6OoVAnhw5zWj+EcgzBRutYysnrUOJZls6a3JE/yDRg2d40LySadEFpFvvXJIjJfGV4IWwnlpwRbAMFYixArI=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr45804138jaz.30.1561458615513;
 Tue, 25 Jun 2019 03:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
In-Reply-To: <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 17:29:49 +0700
Message-ID: <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
> I'm curious how big these EWAHs will be in practice and
> how useful an array of integers will be (especially as the
> pretty format will be one integer per line).  Perhaps it
> would helpful to have an extended example in one of the
> tests.

It's one integer per updated entry. So if you have a giant index and
updated every single one of them, the EWAH bitmap contains that many
integers.

If it was easy to just merge these bitmaps back to the entry (e.g. in
this example, add "replaced": true to entry zero) I would have done
it. But we dump as we stream and it's already too late to do it.

> Would it be better to have the caller of ewah_each_bit()
> build a hex or bit string in a strbuf and then write it
> as a single string?

I don't think the current EWAH representation is easy to read in the
first place. You'll probably have to run through some script to update
the main entries part and will have a much better view, but that's
pretty quick. If it's for scripts, then it's probably best to keep as
an array of integers, not a string. Less post processing.

Another reason for not merging to one string (might not be a very good
argument though) is to help diff between two indexes.
One-number-per-line works well with "git diff --no-index" while one
long string is a bit harder. I did this kind of comparison when I made
changes in read-cache.c and wanted to check if the new index file is
completely broken, or just slighly broken.
-- 
Duy

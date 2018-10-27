Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09111F453
	for <e@80x24.org>; Sat, 27 Oct 2018 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJ0RoI (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 13:44:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39882 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0RoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 13:44:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so3982963qtq.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/q9I0+70xqGIYPb/4o+awTR2X4S6QWgL4v1yqI5+0XQ=;
        b=rMBjecEM/ZA8nVq1FsbcPkV8pYRKzeBKHs7getfFyPolArRcv/TbACRK9rImo6QD5I
         eWebzij5TzECrvIAkR1Q1KaKt5I/HSjwWvNdE4BD/FM2Mg0RdUseoAOHw7Exfx5xI8Ir
         qrJFwWr2slrnla4iH05xdwMNsB0GZMZ36ZF7rBCO4THv7jbccU7gNvEb0ut+eDMc4rmW
         QQsviGTUZNGFJcit5G2sq2skABpCZvrRdhjIQkqBlO2M96PzgLDjUNvD66VwJI+vdtMk
         KMWzwtvPCjiXGvbpfUlNyHy9BS9VIE91NPMVHfaXZ2dIrdc/elN1MSWsxBnfejd3Bgw8
         Ll1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/q9I0+70xqGIYPb/4o+awTR2X4S6QWgL4v1yqI5+0XQ=;
        b=Ed5mh1yROKSqC6OuVPFsB+GEkZkNByMpt2c7kYmmkRn0AwkHqNUTsbPWHPCb+UeDbd
         eQuS8R2E0n4Bt/R0YNyHx2xbNvJtldWwinXCz9jXrdjZbkcfODrAgN25SGyV7xjiGD22
         e2u61sjc3EX5Lym+N4YMrCq9ZHhzhDnDsZUyTmmJP00fcP9n3ZHdhagYrhbsS++7Nl2x
         FT+0ZWQLavIWN5lZ5rB08NohbngIKBpqhuBNFQsiwhGUPdqBE/WhBcFUXviBpvZhmQaK
         O5SRyeddPVb3gpomSRT/jWN9S6BuYPZ49DENYEqyZSvCO0cdLJuKoROZXVrZj4tW0ty/
         042w==
X-Gm-Message-State: AGRZ1gJPGP6ClcUSMkx4SlysJzpF0lFkPbLUiUxQb7hbZReaK/pnAHhQ
        iQORNu6+Le8arFRXpwjL8TVtpEtAsW/dsaGK4is=
X-Google-Smtp-Source: AJdET5cSYa0pn6dIqkkB+3lSkNOTyRF/PlY8AF1kWXGBsmXdnDwOXscRi/+ob5W49nxBXcoRUtkM73oc8JFO+NXY7PE=
X-Received: by 2002:a0c:8003:: with SMTP id 3mr6262053qva.129.1540631031779;
 Sat, 27 Oct 2018 02:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181025024005.154208-1-sandals@crustytoothpaste.net> <20181025024005.154208-11-sandals@crustytoothpaste.net>
In-Reply-To: <20181025024005.154208-11-sandals@crustytoothpaste.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Oct 2018 11:03:40 +0200
Message-ID: <CAP8UFD3oYY=brGz1HZ67vxaRrxdwCdwNaJ9n78yJy9bUncW9pQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 4:42 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> +static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
> +{
> +
> +       uint32_t S[8], W[64], t0, t1;
> +       int i;
> +
> +       /* copy state into S */
> +       for (i = 0; i < 8; i++) {
> +               S[i] = ctx->state[i];
> +       }

Maybe remove unnecessary brackets above and below.

> +       /* copy the state into 512-bits into W[0..15] */
> +       for (i = 0; i < 16; i++, buf += sizeof(uint32_t)) {
> +               W[i] = get_be32(buf);
> +       }
> +
> +       /* fill W[16..63] */
> +       for (i = 16; i < 64; i++) {
> +               W[i] = gamma1(W[i - 2]) + W[i - 7] + gamma0(W[i - 15]) + W[i - 16];
> +       }

[...]

> +       RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],62,0xbef9a3f7);
> +       RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],63,0xc67178f2);
> +
> +

Spurious new line.

> +       for (i = 0; i < 8; i++) {
> +               ctx->state[i] = ctx->state[i] + S[i];
> +       }

Maybe remove unnecessary brackets and use "+=", like:

       for (i = 0; i < 8; i++)
               ctx->state[i] += S[i];

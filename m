Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C091F404
	for <e@80x24.org>; Sun,  8 Apr 2018 01:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDHBGK (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 21:06:10 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:44443 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDHBGK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 21:06:10 -0400
Received: by mail-qt0-f171.google.com with SMTP id j26so5341564qtl.11
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 18:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xSlC8SbpMLBN1KYColqlNZoAcFZUb9B+L12H/Gfdp2M=;
        b=X9zK03mpiMbGu5t1a8iXzcsmEcn8Ef5Yfx4a4K1TPCJjAlpNyHCEPyi31QbU91gv0d
         a7EiWPDNk7TEaToy+OUA/HIJK8PfVkOmT3Mt+LFhcmZhgf86/M1F/t97bAX5EgOrlvft
         4tZAE4Np2NYxQfuM7ptwIGEN6dG2g3fo7aBsBhDGIpsNiNAhElczZhVYj+HdwGvbJxm2
         aTlnLJTspTytqJdsPlaFTbQ09138bzluoZ8TB/hNJsTeh4YjgYxr6kjOEs0R2dEPBVIx
         sYEttJ9vGpHkN9UKF2aPxEf2bGOMZaD91EVjotl6wLaDn+7bv5TAknxETNyAb3wkVE0y
         jRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xSlC8SbpMLBN1KYColqlNZoAcFZUb9B+L12H/Gfdp2M=;
        b=m+LryJRQMLxpLBPSMPq+I067o5ZaR3Vbs+LzFakUB8uifVTxM1ss8PBnsgfOM7XrsM
         7bsb3prwOZ6RLAARquIZ5nO60zSeO6Tkbq5Irvwc0c8wxRMORWgjiYEWkkI0YaoYb4yg
         QGdTzjIoBA8CyCXu5ORrD+0B3IS5uKerXdIJ+ozCl7DDaU1ce4ORCiIc6maClKwYYgAI
         2Ml1JUYykXq0n8KvjOC2Uc63PcM5FTYiSjnN59qzH8brIK2ut1FkPsLQRLl7QDlxu67S
         D27A6hSwRjmgSJJAVKtf+g6c3QgHR9hqL1OkjuftyEEW1RzttwD4CSxjLc+JJTtQHv5A
         ZcFw==
X-Gm-Message-State: ALQs6tCflIpfNRt0UD7jsby7HUDuHqQ5pf5EUniBQk5yjlP2h4PGunFK
        ttzw0rquFr0wXKrStPjrnkqpVfb3XS+PAnGhuRo=
X-Google-Smtp-Source: AIpwx49kxTm3TFBuPY3VBJNLhgb3J4l63JuprSVSmSKBKMApAuDzcwGw0KuiIfBAVKg7NqAV5/mTNYIUqM5CDZrlSNU=
X-Received: by 10.200.42.37 with SMTP id k34mr46632082qtk.101.1523149569495;
 Sat, 07 Apr 2018 18:06:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 18:06:08 -0700 (PDT)
In-Reply-To: <20180407164250.54303-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com> <20180407164250.54303-1-haraldnordgren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 21:06:08 -0400
X-Google-Sender-Auth: BN5HYzxvEClEiazed9mHc2Z5-pA
Message-ID: <CAPig+cTQ1ZzWTp6Qsj96nE8QwhuRuqB51orTNsCQjGKD=_veyg@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] ref-filter: use "struct object_id" consistently
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 12:42 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> Internally we store a "struct object_id", and all of our
> callers have one to pass us. But we insist that they peel it
> to its bare-sha1 hash, which we then hashcpy() into place.
> Let's pass it around as an object_id, which future-proofs us
> for a post-sha1 world.
> ---

You incorrectly dropped Peff's sign-off[1] when re-sending the patches
he authored in the series. And, your sign-off should follow his.

Also, if you made any changes to Peff's patch, it's a good idea to
state so with a bracketed comment at the end of the commit message
(before the sign-offs). For instance:

    [hn: tweaked doodle blap]

or such.

[1]: https://public-inbox.org/git/20180406185831.GA11108@sigill.intra.peff.net/

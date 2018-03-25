Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1D21F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 08:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeCYIJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 04:09:39 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:39954 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYIJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 04:09:37 -0400
Received: by mail-io0-f179.google.com with SMTP id e79so19739052ioi.7
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wvILYbJKJFv/21XEVnKjDGWOT/MlCUxtJxL54kmSlmk=;
        b=Ms3DJBAeVX3QrHW13na80iHAYRfBLCsfzKOBUVqnPLpTyi1TQLELL35rq3p48yLvjd
         W6QTV1og4ZpfyByRJDV6K29F/WSPWBQdcpttJjUvSZ9b27Pu6zvMY4NqMTutbFd1gTN8
         pmWQ435Eir0InpMVFL18dslgo/fDGOO/j3aiK32JMNJjSul0HPH7F377+7u8L4BnBkVC
         L5u5++QOFO1L7SgrGi8I+vJzAu4Vnlgo4Zb1KjWZMuTTccY0CQqFzJ/j2AQdl/9KMiFO
         HUnHTpI4faJA71YN4ODUixL2etOROERK4jeKiTrNdSH/eJdHAB7Xy733OfqmYntJKi5c
         LFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wvILYbJKJFv/21XEVnKjDGWOT/MlCUxtJxL54kmSlmk=;
        b=hfXGOXAx7vOF6/sUhExMV91Hfv6On8e6oLxA0axc2CuypxpAhZ61vudmFtVKCuGK0d
         U5633qpotIeOCAwQ36ZwQ/KLZ7x6tRAW7Fxm2oMT3iVYQXqu2UeRDYF7prSF4UXHOcB8
         DcCdgBHceE+Z6snfq/aEe5isGWDVFA5HHRNYP1qylTEMgtGzxMiSnovZOzwIDpxQwRqe
         /M7ZxkBncGvdUuMrabu7t2XjFmKbEScoC5Hs0bMETIeiI+razKYEeZFOTZYVafqxQkAy
         MZhwxpbGp1PM8vgZU1i1mYslvAg/piBKzIdgQ+sGhNI8yyHGABYj1b0K9T6kflSQrGEC
         R/Vg==
X-Gm-Message-State: AElRT7Er3a+ekXxtuLWtQk+YG+kdMkoRNOuylAgdyoeRQC/swl4m3zbP
        oSHdAtE5EiV7pfWhSrzQb7q6M6saG2n5v2izacc=
X-Google-Smtp-Source: AG47ELtUUbk7G2I5re7+nvSOPMPvHtkjUN0/DXpccMe2c3hwWjrdlpJ9u4iiBYTO9Al6OKN/by5BCPbVjJPeBY4DYrg=
X-Received: by 10.107.150.19 with SMTP id y19mr25322682iod.272.1521965376516;
 Sun, 25 Mar 2018 01:09:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 25 Mar 2018 01:09:35 -0700 (PDT)
In-Reply-To: <20180324173707.17699-2-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Mar 2018 10:09:35 +0200
Message-ID: <CAP8UFD3Qxt2YMqTtHwU8n7EDvD66QjGSywRQoxJDnncv7=2BUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 6:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/git-stash.sh b/git-stash.sh
> index fc8f8ae640..92c084eb17 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -711,7 +711,8 @@ push)
>         ;;
>  apply)
>         shift
> -       apply_stash "$@"
> +       cd "$START_DIR"
> +       git stash--helper apply "$@"
>         ;;
>  clear)
>         shift

It seems to me that the apply_stash() shell function is also used in
pop_stash() and in apply_to_branch(). Can the new helper be used there
too instead of apply_stash()? And then could apply_stash() be remove?

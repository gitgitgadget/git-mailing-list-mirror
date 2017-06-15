Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500AA20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdFOTgo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:36:44 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36194 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdFOTgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:36:42 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so10749490pge.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Hmy1n0AgHtIDb8fAhuLy4MJLSYWW7JauS4FZ7wWxjCc=;
        b=AeeikGVveR0315MnN3JssVxuwQ2m2YUb4nwA1Ireo80K967AjSLL6f9E67M23dtnQR
         GG60TKg8+jcN0vQwW/KK33UMPCavF+slP2MAprGHtRQjZwS5OSypogMj9Sx2VwTBLhZA
         wOSZZf4v7aDvr1b90pQsizV17mlk+ZE8Xi+mH7aI09h3QcbyJgB5EWNGbX2Ohbne+zJy
         xZGyBVWHLU/DJXVxVBYxxcRqCfIJJdWN/h1DDz6/cZFKHCrypDjh2drzYKD+haR61asA
         0xJ213M+aPUenAoL7A5lwiY9Lic1TZRtKl1bjtyRRhnqhOhGYd5kkBv3Ji6T3y5JYAm3
         wXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Hmy1n0AgHtIDb8fAhuLy4MJLSYWW7JauS4FZ7wWxjCc=;
        b=c0ftZvqIwIO77EqXMxwd55klI4JScJUXAsKrrmSRzytnjhLVeMn46hk6KzZuoz79pu
         dp5l9pz8DLsi5ynCfRsBGITb5ysg64m3vX9Q+3bJvyT7j1tkpo4K5S4mD5OGTHd4/a23
         uN4yCWuUTu2j8JRByu4nRKE2Ue3hd0j95UuMp+X8zMUs23jMaeWiBkGFpXceP/1MbLBS
         o8wjgIFG/eWBoeAL6BTnyV2bfB+m2r24/fLx4LY7+ghlWgFL8O32elXHByVSPHeBs8Fb
         ULlVcmyvNagzgTcM/AxqyfXYOxLeZlGeESBjSGzTeNvHrvljhdW/EfEKCmvN8owTc6mK
         I3ig==
X-Gm-Message-State: AKS2vOx66TpPzHQ/xT990x/jrafe+zVnRMPt8q16yyu5V1U5yKOYdjgm
        ZA8K0RE/8XvISw==
X-Received: by 10.84.216.23 with SMTP id m23mr8053685pli.268.1497555402214;
        Thu, 15 Jun 2017 12:36:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id h71sm112591pfk.126.2017.06.15.12.36.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:36:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v4 6/6] Use the early config machinery to expand aliases
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
        <b75481173390d70a64a1156421aaa0ec5aa4abc2.1497440104.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Jun 2017 12:36:40 -0700
In-Reply-To: <b75481173390d70a64a1156421aaa0ec5aa4abc2.1497440104.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 14 Jun 2017 13:36:00 +0200
        (CEST)")
Message-ID: <xmqqd1a511rr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +struct config_alias_data
> +{

Style: "struct config_alias_data {"

which I can tweak while applying.

Other than that, everything looks good.

Thanks.

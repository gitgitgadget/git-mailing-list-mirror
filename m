Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4191F404
	for <e@80x24.org>; Sat, 21 Apr 2018 04:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbeDUEOJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 00:14:09 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45399 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeDUEOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 00:14:08 -0400
Received: by mail-wr0-f182.google.com with SMTP id u11-v6so27549545wri.12
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GRytLe7tKTYxjVQ2G7SipVcOK8AIfhz4h9qg7HMZwXY=;
        b=GXYfW1iBLvFIMR1IduEVxoX6nNg9hNxvXaZj5UQlFWK8kepb1DX3dwcYIOYKTvwTfo
         R/9SRoYDpVWc/IJGPaBZvbEQKsYGpxRXU7u4qz3xV7FWhr2kYF44TtSs0dzMGPF2xjHP
         EGZ/ATme8GbO2FTeTA3FixpnnKTnZtcxSO1ITk7cJAYX3l28VWVmO7dTbOXKvG2HvEo7
         x+yJCczFIOYDq0x+ZPcVBmPvyD6hoUyFyiFtUKdL2QRhSOdVYpLXtQjjvMHg8ujqURZ/
         k1NdkNoilZSk4w0feXFAwokwxzJpH/4ETMaiRyPySgeyKdvidgvc5L7VAo0rjUZrc6OT
         /oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GRytLe7tKTYxjVQ2G7SipVcOK8AIfhz4h9qg7HMZwXY=;
        b=nJymlPFBduXi0d5wnZek0S6efJsF0Fbf//xz5MiJODATlXE0bgwP6evTSTSSVk16N/
         W5unCAqj64Fmd0ntdkdmTnRmHGEFcUbiTI8qEUqvQqTcWUckQMyh6Wv0rcdz1Rgr/IqJ
         wpCUDhN0maNkoI2za0x6J8crN4cRL5Xz7RabKNmmRWysYCGSaoRCBA8yUxtE9LSeCcIY
         lnIyWZ9XYD5mMWKJld8t8ChhAaJugn9fxzTHSL/lOvOePlX97afD9E32t9OW54HdRkiq
         dV2msni9z7d9t0PWNM/EW0JdfZqnt7CUQwtGXGFgf21i9vBvyQ9UoYMs3FRzes3cpf/0
         0rgw==
X-Gm-Message-State: ALQs6tDfw3DoK+sUUR2DWqGw39uTO2/16kKuiLaXaWwTNhKgHHEUC7Sm
        53SllOnnmXqiaN1VOZmAjgs=
X-Google-Smtp-Source: AIpwx48EbJUFsL7QkNf90hu+hoJXcjvEfGf+WcG72GqePmDPM8gShaV8cEWFGI6ntEqrX7EQxQIQrg==
X-Received: by 10.28.153.213 with SMTP id b204mr3591380wme.79.1524284047156;
        Fri, 20 Apr 2018 21:14:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a205sm2761300wmf.18.2018.04.20.21.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 21:14:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, peff@peff.net
Subject: Re: [PATCH 5/6] builtin/grep.c: show column numbers via --column-number
References: <cover.1524281843.git.me@ttaylorr.com>
        <20180421034540.GF24606@syl.local>
        <xmqq8t9hb3sm.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 21 Apr 2018 13:14:06 +0900
In-Reply-To: <xmqq8t9hb3sm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 21 Apr 2018 13:07:37 +0900")
Message-ID: <xmqq4lk5b3ht.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> This commit teaches 'git-grep(1)' a new option, '--column-number'. This
>> ...
>> +`columnnumber`;;
>> +	column number prefix (when using `-m`)
>
> Is there other people's tool (preferrably some variant of "grep")
> that has an option to tell it to show the column number of the hit?
> What is the option called there?  Does that tool let the option
> squat on short-and-sweet '-m'?
>
> Thanks.

I still do not know if we have a good existing model system to take
the longer optoin name from, but at least, GNU grep seems to use -m
to mean a completely different thing, so I'd think that we would not
assign '-m' to this new feature.


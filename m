Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0071FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdFMRX3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:23:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36305 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMRX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:23:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so19932882pgb.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IvIHPWyJ07wR7BBWJUq4qOeD2X9E7n3KTY3RAclzdmE=;
        b=Ib3WbYNyuFQNmT81H+NkfDALVCyzJP++qiIUSN/aPJy1L/DWS6iGuomDmLx8M4qXFY
         JsQYRzyRU2UPEmpzAR50d7F0kOX6l3gSJMfO5cuNqWlqexv7hYAjPIbzeD6wc4DmzCmJ
         Ynoo4xEg2dMtl6qp0UPA+FTSULYp+0xCz6NkTN0smRC1yaBadkU0Cmj5fkWwj7Nsl5Ao
         kKI+IGJJFlGYJKlx5Rn5s9Qm7IL5fz2Xiza9zMbVSeWaULQ/yE2OMKgZnTgV0j+mmOua
         azKwQ38qOfP+9kuaVsIi8iBca1Oluhc+2Ox+4hM8EpU5YEThMd1KjwOpbbweVy1kn2Z9
         ny3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IvIHPWyJ07wR7BBWJUq4qOeD2X9E7n3KTY3RAclzdmE=;
        b=eabdYBw0Zm7e9/UjtmDHrt2xeEAwakwU4INra6bmC9LVcnnXv1m+2mvjr8015jRmUo
         83gm0aGNEymPtDLjNf+vc4VI26QM1+gZ24iRDRQ5jNGH24thaFf0l49Wv6UGoCcyKjR0
         LGoZKTyX6JH8mVGYrmpdwrBTJW2/u+GHQ0e+gj+cNM0Nctpxcst8jjGmd/pn3X/NhTiT
         nqIVvTnmYKdUkErNVpsD9h6QFnPRu3Y70Vi7EHuFefF5EvbkAHS8N15b7dw25rLBkBZy
         lSWCU0Zgutc6JbNo6tJ0xiZN8lRdtpwn24ZtFqCbM/C3EjYZK5QIKbHZYmDntYs7nDM/
         E+FA==
X-Gm-Message-State: AKS2vOwNj+8qybef/bDfz+SBGD2kiL6uSlHCdo9R9U+XAD1jkbO62wUZ
        GI+rYWojCbLpiw==
X-Received: by 10.84.215.148 with SMTP id l20mr745982pli.79.1497374608351;
        Tue, 13 Jun 2017 10:23:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 72sm23107556pfl.66.2017.06.13.10.23.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:23:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
        <20170612043313.GE5297@vireshk-i7>
        <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com>
        <xmqqmv9dnkut.fsf@gitster.mtv.corp.google.com>
        <20170613034337.GF5297@vireshk-i7>
Date:   Tue, 13 Jun 2017 10:23:26 -0700
In-Reply-To: <20170613034337.GF5297@vireshk-i7> (Viresh Kumar's message of
        "Tue, 13 Jun 2017 09:13:37 +0530")
Message-ID: <xmqqk24f7qep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

>> Going back to the core part of your change, i.e.
>> 
>> -	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
>> +	foreach my $entry (qw (tocmd cccmd cc author self sob body bodycc)) {
>> 
>> to think about it a bit more, I notice that all the existing ones
>> are about CC.  So I am not just not convinced that tocmd belongs to
>> the same class.  I am inclined to say that it smells quite different
>> from others.
>
> That's right but how do we solve this problem then?
>
> Add another optional argument like suppress-to ? I thought that it
> would be better to override suppress-cc rather than attempting any
> such thing.
>
> I am fine with any solution that address the concerns raised by this
> patch though.

I am not sure what problem is being solved, quite honestly.  "I have
tocmd configured and I want a way not to specify tocmd for a single
invocation?"  Would something along the lines of 

    git -c sendemail.tocmd=true send-email ...

how you do it in general?  Do you want a prettier-looking
equivalent, e.g.

    git send-email --tocmd=true ...

or something like that?




Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EB7201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbdGCUtv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:49:51 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38693 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdGCUtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:49:50 -0400
Received: by mail-wm0-f47.google.com with SMTP id f67so65834134wmh.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rcU7NALJwu+g7kTRDFuoFqPujYcOkK6OCT46Y7t5y0s=;
        b=VavafQuh/EAYX9HOAAgfLIa4rTgS58lJpYSg7WKKcYu+3h6HnrQf+lMGQRthkZ588d
         UcT28g8DgJkzO4hIGGNdd8VDiwJhYzk5giR0lAqJXjSDn2AeWy9ewwulT4vZNfkK72BP
         wgQtY2M1QkXmQjG2rcvrZGvfDbIZYhy4vbBrX5lCuTsi+jT2oy00grm0Ie1kdxw0THZk
         FAQQMuviA94Dse0wLkHviGT6gofmrRTZUgFS+9u8wPTvmLZTQSjud/WJ99xbF5EOmPZz
         t8GRYzMzVF6Ns8Bulf/akDy0tcLP5xF7v2CJvN3BlP4lDDQNl0Xx1NcIdJkpZjyQiUL4
         ulVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rcU7NALJwu+g7kTRDFuoFqPujYcOkK6OCT46Y7t5y0s=;
        b=ijRTityqalOZFeL3gBzlxpKvucwcStHC5z35N69ZuOazbRekbO8TogNTqbG2Hol1ge
         JkCw94PfOpXaTDBd+70AvpULWprBzcCeTqfMr4xl9l20l/bQnYSAh+R48oMPN977doT1
         HXVZPDmeSPhJtEB7nUxztv4vRqiC5jI2/sJn4RyP/TXO5kEmM/Xo6s0V0n3TTUd0op3m
         TL1ZX9zXJtn5YMUSxsrrH06Oay8YH2sA6VwHM2arjVK8c7DD0H6KLghzsZUn7EnYdGzc
         3UdYFbJYeFIpqqxmXQ9/fxAPt1GtoarkomTz8wyPeex9LmN1gzA/ooUDABUDr221643V
         Rg1A==
X-Gm-Message-State: AIVw1102p0u5T8Cc209t4y1lVx7JOO6ItZcJrq/UvzcDDq6wKgeRlUnx
        PA0cofwKOP1nXg==
X-Received: by 10.28.153.21 with SMTP id b21mr8743285wme.96.1499114989483;
        Mon, 03 Jul 2017 13:49:49 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id r40sm17726660wrb.37.2017.07.03.13.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 13:49:48 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS8Hr-0004bC-AK; Mon, 03 Jul 2017 22:49:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/12] builtin/update_ref: convert to struct object_id
References: <20170703185533.51530-1-sandals@crustytoothpaste.net> <20170703185533.51530-7-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170703185533.51530-7-sandals@crustytoothpaste.net>
Date:   Mon, 03 Jul 2017 22:49:39 +0200
Message-ID: <8737adckkc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 03 2017, brian m. carlson jotted:

> Convert the uses of unsigned char * to struct object_id.

I read all of this over (but didn't apply/test it) and it looks good to
me, Just a small nit:

> [...]
>  1 file changed, 34 insertions(+), 35 deletions(-)
> [...]
>  	struct strbuf err = STRBUF_INIT;
>  	char *refname;
> -	unsigned char new_sha1[20];
> -	unsigned char old_sha1[20];
> +	struct object_id new_oid, old_oid;
> [...]

It's easier to skim these when you leave changes in the number of lines
to separate commits which do more than just rename boilerplate code,
e.g. as in 05/12 where `const char *p` is introduced.

Thanks for working on this.

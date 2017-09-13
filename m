Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC14420286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdIMRyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:54:01 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44290 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdIMRyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:54:00 -0400
Received: by mail-pg0-f49.google.com with SMTP id j16so1744068pga.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fPU8wNP9WgZHaJtcb+bbFUddjgUjlNpmrnFQKN07PY=;
        b=r0Vf2jx6vKzfOOeGltQWSF6vOS4t1KTJfYpBNCe/mLggzGKTfglS+fE9Xx3RxqXfjf
         eU1o4PyZdzu9UVoVMEBvxsfyRMWYffiwsXYO9SAZl6NIddn5/LJeivSb9M7vJAZVeh7F
         vjk0FJrURt5sxchkjNvfOpcPvTEo7iX5c1+BvDSBW7a4jKzHUMfzyLhrICTyY+H0+gAN
         oLSBP+QrzDND80OKV53vTZJ37aRMQliVnF1L3tpwTOb59HYc/c8uHNHdto3r4avhtd9H
         wGhtfg8v2A2nFxXzFviTDFk1MeCqOzxJwSVlJvDtE+PRYoemoapKXTCRXrdHo/Ll/naK
         rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fPU8wNP9WgZHaJtcb+bbFUddjgUjlNpmrnFQKN07PY=;
        b=D7XqRpN9rweA+KL8n6vfsBoU5EFK1tPGi0NxcwBR5vEeP+uqqHvZZ7EPh9zEKTpgD8
         j8uc7S/Hj3CQV7YF1tRCg9+x518N3yav5VSZbbB+4YGj8X9et/CyhL9zTZVVq1c2iPdl
         xkoa8omH/ol3yzZcN3B0KnpDgqz4yovKmyLnq0WG1+oysgCErv5QzujtBOgEQYRYSDQk
         3APsRLjEuGa9+L/ThIYoUNgw+t2CvqeW2RIHpcUZflmbbpEfuFBGGjZgdvswLP4czVvM
         yxIxda1YyFkFMYFZfRkGJkLo1Ke4+2Vx/hbYFzHeqrH1b7av6RZH3vvtAVavJSjIFa5L
         lzUA==
X-Gm-Message-State: AHPjjUgI+QNqaI1DyyQX6+kSFf+KmNv74k8jZcabig4ch9LwHY69dVVd
        j2mCLZQTclDMnA==
X-Google-Smtp-Source: ADKCNb7n8xiH+gImPLRwSS6+mh3wfGKoSJpW/DUVOwYfRuQaxjY65DzBwZ24RzVQofobo1gUDjsmPA==
X-Received: by 10.98.149.208 with SMTP id c77mr18575556pfk.330.1505325239659;
        Wed, 13 Sep 2017 10:53:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id w90sm28767742pfi.80.2017.09.13.10.53.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 10:53:59 -0700 (PDT)
Date:   Wed, 13 Sep 2017 10:53:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/7] get-tar-commit-id: check write_in_full() return
 against 0
Message-ID: <20170913175357.GC27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We ask to write 41 bytes and make sure that the return value
> is at least 41. This is the same "dangerous" pattern that
> was fixed in the prior commit (wherein a negative return
> value is promoted to unsigned), though it is not dangerous
> here because our "41" is a constant, not an unsigned
> variable.
>
> But we should convert it anyway to avoid modeling a
> dangerous construct.

If the above logic is correct, then I suspect this series does not go
far enough.  write_in_full() would be one of those APIs that is easy
to misuse and difficult to use correctly, and if so we should fix that
at the source instead of trying to teach callers not to hold it wrong.

E.g. what would you think of

 1. Introduce a write_fully (sorry, I am bad at names) function
    that returns 0 on success and a coccinelle semantic patch in
    contrib/coccinelle to migrate callers in "make coccicheck":

@@
expression E;
expression F;
expression G;
@@
-write_in_full(E, F, G) < G
+write_fully(E, F, G)

 2. Run "make coccicheck" and apply the result.
 3. Remove the write_in_full function.

Does read_in_full need a similar treatment?

Thanks,
Jonathan

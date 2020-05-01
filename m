Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE2BC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7EE2137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD1mP0d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgEAOkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgEAOkN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 10:40:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2223AC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:40:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so1317163qke.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xu00IeHHQv6IMEC9hVCz5+Bz8rGdtZOjjRwFhpZl4Kk=;
        b=GD1mP0d+P3VHzSOd5JKHdTMPno4KPRWiAMlUzLEh4dExi++2Lw5MH4QpyxLqX1GHVe
         96keR3YATWUNsWl9p2zhVjQDwlZc0AwopMwCMM85/upV965aAKn30cipJsR+2aWeaQ4M
         AROcY64kdPmjCGr8DWaYPz1OafsYegYdihecAayMmtF/LDQl1T7bq/9D6Q0deU4nLfvA
         afcsLGPJQ5lXJ1860ltSzM6FSlveBB8jzZ4IY4dE5f57r1PN8X/yNwIJY+gfMyzb7tyC
         cAjhsvf9iH31fUDAx+B55/5sho/asTx8+K8QvaxjWzrwLuk4zFm0wKq8tfg2QGqELR8X
         AFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xu00IeHHQv6IMEC9hVCz5+Bz8rGdtZOjjRwFhpZl4Kk=;
        b=myaK/jj8aNea/bspoAGjz7H7dwf7fVoTWKtRt9RRvHiR48VN7IM5+LWsE/wfNCKJFw
         mebmLDpHXs9/1gka3iBBGt4oCH1rOX0GBJyO0GJ8Y3Wqy0umVV2BxDMMN5pN8buhHMQl
         ONDPK5QFwHiWTAKSd+VAm9+BvqiQtkZt/VQ512blaKLRNG1dMS3lbG0fdjfXB6ajK5Kh
         Su+AcLEwTYhR4CzVMMLiXqwS1EYAksjV4UBfWQgk8mOizD6IIjHdixxjYgtmjHP5gvUu
         VYF6UjjEYzt+7MQSqjDvx6sYN29Z2NTHTym5/UnrzvIHUxIEUYVyPG8oHl1ZQg35vSTK
         Yreg==
X-Gm-Message-State: AGi0PuaCWq4S6t0apKMYGQXnAKZ3WOgDdqnexeOp7s9VUNnABQXXPpY2
        0PbTc+cH2cguqdNB4KqgwNFRSOUrRjY=
X-Google-Smtp-Source: APiQypI+GNy5FjJwX65Td3cgBI/aszaVNZ9kmtFRptt14SZFQgLNyoiUlz+zbfYmg3LzqHRZn+sG9g==
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr3947668qke.172.1588344012147;
        Fri, 01 May 2020 07:40:12 -0700 (PDT)
Received: from Douglass-MBP-2 (c-71-236-60-199.hsd1.tn.comcast.net. [71.236.60.199])
        by smtp.gmail.com with ESMTPSA id k58sm2818763qtf.40.2020.05.01.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 07:40:11 -0700 (PDT)
Message-ID: <448114a7ab365f81971bfd9dd75b781f4145b098.camel@gmail.com>
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
From:   douglas.fuller@gmail.com
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 01 May 2020 10:40:09 -0400
In-Reply-To: <20200501061917.GC23665@coredump.intra.peff.net>
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
         <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
         <20200501055738.GB23665@coredump.intra.peff.net>
         <20200501061917.GC23665@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-05-01 at 02:19 -0400, Jeff King wrote:
> On Fri, May 01, 2020 at 01:57:38AM -0400, Jeff King wrote:
> 
> > It may be easier to just use double-quotes consistently, even for
> > ones
> > that do not need it, to give readers one less thing to wonder
> > about.
> 
> So here's a patch that does that. I also noticed a few other
> deficiencies in that final example, which are fixed in the second
> patch.
> 
> I hope I'm not stealing Douglas's thunder. :)

My one-line patch definitely wasn't thunderous -- I didn't even know
how to write a comment in a config file. As posited upthread, I did
interpret the example as presenting config file syntax, so I got
tripped up by the semicolon there. This patch makes it more clear.

I use git (thanks!) without having looked at the code, so I figured I
was a good example of the target audience for this doc. Thanks for
making it more clear.

Cheers,
--Doug

>   [1/2]: gitcredentials(7): clarify quoting of helper examples
>   [2/2]: gitcredentials(7): make shell-snippet example more realistic
> 
>  Documentation/gitcredentials.txt | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> -Peff


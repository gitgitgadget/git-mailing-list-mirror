Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF8A1F42D
	for <e@80x24.org>; Wed, 30 May 2018 01:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968578AbeE3Bmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 21:42:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37980 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968432AbeE3Bml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 21:42:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so44554738wmb.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3vj9fjSe9UAeLW2lt6lDjRyTXWgLc8s/zmBzkUIoPZ8=;
        b=KBSDv7wmnm/vLHamJhTrem87sW+eOwUKZDus+bj24UvpWRGTTQwtFFuKlUZDhAxgJW
         ffvWbYRDZiAP4sYdB/loNF3dx8WH8+xv01dQQ/oKJ/TjE817BJwpU/tBh8dwQKG5VGKr
         O2QfLQcayE5KRpolzK1dG8k0UvNqBaQq6zHFN3JLDNOxfCMt95eKHsK8qdwvRPLMHKUn
         d0yOk0PhQsPA32dVFtNsGHzm8rRgQpghhq2yiRkwB2LI2CwEpSeiGm+J+iV6dFhiZQEA
         nKpKXBNsn+HpMoqqtdta9WOXgJ8Ae8MC1k5SldTJZCGNVVCBXoiyvyT94RPQABUW3TDx
         ZMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3vj9fjSe9UAeLW2lt6lDjRyTXWgLc8s/zmBzkUIoPZ8=;
        b=c/gFpIf6W1Y/p5UJ0jeUT5mZt53kxJY5JqVR28IolRHdU0cI7Hxmb1kVlsfxEvy5Td
         1IpCw4pxYevrxoVyakIXJHJvs35BhSDPOCiqV4wrsqTgflY+y7u7o5WvK5y2vVJdJOYk
         yeIWjCAbJKj0gxQn+kerCiphza9DHQP11nPU72GxhJwIS+iXbKeP0Ssns+H7imkdLI5c
         HtFoZQhHilAMoSyPNlX47DZcrwIKIT1osXVq9h1gQEpxB3uGUu/+r9pupUUjevtNRpzq
         OCcXZiHHs60E8/Wt+5Q+rtYsvpZ/Swy3vMC+FojtDg51OGVfZ2IT0u58MNPG7M4oK3rl
         hrCQ==
X-Gm-Message-State: ALKqPwd0fCtAKTmG/aCYmlnnorQp+kHCPo2qf061ANhiClkGaOLsi6hu
        cn597yhmItDZlbO8J8OMXdo=
X-Google-Smtp-Source: ADUXVKJ7V2nJE/03nRXrStabn5wvfVUUe7snHdYLJlmQKw8i1K/SazIQaYNTnTIehUXF5fFwnJHQiQ==
X-Received: by 2002:a1c:e80f:: with SMTP id f15-v6mr621400wmh.137.1527644559740;
        Tue, 29 May 2018 18:42:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x17-v6sm47294065wmd.46.2018.05.29.18.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 18:42:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
        <20180529213957.GF7964@sigill.intra.peff.net>
Date:   Wed, 30 May 2018 10:42:38 +0900
In-Reply-To: <20180529213957.GF7964@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 May 2018 17:39:57 -0400")
Message-ID: <xmqqfu29gbqp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But most importantly, it means we could eventually colorize errors, too,
> where we are not allowed to allocate.
>
> So perhaps:
>
>   void report_lines(FILE *out,
>                     const char *color, const char *color_reset,
> 		    const char *prefix, const char *msg);
>
> or something?

Sounds good to me.  And if you hate the repeated "error:" prefix
that makes the prefix on the second and subsequent lines included in
cutting and pasting, we could use the two-prefix idea elsewhere in
the thread, too.


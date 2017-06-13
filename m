Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A13E1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbdFMQkx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:40:53 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35717 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMQkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 12:40:52 -0400
Received: by mail-pg0-f42.google.com with SMTP id k71so63042897pgd.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9noFJUahSPJtsqpjN0usCEVbfl29inkodXHM6y1eTqs=;
        b=LJprNQdaSEhdKxLQURGDNUxQrdxrUIpQpWNA8Wm9ZQqvVfV1qATuzF2GhZIa9FoXCY
         oN9rbaOLEgXkpU+a/6L2g+QmgAzy9rFQg5oytBfuv/vGWDTqdXP8DI5DhSYzcj7GdWgw
         hMHsIDdljBROlvzK/eIG8WqWDM5ScCUH8IU8mNO3MxW8N3AHoAKV89oFwEIJep2inKJw
         xtMQj6cmUhRdPzL3xdrRam3tda7gwoKeXldZ4Tx8BQKePWlXqB0Oinz+4LhuKKhEsSpo
         pc29yAe9wbXsRBzE4yP9UIqw6Qp0gI2ojc4sOiE0H+pgsC50kHO0Z+dzKkSHtOyTIH4A
         6Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9noFJUahSPJtsqpjN0usCEVbfl29inkodXHM6y1eTqs=;
        b=N/6H6WUjzc35+fIjruHqu94jXl7sSGu1erxXpqjNdcoSWV4vz157hoFxi/P64dKYBw
         gwTnDQvt08orbFh7OeVGjmx0P9VxPBjogs0XrYK7u4XFlKCHhSvXrdYpuuxGjwnNgOzk
         QTwOOnfnHqaQiVxi5xyt6Q2qfRDU5I63JUw0F7y7zjpzd/kXb/S7+1enPf3xPjkRg8UA
         EZJQSdLWrHY6IvIq8Bp9dteLCSGBfx8v+KHW5C+E1YyV2c4Li0gVpgZwIPIbM/3/xbpI
         XNOSsbxFzolZ3KSgcnWFpoyM18SjJV6DLuwoQfu5u5mrVjJqCygXg+oN9M+EKZrGa9jk
         xSLw==
X-Gm-Message-State: AKS2vOxQN3c3lXU8Jid2fvC/D27x961PcP+ewJxeV9vxiTXkSAV8BKRk
        C9418e9WuaeAKA==
X-Received: by 10.99.97.12 with SMTP id v12mr536241pgb.232.1497372051701;
        Tue, 13 Jun 2017 09:40:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id r85sm26094676pfb.61.2017.06.13.09.40.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 09:40:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level directory
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
        <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
        <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
        <alpine.DEB.2.21.1.1706131339320.171564@virtualbox>
        <20170613114254.oo6r6oqwtchvjuim@sigill.intra.peff.net>
Date:   Tue, 13 Jun 2017 09:40:49 -0700
In-Reply-To: <20170613114254.oo6r6oqwtchvjuim@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Jun 2017 07:42:54 -0400")
Message-ID: <xmqqefun96y6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jun 13, 2017 at 01:42:02PM +0200, Johannes Schindelin wrote:
>
>> > As you probably guessed, I had tried that first and then figured that if
>> > I needed to keep the config_key_is_valid() test anyway, I could just as
>> > well keep the strbuf around for later use.
>> > 
>> > Will change the code,
>> 
>> Alas, I won't change the code after all.
>> 
>> It is really tempting to avoid the extra strbuf, but then the error
>> message would change from
>> 
>> 	error: missing value for 'alias.br'
>> 
>> to
>> 
>> 	error: missing value for 'br'
>> 
>> which is of course no good at all.
>> 
>> And since I already have to keep that strbuf, I'll simply keep the
>> config_key_is_valid() guard, too (because why not).
>
> Oof, yeah, that is definitely worse. I'm fine with keeping both parts.

When you replace Dscho's "compare 'var' with 'alias.br' that is in
strbuf naively with the "skip-prefix and compare with br" without
changing anything else, i.e.

    if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))
	return git_config_string((const char **)&data->v, key, value);

it would cause the "br" to be fed to git_config_string() and result
in problem reported for "br", not "alias.br".  

But this can be trivially fixed by passing "var" instead of "key" to
git_config_string(), no?  Am I mistaken?


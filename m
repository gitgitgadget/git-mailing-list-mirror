Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8535D20209
	for <e@80x24.org>; Thu, 25 May 2017 01:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdEYBgS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 21:36:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34804 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbdEYBgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 21:36:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so35653294pfk.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W0o6P1Y76H/aF8LyKR3VzwMYQUF1USo2FViBOm8680k=;
        b=d43yvC8awQCbF8OMoWyHvUsSZa14Ar4obusEekZ0P5Jv+HemNh7gUPpH+YM6cYYK05
         12gIxuagHQo2FEFuuXvDtpW5RLaLnjL9Kx10BBDNAmONKWJDfMMOpD5cXJNYbtykSQsv
         lnQyqd0GsC1STUji0kPrAVWtw6KszutbLxPnjyeQggCF76uLsZG4nh6m49kUyU0Z83Zl
         6w+xjjGvOPmRF5EynQonTL7772hb85PtCS99IUJ7x+h0v2/GPWp04Yd1EiBurAvbbMrL
         ruiTdz0t1k8CL1N9vWXJMPg4U8snYNOiSdJGCaf17GPsrHpa3bvBiUXyBQBe2raY4963
         f0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W0o6P1Y76H/aF8LyKR3VzwMYQUF1USo2FViBOm8680k=;
        b=mLwqIZkd5efVM9MSBCRuqe+n3UgSsScLZevB4MY3UEtJVNUgZp8UzwZr4A1NoyqxLv
         uL6IsPwRPxyliHy62+CNPp4WKDC29Hr3gUZ7kgddrRu3mu2hoSc0R5hJ9LSVbgQzV4wY
         H88RW+lvmrruibApWQmvXpHGD4yE2RJBJQIH9j/UsM/bRvLkLwmQyNwKC0xVcboVOZq+
         pyejeJ5etYLyRyqxsUZ3JSy6qabzT+h0aIuRyH+L8FmJz4SMSsquAtoD9+YtrLcCZhhU
         0VZGfMmVIk4fGBfjNuttuma/UVkzJ1pA2vB2AFolC0QLAEK9QTLKFsCjqYV1utFgvI98
         l4NQ==
X-Gm-Message-State: AODbwcC+pRvxcroaufotV5kmmH8l+wIwLBwk1TkLqM4R2LoOV6zYhlOR
        Q1mvoLhAPIYADQ==
X-Received: by 10.98.158.5 with SMTP id s5mr41512997pfd.159.1495676176212;
        Wed, 24 May 2017 18:36:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id g27sm9421934pfg.63.2017.05.24.18.36.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 18:36:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
Date:   Thu, 25 May 2017 10:36:14 +0900
In-Reply-To: <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 May 2017 10:19:48 -0400")
Message-ID: <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Unfortunately, it can't, because the ref doesn't exist:
>
>   $ git ls-remote git://github.com/passcod/UPPERCASE-NPM.git
>   efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/heads/MASTER
>   e60ea8e6ec45ec45ff44ac8939cb4105b16477da	refs/pull/1/head
>   f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c	refs/pull/2/head
>   0d9b3a1268ff39350e04a7183af0add912b686e6	refs/tags/V1.0.0
>   efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/tags/V1.0.1
>
> There is no HEAD line at all, so we have no information about it on the
> client side.  Likewise, if you run with GIT_TRACE_PACKET=1, you'll see
> that the capabilities line does not include a symref marker either.
>
> So if we wanted to improve this, I think the first step would be for the
> server to start sending symref lines for HEAD, even when it does not
> resolve to anything.

Yup, noticed the same and I agree with your conclusion.

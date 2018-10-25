Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A001F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeJZGeC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 02:34:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36078 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZGeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 02:34:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so4499685plt.3
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqBwjzADDmioaGlT2Rp9a/URdWJ1Dg9uCruifOaC6bg=;
        b=f44RzAdGar5iO5fluVsu6UTwFbBCtqcq7UXXEq3wN+QVIItvLTClOD1Kx17MDnc43Q
         cQLypJDYeF544vqSHcctTVvUtfkgDBdVvCp2Hpgh7Ihoo186BUliY4c3N+McYv/VzdVe
         jfhmLfoYtsH69Kv/TFsMKTntOjZEXHQifVhbG2vmwFRrI6bxJwj78aX8EUTYq6ujffpS
         v2x7SdEZWso+kBWCQJC1k+MVzh0LyPfEeyqCT8GiP7dV9cix2UkjcVYWsnCn+s1eFE6i
         nAb0MNW9y6IMBnOvxQa6spvryAy+R7KSGXuXHaQCLi3otApIbIDCpvvVnFYn6oYcFlTt
         BjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gqBwjzADDmioaGlT2Rp9a/URdWJ1Dg9uCruifOaC6bg=;
        b=dvmyWscxhV0FfgZzOOx3aS4GRQ2KCl9grScVMXLBbNnTgT7HLwleBdVWVxHKDtykcR
         +VshjOVo4CW2eUZGn5CYdT7GmiPrQW6ZN9XMNEEKBc8CTAilgdGjvRhyxf2az5oSqkV9
         +1kFZUKFQ7lEEkJNABK1Lh4t/k0WJsntWvAWyKL+jPoCg1RNe+grTgMCtvBpo3mQItJl
         0S0OOMdTnpiXG3nQBKnUJEo5m4rBEWNPyKS1RxHmGTTw/XfeLe8wV+7hTBPUma1zumBr
         nTjXzbjRGhUuZL2+8CVccJlL3pDhsN/pBhf0BmXTIrzSbMw5+iFD4KaJsd8SgB9hubyF
         /eJg==
X-Gm-Message-State: AGRZ1gJyPCK7el+YVu6ONLGDXVZhDaTw1HOH1KxZBJEEH3p3ZglvYsgr
        niim9CNrwDDfMSA6Gtym0W3l/w==
X-Google-Smtp-Source: AJdET5f5E0yj/bSnpEGKFaySfFfqpWlqHNV15ogovJMlFeznx19ChzGA4NxIG7ElOehvE7s1wCRaYg==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr868911pld.89.1540504777182;
        Thu, 25 Oct 2018 14:59:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 126-v6sm10131092pff.105.2018.10.25.14.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:59:36 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:59:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] upload-pack: fix broken if/else chain in config callback
Message-ID: <20181025215930.GJ233961@google.com>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20181024072752.GA29717@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1810241049200.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810241049200.4546@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.24 10:50, Johannes Schindelin wrote:
> Maybe a lot of explanation, but definitely a good one. The explanation and
> the patch look good to me.
> 
> Thanks,
> Dscho

Agreed, as a newbie I definitely appreciate detailed explanations. Looks
good to me as well.

Reviewed-by: Josh Steadmon <steadmon@google.com>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBE31F462
	for <e@80x24.org>; Sun,  2 Jun 2019 11:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFBLVx (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 07:21:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfFBLVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 07:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A655CAEA3;
        Sun,  2 Jun 2019 11:21:52 +0000 (UTC)
Date:   Sun, 2 Jun 2019 13:21:50 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: SHA-accelerated Git
Message-ID: <20190602132150.4c1b320f@naga.suse.cz>
In-Reply-To: <CAH8yC8nMcVuLeLWrVumLaz2Pbi3GugzgY-Bw3SMipjJkaph85Q@mail.gmail.com>
References: <CAH8yC8nMcVuLeLWrVumLaz2Pbi3GugzgY-Bw3SMipjJkaph85Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sun, 2 Jun 2019 06:43:07 -0400
Jeffrey Walton <noloader@gmail.com> wrote:

> Hi Everyone,
> 
> I have a lot of experience with cutting in SHA acceleration. I have no
> experience with Git.

sha1 is dead. Git is planning to move away from it. It will not happen
overnight but it probably does not make sense to accelerate it at this
point.

https://github.com/git/git/blob/next/Documentation/technical/hash-function-transition.txt


> 
> If someone would setup a fork and provide a call like:
> 
>     // https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/cpufeature.h
>     // Or whatever the project prefers
>     has_x86_sha = cpu_feature_enabled(X86_FEATURE_SHA_NI);
> 
>     if (has_x86_sha)
>     {
>         sha1_hash_block(state, ptr, size);
>     }
> 
> And provide a stub:
> 
>     sha1_hash_block(uint32_t* state, uint8_t* ptr, size_t size)
>     {
>     }
> 
> Then I would be happy to fill in the pieces.
> 
> I can also help with ARMv8.
> 
> In fact, if you want to use Andy Polyakov's asm from Cryptogams
> (https://www.openssl.org/~appro/cryptogams/), then I can help with
> that, too. Andy's skills are renowned and his code is used in the
> kernel.

And buggy. I am not referring to the sha1 implementation in particular
but to the hand-crafted assembly in general.

Do you have some performance data that shows significant improvement of
common tasks that makes maintaining this hackery worthwhile?

Thanks

Michal

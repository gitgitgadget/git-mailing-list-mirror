Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EFC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 22:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA25D2070A
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 22:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Brrit1aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgDZWhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 18:37:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54605 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgDZWhK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 18:37:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9F9CBE86D;
        Sun, 26 Apr 2020 18:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=COglnfFzMOl09tBWhCJBjiqMmiU=; b=Brrit1
        aQDe+Gkce+a7L0MctyxD/tqsqs5RLTS5CULRqELipm4GD0uM3/WlvIn2p5c4oOGp
        Bs2q2wRk3Ml7yrxrUcUx5pCxUErM8jAMipfmyDm1qpgdqVk9oF0/O+nM/+TgwaOn
        6dW2VYY48XovM9FskG+HaeKXBsnfF9RCuW0zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gaXCRJkikCqXLJN0AVoN+T1K3Z5741PY
        JQkelu4YwAuP4E2zrQ+L4l5eXYQFNaGNeFiQsLWSmXO2hpwCBMnqk5crp5MnO1pt
        eZTbtZGCfMUafzqMqHIdnYmIC+5UaPNAS+Zu5YHvYYmirf1KCXFSRdfMcdaeRuDD
        WVhpX0magwQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1B5CBE86C;
        Sun, 26 Apr 2020 18:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB1E4BE86B;
        Sun, 26 Apr 2020 18:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
References: <cover.1587648870.git.congdanhqx@gmail.com>
        <cover.1587740959.git.congdanhqx@gmail.com>
        <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
        <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
        <20200424170916.GA29153@danh.dev>
        <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
        <20200424223440.GC721@danh.dev>
        <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
        <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
        <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
        <1a0c2b25-e283-9936-1fa2-ce51df1404dc@ramsayjones.plus.com>
Date:   Sun, 26 Apr 2020 15:37:04 -0700
In-Reply-To: <1a0c2b25-e283-9936-1fa2-ce51df1404dc@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 26 Apr 2020 20:38:26 +0100")
Message-ID: <xmqqo8rd98mn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74DD0936-880E-11EA-92F4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I don't have any other systems to test this on, so I can't say that it
> won't cause problems somewhere. In practice, I think the chances of that
> are rather low, but don't quote me on that! :-P

This does smell like a right approach to me.  If we can get it
tested widely, that would be good.

Thanks.

> -- >8 --
> Subject: [PATCH] regex: fix up musl-libc builds
>
> ---
>  compat/regex/regex.c          | 1 +
>  compat/regex/regex_internal.h | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/regex/regex.c b/compat/regex/regex.c
> index f3e03a9eab..e6f4a5d177 100644
> --- a/compat/regex/regex.c
> +++ b/compat/regex/regex.c
> @@ -60,6 +60,7 @@
>     #undefs RE_DUP_MAX and sets it to the right value.  */
>  #include <limits.h>
>  #include <stdint.h>
> +#include <stdlib.h>
>  
>  #ifdef GAWK
>  #undef alloca
> diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
> index 3ee8aae59d..0bad8b841e 100644
> --- a/compat/regex/regex_internal.h
> +++ b/compat/regex/regex_internal.h
> @@ -23,7 +23,6 @@
>  #include <assert.h>
>  #include <ctype.h>
>  #include <stdio.h>
> -#include <stdlib.h>
>  #include <string.h>
>  
>  #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC

Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D2C433DF
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011E220853
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aqvg3pak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgEXQRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:17:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64426 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXQRc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:17:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 779F365DB4;
        Sun, 24 May 2020 12:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aUHXCCHMDtUZMQ/gTRZgV4uNnWc=; b=Aqvg3p
        akDKVUt85avQA3i4J5qKGvxY5WSW4OPyrLZCW1OUm2qUUlSYuoAGVdxiEWykZK82
        XlSnS1PJJuWUyyDXaxIkEGBKI+4mmzNmBz6UYtHbY63IFLsZNi06kB9homzFTMcc
        Lh3BdP+/0820362BL4tvhFKMwliCh+iXfZBG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jIExRzbrRRn6TTGETpniPEW0b1Y+vRWM
        iJ6uBPecdpgfIu+RUTupHvRQyJKUgBB0dbwpDkEeGZkpHIbP6/iABeB5ibwlHCS6
        guBx4/ROwDgdHu0aSQXpkQ0meXJCs+1q9WA12uG5+EF6PabkGloWgCa6tOp/lNtC
        kRDBZ/UQRYA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B4D465DB3;
        Sun, 24 May 2020 12:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E73FB65DB2;
        Sun, 24 May 2020 12:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] sparse: allow '{ 0 }' to be used without warnings
References: <20200522002502.9010-1-luc.vanoostenryck@gmail.com>
Date:   Sun, 24 May 2020 09:17:29 -0700
In-Reply-To: <20200522002502.9010-1-luc.vanoostenryck@gmail.com> (Luc Van
        Oostenryck's message of "Fri, 22 May 2020 02:25:02 +0200")
Message-ID: <xmqqa71xqpd2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10DE4F76-9DDA-11EA-B012-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> Note: The option have just been added to Sparse. So, to benefit
>       now from this patch it's needed to use the latest Sparse
>       source from kernel.org. The option will simply be ignored
>       by older versions of Sparse.

The last sentence in this paragraph is very very much appreciated
;-)

>
> [1] https://lore.kernel.org/r/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com
> [2] https://lore.kernel.org/r/xmqqd07xem9l.fsf@gitster.c.googlers.com
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>
> Change since v1:
> * adapt the commit message to:
>   - fix a typo
>   - give a reference to the Spatch patch
>   - add a note telling the latest Sparse source is needed to
>     benefit from the patch but older versions won't complain.
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 3d3a39fc19..69f065ef8c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1189,7 +1189,7 @@ PTHREAD_CFLAGS =
>  
>  # For the 'sparse' target
>  SPARSE_FLAGS ?=
> -SP_EXTRA_FLAGS =
> +SP_EXTRA_FLAGS = -Wno-universal-initializer
>  
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.

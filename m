Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBFC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A22070A
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fVqVdNgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQUfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:35:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51522 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:35:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB84BC216C;
        Wed, 17 Jun 2020 16:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Quhpy6Ocm89oypggTw7M1PyVoLw=; b=fVqVdN
        gfsWoQmMFQIgZ7plPg4iUACsYjGg3aB6Xo0vXqzEqjmpPPuL7GrSLgm3fPIk3hM1
        BVfWACkAGwJZYn+VJyRRPYivbY5ltXES6HqF0bDFF5C+TH/Y24nSZFlMlFYOx4Sl
        OuWAQRyZ+QW1DZZtBAzqLJ64dhb71T8mn9j0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tlVWQ3X6BeMGfzSvRs6CY+c+CtLSaOnn
        CMeEQie+JPZT53SHzEA9Sn6KP4dYKLsEs3v132J5tZWw+1xjFqjf5xTZKSHYBtbm
        /0dDvdEPfT7WbRIFpNRwWtTU0JoL7YBjm16HVMSnAQ9uB7i7RMakJ4EFM+yIgDGP
        P1qUr2ZQcZ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A45A1C2169;
        Wed, 17 Jun 2020 16:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB091C2168;
        Wed, 17 Jun 2020 16:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, kaartic.sivaraam@gmail.com,
        christian.couder@gmail.com
Subject: Re: [GSoC] Shourya's Blog
References: <20200616072108.GA10273@konoha>
Date:   Wed, 17 Jun 2020 13:35:17 -0700
In-Reply-To: <20200616072108.GA10273@konoha> (Shourya Shukla's message of
        "Tue, 16 Jun 2020 12:51:08 +0530")
Message-ID: <xmqq4kr9toqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F08344C-B0DA-11EA-85DC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Hello all!
>
> This is the sixth installation of my weekly blog covering what I have
> learned in GSoC and other like stuff.
> https://shouryashukla.blogspot.com/2020/06/gsoc-week-55.html
>
> Feel free to comment!

This like looked unusual:

    var1=${var1:=$var2}

What's inside ${...} is sufficient to assing to var1 when it is not
uset or set to an empty string.  It is far more common to say

    : ${var1:=$var2}

with or without the colon in front of the equal sign (which tells
the construct to treat "set to empty" the same way as "unset").


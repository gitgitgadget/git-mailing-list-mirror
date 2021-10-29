Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590BAC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29967600D4
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ2WA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:00:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55560 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJ2WAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:00:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABF2A15EB5E;
        Fri, 29 Oct 2021 17:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z3UM74RNcbhhxE+NzfMmFXilop8JCnipCZSB+i
        2203o=; b=keDRGSHdL+I5u1A3g8RdR2ZpH1Fp4OfW5OP8xhAzaBvEJtzBDcgAqO
        i+dYi+68kFZpVL6KrHdsEleRCTIX3N5XjhNaVGGHdHURo7HjbIv4zkPOYEDPNVlH
        uCy3hSm9NDyFe+jYZdVr6oLiiamH1FAl+McTG6h6JVJD2sEn9OmCA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4B4715EB5D;
        Fri, 29 Oct 2021 17:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61DB615EB5C;
        Fri, 29 Oct 2021 17:57:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmail.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Bug] wrapper.c uses unportable unsetenv
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>
        <xmqqsfwjk1s3.fsf@gitster.g>
        <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>
        <013a01d7cd09$72d91cb0$588b5610$@nexbridge.com>
        <xmqqwnlvik3v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110292348530.56@tvgsbejvaqbjf.bet>
Date:   Fri, 29 Oct 2021 14:57:52 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110292348530.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 29 Oct 2021 23:50:38 +0200 (CEST)")
Message-ID: <xmqqfssjijdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 443CDA70-3903-11EC-85E7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmail.com> writes:

> @@ -24,4 +24,5 @@ void gitunsetenv (const char *name)
>  	  ++dst;
>       }
>       environ[dst] = NULL;
> +     return 0;
>  }

Yup, that hunk (with a blank before the "return") is already in my
"real" version.  Thanks for spotting.


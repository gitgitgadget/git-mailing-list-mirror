Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13EC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D022E2082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TlhPtTg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDVRSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:18:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64319 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVRSu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:18:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0236C2B85;
        Wed, 22 Apr 2020 13:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CQmGGS4feauKxeoykeA5o6F48Us=; b=TlhPtT
        g/6Y7udoj9xJx5ttCHrLtWipFywX9gVF8Q7Fsjaut6M02ZQhT54x78UdTYmFqrvI
        yjFGrEaFeISnmalnFPf2P8iJecWd7OXsUAja0nT+8L8TnSQqN1MazI324GCYiwwL
        vcxTfw9Q03hxDV9jHkZ7x6IckE2nrM86EBVbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/HolARdj5H+6FdcJwiliPAKZLY8wcYL
        oCDl75Rp8V7ymJY7SIVeGMdGnDdpUOLjTrqIYzOOiGQsySgbIuttfCvUa7PtbqRy
        dIOzdxrKt6EBmq8FnDleFxxJJZs6X3K3l+HCYvb4AXK0MAxhN4ECaNISo5uPHXL/
        nrPxbhAPjO8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C46C2B84;
        Wed, 22 Apr 2020 13:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0DB7BC2B82;
        Wed, 22 Apr 2020 13:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
Date:   Wed, 22 Apr 2020 10:18:44 -0700
In-Reply-To: <20200422153347.40018-1-jrtc27@jrtc27.com> (Jessica Clarke's
        message of "Wed, 22 Apr 2020 16:33:47 +0100")
Message-ID: <xmqqblnjjv63.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52C73D3E-84BD-11EA-822A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> GNU/Hurd is another platform that behaves like this. Set it to
> UnfortunatelyYes so that config directory files are correctly processed.
> This fixes the corresponding 'proper error on directory "files"' test in
> t1308-config-set.sh.
>
> Thanks-to: Jeff King <peff@peff.net>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

I'd tweak s/Thanks-to:/Helped-by:/ while queuing.

Thanks for a quick turnaround after reporting the issue and getting
a response.  The way collaboration is working feels wonderful.



>
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e00938..3e526f6b9f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -308,6 +308,7 @@ ifeq ($(uname_S),GNU)
>  	NO_STRLCPY = YesPlease
>  	HAVE_PATHS_H = YesPlease
>  	LIBC_CONTAINS_LIBINTL = YesPlease
> +	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),IRIX)
>  	NO_SETENV = YesPlease

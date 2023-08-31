Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA0C83F32
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjHaRGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbjHaRGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:06:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2510F7
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:05:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46A2B1DE58;
        Thu, 31 Aug 2023 13:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=378lL4nR1WLb8OVvO0TiueBRezh1CbJ86aSbKA
        6Vm10=; b=oMW2YjpdNwVdXqqGmYVl+IJGbaF+KT5hv+2D/1PkaiWQA/Y4EZzGOi
        9L6O9TWrJv16NV6OR+XXDmTTSPaI9wzzTK9+KrdZ64AJM4flfO/VhZRRlmet4Y5e
        71z+Su057Q60EAsCJFCUdNKIiUk0vUs+hTqB50QvTQYO9WbX79q+I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D4F11DE57;
        Thu, 31 Aug 2023 13:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E52681DE56;
        Thu, 31 Aug 2023 13:05:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] parse-options: mark unused parameters in noop callback
In-Reply-To: <20230831072027.GF3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:20:27 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831072027.GF3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 10:05:07 -0700
Message-ID: <xmqqzg27w3b0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A2ED19A-4820-11EE-BF70-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Unsurprisingly, the noop options callback doesn't bother to look at any
> of its parameters. Let's mark them so that -Wunused-parameter does not
> complain.

;-)

Thanks.

> Another option would be to drop the callback and have parse-options
> itself recognize OPT_NOOP_NOARG. But that seems like extra work for no
> real benefit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  parse-options-cb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index a24521dee0..bdc7fae497 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -227,7 +227,9 @@ int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> -int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
> +int parse_opt_noop_cb(const struct option *opt UNUSED,
> +		      const char *arg UNUSED,
> +		      int unset UNUSED)
>  {
>  	return 0;
>  }

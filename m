Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF053C433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FD6610A1
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhJRU2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:28:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53076 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 16:28:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90FC1E2FFA;
        Mon, 18 Oct 2021 16:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iQ0QtblibXO2g3Q+ocDXWfy+lK3kZR/Su/FRNZ
        UjVwk=; b=UpHXzpOO3vwGsDJ5TshmLDvDHeGg7fMC6ldLMgWcgSmRjVfncGiQqm
        aGb8+vGXft9uF+k80io4rGVuO1Vwrrdw8S9kH/kt/aJHtEgzOlGx7+Bp49Re7vot
        5/3oF0g8PbXzRpyPEg8I+9mMB7OgCz/zlSSlJK0B9FTo87k56Wu1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 885DDE2FF8;
        Mon, 18 Oct 2021 16:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAF75E2FF7;
        Mon, 18 Oct 2021 16:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-pack: complain about "expecting report" with
 --helper-status
References: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
        <YW3OcxqcOsY9AFQ8@coredump.intra.peff.net>
Date:   Mon, 18 Oct 2021 13:26:22 -0700
In-Reply-To: <YW3OcxqcOsY9AFQ8@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 18 Oct 2021 15:43:47 -0400")
Message-ID: <xmqqsfwyuljl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9BC5732-3051-11EC-A7A0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 8932142312..69c432ef1a 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -87,6 +87,10 @@ static void print_helper_status(struct ref *ref)
>  			break;
>  
>  		case REF_STATUS_EXPECTING_REPORT:
> +			res = "error";
> +			msg = "expecting report";
> +			break;
> +
>  		default:
>  			continue;
>  		}

That is obviously correct, minimum and surprisingly simple ;-)

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F19C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0FA64E0C
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA3AIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:08:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59238 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhA3AIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 19:08:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBC3FA23AA;
        Fri, 29 Jan 2021 19:07:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TjNeBx1xaETwhhrARJaaZiBNsl8=; b=Kc2fXL
        uu+bc2HWlshR9vjwpsC+3ZKTLLvzaM3GZRjPawKDgkXN4nN71NG4+EsP7VcCAuMa
        NkVeabqz6B//8acAPDfK0b2zWADY+px3Migg9C1Xa7KoHsW6KIeUG7dp2+A38C9F
        VuSiQU5QUuUdgKOC3xHcC/FdbpU3ZYh9hipO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fFq0XcP6ejGQ9/Vq5iSo1ZMZtf0Ub2Z/
        N6dTg3TxjtOjbtihgSShXuesQpInEaCP+wqvaIV8HZin+9ME3sBV7XTiVT9nmBgt
        S6hLqznt1k8NIQDoih9ORTwlvVRpt02bLSmOEGB1Y30s0AGtsVXZ6cHv9SNzpGZS
        OVgIzt9S4NA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3202A23A9;
        Fri, 29 Jan 2021 19:07:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F8D5A23A8;
        Fri, 29 Jan 2021 19:07:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 16:07:25 -0800
In-Reply-To: <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Fri, 29 Jan 2021 21:09:02
        +0000")
Message-ID: <xmqqo8h7qoci.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2291775A-628F-11EB-9031-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
>  			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
>  			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
> -			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
> -			break;
> +			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only)) {
> +			size_t invalid_arg_len = strcspn(*arg, ",)");
> +			*invalid_arg = xstrndup(*arg, invalid_arg_len);
> +			return 1;
> +		}
>  	}
>  	return 0;
>  }

Would the existing caller be OK with this change?

It used to be that this parsing code simply _ignored_ unrecognised
trailer keyword because the very original just did a "break" and
fell though, but now because this returns non-zero, it causes the
caller rewritten in the patch [v2 1/3] to "goto trailer_out".

It is not clear from your proposed log message if this would result
in behaviour change, and if so if that behaviour change was intended.

I suspect that the behaviour change the code implements may be OK,
but the log message needs to discuss why it is OK.

Thanks.

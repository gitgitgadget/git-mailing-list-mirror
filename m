Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B05C6379F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D2120721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PaM/KXry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgKWThx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:37:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59177 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgKWThw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:37:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6064108DF6;
        Mon, 23 Nov 2020 14:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sgN5ewKCb8ss6iAd7KiXdMu1qiw=; b=PaM/KX
        ryZSwSgQrjE5q+0Xqr7081ZZ7BLN8U75byOnkLGVYezyL1uOa+QYku9kIKOi6T7u
        GIJMgGz+iDaJe/dQ5S/OkRS0d/Kg0wetob6Em1Sr0yNK/D+wHnnzVxnyOKNT8sKA
        n7lwTBjrEC09xU41xPVVeOFdclGV1mCC3J+uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tvr5f8a/NdUdGfbg+jdpFKfMha3BPHj1
        bDMpygkQSj/rSjnx3Vefc7DObEUutofUtva0X2xZs0jn4i+0YtR6onHmMUmTXFGv
        0B/jxH00WGUlNip/i49LZcTdorBhpZXnXVl6kGgNUSPaue2ESF6nBeL7vQFudss1
        WF6PHkeFeek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD7D1108DF5;
        Mon, 23 Nov 2020 14:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2C17F108DF4;
        Mon, 23 Nov 2020 14:37:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 11:37:46 -0800
In-Reply-To: <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 23 Nov 2020
        16:05:04 +0000")
Message-ID: <xmqq1rgjoodx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DE36364-2DC3-11EB-BBDF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (fixed_value) {
> +		int allowed_usage = 0;
> +
> +		switch (actions) {
> +		case ACTION_GET:
> +		case ACTION_GET_ALL:
> +		case ACTION_GET_REGEXP:
> +		case ACTION_UNSET:
> +		case ACTION_UNSET_ALL:
> +			allowed_usage = argc > 1 && !!argv[1];
> +			break;
> +
> +		case ACTION_SET_ALL:
> +		case ACTION_REPLACE_ALL:
> +			allowed_usage = argc > 2 && !!argv[2];
> +			break;

Implicitly all other ops do not want to work with the --fixed-value
option, which makes sense.

> +		}
> +
> +		if (!allowed_usage) {
> +			error(_("--fixed-value only applies with 'value_regex'"));
> +			usage_builtin_config();
> +		}
> +	}

I was afraid that abandoning the bitmask based approach of the
previous round may bloat the code but seeing the result here makes
me quite happy ;-)  It is quite clear what is going on.

Nice.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B144BC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B36B64E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhBQUAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:00:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60071 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhBQUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:00:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FEE8122D5E;
        Wed, 17 Feb 2021 14:59:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ogpyyvhbyDVv6ekFHr+CW/3JKJ0=; b=WGCfxp
        aGBDJ9aQq9fsFgIsG/udRHTX2c9+08Rvy5CabOh/G0mietZYUFm6qUw9tHxqud3o
        JGG3KXqsNMJmpsPT7xWFoQjYUWELfW2O1Yg/24BbrVdDBbsySnrE5RWxiYQSvpZV
        2+TU9EweZKUKiU5zoXlHU6ZT23Ok5WYuLEaQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GOtZexUKFE3vOJE8D5L5xbQy2UON53Ts
        bHg2pJmjH54DcUXPaNLwUBqnS82kzszug+k5X1tmt7bMmZh4B+aDy4kfW+xvQRMc
        vQVE3H8+U2B0Styvuq5RAW/j/B4WQBrE7U1ktgUwAUGrmxcvM2JnZ/79dR/v7Us8
        HefYopBtdJI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 192C1122D5D;
        Wed, 17 Feb 2021 14:59:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FB07122D5A;
        Wed, 17 Feb 2021 14:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-4-charvi077@gmail.com>
Date:   Wed, 17 Feb 2021 11:59:49 -0800
In-Reply-To: <20210217073725.16656-4-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 17 Feb 2021 13:07:23 +0530")
Message-ID: <xmqqsg5ujwi2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B21B9FCA-715A-11EB-A0B7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Subject: Re: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options

Isn't an equal '=' sign missing somewhere?

> +test_fixup_reword_opt () {
> +	test_expect_success C_LOCALE_OUTPUT "--fixup=reword: incompatible with $1" "
> +		echo 'fatal: cannot combine reword option of --fixup with $1' >expect &&
> +		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +for opt in --all --include --only
> +do
> +	test_fixup_reword_opt $opt
> +done

As I suspected earlier, a pathspec is not tested here, but it should
be.

> +test_expect_success '--fixup=reword: -F give error message' '
> +	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> +	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
> +	test_cmp expect actual
> +'

Why?  If you can use -m msg, you should be able to use -F msgfile,
too, no?

>  test_expect_success 'commit --squash works with -F' '
>  	commit_for_rebase_autosquash_setup &&

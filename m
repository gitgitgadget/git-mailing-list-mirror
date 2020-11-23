Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A7C388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEC8206B7
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNLtSdm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgKWWl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:41:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61665 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbgKWWl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:41:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3075993EEA;
        Mon, 23 Nov 2020 17:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V35ZFX/8s3Ta85+7CzEY9qG+t1c=; b=hNLtSd
        m1FKZokDjwpqYZdHlYOvy8tbG+bAJBmiSIFkJbbprz7Vg8fn+Q6Rc2oYUoCLjdxb
        Cs2+07Cuwq59JdaKvCwiGiDjWwdMrQeQItH0JTsxI1Z+h0O4bg5ZekPoeI31MicA
        qa7AY+zgrmxhrhHhbq/FbNyT1f4/VXlaVIDYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qwPtYh0E9DCDFT1avRIKNRHHEIN+trWz
        kfWMCk68B1Bf0STDx/ZGtbm8uqu/pJdKGRxt9GseSkGpRwsgB+Jw0W4I1koGeVkF
        vDGhGmwLU7v6CtwGCAWSvu5u1p7Vkz/kQAohRBOZwhSLhfpWz3AQn/1y/vXDw2nb
        RbLS4lsdl7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25A9893EE9;
        Mon, 23 Nov 2020 17:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4DB193EE7;
        Mon, 23 Nov 2020 17:41:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
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
        <20201123215122.GD499823@google.com>
Date:   Mon, 23 Nov 2020 14:41:54 -0800
In-Reply-To: <20201123215122.GD499823@google.com> (Emily Shaffer's message of
        "Mon, 23 Nov 2020 13:51:22 -0800")
Message-ID: <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16B58F70-2DDD-11EB-8462-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
>> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
> I'm not sure how to feel about this phrasing. I wonder if it would be
> clearer to say something like 'treat 'value_regex' as a literal string
> instead'? Hmmm.

Update the document and help text with s/value_regex/value_pattern/
and say "use value_pattern as a fixed string, not an extended regexp",
perhaps?

>   /* If set, ensure 'value_regex' was provided also */
>   if (fixed_value) {
>     ...
>     /* 'git config --unset-all <key> <value_regex>' */
>     case ACTION_UNSET_ALL:

Nice.

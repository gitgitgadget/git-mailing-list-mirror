Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6539C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B23722D5B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgLJGzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:55:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63152 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgLJGzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 01:55:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DC3C11407A;
        Thu, 10 Dec 2020 01:54:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GF0HTZsZNUNp7SvDypCNn4ssgBs=; b=XGM0h3
        wD9W2KM71V1oyiYn/1LSOuo5VvIw0/8gvBAcwG2ocn7bJwOWrYvDnJZdeNeUQle9
        IH6NTQ4V7FJ1SMEvbVolCAcGZubQ4d6c8seAiejGXvZIS4HpzZZGz2XQUB2oWBwW
        2Jn1hlT/WG2v0E2ZthhsW1AaRbv5r5TXoc9mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TA+JfFmLOL4T6Rotybh50hPSPhQs2Rza
        fmPQw0Fgd/F/l3xi8oNwbfMi5KMe3nOh5Bxpi+sp82MPbBmTadqz2riceyBQnKOc
        BpuEor7MO9xW3zUdSkfAH8p/fscY9QQ/t0sUXpM9JJoIm01KtLDWgK1k7B7n5H6K
        I2X1Bu0T9z4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15CB7114079;
        Thu, 10 Dec 2020 01:54:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 631D4114078;
        Thu, 10 Dec 2020 01:54:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
        <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
        <20201209185114.GN36751@google.com>
        <20201209191616.GO36751@google.com>
        <xmqqtusuzffv.fsf@gitster.c.googlers.com>
        <995da636-94bc-378b-83d0-ecce9d802b81@gmail.com>
Date:   Wed, 09 Dec 2020 22:54:18 -0800
In-Reply-To: <995da636-94bc-378b-83d0-ecce9d802b81@gmail.com> (Derrick
        Stolee's message of "Wed, 9 Dec 2020 20:52:36 -0500")
Message-ID: <xmqqtusuw3qd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8759753C-3AB4-11EB-869D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/9/2020 7:13 PM, Junio C Hamano wrote:
>> Josh Steadmon <steadmon@google.com> writes:
>> 
>>>  	# start registers the repo
>>> -	git config --get --global maintenance.repo "$(pwd)" &&
>>> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>> 
>> The rewrite makes it better than the original, but I wonder why the
>> original did not do a more obvious
>
> maintenance.repo is a multi-valued config setting, so it is possible
> that there are multiple existing values. Hence the reason for needing
> the value filter.

I do not quite get it.  You mean as long as $(pwd) appears, you do
not care what other value appear on the variable?  Aren't we control
of what repositories have been registered to the system at this point
in the test sequence?

It's not wrong per-se to use "does this value exist for the key?",
especially with the --fixed-value option.  It somehow just felt a
bit unusual to me.

In any case, thanks for the metacharacter fix.  That is now on
'master' so the previous breakages are all gone with Josh's fix.

Thanks, both.

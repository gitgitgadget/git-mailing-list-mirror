Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DF2C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B007613EA
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhDFA5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:57:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54918 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhDFA47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 20:56:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C89B28E0;
        Mon,  5 Apr 2021 20:56:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4mC/fmKXHdL1XbkhWDvG1Mno9dE=; b=dldykP
        v1DjN1q4pJKRvkPxF7AJj1CEyIqNqoVwj57gxwzs6sXj4irifPIRPS2v27KaqwQj
        lY0ffH4V8bNMs4vfbBd6f333jNzMVCjTJTnwEzVl8IaG3Jm+VFwmeqtYkVAKR4nF
        EXOVirXUlpAGxTe9guA9smYKW8Pi+akWPlKUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p6YQl3CU6LG9KS3JGitGoHNipdhnqSTu
        IuYmCvJcaZPjoFtPDP1ZEBShBLM6+k1uttc1haFVbAgpsHYAeiXNaKdgt2F9i5V8
        nZIBbH6IEQr+i1jDNRCgpLxB/SZ0HoCPRWbtJXSo4R95sVTdnYWkSz+0cgcl11Hx
        gfCl9GRU3Jw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51166B28DF;
        Mon,  5 Apr 2021 20:56:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99942B28DE;
        Mon,  5 Apr 2021 20:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v6] gitweb: redacted e-mail addresses feature.
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
        <xmqq5z19k9wu.fsf@gitster.g>
Date:   Mon, 05 Apr 2021 17:56:50 -0700
In-Reply-To: <xmqq5z19k9wu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Mar 2021 13:00:17 -0700")
Message-ID: <xmqq35w444dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F936ECBA-9672-11EB-A290-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>> Gitweb extracts content from the Git log and makes it accessible
>> over HTTP. As a result, e-mail addresses found in commits are
>> exposed to web crawlers and they may not respect robots.txt.
>> This can result in unsolicited messages.
>> ...
> Will queue as-is.  Input from those who are more adept at Perl
> and/or interested in helping polish gitweb are still welcome, but at
> my level of interest on the topic, this version looks as good as it
> gets ;-)

Comments by anybody who is more adept at Perl and/or more well
versed in gitweb and e-mail privacy issues?

Otherwise I am inclined to merge it down to 'next' as-is in a couple
of days.

Thanks.

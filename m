Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37FC433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE7B2065C
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGb6ddtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgG1Unp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:43:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62516 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1Unn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:43:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC8C783A5;
        Tue, 28 Jul 2020 16:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aZaxpmP7aCLyWLLvcIBbeRGv+G0=; b=oGb6dd
        tRBCrzbipSAvCi578zjQbeUhgzLOMOzodf1aJY+KqQlwae7xCyNw80K6ZFG7nXNB
        p0yCJKYhBnGRPfGGA4EAMOk33B3o6WarmS+36xVVjmArQtnyA1fOpH4p67WOsUNj
        8rmRcJtvfX/u0EF2x96wvEM7YhPN2ONQUAyfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GkzArQs9Y7bfBFk+cMEfoiw1Fvc7viU+
        xl7HbvPxElYHqYbiKA9tYbNesDw3iChxB1cutZjVkCHLRi3YmCDGPXhl0h7LYKCN
        wkJo/uELKRROJcDhomXGN+f1tcgr3gLhSexHvPSwyNm/cyQSmFY7l7BeFdnYli2G
        rvHywZrjmvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2C41783A4;
        Tue, 28 Jul 2020 16:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 378D4783A3;
        Tue, 28 Jul 2020 16:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/5] ref-filter: support different email formats
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
        <xmqqeeowfu75.fsf@gitster.c.googlers.com>
        <CA+CkUQ9nqW8=GuvNapsySf=EXm8c02qKV2xMrwvRY-Kd9Yy9mA@mail.gmail.com>
Date:   Tue, 28 Jul 2020 13:43:40 -0700
In-Reply-To: <CA+CkUQ9nqW8=GuvNapsySf=EXm8c02qKV2xMrwvRY-Kd9Yy9mA@mail.gmail.com>
        (Hariom verma's message of "Wed, 29 Jul 2020 02:01:53 +0530")
Message-ID: <xmqqzh7jcqv7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0557A99C-D113-11EA-A363-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

>> The ref-filter formatting language already knows many "colon plus
>> modifier" suffix like "refname:short" and "contents:body", but I do
>> not think we have ugly repetition like the above code to parse them.
>> Perhaps the addition for "email:<whatever>" can benefit from
>> studying and mimicking existing practices a bit more?
>>
>
> For "email:<whatever>",
> even If I parse that <whatever>. I still make comparison something like:
> ```
> if (!modifier)
>     email_option.option = EO_RAW;
> else if (!strcmp(modifier, "trim"))
>     email_option.option = EO_TRIM;
> else if (!strcmp(arg, "localpart"))
>     email_option.option = EO_LOCALPART;
> ```

Somebody needs to do a comparison, but it should be done at parsing
phase when the --format is grokked, not in grab phase that is run
for each and every ref to be shown.

These patches should only be done after looking at existing
"<basicatom>:<modifiers>" like "objectname:short" etc are handled,
not before, I think.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764DC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3E61AF0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhKSQtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:49:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhKSQtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:49:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3023C158404;
        Fri, 19 Nov 2021 11:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YdA85fUhW6vST//j7ZV8Upe2gsAyxfCbzw/oxG
        IoO38=; b=LZppOwkG8Vdcykv6oHP0lYM5tR/a125l/YmcNmIT/UP9HQPT6yru/A
        e9wWhNBlG1Uddn2Y++nHTopDAzPEwClRBhgeWEBeyF+BKLSXqxa4LHssrpH8FRli
        JSvwu3T2sNqXF3q9Uz4Hopa1wLeM8EVygpO4MUgVz/viH20I0H+AY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2806D158403;
        Fri, 19 Nov 2021 11:46:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79531158402;
        Fri, 19 Nov 2021 11:46:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
        <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com>
Date:   Fri, 19 Nov 2021 08:46:02 -0800
In-Reply-To: <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com> (Bagas Sanjaya's
        message of "Fri, 19 Nov 2021 17:33:35 +0700")
Message-ID: <xmqq35nsrt4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EF0AF1A-4958-11EC-88CD-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 18/11/21 17.50, Aleen via GitGitGadget wrote:
>> +test_expect_success 'still output error with --empty when meeting empty files' '
>> +	test_must_fail git am --empty=drop empty.patch 2>actual &&
>> +	echo Patch format detection failed. >expected &&
>> +	test_cmp expected actual
>> +'
>
> Why isn't the echo string quoted?

You may doing so without realizing, but such a "why does the code
not do X" question, especially without stating why you think the
code should do X, gets irritating quickly.

    I think it is better to quote the arguments to echo to make it a
    single string, because ...

would have helped the author of the patch.

If this were one-off, I would have let it go, but I thought it may
be worth commenting, as you seem to often ask this kind of
"questions".

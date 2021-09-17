Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8CFC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B17610A6
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbhIQQjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:39:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59190 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhIQQjM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:39:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20F7A15FD7A;
        Fri, 17 Sep 2021 12:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWqqjmUuUEKU91GxGxuHzB5ZmPzi4j8yAQH06Z
        xwzQ0=; b=BytIDxUWjDH6XFTYtt+TxFcdGqFamwdJiy2vw+TfRqaUI4EzqYbeSC
        1vgDX90MtZyn84YOzFfRgKgFUQpnWg9w/u2MWezRWxw73T7u5fx5i6EZZoywKtXc
        Jn04zwalWnM8ItDtf7m9i5BkPsUH28aC9227S14Mnh0X8xCDvwRpA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 190CC15FD79;
        Fri, 17 Sep 2021 12:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D6F015FD77;
        Fri, 17 Sep 2021 12:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Ryan Anderson <ryan@michonline.com>, vmiklos@frugalware.org,
        bedhanger@gmx.de
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
References: <20210916113516.76445-1-bagasdotme@gmail.com>
        <20210916113516.76445-3-bagasdotme@gmail.com>
        <YUNKIj44AlW0tkXk@danh.dev> <xmqqbl4stg91.fsf@gitster.g>
        <187b4b89-e037-6103-08f4-870ce8f1e4fd@gmail.com>
Date:   Fri, 17 Sep 2021 09:37:46 -0700
In-Reply-To: <187b4b89-e037-6103-08f4-870ce8f1e4fd@gmail.com> (Bagas Sanjaya's
        message of "Fri, 17 Sep 2021 14:41:56 +0700")
Message-ID: <xmqq7dffi2ed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97494BC6-17D5-11EC-8465-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 17/09/21 03.30, Junio C Hamano wrote:
>> So a good middle ground may be
>>   - allow translation, like these patches attempt
>>   - introduce the command line option "--l10n=<value>" and
>>     the requestpull.l10n configuration variable that gives the
>>     default for the option:
>>     - when it is set to 'true', end-user's local taken from the
>>       environment is used as the target for translation.
>>     - when it is set to 'false', translation is turned off.
>>     - when it is set to any other value, the locale is set to the
>>       value of that variable (imagine a Japanese developer
>>       contributing to a German project).
>> perhaps?   I dunno.
>> 
>
> I'm leaning towards second option.

I didn't give that many options for there to exist the second one,
though ;-)

> However, I proposed that --l10n and corresponding config
> requestpull.l10n just take locale value set, and defaults to English 
> (en_US or C) if empty.

I do not quite see merit in that tweak over what I outlined before,
though.

But all of the above depends on the assumption that it is a good use
of our engineering bandwidth to make request-pull localizable, and
more importantly if the "C locale is much more appropriate than the
local one when it comes to request-pull" is important enough to make
it behave quite differently from other subcommands in our toolbox.

To put it differently, my "I dunno" above still stands---I am not
sure if that is a _good_ middle ground, even though it is a middle
ground.

Thanks.

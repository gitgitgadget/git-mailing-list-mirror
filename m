Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF54C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0999260E97
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhJYQ6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:58:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61141 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhJYQ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:58:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19AAEF786E;
        Mon, 25 Oct 2021 12:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ETHdnDNWN09X5yaYRPDJT86aM75vM9rtUTA8KJ
        RooeU=; b=QQv30QuA9PG9QPWUXeWLFU+93iMYTzri6kSLrH0t8FvSMr9wfnprw0
        bNc6ARyi1nF/RO7BvwTFwT5Dv9zen34CB6a0xE3VpwAAcXUGNDKmYMNacX6EcKwv
        4t+TcFpjN0NKwpZhZQLNgw7gaVIJxR/4wShANjGankQVplZTFiWBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1132DF786D;
        Mon, 25 Oct 2021 12:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75B3DF786C;
        Mon, 25 Oct 2021 12:56:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
        <006c186e-c005-28a3-7a5c-27d365ffe026@gigacodes.de>
        <xmqqilxl2gpj.fsf@gitster.g>
Date:   Mon, 25 Oct 2021 09:56:10 -0700
In-Reply-To: <xmqqilxl2gpj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Oct 2021 09:48:40 -0700")
Message-ID: <xmqqee892gd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7500D000-35B4-11EC-A493-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> @@ -260,8 +281,8 @@ or include any extra files which do not relate to what your patch
>>>  is trying to achieve. Make sure to review
>>>  your patch after generating it, to ensure accuracy.  Before
>>>  sending out, please make sure it cleanly applies to the `master`
>>> -branch head.  If you are preparing a work based on "next" branch,
>>> -that is fine, but please mark it as such.
>>> +branch head.  If you are preparing a work based on selected topics
>>> +merged to `master`, please mark your patch as such.
>>
>> I think this meant to say 'merged to "next|maint|seen"'?
>> Or topics selected for being merged into master?
>
> Ah, thanks for catching.  I meant "not merged to 'master'" (will fix
> locally).

Sorry, should have re-read it more carefully.  The original text
is saying what I wanted to say, but I misread it ;-)

We earlier in the document said that there are three possible bases;
fixes are usually based on 'maint', new features on 'master', but as
an exception, if your new feature need to depend on something not
yet in 'master', then you start a branch from 'master', merge
selected topics into that branch, and use the resulting branch as
the 'base' of your topic.  We do not want a new topic based on
'next', so preparing such a synthetic base by starting from 'next'
and merging topics that are not yet in 'next' is unwelcome.

Perhaps there needs some rewording to clarify that the sentence is
referring to that case.

Thanks again.

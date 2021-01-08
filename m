Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB85C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451423A9D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAHVf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:35:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63921 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHVf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 16:35:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0169DB3431;
        Fri,  8 Jan 2021 16:35:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LJryM+AcoOJfCjUgGsGupBjD+/I=; b=lHns4V
        QzIwL21nK3OQ14akGQjjuKRDizUrjoNJfhBCmKQkGmwqmRXO/2rjc4buXiwIHQgi
        RzQ6d4/P8mvKxz7qbHXwBvyLCFq5bj702I5TcffJhHXB20BjjqynZ9l5nJbyKQLu
        19f8OQN2ylLdM428v9Pcdyl7Im5hZ1+HvWS5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/houhe1zLLsbocjcCbZIEzBTvc5bpjk
        hFb/MLtsgz9f792Zukqnu/yebal/aE5VO6PPrYoVo8kVbCxiSpQGs5FjBuzMdURW
        pT4mkSeg/CAmPpY2Uob1rGOOEOZP+vfw+SjHVvoY7JDrMikDSLHoBV+QQZZj1Uay
        J1zyxRi7K4s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED631B3430;
        Fri,  8 Jan 2021 16:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 727E8B342F;
        Fri,  8 Jan 2021 16:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: What's cooking in git.git (Jan 2021, #01; Wed, 6)
References: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
        <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
        <xmqqpn2glcms.fsf@gitster.c.googlers.com>
Date:   Fri, 08 Jan 2021 13:35:13 -0800
In-Reply-To: <xmqqpn2glcms.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 07 Jan 2021 12:23:39 -0800")
Message-ID: <xmqqwnwnglim.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64CDCFA2-51F9-11EB-9233-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> * en/diffcore-rename (2021-01-04) 9 commits
>>>  - diffcore-rename: remove unnecessary duplicate entry checks
>>>  - diffcore-rename: accelerate rename_dst setup
>>>  - diffcore-rename: simplify and accelerate register_rename_src()
>>>  - t4058: explore duplicate tree entry handling in a bit more detail
>>>  - t4058: add more tests and documentation for duplicate tree entry handling
>>>  - diffcore-rename: reduce jumpiness in progress counters
>>>  - diffcore-rename: simplify limit check
>>>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
>>>  - diffcore-rename: rename num_create to num_destinations
>>>
>>>  File-level rename detection updates.
>>
>> I'm curious again about your workflow and the meanings of your
>> messages.  Here, I'm surprised by the change in date; in [2] you
>> listed it as 2020-12-14.  Do you update the dates when you pull in new
>> versions of the patch series?
>
> These record the committer dates, which is much closer to the date
> the version of the patches were exposed to public testing for the
> first time, and probably is more appropriate than the author date to
> use to judge how long each topic has been "cooked".
>
>> Anyway, I'm not aware of any outstanding requests for this series; I
>> think it's ready to start merging down.  Are there issues you are
>> aware of that you want to see fixed?
>
> Again, just getting overlooked and nobody bothered to ping the
> topic; also I haven't had chance to give these patches serious
> enough reading they deserve yet.

FWIW, I marked the topic to be merged to 'next' after giving this
series a scan and liking it.  I admit that I didn't give too much
tought to the last two steps, though.

Thanks.



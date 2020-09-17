Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E74C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793432078D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZTJWN0na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgIQQgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:36:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61364 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgIQQgo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 12:36:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1A3186643;
        Thu, 17 Sep 2020 12:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BprWYTv+H98yIJVK8FcmHJ/igxs=; b=ZTJWN0
        naHpM+sVioJzSM21mwtEswNW6fP1IPsumr9fiJXcdHKgP4oqnosR9rr97obGNg1G
        kUNXvxV7VA0IE9jN4x6cHAEna8iz8CJfACgKsW4y7r9pxNZ58A9Ws4ujJcw3hbwO
        j2OwXZM7MjI4KHqtTD15ku5f9wp+1vqsuFUC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ISG3moj54w/EcfpbE2Gmr5q9DoJDpO7v
        A0dzlsFke+dNA7HX+61SBUjtsUx/JZLo5623sropSkiHn/2OsoiAX28z4A4psGIR
        DUWLOHKX3UiDW25MBmMe+xzjn1cU3fu2wCSvq2L8m9Q6JHkOftI2sUl43DZ9fL9s
        SDy92nX+yoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5D4D86642;
        Thu, 17 Sep 2020 12:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FC1686641;
        Thu, 17 Sep 2020 12:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/maintenance-part-1 (was Re: What's cooking in git.git (Sep
 2020, #04; Wed, 16))
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
        <39e940da-c8ee-9371-84e3-1bedbe86bf5b@gmail.com>
Date:   Thu, 17 Sep 2020 09:36:05 -0700
In-Reply-To: <39e940da-c8ee-9371-84e3-1bedbe86bf5b@gmail.com> (Derrick
        Stolee's message of "Thu, 17 Sep 2020 08:54:30 -0400")
Message-ID: <xmqqo8m4s6mi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2472F68-F903-11EA-9338-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> This message [1] includes a simple forward-fix for the
> parsing logic. I mention a re-roll in my preface, but
> I was talking about a potential re-roll of part-3 when
> that gets more feedback.
>
> My hope was that the quick fix could be applied directly
> on top of this branch and then cook in next as planned.
> I'll accept a delay if you think that is merited, but "on
> hold" just seems like you are waiting for something more
> from me.

I was expecting [1] to be corrected in the commit in the series
before it hits 'next', not a "oops we screwed up earlier so here is
a band-aid on top", which we must do after the topic is already in
'next' or 'master', and also hoping that it would happen quickly so
that we can move it forward.

Thanks.

> [1] https://lore.kernel.org/git/0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com/

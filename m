Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807CDC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495AC22463
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nz0az/+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKTExC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:53:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58251 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfKTExC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 23:53:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D59AEA3233;
        Tue, 19 Nov 2019 23:53:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G7urcq3jECgO23kHpnnuO9mPCVU=; b=Nz0az/
        +lqCnVAQoUwD6fei5HgMPItOjp79OYTIdH4zY90BW9wz7kpF5aVTrT6Bn6bTPOAo
        yH7AMSeK2fMUif5216RaAhJAI3DuXNQdo1mYRj3NhVEj277sfcOE53RAh+k5Jl9g
        K+3NvFoFOLB5PxjafgNBw0tf8G/aNIs23SIrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DyWNmF0I9mLyXNmMVNs2tEm8FUnG0KUh
        57jAgxa2FAfBzfGW0Bu11ODYI5zOnEVK1yolyjOaS8vuwHdyO34C4A8pE+LSsJ2L
        GRFtQ/ZD26U9uarfpJVkvK6MId7eIPQfjas7BNrvUfDYogz2t4KM3Awi7J50BVo4
        Uv4haVMCS2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEF72A3232;
        Tue, 19 Nov 2019 23:53:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F372BA322E;
        Tue, 19 Nov 2019 23:52:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: none
References: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
Date:   Wed, 20 Nov 2019 13:52:56 +0900
In-Reply-To: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 19 Nov 2019 19:49:17 -0800")
Message-ID: <xmqqsgmjb13r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FD671DE-0B51-11EA-8CE7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I spent the last few weeks cobbling together an implementation of the
> reftable format in C and in Go. I thought this would be cool to add to
> git-core, but I doubt whether I will have enough time to see such an
> effort through. Maybe some of you would want to try integrating it
> into the Git-core code base?  Example code is here:
>
>   https://github.com/google/reftable/blob/master/c/api.h#L153
>
> cheers!

My initial impression was that the API overuses typedef.  We tend to
avoid doing

	struct _foo { ... };
	typedef struct _foo foo;

and instead write "struct foo" explicitly to make us well aware of
what we are talking about.  That lets us see that we are passing or
returning a structure by value (which we would like authors to think
thrice before doing in C) like so quite easily:

	foo some_function(foo arg1, ...) { ... }

because it would be clear if it were written like so

	struct foo some_function(struct foo arg1, ...) { ... }

without hiding the structure behind a typedef (it also lets us avoid
names with leading underscore, which is frowned upon by some people
for different reasons).

But the set of operations defined in the header file seemed at the
right granularity in order to interface with the refs.h & refs/* API
we have.  It however was unclear to me how transactional ref updates
would work with it.

Thanks.

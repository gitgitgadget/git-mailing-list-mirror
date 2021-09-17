Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98DC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AAF60FED
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhIQUzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:55:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50368 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbhIQUzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 16:55:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91011F7C8D;
        Fri, 17 Sep 2021 16:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J/U6kZacWs9vtwh7yfgxSNeoYogTTnRH5GxSnw
        4WiS0=; b=mGC9CuvNbCjxlfpRkWnwgOrJ3GVlphg1yjx9zyqaJ/u5YR5KC95sWq
        GOusCYW3jH5Raj0T4Y5r3vR1RCQGYB37VV4skMbv5f8OoFqcufg/uBtILn/OLJYK
        3ZIJODSrpfGr4aUbLRBTa3bPBUmwG2nlLdwjjzXrXVp79jPcZDd/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89180F7C8C;
        Fri, 17 Sep 2021 16:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 011B7F7C8B;
        Fri, 17 Sep 2021 16:53:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     gitmailinglist.bentolor@xoxy.net, git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
        <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
Date:   Fri, 17 Sep 2021 13:53:52 -0700
In-Reply-To: <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 17 Sep 2021 11:20:14 -0700")
Message-ID: <xmqq4kaihqjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E6E9C88-17F9-11EC-B128-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, Sep 17, 2021 at 7:12 AM <gitmailinglist.bentolor@xoxy.net> wrote:
>>
>> A SO commenter pointed out, that git-check-ref-format forbids @ and
>> maybe I should report this as a potential bug. Is it?
>
> a reference that is named "@" only is invalid, but refs/tags/@ is not.

;-)  

"git check-ref-format master ; echo $?" would show that any single
level name is "forbidden", so probably the SO commenter (whatever
that is) was confused---it is not about @ at all.

In any case, a tag whose name is @ may be another source of
confusion in the modern world, after we added @ as a synonym to
HEAD.  I do not know, for example, offhand which between the HEAD or
that tag "git show @" would choose.  It makes sense to avoid it.

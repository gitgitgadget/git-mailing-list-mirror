Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37B4202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdJXCW6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:22:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62579 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751286AbdJXCW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:22:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FA0D965F8;
        Mon, 23 Oct 2017 22:22:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xhsrzUZyjsq+7vC8kCS4OyH4ZZY=; b=ngceeg
        /qMjayK8CBCHitI9Ny6Kj/G6rHoiHhHcJ4D94wz0zBYk3X0weQWznGLdXY64266D
        mFfzuY7owuLILxcBB6w/vMN/TzQeiRJpYz6oSl0COulccC/wKcKP9kWqj3nhtP/m
        GAWtExKsZkZRTkN4XG5ggdkIBV+unZ4AxD/e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xe7hRCnAMZaZNM1PBML00aOJgY9MtU6Z
        VMISIljGoLdHjHcq1B0+79ok83TME0vjw6yOJrmKzq2VUtJ6auS5iw84K5CtXwv7
        L7ROL34757/vFwfrXMVkDoOiqyfvbHfqllMZfcuvcJBsUgWmrdiCdztxw3iLKTvF
        UMJkR/u0xbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37EFF965F7;
        Mon, 23 Oct 2017 22:22:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90604965F1;
        Mon, 23 Oct 2017 22:22:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH v2 0/5] Coping with unrecognized ssh wrapper scripts in GIT_SSH
References: <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <20171023151929.67165aea67353e5c24a15229@google.com>
        <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
        <20171023225106.GA73667@google.com>
        <20171023155713.5055125d7467d8daaee42e32@google.com>
        <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
Date:   Tue, 24 Oct 2017 11:22:54 +0900
In-Reply-To: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 23 Oct 2017 16:16:25 -0700")
Message-ID: <xmqq1slt9tdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EB9976C-B862-11E7-896D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>>> On 10/23, Jonathan Nieder wrote:
>
>>>> If this looks good, I can reroll in a moment.
>>
>> Yes, this looks good.
>
> Thanks.  Here goes.
>
> The interdiff is upthread.  Thanks, all, for the quick review.
>
> Jonathan Nieder (5):
>   connect: split git:// setup into a separate function
>   connect: split ssh command line options into separate function
>   ssh: 'auto' variant to select between 'ssh' and 'simple'
>   ssh: 'simple' variant does not support -4/-6
>   ssh: 'simple' variant does not support --port

These looked mostly good. I left some nitpicks on individual
patches.


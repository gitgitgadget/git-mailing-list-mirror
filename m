Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329EA1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFQRbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 13:31:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65445 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 13:31:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D51541580D3;
        Mon, 17 Jun 2019 13:31:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IiyIiSCR42ZlbfKgj0S+9yZ0G/Q=; b=BBY5ez
        SDl2EcnjtkfkEZHeWKo0BecUFmsxueMI9a1p6LJr8L6KbLhEA/Q7r4neA/rys0HC
        sQpMg/z1g6TF07eACw4IEzRXX4ancjUmIRv/kuLHLzy04++F8sDoTLqnnPEqKjbr
        6DzAwSnWpL0rseZiF1yxIe/gj/YXs0xhK2FwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xDwjIVTmb3cLk66DqagmU8qHEVdu/Rhk
        fRV1EpaKs5uWWNEuzvQhIRYbvr47KFrBXlDi6D7RAchYsONoLiluYMpbl6xaOETq
        p+DFzyO4229+NZ0+dJaMpoGzNao/8rF/ee59pwjQoUqM/CbUaoXp+6Z+4iXVQa9g
        40IzHn8ip50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC9001580D1;
        Mon, 17 Jun 2019 13:31:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33F1B1580D0;
        Mon, 17 Jun 2019 13:31:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other than '#'
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
        <20190614150758.GA22984@sigill.intra.peff.net>
        <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
        <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
        <CAP8UFD3_kKvBs=rMvBp-K-UPD5mCqVsHRZ1VqGYY7uR8G+H8SQ@mail.gmail.com>
Date:   Mon, 17 Jun 2019 10:31:45 -0700
In-Reply-To: <CAP8UFD3_kKvBs=rMvBp-K-UPD5mCqVsHRZ1VqGYY7uR8G+H8SQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 17 Jun 2019 07:03:29 +0200")
Message-ID: <xmqqtvcoruda.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8543D18-9125-11E9-BB6E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jun 17, 2019 at 6:33 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> On Sat, Jun 15, 2019 at 5:41 PM Christian Couder
>> <christian.couder@gmail.com> wrote:
>> >
>> > > I do wonder if the trailer code is correct to always respect it, though.
>> > > For example, in "git log" output we'd expect to see commit messages from
>> > > people with all sorts of config. I suppose the point is that their
>> > > comment characters wouldn't make it into the commit object at all, so
>> > > the right answer there is probably not to look for comment characters at
>> > > all.
>> >
>> > Would you suggest an option, maybe called `--ignore-comments` to ignore them?
>>
>> Since 'git interpret-trailers' already ignores lines starting with '#',
>> is this option true by default?
>
> Sorry, I should have suggested something called --unstrip-comments or
> --ignore-comment-char that would make 'git interpret-trailers' stop
> stripping lines that start with the comment character.

So, to summarize:

 - As the traditional behaviour is to strip comment, using the
   hardcoded definition of the comment char, i.e. '#', we do not
   switch the default.  Instead, a new command line option makes
   it pretend there is no comment char and nothing get stripped.

 - But the core.commentchar that does not override hardcoded
   definition is a bug, so we'd fix that along the lines of what
   Peff's patch outlined.

Anybody volunteering to do the honors?

Thanks.


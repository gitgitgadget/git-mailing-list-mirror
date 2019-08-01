Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461031F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfHAVqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:46:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64313 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHAVqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:46:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDE5D16639E;
        Thu,  1 Aug 2019 17:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I+clIJcicOvhwUpG2t8DBdYCn00=; b=UFMMrj
        QyMagGf2bPPcTvXbjhtcNIUMlqTJQT34jgr6YLEtp3l62vtsj2YnRznfK5V5HfYi
        GCfpRHJPwOBh6AO3Qr2JZgrm3MEHFZ/KoV21ILqZcSm31bzauD3qQK9jTqOYpsUs
        /bt3JYcCeAizeDLUwU6eLdZtC3vtAJRu5zRHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aYpGO29NmMWnXxIe8vlCp+RUST7FmOBJ
        3sYgBe27JZP0ac9VvpDYcdVaRAo9gKnPqhCAUuHKpE8Y3hgVYww7khLBe8gUVAQQ
        aNKPgmeiMdZIqHxywJRW5j+nvs4z2862hAT4wYMBuxrVd0LtKp28HBx2Ds033zNH
        sHj+OVYMi1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4D9616639D;
        Thu,  1 Aug 2019 17:46:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4699C16639C;
        Thu,  1 Aug 2019 17:46:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
        <20190731231848.GC1933@sigill.intra.peff.net>
        <20190801002125.GA176307@google.com>
        <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
        <20190801213638.GA30522@sigill.intra.peff.net>
Date:   Thu, 01 Aug 2019 14:46:29 -0700
In-Reply-To: <20190801213638.GA30522@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 1 Aug 2019 17:36:39 -0400")
Message-ID: <xmqqa7csmudm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D257C5D4-B4A5-11E9-B673-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	if (mailmap < 0)
>>  		mailmap = 0;
>> -	}
>
> This should be "mailmap = 1" to match the commit message, no? (Which
> also implies we may want a new test).

Gaa, of course.

> I'd also be OK with leaving it at "0" for now, making a note of the
> upcoming change in the release notes, and flipping it _next_ time. But
> IMHO we don't need to be that conservative (and I share your pessimism
> that enough people actually read the release notes to merit that kind of
> advance notice).

I'd actually think s/need to be/get any benefit from being/; it
would be wasted effort to be extra careful, and any way we cut it,
there will always be people who complain.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA941F462
	for <e@80x24.org>; Mon, 10 Jun 2019 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfFJQ3T (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 12:29:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55968 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfFJQ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 12:29:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D222161A6D;
        Mon, 10 Jun 2019 12:29:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MuJjtwr09safWQLZ22tWCv/hZY8=; b=bS3zUI
        EIgUdrrMwHljD2kyj1Qzbp60+p0AJw8zw0ROFx3EuBNOnImtSmk/pgtWJZU2+apV
        YeRnsg9lfR+7Qr97FMZ2gbr3M/8go2vBav2RHY/JH0dIxxlRADvWeQn0aG4qFka7
        b2fLUvqLDLutVj30DkIH+3p3kZjM3gZEN3gQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ab3Z3m0r7BwTGfnDcOnHG9G+qcU3iSCM
        C/y+5OgzwrqusJe0TR/xxq5/cV3jm+7SCbmveYJ/dzWzFjG0QIO2puUhgZwNJv36
        KO89tprVZT02i4QPaCmHTOddasmJ4BYXjZdpUg1ewtVOsr0ZKTCak7tTQVXtWvQl
        8GFiDNwXANM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 750FA161A6C;
        Mon, 10 Jun 2019 12:29:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98A98161A6A;
        Mon, 10 Jun 2019 12:29:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
References: <20190607225900.89299-1-emilyshaffer@google.com>
        <20190609130004.GB23555@sigill.intra.peff.net>
Date:   Mon, 10 Jun 2019 09:29:14 -0700
In-Reply-To: <20190609130004.GB23555@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 9 Jun 2019 09:00:04 -0400")
Message-ID: <xmqqsgsho145.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E350E2D0-8B9C-11E9-ABDD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Your patch only helps with this at all because you're using the "tree:1"
> ...
> because there you'll have actual names which cat-file will choke on. So
> it seems like this is helping only a very limited use case.
> ...
> Alternatively, it would be reasonable to me to have an option for
> "rev-list --objects" to have an option to suppress the filename (and
> space) entirely.

Yup, I think that is a more reasonable short-term change compared to
the patch being discussed, and ...

> I think in the longer run along those lines that "--objects" should
> allow cat-file style pretty-print formats, which would eliminate the
> need to pipe to cat-file in the first place. That makes this parsing
> problem go away entirely, and it's way more efficient to boot (rev-list
> already knows the types!).

... of course this makes tons of sense.

Thanks.

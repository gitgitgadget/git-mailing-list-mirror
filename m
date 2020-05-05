Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F8C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701E4206C0
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9JGlaj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgEEAYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:24:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52093 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgEEAYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:24:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BE60DDE84;
        Mon,  4 May 2020 20:24:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mdn6IjlrKPT9HWhZuTxDZCXPIu4=; b=C9JGla
        j3ZLe2WtzKseiKHIOrI2jQq8kq7WO4jT2xdF5R9v369xgqinp7pF2YIgWDeOB6ip
        Hn7VygpORbd/L+GF1r0bSatMX7KaUmX8I4E6qeYz6QGrFJLwgBdi9RJ9DnN1PDDQ
        sa7E1Et8oj3xn9CM8kAkKEu67LFusF+3OTjl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IP9sAy77JFJYp8SpFEA6cfP2cm9tSz8U
        zxi7NnGiqjhESutwjl+I5Qzr7KYn+242rWlBSjpQtTOfZ6LC1k/NIwMBB3Gosgcq
        jB39ZS3mqgXqIjBnC7m1fDxChIrM6QOjkwqwRyRbE7l5x1hY/rPzMHYu+XwUR/DG
        CEBrw3S1MRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63521DDE83;
        Mon,  4 May 2020 20:24:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD2F2DDE82;
        Mon,  4 May 2020 20:24:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <xmqqzhane2ir.fsf@gitster.c.googlers.com>
        <20200504231544.GJ45250@syl.local>
        <20200504233512.GA39798@coredump.intra.peff.net>
Date:   Mon, 04 May 2020 17:24:39 -0700
In-Reply-To: <20200504233512.GA39798@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 4 May 2020 19:35:12 -0400")
Message-ID: <xmqqv9lbcjp4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D017B482-8E66-11EA-B4F8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 04, 2020 at 05:15:44PM -0600, Taylor Blau wrote:
>
>> > If this is only a reaction to what I said earlier (i.e. "building
>> > everything in github.com/gitster/git/ has no value to me"), then I
>> > suspect it may be an over-engineered solution to a problem that does
>> > not exist, and harms people like you.  I could just go there and
>> > turn off GitHub Actions for that repository instead.
>> 
>> It is a reaction to that, yes. It would be nice to have a middle-ground
>> where you can run Actions on the official integration branches, but
>> contributors such as myself run Actions on *every* branch of their fork.
>
> The problem is that there is no way for people to _not_ run on every
> branch of their fork, then. It is either every branch or no branches.

OK.

> .... I don't like it, but I don't see any other way to let people
> choose some branches but not others (that doesn't involve a one-line
> yaml change at the beginning of every branch, which is an even higher
> burden).

True, and having to mark a commit object with "do not run CI on this",
which is what I heard Travis does, is even worse.


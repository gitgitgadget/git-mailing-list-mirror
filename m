Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0230F1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbcHITTu (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 15:19:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932207AbcHITTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 15:19:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A27EB34319;
	Tue,  9 Aug 2016 15:19:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TlzoOFLwFMPRUkGK75ergxSr//o=; b=kbt5Uw
	ws2s+eUVH2whHyxpvDn1UrIYEnAD33DeivDl+XpGCvTYI6hXEYKm3NL6Gef+cdTS
	GHZpoZNm2lwtXfCqjxr3cYLf5Zt2BDGFcTI4iVaL2AaYBSlfa2e8P+DIkYEBUdJB
	1rPW1or3FddjL427YZJZGbhZt6OUgR/q5XsPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DteeMoC9tbzsn79VSu/lNvXXHBsJ3ZXb
	K0NDCMmmHaeeAkRe+u2JOMYy77mGdSD7ceXyDXQ1y/c8waNK6rlVJaKfI9wF5xnZ
	PkoVbnTMVKRyCVkEDBPfcdtKaD5kfef0BV00btApITGYXeXP/3/scet1Iwa4Z7eO
	qaCbM2dKGjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98BC234318;
	Tue,  9 Aug 2016 15:19:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E2AA34317;
	Tue,  9 Aug 2016 15:19:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
	<xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
	<3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
	<20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
	<xmqqh9atc0do.fsf@gitster.mtv.corp.google.com>
	<20160809175018.p3bwnqjwz44t2xnb@sigill.intra.peff.net>
Date:	Tue, 09 Aug 2016 12:19:43 -0700
In-Reply-To: <20160809175018.p3bwnqjwz44t2xnb@sigill.intra.peff.net> (Jeff
	King's message of "Tue, 9 Aug 2016 13:50:18 -0400")
Message-ID: <xmqqziol92cw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BA8B3C0-5E66-11E6-905A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 09, 2016 at 10:34:11AM -0700, Junio C Hamano wrote:
>
>> It may be a good UI that is optimized for drive-by contributors.  It
>> is just that it is not very well suited (compared to mailing list
>> discussions) to conduct high-volume exchange of ideas and changes
>> efficiently.
>
> I think that's something to ponder; can we have a workflow where
> drive-by contributors can use something that has a lower learning/setup
> curve, but long-term contributors might opt for something more powerful?
>
> I think SubmitGit is a step in that direction.

Yes, agreed 100% with that.  The author of the tool must be praised
by getting added to the Cc: line in this discussion ;-)

> It does still require
> switching to the mailing list for subsequent conversation, though. It
> would be interesting to see something like SubmitGit that puts its own
> email in the "From", and that processes email replies into PR comments,
> and then subsequent PR comments into emails (i.e., part of my "dream tool"
> from earlier). It's not clear to me whether the result would just end up
> being irritating for both sides to use (because it doesn't _quite_
> conform to the norms of each format). But it would be fun to find out.

Perhaps.  I do not know if I like that second and subsequent steps
for SubmitGit, but its first step as currently deployed I am very
happy with.


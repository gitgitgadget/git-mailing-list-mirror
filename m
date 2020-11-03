Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A0C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C723721D91
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tNx3iz3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgKCRfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:35:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60526 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgKCRfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:35:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB401E32F8;
        Tue,  3 Nov 2020 12:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LRqExUWtuSDPo2L+c99EDlUbduU=; b=tNx3iz
        3stf/zuTcIEIoEwaIb5uSUi2tuSnWXCvcLqS0g0SfxnpIaJMrqoOxeBcOQt2K1QA
        1QAIXmtJTH5Rcspy8kcq5UDrT81/Dem4aaZ7UKGH3Mn6EpFAvL4/76ktLuOfV7pr
        70qjU7tFWMn6tgLdSufSBKpvFN1h/hrods/YU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G6zcAOqzoT5qvvvPhCcd5T98uQj6dc2w
        iE34E2BkS/TJoDsQ9oWNuvnWwjSZAZRPYg3yMPcTNjyxsEBlzcgUHeX6wjgx2+cX
        bpQCbb9fy+Fkx0WXAzc3sTC4bmPtu3fOxwkHDcl6f9FLDSF+tlIT/Fc7R/ZqD0Qt
        roKU+POn7XU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D21CAE32F6;
        Tue,  3 Nov 2020 12:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D502E32F4;
        Tue,  3 Nov 2020 12:35:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/4] Doc: push with --base
References: <cover.1604362701.git.jonathantanmy@google.com>
        <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
        <20201103053554.GC948115@google.com>
        <20201103151859.GA444466@coredump.intra.peff.net>
Date:   Tue, 03 Nov 2020 09:35:39 -0800
In-Reply-To: <20201103151859.GA444466@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Nov 2020 10:18:59 -0500")
Message-ID: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE5B8F98-1DFA-11EB-B982-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 02, 2020 at 09:35:54PM -0800, Jonathan Nieder wrote:
>
>> I think you're saying that we don't need a "push" v2 because v0
>> already has what a user would want.
>> 
>> Git protocol v2 for fetch brought two major changes:
>> 
>> - it changed the response for the initial request, allowing
>>   abbreviating the ref advertisement at last
>> 
>> - it defined a structure for requests and responses, simplifying the
>>   addition of later protocol improvements.  In particular, because the
>>   initial response is a capability advertisement, it allows changing
>>   the ref advertisement format more in the future.
>> 
>> Both of those changes would be valuable for push.  The ref
>> advertisements are large, and matching the structure of commands used
>> by fetchv2 would make debugging easier.
>> 
>> There are some specific applications I'm interested in after that
>> (e.g., pushing symrefs), but the fundamental extensibility improvement
>> is larger than any particular application I could think of.
>
> You pretty much summed up what I was going to respond. :)
>
> But I'd go further here...
>
>> That said, I'm not against experimenting with extra parameters before
>> we go there, as a way of getting more information about what a
>> workable negotiation for push looks like.
>
> I'd prefer to avoid doing this as an extra parameter for a few reasons:
>
>   - once it's in a released version, it's much harder for us to take it
>     away
>
>   - the extra parameters area is a hack that helped us bootstrap v2. We
>     could probably use the same hack to bootstrap v3, etc. But it has
>     limitations for stuffing in arbitrary data. An obvious one is size.
>     We can transmit a single base, but would be limited if we wanted to
>     be able to send multiple. We already ran into this once with the
>     "symref=foo:bar" capability overflowing pkt-line limits. Here I'm
>     not even sure what the limits might be (it's subject to things like
>     how big an HTTP header a proxy will pass, or how large an
>     environment variable an ssh implementation supports)
>
>   - it potentially pushes more data/work outside of the git protocol
>     itself. E.g., web servers have to translate Git-Protocol headers
>     into the GIT_PROTOCOL environment for v2. I guess this new field
>     works in our tests because we copy the header's value entirely in
>     our apache.conf. But I wonder how many systems in the wild may only
>     work if it contains "version=2".

I do not have much to add to what has been said so far, other than
offering historical perspective.

The single biggest reason why "fetch" has common ancestor discovery
negotiation and "push" does not is because the design comes from the
use case the inventor of Git and those worked on the early protocol
wanted to support---you are pushing into your own repository you
alone push into, your work is disseminated to others who fetch from
your repository, and you get others' work by fetching from theirs.

In such a world without a central server where everybody pushes
into, by definition, a pusher knows all the objects that have ever
been pushed into the receiving repository when running "git push".
They are all objects that passed through the repository you are
pushing from to the receiving repository in your previous pushes.
The advertised ref(s) are expected to be known to the repository you
are pusing from anyway, and if that is not the case, you would first
fetch from there before force-pushing.

Hence, when you push, there isn't much need to walk back from the
tip of refs at the remote to discover common ancestor like we do for
the fetch side in pre-central-server world.

On the other hand, you expect that remote refs point at objects
unknown to you when you fetch from your colleagues, so it is
expected that you have to perform the common ancestor discovery
negotiation.

After 15 years, we live in a different world.

People expect that a single repository at their hosting sites can be
used as the central meeting point for the project, just like CVS/SVN
servers were in older world.  "git push" would need to accept that
reality and start common ancestor discovery eventually.

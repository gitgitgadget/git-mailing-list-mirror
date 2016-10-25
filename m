Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DDE2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbcJYSll (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:41:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52326 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932538AbcJYSlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:41:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D4074777F;
        Tue, 25 Oct 2016 14:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nt0g8E8YPps0QcnYpbmLE9hrhBo=; b=wYk3cQ
        c8nZ/mQg/O3sNF/8jJvv2LKGBTbGPPAsuV5rQixIKOwhIAk9k9tSgpCkMTnNctaN
        xm6HJKThCSwIFgW6moe/1HMtcV14NRXx5EaSh6YP0lVEvi1PGsYxKUHZfOBAsH4m
        3CNtZ4Uik8Qt1DLzbXS636ZYCmlfhLygIlNZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M6En3UqoetT+rtN4dLBA0qLnkfPVYu4o
        6hHWNeCZjXazzC6845d93+33RtBpkNeDuJx+J79T1DUm++7VJzQFOES9j4HolcBX
        URc+Ie3G9Wk3vt2WYmdoPX01CrVHUyD3XOdUmJpMKCbanX9/QZlkwiDWD3q/2TO2
        bk8HqPN5bE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 449D54777E;
        Tue, 25 Oct 2016 14:41:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE0BF4777B;
        Tue, 25 Oct 2016 14:41:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
        <20161025183057.x24gqm56tgshyuvu@sigill.intra.peff.net>
Date:   Tue, 25 Oct 2016 11:41:36 -0700
In-Reply-To: <20161025183057.x24gqm56tgshyuvu@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Oct 2016 14:30:57 -0400")
Message-ID: <xmqqy41cqnj3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA111CAE-9AE2-11E6-B72E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 24, 2016 at 06:09:00PM -0700, Junio C Hamano wrote:
>
>>  - lt/abbrev-auto and its follow-up jk/abbrev-auto are about auto
>>    scaling the default abbreviation length when Git produces a short
>>    object name to adjust to the modern times.  Peff noticed one
>>    fallout from it recently and its fix jc/abbrev-auto is not yet in
>>    'next'.  I would not be surprised if there are other uncovered
>>    fallouts remaining in the code, but at the same time, I expect
>>    they are all cosmetic kind that do not affect correctness, so I
>>    am inclined to include all of them in the upcoming release.
>
> Yeah, I'd agree any fallouts are likely to be purely cosmetic (and if
> there _is_ some script broken by this, it was an accident waiting to
> happen as soon as it was used in a repo with a partial hash collision).
>
> I'm still not sure if people will balk just at the increased length in
> all of their output. I think I'm finally starting to get used to it. :)

I am finally getting used to it.  At this point, I think the
transition plan would be to tell them to set core.abbrev to
whatever default they like.

>> * jc/abbrev-auto (2016-10-22) 4 commits
>>  - transport: compute summary-width dynamically
>>  - transport: allow summary-width to be computed dynamically
>>  - fetch: pass summary_width down the callchain
>>  - transport: pass summary_width down the callchain
>>  (this branch uses jk/abbrev-auto and lt/abbrev-auto.)
>> 
>>  "git push" and "git fetch" reports from what old object to what new
>>  object each ref was updated, using abbreviated refnames, and they
>>  attempt to align the columns for this and other pieces of
>>  information.  The way these codepaths compute how many display
>>  columns to allocate for the object names portion of this output has
>>  been updated to match the recent "auto scale the default
>>  abbreviation length" change.
>> 
>>  Will merge to 'next'.
>
> In case it was not obvious, I think this topic is good-to-go. And
> clearly any decision on lt/abbrev-auto should apply to this one, too. I
> notice you built it on jk/abbrev-auto, though, which is listed as
> "undecided". That's fine by me, but I think it would technically hold
> this topic hostage. You might want to adjust that before merging to
> next.

I am planning to merge both lt/* and jk/*; I should have said it
more clearly.

Thanks.

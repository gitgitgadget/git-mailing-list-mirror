Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB7C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 20:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9139C61076
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 20:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhCaUTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:19:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52280 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhCaUS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 16:18:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DF34123A89;
        Wed, 31 Mar 2021 16:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WDbFMOq+9OJxeB4AdBwzNCGzXOo=; b=ZhuD46
        lb20+iJ5QNsfqri8iCVxMYeQmX3/hXEtKtFCXwWfM9YAtedg+DFncm6W2zYyBwwN
        giLEC8F0rccIJqXs094xxpV2NsDPKl6nvkvfbb8Qr7OoqdWpF7yDLdlPcJ1WZ+0Q
        0vKT3lvonk3fof5UZLcBefFNLw50Bf4ogbqjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a+vpqmrFmdrzs3vXV+u/PUYIMh+v0Cmv
        HJt1txoZLxX83DM2Z/5zlTZ6pkfo23zO3bzwZENX6MNhpy8ZqOSqvNxd9pX7TaYT
        Way2+GH43Wi2i4bQ0/+ATY3TBPqkWQm+L11ryAOhSjL88Wx2crYbbpePgZ8ITVsK
        jSaGgWXvQCw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46C9C123A88;
        Wed, 31 Mar 2021 16:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77ED2123A87;
        Wed, 31 Mar 2021 16:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2021, #08; Tue, 30)
References: <xmqqv99889hh.fsf@gitster.g>
        <CABPp-BEmZ-UGNeWs+XS4o0VWZ8=nqrCwJsSBQFYBBJ8Py2XOZg@mail.gmail.com>
Date:   Wed, 31 Mar 2021 13:18:54 -0700
In-Reply-To: <CABPp-BEmZ-UGNeWs+XS4o0VWZ8=nqrCwJsSBQFYBBJ8Py2XOZg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Mar 2021 18:23:09 -0700")
Message-ID: <xmqqeefv6pqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51FCFC36-925E-11EB-8631-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Tue, Mar 30, 2021 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> [New Topics]
>> ...
>> * en/ort-perf-batch-11 (2021-03-25) 7 commits
>>  - merge-ort, diffcore-rename: employ cached renames when possible
>>  - merge-ort: add helper functions for using cached renames
>>  - merge-ort: preserve cached renames for the appropriate side
>>  - merge-ort: avoid accidental API mis-use
>>  - merge-ort: add code to check for whether cached renames can be reused
>>  - merge-ort: populate caches of rename detection results
>>  - merge-ort: add data structures for in-memory caching of rename detection
>>  (this branch uses en/ort-perf-batch-10, en/ort-perf-batch-9 and en/ort-readiness.)
>
> I was actually slightly surprised you picked this one up this early
> given the other three in-flight.

As I always say, don't read too much into being in 'seen'.  I can
try queuing them only to see how bad a conflict I should anticipate
when the time comes and forget to remove it by mistake.

>> [Cooking]
> ...
>> * en/ort-perf-batch-10 (2021-03-18) 8 commits
>>  - diffcore-rename: determine which relevant_sources are no longer relevant
>>  - merge-ort: record the reason that we want a rename for a file
>>  - diffcore-rename: add computation of number of unknown renames
>>  - diffcore-rename: check if we have enough renames for directories early on
>>  - diffcore-rename: only compute dir_rename_count for relevant directories
>>  - merge-ort: record the reason that we want a rename for a directory
>>  - merge-ort, diffcore-rename: tweak dirs_removed and relevant_source type
>>  - diffcore-rename: take advantage of "majority rules" to skip more renames
>>  (this branch is used by en/ort-perf-batch-11 and en/ort-readiness; uses en/ort-perf-batch-9.)
>>
>>  I made a mistake of picking these up before they got sufficient
>>  exposure to the reviewers and ended up a source of potential mess
>>  when it turns out that any of the earlier ones need rewriting (I
>
> Um...are you by chance conflating my comments linked above on
> ort-perf-batch-11, the very latest series, with this series?

No, I did mean the comment on this topic, and the readiness one that
depends on it.  While -9 is not yet in 'next', having three
interdependent topics on top of it is just asking for reviewer
fatigue, and that picking up this topic was the beginning of the
issue.  I should probably have waited for one more cycle and spent
my time more on making sure -9 was in good shape and merge it down
to 'next' before touching them.



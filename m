Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8171F4BE
	for <e@80x24.org>; Thu,  3 Oct 2019 01:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfJCBHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 21:07:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfJCBHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 21:07:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD1801B71B;
        Wed,  2 Oct 2019 21:07:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/pS/WiwZH7ut7tUYYMHKF9OzBA=; b=o/Ie/4
        AM6fGooQfHtGebXJOgbGsQjZK/Eh2whrQswAiOCpWbZyA8vgB5ZmGlZaYB7rTTbU
        xCkmbpzg35x+y5XNuzM0mR7v5LVyjafZNbsPXqhUfElNRJKFB6u7cA8/RpSdOzbD
        LMeYru5W9KPNzbjXEs9lcvy1r6u3HrEg1UDP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wWPU25C4HwkSwU+0ZfDgDZT+cBeMes4a
        m9TgdMJoZms4aRSP2NCH4YjfBWHEozkkNdflKZyLwqA7aJziWqjbr3wExV9jHVvn
        hqSubq4+4JG1tQIPWTqvszibVrxsMAEZJ5bcyZwqEaQ+Ww7txcYziKKWf1cRp9MN
        J/AoZpeg8M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A542E1B71A;
        Wed,  2 Oct 2019 21:07:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F53D1B719;
        Wed,  2 Oct 2019 21:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] fast export/import: handle nested tags, improve incremental exports
References: <20190925014005.17056-1-newren@gmail.com>
        <20190930211018.23633-1-newren@gmail.com>
        <CABPp-BFckDZL4iAqhHmrXDpFi3eQgvOkbgjJdGRZE4ePUwNDuw@mail.gmail.com>
        <xmqqzhiidi2u.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEJ47MonV2WmD+UornSG5LPmpGAyjWQa_4DTkAfjMjRmg@mail.gmail.com>
Date:   Thu, 03 Oct 2019 10:07:42 +0900
In-Reply-To: <CABPp-BEJ47MonV2WmD+UornSG5LPmpGAyjWQa_4DTkAfjMjRmg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Oct 2019 14:05:55 -0700")
Message-ID: <xmqqa7aid4bl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 347B2526-E57A-11E9-A701-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> And the draft copy I locally have for the next issue of what's cooking
>> has the comment removed already.
>>
>> Anything I missed?
>
> I was looking at the commit message for the merge commit where you
> merged in v2 of the series...

Ah, sorry, yes you are right, the merge messages can lag behind,
especially until the topic hits 'next'.  It is not a designed goal
to work that way, but just a consequene of how my workflow is
structured.

 * A merge grabs the message from the then-latest "what's cooking" draft.

 * The "what's cooking" draft is then updated.  This is a two-part
   process:

   - "git log --first-parent master..pu" is scanned, to see which
     parts of what topic are and are not yet in 'next' (this flips
     '-' and '+' prefix in the "what's cooking" report) and marks
     the changed parts for the next part.

   - An editor session looks for these topics with updated status
     and updates the comment in the "what's cooking" draft..

So, the topic with the new fix-up commit was merged to 'pu' with the
message taken from the "what's cooking" draft before the draft gets
updated with that fix-up commit.  When I have sufficient time, I
rebuild 'pu' twice (i.e. do the integration once, and then update
the "what's cooking" draft, rewind 'pu' to 'master' and do the
integration again to pick up messages from the updated "what's
cooking" draft), but yesterday was not one of those days X-<.


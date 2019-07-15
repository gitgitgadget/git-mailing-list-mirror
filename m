Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F7B1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfGOQ5u (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 12:57:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59187 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQ5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 12:57:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B56BC84977;
        Mon, 15 Jul 2019 12:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ySKly7dQYVldOWTtmgIucSLOn3k=; b=IqeAEP
        sj0Iy3wzuwzh3XVcBruDIyB3OrhYVpvIaG6q50gOaJpH6JWD9FinEu2+jUQw17/m
        +9v5hHqqqhnsn5QmCIYEfM6m6zqfnG4omQwcLgATDCmLkQOWefM9BAMYvKKFw6TI
        UgxuMw/gtVq7O/wDL/73IBGudv6KTiP2Pbdzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S0S2p59d4xFywz391KVk/DT/Jaw0OfdT
        lPehEY3Yq1l3x3xZnaUyHaDcdjPXKaTsDNclvie/633hB0PoyJpEaGTivR/QdtGY
        S6ziEuZ7xwQw4Tc8XsmruiFG1t3mRKn3een7o8i4s84eRQQs/j66gRxhTBSVbA2q
        GjVSW6U9OYY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD21284976;
        Mon, 15 Jul 2019 12:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB12584975;
        Mon, 15 Jul 2019 12:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
        <87sgrdf91j.fsf@osv.gnss.ru>
        <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com>
        <87blxz9xbh.fsf@osv.gnss.ru>
        <xmqqh87rp0gy.fsf@gitster-ct.c.googlers.com>
        <874l3nzcpo.fsf@osv.gnss.ru>
Date:   Mon, 15 Jul 2019 09:57:42 -0700
In-Reply-To: <874l3nzcpo.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        15 Jul 2019 15:47:31 +0300")
Message-ID: <xmqqtvbn44mx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA943C3A-A721-11E9-9476-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>> But the point is, if M and N are equally well tested before
>> publication, they may still have bugs resulting from subtle
>> interactions between A and F..X that is not discovered during that
>> testing.  And N loses the information that would help diagnosing
>> what went wrong, which does not happen if you published M.
>
> I see your point.
>
> My point is that it's still a /choice/ between more information and
> history simplification.

I actually fail to see that point.

If we are not constrained by that "first merge of a topic must be a
redundant fast-forward merge", a topic that originally had two
commits A and B, merged to the mainline to produce M and then
further corrected with a commit C before it gets merged back at O to
the mainline would leave this history:

          A-----------B-------C
         /             \       \
    o---F---o---o---X---M---o---O---

If you enforce the "first merge of a topic must be a redundant
fast-forward merge" rule, you'd end up with a history like this:

          A-----------B
         /
    o---F---o---o---X-------N---o---P---
                     \     /       /
                      A'--B'------C

Is the latter materially simpler than the former?  I do not think
so.

I was preparing myself to say "we rejected the combination because
it would encourage wrong workflow, but perhaps over the years people
like you and usbuser may have found good use patterns different from
what we considered back then, and these use patterns may not
encourage wrong workflows.  It may not be a bad idea to introduce a
new optional behaviour if that is the case", but what I heard so far
does not convince me that we have good use patterns.
>> About the docs easily getting misinterpreted, I think Elijah covered
>> it pretty well.
>
> Yeah, sure, the docs should better be fixed.
>
> Anyway, bare "git --no-ff" is still there, and I can live with no safety
> belt that '--ff-only' could easily have been, it's just that it's a pity
> to see lost opportunities in the design.

Lost opportunities to add an option to encourage bad workflow?  

No, thanks ;-)

But thanks for a discussion anyway.


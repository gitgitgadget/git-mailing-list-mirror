Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209EC433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 22:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21476197B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhCSW62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:58:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSW6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 18:58:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D083CB870D;
        Fri, 19 Mar 2021 18:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TrE2eC4Ee0D0VCp3MbT/MsFaIg8=; b=r1iCRr
        CMrxA6FBZGuRcNOJqV7BYBF+koEWzUNZt/T+/H5Z9ZIbnS66q7Am1JPw6qgP3zYO
        CiA1CLWnuXniOtihzjgvqAjIlX/ZuZw2eNex/r6/5g2NhXHTvRq7D6uaS9kG/Efc
        1gF4TUSjq2l4g/S2hmPtFwJftgdHz3FZXqHyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vWGp2mwmB01GxI79y/mH5Pa093aHTDSv
        kG4cfp0Fz0q5eOUDu0QoXU3nvwYjJsV8O1whug2bdIRQJvNoqvuNkOq8yBieJX2/
        OqQK5KmSZ5FB+A+w9o9K+BGmvWXT9Dbg2Ya/efk0LgHN8caVvePvL9kLkDJWYpO5
        syYsMjtCLj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7637B870C;
        Fri, 19 Mar 2021 18:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AB51B8703;
        Fri, 19 Mar 2021 18:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/5] Parallel Checkout (part 2)
References: <xmqqft0srxjc.fsf@gitster.g>
        <19fee535ee0ec5211f22b2b69a4a9804816c2322.1616122653.git.matheus.bernardino@usp.br>
Date:   Fri, 19 Mar 2021 15:58:22 -0700
In-Reply-To: <19fee535ee0ec5211f22b2b69a4a9804816c2322.1616122653.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Fri, 19 Mar 2021 00:24:38 -0300")
Message-ID: <xmqqsg4qlpip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B564C04-8906-11EB-9FD3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

>> Let's redo part-1 on top of 'master' first without such a merge; it
>> has been out of 'next' so we can do so easily without wanting for
>> the tip of 'next' to get rewound.
>
> Thanks!
>
> I saw you've added the "entry.h" inclusion that was missing at
> builtin/stash when merging this branch on 'seen'. However, now that
> part-1 is based on 'master', the branch is no longer buildable without
> this fix. So could we perhaps squash this change directly into the
> relevant commit in this series?

Yeah, that was the kind of thing I had in mind when I suggested you
to "Let's redo part-1 on top of 'master'".

I'll mark the topic to be "expecting a reroll" for now, as I am deep
in today's integration cycle.

Thanks.

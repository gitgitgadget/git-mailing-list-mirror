Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ADC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353493AbhLCTYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:24:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54486 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbhLCTYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:24:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87F9EEA28B;
        Fri,  3 Dec 2021 14:21:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4jK9Ry9thDFq+ArTQef52n68lfAXqY7tDpgSMJ
        LMRTc=; b=j3yGoqWXEHYSIOCaVzpzX0jDXiJogXKwHZhsb0HsjIMiOJkc8wZklJ
        vxN7XzhLu7QkRjJbdflBNuT0mNF4B7nRDIfzytI+Nh0XOPfrhSsuO1YlFRX7d0I6
        9PxaSC+rBEIHIxNQJ/vj3hXuostXjcRjvwEdF+swvSTwHlZfnLhOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 801EFEA28A;
        Fri,  3 Dec 2021 14:21:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B793EEA289;
        Fri,  3 Dec 2021 14:21:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ns/tmp-objdir and ns/remerge-diff
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
Date:   Fri, 03 Dec 2021 11:21:13 -0800
In-Reply-To: <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Nov 2021 15:07:32 -0800")
Message-ID: <xmqqa6hhsdee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EAAAD8C-546E-11EC-8B64-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ns/tmp-objdir had a re-roll that has not been picked up, at [1] --
> perhaps because it's an combination of ns/tmp-objdir and
> ns/batched-fsync (it'd be nicer to have those two split).  I gave the
> ns/tmp-objdir part another read over and was only able to spot two
> small things.  I think you should mark it as expecting a reroll based
> on [2] ("Good catch. I'll fix this.") and [3] ("I'll take this
> suggestion."), but I think it could be merged to next quickly after
> that.
>
> [1] https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
> [2] https://lore.kernel.org/git/CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com/
> [3] https://lore.kernel.org/git/CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com/
>
>>  Also ns/remerge-diff that is Neeraj's rebase of the
>> remerge-diff topic needs Elijah's Ack at least.
>
> Mark it as expecting a re-roll; I've been waiting for ns/tmp-objdir to
> settle so I can rebase on it.

I took a quick look at the rerolled one on list, and I agree that
keeping tmp-objdir and batched-fsync as two separate topics makes
sense, since the former can graduate much more smoothly and quickly,
and it can have other dependant topics.

So I'll mark all three (ns/tmp-objdir, ns/batched-fsync and
remerge-diff) as "Expecting a reroll".

As I announced, I won't be taking any new topics or new rerolls
today (or possibly tomorrow) until I can sift the topics I've
already seen to come up with a tested set of candidate topics to
merge to 'next', so there is no need to rush.

Thanks.

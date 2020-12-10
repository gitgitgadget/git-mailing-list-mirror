Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B9DC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E9D2343F
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgLJA6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:58:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53021 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgLJA6M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:58:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F7C1102B57;
        Wed,  9 Dec 2020 19:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rQuabmdh4YBJH55xNaP7f1YfdmY=; b=paoqq7
        L05AIrIUx94d6RvkV0AEdtp38WbPDhHoP5cO2/0ZfJ3kiRZDo0e6nkfiXH/BeAzR
        P9CYuCA5tAk4Dj8VbjjimxbMfLtbxf3oKE4lxAp20DOaNYv/GHsMlAGsBaBumU/6
        86QygNM3htDcUyfQhEG2pNjH1RKL8Hjr2LBUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mRV0o1anV3UUZ13c2MySrAZcZlK6ixvj
        ppH5JQLbEiA6LrUaDpXnB6RaxQSQApxOUzJldcr6hSFtUJQYdAHkCjweHXzg6neK
        kDP65QRbscOP0/uxy8olnrFer9Ljz1qnOIobWqiVYcMxFNWZuFFrQCPlF7l4whHM
        +FMf5oec50g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08176102B56;
        Wed,  9 Dec 2020 19:57:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 500BD102B55;
        Wed,  9 Dec 2020 19:57:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
        <xmqqy2i738x1.fsf@gitster.c.googlers.com>
        <X9FXnWLFT/2v8acE@nand.local>
Date:   Wed, 09 Dec 2020 16:57:26 -0800
In-Reply-To: <X9FXnWLFT/2v8acE@nand.local> (Taylor Blau's message of "Wed, 9
        Dec 2020 18:02:53 -0500")
Message-ID: <xmqqa6umzde1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACC1331E-3A82-11EB-BC2E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Dec 08, 2020 at 08:22:50PM -0800, Junio C Hamano wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Tue, Dec 8, 2020 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >>
>> >> * en/diffcore-rename (2020-12-07) 5 commits
>> >>  - diffcore-rename: simplify and accelerate register_rename_src()
>> >>  - diffcore-rename: reduce jumpiness in progress counters
>> >>  - diffcore-rename: rename num_create to num_targets
>> >>  - diffcore-rename: remove unnecessary if-clause
>> >>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
>> >
>> > Curious.  I submitted 7 patches for this series.
>>
>> Yeah, I wanted to leave the "hard-to-digest" one out, and queued the
>> "relatively easy to review" ones.  Even then, I ran out of time to
>> read these early 6 (and nobody else seems to have done so, either).
>
> I reviewed all seven, and would be happy to see these merged up. The
> first five were all pretty trivial to review, and the last two
> definitely required more attention, but I couldn't spot any correctness
> issues with them.

Thanks for helping out.  Greatly appreciated.

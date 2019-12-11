Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB22C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0E20836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H1oOMGVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLKVqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:46:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60545 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKVqu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 16:46:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C216950A7;
        Wed, 11 Dec 2019 16:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yTdQAaF/esF7PFbpCCmc3AYQc3k=; b=H1oOMG
        VsDFuW/t1+H/SfgwvAZ1WmEdd7hiVhoCbFZcin8rLzu5bdDt0gekKgRfq3MuxpVK
        BZusXpnOB0FoU6qfiop7MqQwj63Uz36p1BesRKyZC/k1M4Xl0OCCXiCQKMMFTvzC
        4ijTPUkivE3eSDgV8BQC4czBlzD1DzuLGKVOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iaFPwmryMMqUPlqG1mkQGU4vkKEOtV8C
        +Q+TtRMvpuwcAdlC/HPTm6GffKJpLuzBdtUMuh4+STS5cF0ucET+UUjQKe8QO0od
        uABm3lLY44PWVw2XQHzT2hbrSrbsd2IECdsNwU89O9wtDzCHzHdW2X3Bh66iN7FW
        c1unf+mpsPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92F81950A6;
        Wed, 11 Dec 2019 16:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5618950A5;
        Wed, 11 Dec 2019 16:46:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Denton Liu <liu.denton@gmail.com>, Ben Keene <seraphire@gmail.com>,
        Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings in python3
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <20191207194756.GA43949@coredump.intra.peff.net>
        <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com>
        <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
        <20191211171356.GA72178@generichostname>
        <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
        <CAE5ih78O4_ZPm1sxA=D9Ff-u3ga5Ax1CbvrFg0_E4KrRdUihDQ@mail.gmail.com>
Date:   Wed, 11 Dec 2019 13:46:40 -0800
In-Reply-To: <CAE5ih78O4_ZPm1sxA=D9Ff-u3ga5Ax1CbvrFg0_E4KrRdUihDQ@mail.gmail.com>
        (Luke Diamand's message of "Wed, 11 Dec 2019 20:19:48 +0000")
Message-ID: <xmqq5zimo7r3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B84AC37C-1C5F-11EA-A5CD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On Wed, 11 Dec 2019 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Denton Liu <liu.denton@gmail.com> writes:
>>
>> > On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
>> >> Ben Keene <seraphire@gmail.com> writes:
>> >>
>> >> > Yes indeed!
>> >> >
>> >> > I hadn't pulled before I attempted the rebase, and got bit.  Yes those
>> >> > shouldn't be there!
>> >>
>> >> So, other than that, this is ready to be at least queued on 'pu' if
>> >> not 'next' at this point?
>> >
>> > From what I can tell, Ben agreed to have this series superseded by Yang
>> > Zhao's competing series[1].
>>
>> OK.  Let me not worry about this one, then, at least not yet.
>>
>
> Oh, I hadn't seen Yang's python3 changes!

I haven't been paying attention to them either.  The patches I
started commenting on from Ben were easy to read and understand, and
I didn't even know until Denton pointed out that Ben's series
yielded the way.

> What do we need to do to get these ready for merging?

Somebody needs to take the ownership of the topic---we cannot afford
to have two independently made topics competing reviewers' attention.

If Ben wants to drop his version and instead wants to use Yang's
ones, that's OK but Ben probably is in a lot better position than
bystanders like me to review and comment on Yang's to suggest
improvements, if he hasn't done so.  The same for those who reviewed
Ben's series earlier.

It would make sure that the single topic a combined effort to
produce the best of both topics.  If there is something Ben's
patches did that is lacking in Yang's, it may be worth rebuilding it
on top of Yang's series.

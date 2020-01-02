Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372CDC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94F21655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FxdDY4yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgABS0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:26:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59686 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABS0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 13:26:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92F84B458D;
        Thu,  2 Jan 2020 13:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=diYC2e/C0xiW00p5A8p/+LRD0lE=; b=FxdDY4
        yvWMsBS8Esf+ieSO68w+e9EJcEsRojYELdyQQ4ldPviHy/o3mYlqa5OkIGsbg0xH
        itasY2bkIRmWPoaiDZjNQT39kwfd1j/mjFDSy+esk+Ya675sBiv9tKNd7MsuSiT1
        52qGngLKvAIme4Fbp8MgQizh6qW9zQEECncQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DcKMEwfm5GSFXPwKb/H4sJI8Z9HsvoD/
        00ddCofVRxXwFt9zh4g2mHoRRfAzPWO639x4zc37+lb/gKaGy0IX+OQ09NZKqmIH
        PjnzMfko6eOsYdJNKwTBzhflm+B4cnt7oOj7aJ43dYvupyJBxnXwTAu9ntfV1ANZ
        XcxNCqVIjfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AB51B458C;
        Thu,  2 Jan 2020 13:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 231B4B458B;
        Thu,  2 Jan 2020 13:26:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 05/16] t2018: don't lose return code of git commands
References: <cover.1577454401.git.liu.denton@gmail.com>
        <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
        <CAPig+cQmO2W7kcqWZwrSsC7-vkk_UVcC5NktY+0dddcyaegr6Q@mail.gmail.com>
        <20200101084840.GC5152@generichostname>
Date:   Thu, 02 Jan 2020 10:26:16 -0800
In-Reply-To: <20200101084840.GC5152@generichostname> (Denton Liu's message of
        "Wed, 1 Jan 2020 03:48:40 -0500")
Message-ID: <xmqqy2upemuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC16A38-2D8D-11EA-BAD3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Try writing your commit messages in imperative mood:
>> 
>>     Fix invocations of Git commands so their exit codes are not lost
>>     within command substitutions...
>> 
>> or something. Same comment about several other commit messages in this series.
>
> I thought that the preferred form of commit messages is to introduce the
> problem that I'm trying to solve first ("We had some git commands losing
> return codes") then, after that, describe the changes I made in
> imperative mood ("Rewrite these instances..."). From what I can tell,
> all of my commit messages conform to this template.
>
> I'd prefer to keep the "problem statement" introduction in my commit
> messages as it primes readers so they know "why" before "what" but I
> can't think of any way to phrase the "problem statement" part in a way
> that sounds good without resorting to past tense. Any suggestions?

I find Eric's slightly easier to follow in this particular case,
primarily because the problem being solved is so obvious (i.e. "so
that their exit codes are not lost" is sufficient to convey that the
current code lose exit codes and that it is bad to lose exit codes).

When the problem is deeper or needs longer backstory to understand
where it came from, I do prefer a separate description of the
current status and reason why the current status is undesirable
(both in the present tense), followed by commands to the code to
become better.

Thanks.



>> 
>> More below...
>> 
>> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> > ---
>> > diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
>> > @@ -23,7 +23,8 @@ do_checkout () {
>> >         # if <sha> is not specified, use HEAD.
>> > -       exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
>> > +       head=$(git rev-parse --verify HEAD) &&
>> > +       exp_sha=${2:-$head} &&
>> 
>> Are you sure this transformation is needed? In my tests, the exit code
>> of the Git command is not lost.
>
> Thanks for double checking, it's not needed. I'll drop this in my next
> reroll.

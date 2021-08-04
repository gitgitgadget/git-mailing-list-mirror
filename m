Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED137C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC9460EE5
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhHDWRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:17:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50786 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:17:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2B2A13256D;
        Wed,  4 Aug 2021 18:17:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MXR/HG0uUoxq+kCihgHmJYO1SX2Z9YxdqLv1ib
        aCJQ4=; b=OYruGB3Nd4dHvXYSKSOzkmn0k+AHgz/xcwhSaYeVgN7xpT97d4qdIg
        pQIeintIBh/sgX5v/ytLE//iW84avc5ht1ELg2tJHbyARXRFuHZEIx2f6ZsXlePv
        fygk2j6hGDYAHLXxz+W4P8kBzEE0/t69FRoKztvNzFaC8F+64yIzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2E7713256C;
        Wed,  4 Aug 2021 18:17:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27CF613256B;
        Wed,  4 Aug 2021 18:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v3] upload-pack.c: treat want-ref relative to namespace
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st> <xmqq35rooqr5.fsf@gitster.g>
        <CDB2GX6ICZMC.1FDRFIKZU9GU6@schmidt>
Date:   Wed, 04 Aug 2021 15:17:15 -0700
In-Reply-To: <CDB2GX6ICZMC.1FDRFIKZU9GU6@schmidt> (Kim Altintop's message of
        "Wed, 04 Aug 2021 22:04:05 +0000")
Message-ID: <xmqqczqsn9ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA5E09D4-F571-11EB-96D2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Altintop <kim@eagain.st> writes:

>> > +	) &&
>> > +	git -C "$REPO" config uploadpack.allowRefInWant true
>>
>> I do not see a reason why the last step wants to be done outside the
>> subshell, which we would be using anyway. Does it clarify something?
>
> I agree, but was sticking to the style that was already there. I'll then revise
> the other setup steps as part of the refactor.

Touching existing tests only for this, unlike the creation of a
helper out of existing test to improve reuse, does not improve
anything.  I was curious if there was a good reason to create in a
subshell and configure in a separate step, and "others do the same"
is good enough to satisfy the curiousity.

Thanks.

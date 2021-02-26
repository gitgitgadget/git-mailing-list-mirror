Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D6C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E408F64F1B
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZTdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 14:33:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54009 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZTdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 14:33:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA14B109E9C;
        Fri, 26 Feb 2021 14:32:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eUhAUG9JDhtq3cNEtyGKkkBh9q8=; b=T4zL7n
        Meq8ln6J1jnT7swd45OK5WipYLHAKpoRIgky8PsEOBhRDUzE+/gRlON5gG/NwUnN
        7Sbc0Fuc3SFmnn/eXxICJeTQaWQ28LHH1p7sUuxKL1gMskZdAbNACXS1tbMo8hcB
        v1NIAMtSJRIN4d0UF0gQsIs4m0Y0I8feZxSbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oHXzgbCDpywhyZm8ydbMKr+0D1i7wmgP
        Ek9BnqsaD8SuezrHN8Ldz8zEajDGA7jec3zy03PH0Q30QdNo4nnn4jatQWfpvNu3
        GEtUoSAkO08u3C47ruwnzMGugNjne9T5VpJJIELtuFSQ8rP1FeTmFB43LVFnurQN
        QoS49ezyTgc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2783109E9B;
        Fri, 26 Feb 2021 14:32:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31605109E99;
        Fri, 26 Feb 2021 14:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210225100855.25530-3-charvi077@gmail.com>
        <xmqqwnuvsw0d.fsf@gitster.g>
        <CAPSFM5eKnqOhDrZWEd-c_sDNMbQkqtMwpFM0zT-gOVHvMtcZnQ@mail.gmail.com>
Date:   Fri, 26 Feb 2021 11:32:30 -0800
In-Reply-To: <CAPSFM5eKnqOhDrZWEd-c_sDNMbQkqtMwpFM0zT-gOVHvMtcZnQ@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 26 Feb 2021 16:08:29 +0530")
Message-ID: <xmqqczwmsjzl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5ECADA28-7869-11EB-9EE0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> subject of head
> body of head
>
> So, I am not sure about the other option to implement it ?

Thaks, and OK.

>> > +                     if (have_option_m)
>> > +                             die(_("cannot combine -m with --fixup:%s"), fixup_message);
>> > +                     else
>> > +                             prepare_amend_commit(commit, &sb, &ctx);
>>
>> Hmph, why is -m so special?  Should we allow --fixup=amend:<cmd>
>> with -F (or -c/-C for that matter), or are these other options
>> caught at a lot higher layer already and we do not have to check
>> them here?
>
> yes, those options are caught earlier and give the error as below:
> "Only one of -c/-C/-F/--fixup can be used."
> and only `-m` is checked over here.

And the reason why -m cannot be checked early is because we do not
recognize which kind of "fixup" we are doing when "only one of
-c/-C/-F/--fixup" check is made before this function is called?

OK.  I wonder if we can tell which kind of fixup we are doing much
earlier, though.  Then we could extend it to say "Only one of
-c/-C/-F/-m/--fixup=amend:<commit> can be used", etc., and we do not
have to have this "only -m is checked here, everything else is
checked earlier" curiosity.  But I do not know if such a change is
necessarily an improvement.  I guess a better "fix" would probably
be to add a comment to this function where it only checks for "-m"
and tell readers why -c/-C/-F do not have to be checked here.

Thanks.



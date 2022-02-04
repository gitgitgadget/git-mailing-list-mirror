Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D0C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 00:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356215AbiBDA1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:27:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61019 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353694AbiBDA1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 19:27:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7169A11ADB4;
        Thu,  3 Feb 2022 19:27:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3C1mG1fUPAxh2BvBFOB21Dl8TsH31T8v+nkwO
        K29cc=; b=FgDQCvo9cdiBJFAFHdc/7homCVSMiBhfYp+1og83rw82v3/i/BXRpB
        7wg91nXjUTBEVJj2z3xdpY01v4fkmwvZaHsthakr75RbsfLQSkasdRrml/+9ZjeD
        Ju7DdEBqLazwHcSTvxwUquyXndfbJufBn/pOJxt/99K6XhjT4RUAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F00811ADB2;
        Thu,  3 Feb 2022 19:27:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 090E011ADB1;
        Thu,  3 Feb 2022 19:27:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #07; Mon, 24)
References: <xmqq35lc53e9.fsf@gitster.g>
        <YfRu0G9aNQxT3vtl@camp.crustytoothpaste.net>
Date:   Thu, 03 Feb 2022 16:27:04 -0800
In-Reply-To: <YfRu0G9aNQxT3vtl@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 28 Jan 2022 22:31:44 +0000")
Message-ID: <xmqqiltvpjc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E81AA04-8551-11EC-A81F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> * bc/csprng-mktemps (2022-01-17) 2 commits
>>  - wrapper: use a CSPRNG to generate random file names
>>  - wrapper: add a helper to generate numbers from a CSPRNG
>> 
>>  Pick a better random number generator and use it when we prepare
>>  temporary filenames.
>> 
>>  Are we solving the right problem?
>>  cf. <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
>>  source: <20220117215617.843190-1-sandals@crustytoothpaste.net>
>
> It sounds like folks would prefer we drop this series.  I'm not planning
> to send an alternate approach here.

I personally am OK with these two patches, by the way.  There was an
interesting thought experiment to see if we can only rely on
mkstemp() and mkdtemp() that we assume are already secure enough,
but swapping the not-particularly-good linear conguential generator
used in git_mkstemps_mode() with a better algorithm that is
externally supported, making the security issue somebody else's
problem, is a good incremental improvement, I would think.

Unless I hear differently from others, I am planning to mark the
topic for 'next' in my draft of the "What's cooking" report.

Thanks.

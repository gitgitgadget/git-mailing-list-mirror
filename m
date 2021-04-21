Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA27C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DBB6140F
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbhDUXXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:23:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63359 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhDUXXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:23:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09D2B136301;
        Wed, 21 Apr 2021 19:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kzxIq7cIo5/0eK/EC0EWHz6Cy4=; b=lqKyYL
        uHshzzVqnha8z3vA9tEdlsRvpJ2fcTIjce2urxE/pKZYUG5tORLyYG96iHTRC4kq
        KkYz3mxDau4Tx3CXsEh5fyq8fQcZxPX99SlZHmsenm8JfLLnD5ESuSUSNO/C1ibk
        8wQZIHiOMx1WJXS0AICdAJBs8Z5baM7tN1+2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uHRUTdyxzp4FDj5qd5oyBYtSKQqDbwPy
        9RYojEl1wXmLwGBcfSUycnqlweAchucg2S/FMJ4t06sy2rhraGJ8Bjjoz3QB9DEO
        Z4lBpiM6c2iy56DJ73FGIyr72K2sQy8+PXdIZp+VdDPTYcFTADhs2EoSTcRL5kah
        xpxmyr4aba0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 003FD136300;
        Wed, 21 Apr 2021 19:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E0CD1362FB;
        Wed, 21 Apr 2021 19:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
        <xmqqk0ow37as.fsf@gitster.g>
        <CAFQ2z_Nm4Mixhi0kXTdN+nVj412_WPe=k9v6FpJFyaOx9qMRUA@mail.gmail.com>
Date:   Wed, 21 Apr 2021 16:22:35 -0700
In-Reply-To: <CAFQ2z_Nm4Mixhi0kXTdN+nVj412_WPe=k9v6FpJFyaOx9qMRUA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 21 Apr 2021 12:19:09 +0200")
Message-ID: <xmqqeef3xlxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 758DC446-A2F8-11EB-B586-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> IOW, do you want the above to read
>>
>>         if test -n "$GIT_TEST_REFTABLE"
>>         then
>>                 test_set_prereq REFTABLE
>>         else
>>                 test_set_prereq REFFILES
>>         fi
>>
>> when both series are in effect?
>
> Yes, but on 2nd thought it's probably better to stick with just
> REFFILES, and rewrite any reftable specific tests as !REFFILES.

I guess that is both good enough and simpler.  The only possible
downside is that it would be cumbersome if we ever need to support
the third ref backend, but I expect that it won't happen before the
reftable support solidifies, and under that assumption, the simpler
the better.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E1C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiI1Rlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiI1Rlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:41:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB719C37
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:41:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C36A31B631B;
        Wed, 28 Sep 2022 13:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6DyUIRXd3lOF
        TvCLX3N+i6s+FSCNPAiGMF02+7uRHGQ=; b=aUcaWDSuRcPVG1b3drCsLg4qVFcx
        X1cp3X3D3CngIGOulRsXdjwdt6+RWHXCbv9TdCoFQtXjwSgPfA872ZamTvP83Mdm
        AjAezxliAOxog5Jp83TRJ+Ekpc1MpTAVBz3d3IbnD2lFaXzD3inIeyFGvl7HNujY
        FSXDPz9zh3qoMAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD5C81B631A;
        Wed, 28 Sep 2022 13:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 528FE1B6319;
        Wed, 28 Sep 2022 13:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: vd/fix-unaligned-read-index-v4, was Re: What's cooking in
 git.git (Sep 2022, #08; Tue, 27)
References: <xmqqtu4s1q1m.fsf@gitster.g>
        <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
        <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
        <xmqqv8p7xxi3.fsf@gitster.g>
        <220928.86h70rwhxh.gmgdl@evledraar.gmail.com>
Date:   Wed, 28 Sep 2022 10:41:40 -0700
In-Reply-To: <220928.86h70rwhxh.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 28 Sep 2022 19:01:59 +0200")
Message-ID: <xmqqa66jv1kb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFBE8DFC-3F54-11ED-98DE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Sep 28 2022, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> ... I have no objection to adding more comments, but I am
>>> happy enough without them (like Junio, it may be that I'm overly
>>> familiar with how I expect our get_be() functions to handle alignment=
).
>>> ...
>>> So it's mostly just a minor annoyance for running the tests; we're
>>> probably better not to change any code, even trivially, this late in =
the
>>> release cycle.
>>
>> Yup.  I never planned to merge the topic to 'master'.  The finishing
>> touch I expected was to help Phillip and friends with a bit of
>> explanation in the log message, and then it would be ready to wait
>> in 'next' for the next cycle.
>
> In the interim are we interested in a minimal patch to the specific
> scalar test that's finding this under SANITIZE=3Dundefined, as running
> un-cleanly will be new in this release?

Yes, it is a new minor annoyance that is better left this late in
the cycle.

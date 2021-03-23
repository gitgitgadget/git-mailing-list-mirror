Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA58C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382CD619CE
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCWUO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:14:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60200 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhCWUOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:14:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D296EBB6DE;
        Tue, 23 Mar 2021 16:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FxFcQ88HlI+T
        wCIcXy+O496P6HU=; b=wY/f7/gr2rGmLwO9Pkbwt1/RNmkaVBGf7LMlNdPIJULM
        pEqEyl9wXQKas+fPW6aqHdu+yYMfBVC5aEss26YWvUPr9RVVHM8a0aF3ekaD5z2d
        jIY2Ny0q4JDmZh882jZh9FSj9+gAloBv/B98DQjhxFoQPWe/Hpp6tDvXMoSuxFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ojNpNX
        svMY/pwlCKx0yVj5oGJQc4ZVm1/Oek12Ob7iKxYUaXV0VH3LWl671pECRz+fsN8i
        Y8nQ+N+9tv1jf6iSyLoh3ZlQCNLA3sm/VkHIyNlSuooUGjifcw1jpPTTmJ1P+C+g
        eYEBLxixsRAlo4M6yt7auYffTTHoOY8+xsTi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8832BB6DD;
        Tue, 23 Mar 2021 16:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45DC1BB6D9;
        Tue, 23 Mar 2021 16:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 13/15] Reftable support for git-core
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
        <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com>
        <8735wmqcx5.fsf@evledraar.gmail.com>
Date:   Tue, 23 Mar 2021 13:14:51 -0700
In-Reply-To: <8735wmqcx5.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 23 Mar 2021 13:20:38 +0100")
Message-ID: <xmqqzgyt1vb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D219AF8-8C14-11EB-8DD7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 23 2021, Derrick Stolee wrote:
>
>> On 3/12/2021 3:19 PM, Han-Wen Nienhuys via GitGitGadget wrote:
>>> diff --git a/Documentation/config/extensions.txt b/Documentation/conf=
ig/extensions.txt
>>> index 4e23d73cdcad..82c5940f1434 100644
>>> --- a/Documentation/config/extensions.txt
>>> +++ b/Documentation/config/extensions.txt
>>> @@ -6,3 +6,12 @@ extensions.objectFormat::
>>>  Note that this setting should only be set by linkgit:git-init[1] or
>>>  linkgit:git-clone[1].  Trying to change it after initialization will=
 not
>>>  work and will produce hard-to-diagnose issues.
>>> ++
>>
>> I noticed while resolving conflicts with my series, which also edits t=
his
>> file, that the "+" line above should be removed. That likely munges th=
e
>> fact that the config entry below should be its own list item, not a
>> continuation of the previous one.
>
> I haven't tested this patch, but just a plug for the very useful
> Documentation/doc-diff for discovering any such formatting errors when
> making non-trivial doc changes.

Yup, doc-diff is a useful tool to try.  I recall however in this
particular case there was no difference in the rendered output, even
though a blank line that separates two enumerated items is
semantically more correct than a plus-alone line that adds another
paragraph to the single item.


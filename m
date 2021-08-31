Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4ACC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF8460FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhHaRkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:40:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56529 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhHaRj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:39:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2B5C15614D;
        Tue, 31 Aug 2021 13:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wRFyJKE4Hhwe
        qHY6gBLZ7/TV4eiBIYPeIk7EDMtaT4Q=; b=gMcKvgz0UljGOM2u05W402C8Dziw
        rSTgFjJu9R14oTh/U3/KpGBr8DSPn7Go4T4SCPcdAQtEbjSWd2jvQLUTfMesL9Nv
        WtlRVOe1X9farKq3/TOV6bof7lpmEcKVbKeFTobQucltWqYHF94yWTCFOAp9jnkW
        06kdfFFRarFXeH8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AF1715614C;
        Tue, 31 Aug 2021 13:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1957B15614A;
        Tue, 31 Aug 2021 13:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix GIT_TEST_SPLIT_INDEX
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
        <20210826210004.672860-1-szeder.dev@gmail.com>
        <885bc067-adef-6d23-b867-017cf1b72d25@gmail.com>
Date:   Tue, 31 Aug 2021 10:38:59 -0700
In-Reply-To: <885bc067-adef-6d23-b867-017cf1b72d25@gmail.com> (Derrick
        Stolee's message of "Tue, 31 Aug 2021 10:47:41 -0400")
Message-ID: <xmqqczptv7ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53E508A8-0A82-11EC-9C6B-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/26/2021 4:59 PM, SZEDER G=C3=A1bor wrote:
>> To recap from v1's cover letter:
>>=20
>> Running tests with GIT_TEST_SPLIT_INDEX=3D1 is supposed to turn on the
>> split index feature and trigger index splitting (mostly) randomly.
>> Alas, this has been broken for ~2.5 years, and it hasn't triggered any
>> index splitting since then.
>>=20
>> The last patch in this series makes GIT_TEST_SPLIT_INDEX=3D1 work agai=
n,
>> although it slightly changes its behavior; see its log message for all
>> the details.
>
> I checked the range-diff and reread the patches. This version looks
> good to me. Thanks for pointing out the new failures that were
> happening in my patches. I think I fixed them in my latest versions
> of the sparse-index work, so the latest 'seen' should pass with these
> changes to GIT_TEST_SPLIT_INDEX.
>
> Thanks,
> -Stolee


This, at least the t7519-status-fsmonitor.sh part, seems to depend
on the 'ds/sparse-index-ignored-files' topic, so I'll prepare a
merge of the topic on top of 'master' then queue these with your
Acked-by.

Thanks, both.

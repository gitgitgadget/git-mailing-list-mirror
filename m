Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58308C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 05:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C59600EF
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 05:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhG1FoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 01:44:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57190 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhG1FoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 01:44:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EBA9139DE8;
        Wed, 28 Jul 2021 01:44:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wXvSHru2MWrka4onrdl0BS3V9WE1Ai0sKSdFE1
        PPQhc=; b=plGoTQw65HOoIHzskPPx7mCUIOJub7dxgFFbzoB4QhFUJHfmlYv+8D
        LM+UPurLKvZNT69NdYUI1e+hah2gp2wYtVtBfg5loCVq5LSuLSrNlc8xYiHeGTo9
        BmXKXsFWixVFgxNyeP8ggc8F2QhxbEeKyKscrWSTV8XGeVBNEnqm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 873F2139DE7;
        Wed, 28 Jul 2021 01:44:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C952E139DE0;
        Wed, 28 Jul 2021 01:43:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        <xmqqh7gghgtd.fsf@gitster.g>
        <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
        <xmqqfsvzcqmo.fsf@gitster.g> <xmqq8s1rcn0t.fsf@gitster.g>
        <xmqq4kcfclw8.fsf@gitster.g>
Date:   Tue, 27 Jul 2021 22:43:56 -0700
In-Reply-To: <xmqq4kcfclw8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jul 2021 17:39:03 -0700")
Message-ID: <xmqqczr3at7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD80FDDE-EF66-11EB-BB02-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>
>>>>> I think Fabian's "ssh signing" is not as ready as this topic, and it
>>>>> can afford to wait by rebasing on top of this topic.  By the time
>>>>> "ssh signing" gets into testable shape (right now, it does not pass
>>>>> tests when merged to 'seen'), hopefully the "expand install-prefix"
>>>>> topic may already be in 'next' if not in 'master'.
>>>> I think the test problem is not due to my patch.
>>>
>>> I've been seeing these test failers locally, every time
>>> fs/ssh-signing topic is merged to 'seen' (without the reftable
>>> thing).
>>> ...
>> Interesting.  It seems that the failure has some correlation with
>> the use of --root=<trash directory> option.
>>
>>     $ sh t5534-push-signed.sh -i
>
> And 7528 fails with --root set to a /dev/shm/ trash directory.

An update.  The same failure can be seen _without_ merging the topic
to 'seen'.  The topic by itself will fail t5534 and t7528 when run
with --root= set to somewhere:

    $ make
    $ testpen=/dev/shm/testpen.$$
    $ rm -fr "$testpen" && mkdir "$testpen"
    $ cd t
    $ sh t5534-*.sh --root=$testpen -i
    $ sh t7528-*.sh --root=$testpen -i

on the branch itself, without getting interference by any other
topic, should hopefully be an easy enough way to reproduce the
problem.

Thanks.

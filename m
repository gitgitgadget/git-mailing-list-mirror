Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCCC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F272961154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbhIHG5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:57:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54866 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347914AbhIHG5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 02:57:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 674EB162EE8;
        Wed,  8 Sep 2021 02:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cG47VbZGdLPspobmzukNj532i+ibYvFH0OOCaN
        Epkhg=; b=oh9nBHB3BLKs6Q2gXhGg4tS9+TGP9fqwLxH2XGKpvgsrMBkRU1LJ6N
        z/7jojFHkmtbJoFeFYjbBbDQrTOoeWpbTDFIJ++vlfSA0f56blTUmZ7gwbFuS8RC
        l/+/HmdcMEXrIGAKP7/QTsZTDI+GOuFN+Osb7DjspgWeLbtxV+RcE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EB4F162EE7;
        Wed,  8 Sep 2021 02:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A940A162EE6;
        Wed,  8 Sep 2021 02:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 0/9] Sparse index: delete ignored files outside
 sparse cone
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
        <xmqqwnnr7icz.fsf@gitster.g>
Date:   Tue, 07 Sep 2021 23:56:19 -0700
In-Reply-To: <xmqqwnnr7icz.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Sep 2021 22:21:16 -0700")
Message-ID: <xmqqczpj7dyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF67BE44-1071-11EC-BF56-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Updates in V5
>> =============
>>
>>  * Updated the locality of a cache_entry pointer.
>>
>>  * Rephrased a comment.
>>
>>  * Removed the patch adding a config option.
>>
>>  * I tried, but failed, to create a scenario where the call to
>>    cache_tree_update() causes a test to fail. I still think this is valuable
>>    as defensive programming for the reasons mentioned in the patch, which is
>>    why I didn't remove them here.
>
> OK.  
>
> The 'sg/test-split-index-fix' topic that has been queued in 'seen'
> textually depended on the earlier iteration of this topic, so I'll
> discard it while replacing this topic.

I rebased the dependent topic myself, but I would not be surprised
if I weren't careful enough and introduced a new bug.  Please double
check when a new 'seen' is pushed out in several hours.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38837C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1796F610A7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhGTVCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:02:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55251 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGTVCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 17:02:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFD80E901D;
        Tue, 20 Jul 2021 17:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QfcqCI4FNp8W0rXnpqtPL78ghrZQdXKwsbo6Dh
        oy65Y=; b=xeXsiEQ+sbBDbgFLs6FY3xHVwFVPz3r+4CL9jxJlZWcHgregZvi/+e
        5EXr4LicugTS8N/q1tbPC4BEyNPzpbxw9iOreRyqkUJW9X1Hvke7Oc7Jh5yx5d7f
        Iq5PMPYTgdbkHi3Y3JXgTMpdQqiIWamVrkp9ikyRBfIIOz1S8eQHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7185E901C;
        Tue, 20 Jul 2021 17:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46037E901B;
        Tue, 20 Jul 2021 17:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 0/7] Optimization batch 14: trivial directory resolution
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <1eeec718-a315-c038-d54a-4503a5ca88d1@gmail.com>
Date:   Tue, 20 Jul 2021 14:43:14 -0700
In-Reply-To: <1eeec718-a315-c038-d54a-4503a5ca88d1@gmail.com> (Derrick
        Stolee's message of "Tue, 20 Jul 2021 09:00:48 -0400")
Message-ID: <xmqqk0lkhdal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D1F39B4-E9A3-11EB-B5EB-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/16/2021 1:22 AM, Elijah Newren via GitGitGadget wrote:
>> This series depends textually on ort-perf-batch-12, but is semantically
>> independent. (It is both semantically and textually independent of
>> ort-perf-batch-13.)
> ...
>> Range-diff vs v2:
>
> Thank you for making these edits.
>
>>      ++struct deferred_traversal_data {
>
> In particular, I think this new struct works rather well.
>
> This version LGTM.
>
> Thanks,
> -Stolee

Thanks, both.

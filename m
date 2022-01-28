Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3983EC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiA1B47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:56:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53563 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiA1B47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:56:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC123108966;
        Thu, 27 Jan 2022 20:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LOG6X3s5ZiQd72eMxfm7cqVDcXVe1GPCA5u0CB
        0vZ88=; b=juJSqNnlJAOqPTXBNoCDum+z/UUEMtaTS/yjO1csdapkCgrLYWNyY4
        fXda4lfqXm9iFDnis6EWp2eq5VN2YZL8XuxQE9L1727cpfPtsbvdZGxUByz5uvF7
        ZtQ1zKWS6vSYcqBQSma/I6fUHH8jYEgOM87aDKvaatB21k02Tc9G0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B36C7108965;
        Thu, 27 Jan 2022 20:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D04B108962;
        Thu, 27 Jan 2022 20:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v4 1/3] completion: add sparse-checkout tests
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <5bb598a055dd8121ad5c7228b11618b037029478.1643318514.git.gitgitgadget@gmail.com>
        <CABPp-BFdaLpmcnU2DUy0Wx1rapsWckz4=aG5yTGdCcM3U3on8Q@mail.gmail.com>
Date:   Thu, 27 Jan 2022 17:56:56 -0800
In-Reply-To: <CABPp-BFdaLpmcnU2DUy0Wx1rapsWckz4=aG5yTGdCcM3U3on8Q@mail.gmail.com>
        (Elijah Newren's message of "Thu, 27 Jan 2022 16:08:20 -0800")
Message-ID: <xmqqtudoy653.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9388B0D8-7FDD-11EC-ACF4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Add tests for missing/incorrect components of custom tab completion for
>> the sparse-checkout command. These tests specifically highlight the
>> following:
>>
>> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>> (it is missing reapply and add).
>> 2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>> both file names and directory names. While this is the correct behavior
>
> s/is/may be/

I would stop at "this may be a less surprising behaviour" without
going into "correctness".

>> +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
>> +       # reset sparse-checkout repo to non-cone mode
>> +       git -C sparse-checkout sparse-checkout disable &&
>> +       git -C sparse-checkout sparse-checkout set &&
>
> Can we add a --no-cone here in preparation for the default to switch?

It would be good to do so, if we plan to switch the default.

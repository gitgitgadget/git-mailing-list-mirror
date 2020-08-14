Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA6C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A2F2065C
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 21:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h6HdIVMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHNVlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:41:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53988 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNVlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 17:41:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17B04E7499;
        Fri, 14 Aug 2020 17:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QOjaveBCejkDJBlYnLRNV40zGzk=; b=h6HdIV
        MZR5nJTucwUQKCjgBlkmlnuk0P7oeIfFgIMBL7qdeX1qUJ7r185y3mYU/xtdU2he
        HWfhahcbRz3DOzvouErOVuUlW2pnuteQl7y9VZnR+k4eREvyV7cSSclbeYMhdpxK
        Wxc+BYImv36lA8x2imK1rNm9GYGTs/s2QDPlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlLD8XjDCk2dv4YEsldVJZt414FziJIk
        zjOoMcF+jOCQatfU0of1lvqqP/8Eaf0WXioe4EcfoS2SF5dJ3A4yHx2LnAT4gdYi
        tJV4wftMLYpuwKr4NSSVM6+aAjnxnXZ9q0bn6QfrFLG5q8bljDaeUjCwU4wY2Tl9
        6LH/IhJ40Y8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0ECF4E7498;
        Fri, 14 Aug 2020 17:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C670DE7495;
        Fri, 14 Aug 2020 17:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] SHA-256: Update commit-graph and multi-pack-index formats
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <xmqqeeo9vxl0.fsf@gitster.c.googlers.com>
        <04ebec72-07de-4494-688f-a9f48442906e@gmail.com>
Date:   Fri, 14 Aug 2020 14:41:04 -0700
In-Reply-To: <04ebec72-07de-4494-688f-a9f48442906e@gmail.com> (Derrick
        Stolee's message of "Fri, 14 Aug 2020 16:34:56 -0400")
Message-ID: <xmqqbljcvrbj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB7EAB0E-DE76-11EA-9E81-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/14/2020 3:25 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> As discussed [1], there is some concern around binary file formats requiring
>>> the context of the repository config in order to infer hash lengths. Two
>>> formats that were designed with the hash transition in mind (commit-graph
>>> and multi-pack-index) have bytes available to indicate the hash algorithm
>>> used. Let's actually update these formats to be more self-contained with the
>>> two hash algorithms being available.
>>> ...
>>> If this is the way we want to go with the formats, then I'll assist
>>> coordinating these textual and semantic merge conflicts.
>> 
>> I agree that the files should be self-identifying, but have these
>> changes tested without sha256 hash?
>
> All of the test scripts pass with and without GIT_TEST_DEFAULT_HASH=sha256,
> and this test in t5318 (and a similar one in t5319) are explicit about
> testing both options:
>
> +test_expect_success 'warn on improper hash version' '
> +	git init --object-format=sha1 sha1 &&
> +	(
> +		cd sha1 &&
> +		test_commit 1 &&
> +		git commit-graph write --reachable &&
> +		mv .git/objects/info/commit-graph ../cg-sha1
> +	) &&
> +	git init --object-format=sha256 sha256 &&
> +	(
> +		cd sha256 &&
> +		test_commit 1 &&
> +		git commit-graph write --reachable &&
> +		mv .git/objects/info/commit-graph ../cg-sha256
> +	) &&
> +	(
> +		cd sha1 &&
> +		mv ../cg-sha256 .git/objects/info/commit-graph &&
> +		git log -1 2>err &&
> +		test_i18ngrep "commit-graph hash version 2 does not match version 1" err
> +	) &&
> +	(
> +		cd sha256 &&
> +		mv ../cg-sha1 .git/objects/info/commit-graph &&
> +		git log -1 2>err &&
> +		test_i18ngrep "commit-graph hash version 1 does not match version 2" err
> +	)
> +'
> +
>
> Since this tests exactly that the "hash version" byte is the same in
> a SHA-1 repo, this checks that the new version of Git writes backwards-
> compatible data in SHA-1 repos.
>
> Or are you hinting at a more subtle test scenario that I missed?

No, I was just wondering how ready we are, as the four tests looked
too easy ;-)

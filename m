Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C7C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5676220B80
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 21:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tei8/MQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGMVqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:46:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55694 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 17:46:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28DCF68866;
        Mon, 13 Jul 2020 17:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eyHM+rqlqp6ypmqn3niCCceGi14=; b=tei8/M
        QOZZ0aCF/JeWLCRhLBByix3Pz+ahvZrREU+Bkh0e1Jwg/aviwViNeZpe7va6zmRO
        7H8EZ52y5CYFDtXOEOgX8NmERfY3dMShpotOKi0hoOY/qjzdOEjnmewfpyHjOYdc
        pe5VA05MiFEwgjlbrBXJqx64K4t+3OavqLWQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eXjB6qzkAXGKuT984DifSNbls2pm5pcG
        86ikudJWHptdwidN8cO2H01fvyUkW8+pcUfExl6U1NqLydwOYeeB1H2/Yf32eKXh
        Ba3Wke2mu7nI5DAIMqGmxp5LuGAPYR70BxQQf6KUbI5XcjL6zbINLnYTqtGnJnpx
        VUoCrIV+CVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2039C68865;
        Mon, 13 Jul 2020 17:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A956668864;
        Mon, 13 Jul 2020 17:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: tweak upgrade policy to grandfather worktreeconfig
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
        <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
        <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
        <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com>
Date:   Mon, 13 Jul 2020 14:45:58 -0700
In-Reply-To: <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com> (Derrick
        Stolee's message of "Mon, 13 Jul 2020 16:46:57 -0400")
Message-ID: <xmqqlfjnm6ll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CD995E6-C552-11EA-AA64-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I also like that you are actually fixing the case where a user in
> the bad state _can_ get out using "git sparse-checkout init".
>
> This can be verified by adding this test:
>
> test_expect_success 'git sparse-checkout works if repository format is wrong' '
> 	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
> 	git -C repo sparse-checkout init &&
> 	git -C repo config core.repositoryFormatVersion >actual &&
> 	echo 1 >expect &&
> 	test_cmp expect actual &&
> 	git -C repo config core.repositoryFormatVersion 0 &&
> 	git -C repo sparse-checkout init &&
> 	git -C repo config core.repositoryFormatVersion >actual &&
> 	test_cmp expect actual
> '
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * This time with a log message to explain and justify the change,
>>    with a matching tweak to the test script, designed to be applied
>>    on top, but feel free to squash it in if you agree with me that
>>    we do not need two separate commits for this.
>
> Since this commit removes all evidence of the previous one, I would
> recommend just squashing them together.

Alright, then care to do the honors ;-)?  Let's make sure we have it
in -rc1 to avoid nasty "regression" in the upcoming release.

Thanks for raising the issue and exploring the solution space.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62981C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiBAXvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:51:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60390 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBAXvr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:51:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36CCEFC7EB;
        Tue,  1 Feb 2022 18:51:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uDCHQIkVPcDyjUOIJTx5BzHIOxhxdPaI50Q+Ro
        NHlPQ=; b=oZWKPpQPfLqFo1/QVp4vOPsZE3TSrWrLSICShJogKf0bR8tuSq+cwN
        Im+h3KjC4CpcyU9JDSuqlIGHn5WuqaIrkKpdU/oTT6FMe0EhysTRiJ1xQdDudyd2
        vtFvMgd7Ul+F2tXH//+ZjkAacPq2Dx9Q/Ethl26E62Ymuh4kP8luA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D68BFC7EA;
        Tue,  1 Feb 2022 18:51:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C52BFC7E7;
        Tue,  1 Feb 2022 18:51:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] t/lib-read-tree-m-3way: replace double quotes
 with single quotes
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
        <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
        <20220130094357.515335-2-shaoxuan.yuan02@gmail.com>
Date:   Tue, 01 Feb 2022 15:51:45 -0800
In-Reply-To: <20220130094357.515335-2-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Sun, 30 Jan 2022 17:43:56 +0800")
Message-ID: <xmqq35l29mcu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA5F3816-83B9-11EC-AC9B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>
> This commit simply converts the old style (double quotes) to
> a modern style (single quotes), e.g.
>
> -test_expect_success \
> -    'adding test file SS' \
> -    'git update-index --add SS'
> +test_expect_success 'adding test file SS' '
> +    git update-index --add SS
> +'

The old one does not use "double quotes", though ;-)

Also, the above belongs to the log message proper, as it would help
readers of "git log" in the future, as opposed to merely helping
reviewers only while the patch is under review (e.g. differences
between v1 and v2 is a good thing to write after "---", as "git log"
readers will not have access to v1, and will not even want to know
that there was v1).

Documentation/SubmittingPatches has more hints on the log message
writing to help anybody who wants to participate in this project.

 * The title summarizes what problem is being solved (yours is
   fine).

 * Then the status quo is explained in the present tense.

 * Readers are made to realize what is wrong about the status quo.

 * The approach taken to solve that problem is outlined.

 * Then orders are given to the codebase to "become like so" in
   imperative mood.

Applying the above to this patch:

	t/lib-read-tree-m-3way: modernize style

	Many invocations of the test_expect_success command in this
	file are written in old style where the command, an optional
	prerequisite, and the test title are written on separate
	lines, and the executable script string begins on its own
	line, and these lines are pasted together with backslashes
	as necessary.

	An invocation of the test_expect_success command in modern
	test scripts however writes the prerequisite and the title
	on the same line as the test_expect_success command itself,
	and ends the line with a single quote that begins the
	executable script string.

	Update the style for uniformity.

or something along that line, perhaps?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E43CC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AFC64DD6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhA1Fo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:44:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61018 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhA1FoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:44:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0700690621;
        Thu, 28 Jan 2021 00:43:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hEQKH/zFkfr09qpMilW9UxP62Ng=; b=HB+7oQ
        V7rlv5PE6CwpDC5AgDF6bm1Ah0OlFU5ZqDwskOeC1aXaJfZ5B/7IvswKWiZgXoBy
        v6b7unjc1biW4/5JLgqiCfwUT9rCfLAqidfBMI5xayAavQjhfHcQyATOWRC4B40R
        6hwOvxE74bHiqD4uA/OIWDlIahtib78NpdxcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LcRcCKLvkgLa71bcHy35/wTATZImWXYf
        sMGtShqOjWT200I2QOcDXwACMxuI29rpOdhVhOm4zeyrEl1KziU2PHgio/arBT0s
        fu3jLQz0OLeUxQczDqyLLHI18CIqFs1ak6RgAWeddRsh7dThBvPkGjabNqS4GJPG
        qY/ZC/KiUtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFB3390620;
        Thu, 28 Jan 2021 00:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A60F9061F;
        Thu, 28 Jan 2021 00:43:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit ranges
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
        <xmqqwnw5am64.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101221720200.52@tvgsbejvaqbjf.bet>
        <xmqq1recal32.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101270357480.57@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Jan 2021 21:43:41 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101270357480.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 Jan 2021 04:01:33 +0100 (CET)")
Message-ID: <xmqqim7hy5te.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C77C36AC-612B-11EB-A128-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The above paragraph says A...B is turned into $(git merge-base A
>> B)..A and $(git merge-base A B)..B, but I wonder if we should be
>> rewriting it into A..B and B..A instead; that would make it
>> unnecessary to explain what should happen when there are more than
>> one merge bases.
>
> You know what? I lied.

I knew.  So we need an update to the patch.

>> >> Does this merely resemble?  Isn't it exactly what a symmetric range is?
>> >
>> > No, it is not exactly what a symmetric range is because `range-diff`
>> > treats both arms of the symmetric range independently, as two distinct
>> > non-symmetric ranges.
>>
>> This however is an end-user documentation, isn't it?
>
> Yes, and the end user is talking about _two_ commit ranges in the context
> of `git range-diff`, and about _one_ commit range in the context of `git
> log`.

You are forgetting that "log A...B" shows only one half of what a
symmetric range means, and hides which side each commit belongs to.

"git log --left-right A...B" shows what a symmetric range really is;
there are two sides, left and right, and "git range-diff A...B" is
a natural way to compare these two ranges.

I've been quite happy with the way how "git range-diff @{-1}..."
shows the comparison of two sides of the symmetric range, given by
"git log --oneline --left-right @{-1}..."



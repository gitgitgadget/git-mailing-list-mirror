Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E3BC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA461431
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhD2DXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 23:23:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53729 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 23:23:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CFC4B84A0;
        Wed, 28 Apr 2021 23:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/gdswivOj8+C1cDi77Tdn4zWjxqh3nXYPIqTW
        vfdJg=; b=SWiCgFE5Ln4AvscwmgkngPQB1FWbcoJ9xhkMei46ajWyA1b4dFvjX8
        8wezrAG2BiOxYGKDM8DJq3uRBgukFlGLg7WfkReB+K2SiWdE06qDaHfayKaqn/g3
        CqjTzBMrYs1gz3QWPRhsC6DBxziQ+RT5/xDj9jlZKw1P3c5CwKGO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02BC3B849F;
        Wed, 28 Apr 2021 23:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CE02B849E;
        Wed, 28 Apr 2021 23:22:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
Date:   Thu, 29 Apr 2021 12:22:28 +0900
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        (Alex Henrie's message of "Wed, 28 Apr 2021 19:44:19 -0600")
Message-ID: <xmqqwnsl93m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20D22800-A89A-11EB-AE2A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Why do -c and -cc imply -p, but -m does not? I tried to use both `git
> log -c` and `git log -m` today and was confused when the latter didn't
> produce any output. Could we change this behavior in a future version
> of Git?

"[alias] lm = log -m" can be used when you only want the logs

    $ git lm maint..master

or when you want to also view patches your preference is to see all
sides of diffs of merges

    $ git lm -p maint..mater

but depending on who you are that may be of dubious utility.

It is best to move on, writing it off as historical accident, and
embrace the new --diff-merges=m option, instead of wasting time on
pondering "why", because accidents do not have to have a deep reason
behind them ;-)

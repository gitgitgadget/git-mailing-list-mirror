Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307EEC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D78320721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWI2W1q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgKWXxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:53:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64335 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKWXxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:53:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E6AA9473B;
        Mon, 23 Nov 2020 18:53:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g66eG2xo5DJItaym5Sj+8DyMkTg=; b=QWI2W1
        q0I2cwa4tTsRoiAB3y/N48YrYBiL25YBFlIReYhL0jpFHCcu1lBMym9s9Y22tbsJ
        gpj0BJQWf6+aDSDWMsBdcCfZpf86m6kXf0nVv5kVArnIQNJm12G0oPvgatbyzi0e
        q4XJ2z/HCC9w5FpR1WiqP4+8YXRjfFMS06Gdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7ATzKwFynzDCgSsAKGPHf6sweR1kJiT
        xJke9UdG9GrsWjrjNOPG4DGSVXe9EAxaVJxMys+FRzApERXX2vZh6CpMu0ZFG3vV
        Pi2I1+WqrVJ3OQGyIceCL6OGH8Rk4DKEHOHCtTQVfmGQKNJU4Pg82boawbKHOLyj
        egCQJpMgkzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16A699473A;
        Mon, 23 Nov 2020 18:53:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78FEF94738;
        Mon, 23 Nov 2020 18:53:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 15:53:00 -0800
In-Reply-To: <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 23 Nov 2020
        23:20:07 +0000")
Message-ID: <xmqq8sarljfn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05589CCC-2DE7-11EB-9D78-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static const char default_branch_name_advice[] = N_(
> +"Using '%s' as the name for the initial branch. This default branch name\n"
> +"is subject to change. To configure the initial branch name to use in all\n"
> +"of your new repositories, run:\n"

I think this is good, assuming that "subject to change" covers the
case where we end up doing nothing after all.  I'd feel safer if we
said "s/is subject to change/may change in the future/", but this is
not a strong preference.

> +"\n"
> +"\tgit config --global init.defaultBranch <name>\n"
> +"\n"
> +"Common names are 'main', 'trunk' and 'development'. If you merely wish\n"
> +"to suppress this warning, you can also use the current default branch\n"
> +"name. The current branch can be renamed via this command:\n"

I think this is worse than the previous one.  Those who merely wish
to suppress the message without wanting to commit to a particular
name (i.e. they just want to take whatever the default we give them)
would be mislead and be frozen in time forever.  We do not give
"I'll just accept the default of the day" choice, and that is OK,
but we want to be clear about it, which is why I've kept raising this
as an issue.

    To configure the initial branch name to use in all of your new
    repositories and squelch this message, run:

may be better---it makes it clear that the offered two choices are
(1) do nothing and see this message every time, or (2) commit to a
name and not see this message again.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CDC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6126F23C18
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbgLKBYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:24:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52459 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404672AbgLKBXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 20:23:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DE549423F;
        Thu, 10 Dec 2020 20:22:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QEC8xJfLkMqmLI18rIKBMMMPdx0=; b=uMk5YR
        1SJ1Smy+ANHE4tuxnu/Y+lzMhN4i/HUEtG5pmWFw5X+jlE33PXQj6Ji1vlw8mkzr
        h3AC+mE5et60roPy96fGgxEBucwUvtjqLCtaZCLd8Zt+oXE3FUM22XU5kOX8ILiR
        NPOfpyqD7X4vcdGzBu8QlHtJFY6OShrHBDH9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wpD/WoA1cBMU+ad77DvsbanFAKerrtMn
        WWeh/524qRacOB23amh8XpdJtwtd0WItGYNLC4P6Id5MZ5wejy647nTWsfoag3y3
        DKCdzggfHucJdXeQf2KLY2GhQXXf27Bc90YWoTe3E58iZ6eAFpGkICQwKXwY/7YI
        lp/pduAXDRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55CE39423E;
        Thu, 10 Dec 2020 20:22:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D83169423D;
        Thu, 10 Dec 2020 20:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com>
        <CAMP44s0mEsfmc7gT6Yv10_nt8d=HrbETmnwNNqxVmRGdHSOHYw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 17:22:57 -0800
In-Reply-To: <CAMP44s0mEsfmc7gT6Yv10_nt8d=HrbETmnwNNqxVmRGdHSOHYw@mail.gmail.com>
        (Felipe Contreras's message of "Thu, 10 Dec 2020 18:15:52 -0600")
Message-ID: <xmqq360dqgpa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66DB17A2-3B4F-11EB-A616-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
>> +static const char default_branch_name_advice[] = N_(
>> +"Using '%s' as the name for the initial branch. This default branch name\n"
>> +"is subject to change. To configure the initial branch name to use in all\n"
>> +"of your new repositories, which will suppress this warning, call:\n"
>> +"\n"
>> +"\tgit config --global init.defaultBranch <name>\n"
>> +"\n"
>> +"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
>
> This is disingenuous; the most common name is "master"... by far. In a
> couple years this might change, but not right now.
>
> If you don't want to mention "master", then don't mention "common
> names" that are not really the most common names.

Names commonly chosen by those who want to move away from 'master'
are...


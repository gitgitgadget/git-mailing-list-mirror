Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550A0C5519F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 02:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F4820936
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 02:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b+K7yk7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKWCHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 21:07:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64256 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKWCHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 21:07:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47AF79D088;
        Sun, 22 Nov 2020 21:07:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okP+hJrFlntyx+fWBUXfa4TPeMQ=; b=b+K7yk
        7jILLpcS4Ip0ntn7LolT6V1KfsUFqcQ2mfwGvT70FxKkj8Z1T0IRNS9/D90oyprt
        za7UVuyomkAOCqw3zzxV6UUKruBrdYhUOWLNV5liCf2uY+izDizMDXrxnVIAgQVq
        A7L2AEHodEdRkMCE3MAims4Y/cE6Q6r2AkSPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WxHzaLKYCujTVigVSYz9LmJPBmvKEpuT
        hHnglWumeBuaeYxKGXoJ2izyAAuVXjNyNjJGBMBfa14/kvmzTQHn7lBu7LxJaWE5
        Ooq0ePalGZRPco7xjfOH5+5X/ZnEoqNlD6LTMCsLY6f1fYAQMzKvIKeg39QlUI9o
        4SRSWYpKgW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F90F9D087;
        Sun, 22 Nov 2020 21:07:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C36369D086;
        Sun, 22 Nov 2020 21:07:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] init: provide useful advice about init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
        <xmqqft51osnu.fsf@gitster.c.googlers.com>
Date:   Sun, 22 Nov 2020 18:07:30 -0800
In-Reply-To: <xmqqft51osnu.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 22 Nov 2020 15:53:09 -0800")
Message-ID: <xmqq4klgq10d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A499C84A-2D30-11EB-B7F3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static const char default_branch_name_advice[] = N_(
>> +"Using '%s' as the name for the initial branch. This name is subject\n"
>> +"to change. To configure the name to use as the initial branch name in\n"
>> +"new repositories, or to silence this warning, run:\n"
>
> s/new repositories/all of your new repositories/ as that is the
> whole point of using --global option below.
>
>> +"\n"
>> +"\tgit config --global init.defaultBranch <name>\n"
>> +);
>> +

The above may give a valuable lesson to those who want to use one
branch name across new repositories, but it does not tell those who
wanted 'trunk' (to match the project, perhaps github.com/cli/cli,
with which they intend to interact) how to recover from having
already created the 'master' branch.  We may want to add some text
to suggest "branch -M" after giving the advice for the permanent
option.

Also, it is unclear to those who do not have a good <name> in mind
(or, those who do not care to choose a <name> for themselves), what
<name> they should give to take the "or to silence this warning"
part of the advice.  It probably is a good idea to rephrase and say
either:

    ... To configure ... in all your new repositories and squelch
    this message, run:

	git config --global init.defaultBranch <name>

or

    ... To configure ... in all your new repositories, run:

	git config --global init.defaultBranch <name>

    Note that this message won't appear after doing so.

I am offhand not sure which one is better.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF76BC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748AF20724
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qX+lojbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgKWSkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:40:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55738 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWSkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 13:40:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2B45EF5FD;
        Mon, 23 Nov 2020 13:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5dDlXscNzFy3HU4zkm/Tw06ApX0=; b=qX+loj
        beuduG5SyE2vFz9oidnOiaN/6QUB40OB8KW8jeVTFC+VRo/bF2DYkLvCJOstMwLA
        TMNU353gtVJQE2mB/VlV21/Zp8KpM+kA3CZquZjhbFYAJrJcpImvIEH/6K/tf8Dg
        RtQy3m5pj0XQ1G/ibaclRNM7/N9V0JKMxN5TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j+YeQVFd4vocW8y/ZFnrIlO5YtYc5mTm
        DCePcs7sTxVkHnaZcMs8lT7sIIZI6lbxC0T8mRo9TAVhk3azye/nEX79KC/hR4sd
        O9Kh0xm2BJXsGFGY+16SydLhTfktnIFYH+9AP116lfsMBc8Em/vEw8NHvlQ4DNvq
        7A4yNCnjrz8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC477EF5FB;
        Mon, 23 Nov 2020 13:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D50D0EF5F9;
        Mon, 23 Nov 2020 13:40:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
        <xmqqft51osnu.fsf@gitster.c.googlers.com>
        <xmqq4klgq10d.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011231326150.56@tvgsbejvaqbjf.bet>
Date:   Mon, 23 Nov 2020 10:40:00 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011231326150.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Nov 2020 13:28:20 +0100 (CET)")
Message-ID: <xmqqv9dvor27.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C666D00-2DBB-11EB-B823-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The above may give a valuable lesson to those who want to use one
>> branch name across new repositories, but it does not tell those who
>> wanted 'trunk' (to match the project, perhaps github.com/cli/cli,
>> with which they intend to interact) how to recover from having
>> already created the 'master' branch.  We may want to add some text
>> to suggest "branch -M" after giving the advice for the permanent
>> option.
>
> Good point.
>
>> Also, it is unclear to those who do not have a good <name> in mind
>> (or, those who do not care to choose a <name> for themselves), what
>> <name> they should give to take the "or to silence this warning"
>> part of the advice.
>
> Also a good point.

> I came up with this, which I intend to submit with v2:
>
> static const char default_branch_name_advice[] = N_(
> "Using '%s' as the name for the initial branch. This name is subject\n"
> "to change. To configure the initial branch name to use in all of your\n"
> "new repositories (or to suppress this warning), run:\n"

The same issue around "to suppress" is here, though.

> "\n"
> "\tgit config --global init.defaultBranch <name>\n"
> "\n"
> "Common names are 'main', 'trunk' and 'development'. The initial branch\n"
> "can be renamed via this command:\n"
> "\n"
> "\tgit branch -m <name>\n"

It is very likely that the users are on an unborn branch when they
see this message and "git branch -m/-M <name>" does not work.  We'd
probably want to update "git branch" to allow renaming the current
branch that is unborn.

In the meantime, you could do "git checkout --orphan <name>" here,
but once <name> exists as a branch that would not work, so...


> );
>
> Ciao,
> Dscho

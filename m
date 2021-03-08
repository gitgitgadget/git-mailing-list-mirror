Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA782C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B168864FA8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHVVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:21:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62554 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCHVUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:20:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89EC5BA777;
        Mon,  8 Mar 2021 16:20:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VvyJICRjmYHFaDtE0WS5/DyUIzU=; b=NVPjnL
        AXH9iQ7u0wYsw1UnyPywXeC0CIPYn6WpdQsnWvreuqwK2z1jkJg0M+pkrHUhA7Se
        XerOqbKn00pdz+FlgIddEwBuJ798GWPY+1YO6dsR0NHbYvc/NeLbOPmFEpiXSYjV
        b+spF9RXEPDGDemVhZJlAIqVG8ZXoPUwnHKkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XtBNgFbQJV5U8UVvlfL5CltYSxzLcp7F
        gjdlzxI8TtbYOOr/F6nyEblRvcA/XqfWrwmW689lUkeOOYuNgLJRCZYTD/VlOkVv
        jgmVhYpW/hF9dMnv/DWFUAiInXs5DkmPDXTACzFXCEiUZzERv97PLvT8La1g/qAV
        JZYbwwug2qY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C3EBA776;
        Mon,  8 Mar 2021 16:20:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FA9EBA775;
        Mon,  8 Mar 2021 16:20:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        <xmqqlfax7dya.fsf@gitster.c.googlers.com>
        <YEZwY0721KvQNkK+@nand.local> <87pn092yja.fsf@igel.home>
        <YEaI5JIobsbtBQO1@nand.local> <87lfax2xat.fsf@igel.home>
        <YEaM7ruZCvaQQbPI@nand.local>
Date:   Mon, 08 Mar 2021 13:20:46 -0800
In-Reply-To: <YEaM7ruZCvaQQbPI@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 15:45:34 -0500")
Message-ID: <xmqq8s6x5olt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2629BC6E-8054-11EB-9A21-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Mar 08, 2021 at 09:41:14PM +0100, Andreas Schwab wrote:
>> >> >  `git push origin`::
>> >> >  	Without additional configuration, pushes the current branch to
>> >> > -	the configured upstream (`remote.origin.merge` configuration
>> >> > +	the configured upstream (`branch.<name>.merge` configuration
>> >> >  	variable) if it has the same name as the current branch, and
>> >> >  	errors out without pushing otherwise.
>
> ... IOW, "if both your and the remote copy call the
> branch you have checked out the same thing."

Introducing a new term "remote copy" makes it even more confusing at
least to me.  And you are *not* checking out whatever branch any
remote repository has.  Your 'master' and my 'master' are different
entities.

I actually wonder what configuration the paragraph considers
fundamental and mandatory (as opposed to "additional" ones).

At the most basic "I just ran 'git clone' from somewhere" level,
remote.origin.url would be set and, branch.master.remote and
branch.master.merge are present.

I wonder if we should update the heading and extend the description
a bit further, e.g.

	`git push`::
		Without additional configuration, uses the
		`branch.<name>.remote` configuration variable for
		the branch that is currently checked-out to figure
		out which remote to push to, and pushes the current
		branch to update their branch with the same name.
		If `branch.<name>.merge` is set to a name different
		from `<name>`, however, errors out without pushing.

so that it makes it clear that .remote and .merge come in pair.

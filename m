Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8455E20966
	for <e@80x24.org>; Thu, 30 Mar 2017 19:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbdC3TTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:19:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934299AbdC3TTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:19:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8729A6D271;
        Thu, 30 Mar 2017 15:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mz5WG+KKHSRbXk+ORmJOMcr6Xqc=; b=JmJSNm
        x8W1bRE9rIwI04JYOzAuZkBmd/a+TY6MpHaA6JDUH6oromi6JEwdq20UDjMNoKz/
        x2ztxDsxtplrFS93Zt/MqyoX9Jq6vSYPffs9y1A3ab6z6+xtu6ooulMMsDzyuhHv
        MyVEeLRe0pNooZr15gKzOUh6YQFJNrZIx+63I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=et1lgOCy7E3toIQIR+bwTEfZQKlypoc9
        acTB5THjDByyaWA4OQ5+O0vacITLWBnji/8y1hqDye49u1RaAcnwh0SICL+ZT+Fq
        x1nz8wl9sRpGkJM0QIszWKhlRwTwL8OW67uH00DPA+ZU2mT8IPLpdF24XmU1TNAG
        wa/BzQ65l/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 688BD6D270;
        Thu, 30 Mar 2017 15:19:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B97F6D26C;
        Thu, 30 Mar 2017 15:19:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] should these two topics graduate to 'master' soon?
References: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
        <20170328185149.GS31294@aiede.mtv.corp.google.com>
        <20170328191911.22wxjbukv47jflgl@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 12:18:59 -0700
In-Reply-To: <20170328191911.22wxjbukv47jflgl@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 15:19:11 -0400")
Message-ID: <xmqq60iq4lp8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA7394C6-157D-11E7-82C7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 28, 2017 at 11:51:49AM -0700, Jonathan Nieder wrote:
>
>> > * jc/merge-drop-old-syntax (2015-04-29) 1 commit
>> >
>> >   This topic stops "git merge <message> HEAD <commit>" syntax that
>> >   has been deprecated since October 2007 (and we have issued a
>> >   warning message since around v2.5.0 when the ancient syntax was
>> >   used).
>> >
>> > * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
>> >
>> >   This is the endgame of the topic to avoid blindly falling back to
>> >   ".git" when the setup sequence said we are _not_ in Git repository.
>> >   A corner case that happens to work right now may be broken by a call
>> >   to die("BUG").
>> >
>> > I am leaning toward including the former in the upcoming release,
>> > whose -rc0 is tentatively scheduled to happen on Apr 20th.  I think
>> > the rest of the system is also ready for the latter (back when we
>> > merged it to 'next' and started cooking, there were still a few
>> > codepaths that triggered its die(), which have been fixed).
>> >
>> > Opinions?
>> 
>> Google has been running with both of these for a while.  Any problems
>> we ran into were already reported and fixed.  I would be all for
>> including them in the next release.
>
> Thanks, I was wondering how much exposure the latter got. It might be a
> good idea to merge it to "master" early in the post-2.13 cycle to get a
> little more exposure (since the point of it is really to flush out
> unusual cases, the more people run it before we make a release the
> better). But I'm also OK if it's merged to master this cycle, as long as
> it's soon-ish. It's much better to flush out problems in pre-release
> master than in a released version.

OK, let's do both during this cycle, before I take a short break at
the beginning of next month.

Thanks.

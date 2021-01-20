Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE54C43219
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11C523603
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbhATWbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:31:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58574 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbhATVwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54ACEFF1D0;
        Wed, 20 Jan 2021 16:52:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AuIeRW3JU+maBLzIHdW8qWwv1JY=; b=Ifsn2R
        hXwRMjRYkOElLThDwwWgHmgQnb7EQKhFj30d4jJ97v6WhJT1rjbeiJLebRH3rSkn
        jJzlhXAMTB83sk9L9fhVqju8ZBxlcrkpV7TL2OKrOPHysEe1mX9eLidmbGcOcTAa
        K3oH/F/5LZqRAdRgA9UwPYC0FZZpcoejts7xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j3seCb09+zqkzq6wKqD4z1EIqeiNG/09
        byN/5rOLCvIwOnB5JdegaRVFCtqUTo3gnloggBt2j8X6BxJbs+2LBYDruE7BBIh8
        C8v1vt3jtV7SWuGgpdgB1oLjrcasV2lYgOTEKa/R2cXqRI405LImScUpVbSV98iX
        MBjdk/c50MU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E647FF1CD;
        Wed, 20 Jan 2021 16:52:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95A1AFF1CC;
        Wed, 20 Jan 2021 16:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>,
        "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
        <xmqqr1mij88k.fsf@gitster.c.googlers.com>
        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
        <xmqq1reginnq.fsf@gitster.c.googlers.com>
        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>
        <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
        <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>
Date:   Wed, 20 Jan 2021 13:52:03 -0800
In-Reply-To: <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us> (Jason Pyeron's
        message of "Wed, 20 Jan 2021 10:11:47 -0500")
Message-ID: <xmqq35yvff98.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC726F82-5B69-11EB-99D5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

>> I actually do not see that as a problem.  In the past several years,
>> I've never needed to see "log --graph" output that goes all the way
>
> I respect your needs, but they conflict with others' needs, while
> this enhancement to resolve an ambiguity does not impede your
> needs and solves others' needs.

I am questioning if such "needs" really exist in the first place.

Among 35k+ commits in the example project, if you had more than a
few dozens of roots, then it may make sense to highlight them
differently from ordinary commits whether they have parents in the
shown part of the history.  It's like "log --decorate" shows branch
tips marked specially.

Yes, I am saying that such a "this is root" marking, if it is
valuable, should go on a part of "log --oneline" output that is
shown even without "--graph", just like we annotate the commit with
"(branch name)" in the output, instead of painting the commit in the
graph by replacing the '*' node with something else.

And how often do you really need to see commits near the root, say
the earliest 100 commits, in the 35k+ commit history?  Is it really
necessary to tell which among these 100 is the root?  What problem
does it solve?  Perhaps I am reacting to your solution without
seeing the problem you are trying to solve?  First, I took the
"replace <*> with {#}" as a solution for "parenthood becomes unclear
in the --graph output" problem, and pointed out that the solution
for that issue should apply to not just root commits but equally to
the ones above the boundary.

But it seems that I am hearing that it is not "graph showing false
parenthood" problem that you were trying to solve, but "I want to
see root differently for unspecified reason".

I am asking why, and if the reason is because there are nontrivial
number of them sprinkled throughout the history, I am offering my
opinion that something like how we show the commits at the tips of
branches and tagged ones would be a better model than changing the
letter used for the node in the graph.

> Here are some messages:
>
> bug 2252 test case (e.g. for tomcat 9 with unpackWARs=false)
> Add migrate-from-blackfat.sql
> Initial commit from Create React App
> parrent pom
> initial commit
> Base applet
> intial
> Initial commit
> initial
> import prod 
> import prod sql 
> import prod 
> import coop/dev 
> import prod CMIS.zip

You seem to have problems with not just root commits ;-)
How many of these 5 "initial" commits are root?

> I'll ask the following questions, besides the left right and test case issues:
>
> What quality issues exists with the patch (e.g. bugs, strategy, etc)?

By strategy I take that you mean design.  We've been talking about
it, right?  Until that gets more or less settled, line-by-line bug
hunting tends to become a waste of time, and I haven't had a chance
to afford extra review bandwidth to dedicate to this topic.

Now the problem being solved seems to be changing, so I am not sure
how close to be "done" the posted patch is to the real solution.
Sorry.

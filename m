Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493DC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1990B22583
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbhAWSIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:08:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63106 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 13:08:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 389C7AF130;
        Sat, 23 Jan 2021 13:07:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=r9SDhW29K3aseyyV/ur4HeR5Qlc=; b=JISaRXVtYuKE+T5gxmtO
        B51TIK8q3TPkrJFzDmbGv7BUkq9HDJHXwbiMQ4DO36agVLdIGov+4RRWirD4l9Bi
        5E33LtySEyOpaVNXMU9mY1IFBEz0vF3K5FDY+GjtoG3CFUqDe7UKEpSCdMxBybnp
        1ZSYVFAtGO0p7OKE68FAV1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=VtUOf36uBI9210QmyAs4SE7UL9cz1spbCpW2/nWRye1gjy
        esh+ib32qK/ctM+XNyHxN9Hrk2+zJekmb8cGc7Kb5Y1LrJhTqda/SRjSQmTmNMfN
        tFmh6wWHXXQHEAyEhe2k3qT/BDYh9fkwapNZShw/D7g4W9N2BahkGnjAxg6ZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D506AF12F;
        Sat, 23 Jan 2021 13:07:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE0A0AF12D;
        Sat, 23 Jan 2021 13:07:26 -0500 (EST)
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
        <xmqq35yvff98.fsf@gitster.c.googlers.com>
        <009a01d6ef80$326572d0$97305870$@pdinc.us>
Date:   Sat, 23 Jan 2021 10:07:26 -0800
Message-ID: <xmqqh7n74jdt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9A37D4C-5DA5-11EB-9AF4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> Summary: --graph used with --oneline sometimes produces ambiguous
> output when more than one commit has no parents and are not yet
> merged
> ...
>> "(branch name)" in the output, instead of painting the commit in the
>> graph by replacing the '*' node with something else.
>> 
>> And how often do you really need to see commits near the root, say
>> the earliest 100 commits, in the 35k+ commit history?  Is it really
>> necessary to tell which among these 100 is the root?  
>
> Yes, and the assumption that they are at the beginning is flawed too.
>
> $ git log --oneline --graph --all | cat -n | egrep $(git rev-list --max-parents=0 --all | cut -c 1-8 | tr '\n' '|' | head -c -1)
>     87  | | * be2c70b7 bug 2252 test case (e.g. for tomcat 9 with unpackWARs=false)
>   2161  | | * 8ef73128 Add migrate-from-blackfat.sql
>   2164  | | * 5505e019 initial
>   2235  | | | | | | | | | | | | | * 83337c67 intial
>   2921  | | | | * ca14dc49 Initial commit
>   2931  | | | * cbdce824 initial commit
>   2963  | | * 8f1828c1 Base applet
>   2971  | * 658af21f parrent pom
>   3026  * 8356af31 Initial commit from Create React App
>
> git log --oneline --graph produces 3026 lines in this example.

Hmph.  Are you saying that you have 3000+ root commits in the 35k+
history?

Whether we add '[root]' decoration to the true roots (like
'(branchname)' decoration we add to branch tips), or painted '*' in
a different color (like '#'), you do not have to look for 'initial',
so having that many roots will not be a problem per-se with respect
to the "log" output, but there must be something strange going on.

I am not going to ask you why you need so many roots, because I
suspect that I will regret asking ;-).

By the way, I sense that your problem description is flip-flopping
again and I can no longer keep track of.  The way I read the message
I got from Kyle was, even when a graph has two commits that have no
parents in the visible part of the history, either Kyle wanted (or
Kyle got an impression after talking to you that you wanted) to see
these differently if one of them is a root and the other is non-root
(but happens to have none of its parents shown due to A..B range).
And that is why I started asking how meaningful to special case only
"root".

Now the message from you I am responding to in the "Sumary" above
says that it is not "root" but is about the placement of graph
nodes.

So, I dunno, with changing the description of the goalpost.  Now it
is that "root" is so not special at all and we only care about that
the a commit, none of whose parents are in the part of the shown
history, is shown in such a way that the user can tell that any
unrelated commits shown in the graph near it are not parents of such
a commit?  Or do you still want to show such a commit in two ways,
one for root and one for the ones above the boundary?

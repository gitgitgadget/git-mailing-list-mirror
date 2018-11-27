Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8C61F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeK0Lay (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 06:30:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0Lay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 06:30:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19F822592F;
        Mon, 26 Nov 2018 19:34:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SsPkKJzaYvyGak2Df5qQg5j3l8c=; b=M83BKZ
        /isNmn9ZoxjM6kW3rQw5KPWsb4QbDgjfEX5pzIiRcKi+5HbbhMITAiQ2ekCUa3aB
        VvvaU66j4ch2umDsnCaFNcOJJUjGDtZsfNDNeW9VXzwiifM1mSea6Md3XfjzUxTO
        L+sETdfoTp+BcULFGpyriDES0phHL4+uxWxWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rAzcKopl9HlapJP1zqLOGf4qUuikwOcx
        +pb34MEf/9Cp79+GU+p10yNr5OK9Ki2GTJwLnG1Y12cM0glALDQ+i1p4fBoXsz2I
        SmacHEF6PoNpa/F/ooRD2Kc8fuLQNMHUOkyuosqIxC2+LxG1qK7R2upn1KTc+Vc9
        rv/fx82F2BI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 132EF2592E;
        Mon, 26 Nov 2018 19:34:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49D8A25925;
        Mon, 26 Nov 2018 19:34:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
        <8736rx1ah9.fsf@evledraar.gmail.com>
        <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
        <20181120174554.GA29910@duynguyen.home>
        <87o9abzv46.fsf@evledraar.gmail.com>
        <CAGZ79kaCidJ1s2vXaQX9b_o7Tk4O+WTdmBSM3RBKX3bCBMSFKA@mail.gmail.com>
Date:   Tue, 27 Nov 2018 09:34:47 +0900
In-Reply-To: <CAGZ79kaCidJ1s2vXaQX9b_o7Tk4O+WTdmBSM3RBKX3bCBMSFKA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Nov 2018 15:10:00 -0800")
Message-ID: <xmqqk1kzuzmg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F5FACA6-F1DC-11E8-83EE-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Maybe we need to step back and consider what the command does.
> And from that I would name it "rewire-HEAD-and-update-index&worktree"
> and then simplify from there. For the beginner user, the concept of
> HEAD might be overwhelming, such that we don't want to have that
> in there.

I'd have to say that it is totally backwards.

Use of HEAD, ref, etc. is merely a means to what the end users want
to achieve, which is to switch to a "branch" (in air quotes, as the
word in this sentence means a bit broader than "a ref that is in
refs/heads/"), to choose which lineage of commits to work on to grow
or reshape the history.  Most of the time, you would be working on a
branch (that is a ref that is in refs/heads/), sometimes you would
be working on an unnamed "branch" (i.e. detached HEAD state, only
difference between being on it and a normal branch is whether it is
named---the history manipulation can happen exactly the same way).

In other words, your initial motivation of stepping back and
thinking about what the command is about is very good.  But in the
context of checking out a branch, the concept the end user works
with are at the level of "branch", not HEAD, ref, index, working
tree (all of which are underlying implementation details that let
you work on manipulating the history, represented by the "branch").

> "content-to-path", maybe(?) ...

Path is not a place.  A path t/Makefile is a shared name of a place
in a tree, the index, or in the working tree.  Renaming "git add" to
"content-to-path" because it adds the content to the index at path
may be equally OK, but it misses the essense (which is that it is to
add to the index and not to anythng else like a tree or the working
tree).

I actually think the easiest-to-understand shorthand for the
operation "checking out the contents at the path to the working
tree" is "checkout".  

These...

>   git tree-to-worktree # git checkout <commit> -- <path>
>   git index-to-worktree # git checkout -- <path>

...are interesting and worth learning lessons from.  These would be
something people would suggest when users start making noises about
"restore-to-path" or "content-to-path" overloads three different
operations and is confusing.

I think "restore-to-path" that can take contents for individual
paths out of either a treeish or the index and update the index and
the working tree, depending on what the user tells it to do, is not
confusing to the end users.  At the conceptual level, the users need
to have a mental model that has three places (tree-ish, index and
working tree) that can hold contents to make use of these
operations, so it is only the matter of how to express it clearly
and concisely.

For that matter, "checkout <branch>", "checkout <treeish> -- <path>"
and "checkout -- <path>" already is a trio of clear and cocncise way
to spell three distinct operations, so with the right mental model,
it may not be so confusing to the users.  And "checkout-branch",
"checkout-contents-from-tree", and "checkout-contents-from-index"
longhands may be a good way to help new users form the right mental
model, as they are more explicit in their names; once they form the
right mental model (that is, there are three places the contents
live, and there are a few operations to move contents from the two
places to the working tree, i.e. what traditionally is called
"checking things out"), they may gradulate to the shorthand form.


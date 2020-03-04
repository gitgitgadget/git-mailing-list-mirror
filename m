Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A23C3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5EB2166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OYIuu2Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgCDQov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:44:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDQou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 11:44:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D948FCD3A9;
        Wed,  4 Mar 2020 11:44:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z7g4unGf9rsGhFymvpHGfNVvOAc=; b=OYIuu2
        LfaoqHPYlJl3qXOphIcBKYfhBbNx8WIAf5HhESCyuvfXFfp7LVKFhmAGv+WOEIxk
        s49AHu3F4onvBvkT+C7At6ilrOfYt0QB/vOStfYGzkmKzPDgUuEGQ9A1mfNYqts4
        BtlLBRWHjOl3wZHCkpnlvwwfmBa1bD+IfdomU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N3vwMNXgm55BaZ7Y9fkIKW+M2P4SmQjQ
        YPpcvq9itTMTSPq/nlNKW00GMgs/5gZdTrc2IYbMjyE58BbhTLlmbyQ/3t4mZfrh
        g1Ml+FTHxxA6aOgU82DGGQgLtXLQAxQfGSLLeu8TrWDctAdqfOEsoc5Sj2NFENp8
        g49KUX6Ob1k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1E74CD3A8;
        Wed,  4 Mar 2020 11:44:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CD6ACD3A7;
        Wed,  4 Mar 2020 11:44:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Takuya N via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Takuya N <takninnovationresearch@gmail.com>
Subject: Re: [PATCH v2] doc: use 'rev' instead of 'commit' for merge-base arguments
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
        <pull.719.v2.git.git.1583325514607.gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 08:44:43 -0800
In-Reply-To: <pull.719.v2.git.git.1583325514607.gitgitgadget@gmail.com>
        (Takuya N. via GitGitGadget's message of "Wed, 04 Mar 2020 12:38:34
        +0000")
Message-ID: <xmqqd09s5atg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74ADC5BE-5E37-11EA-9414-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Takuya N via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Takuya Noguchi <takninnovationresearch@gmail.com>
>
> The notation <commit> can be misunderstandable only for commit SHA1,

Let's step back a bit.  When our documentation says

    $ git log <commit>

we expect that the readers to understand that all of the following
are accepted:

    $ git log master
    $ git log master~10
    $ git log 3868ac720f
    $ git log 3868ac720f7a26f3241f43764d0dc790ec55238f

What gave you the impression that only the last one is valid?  We
need to fix _that_.

The side discussion we had with Dscho touched another important
point (i.e. when a command wants to take a commit but a user gives
it a tag that points at a commit, the command almost always accepts
the tag, finds the commit the tag points at, and uses that commit
instead of the tag---we often mark such a parameter that expects
commit but does not have to name a commit object <commit-ish>), but
it is more or less orthogonal.  All of these are accepted,

    $ git log v2.25.0
    $ git log 61e952148
    $ git log 61e9521487999585dc2b8f27c2a65226fb531a07

not just the last one.

> but merge-base accepts any commit references. Like rev-parse, the name
> of arguments should be <rev> instead of <commit>.

And "like rev-parse" is a poor justification.  It is a lowest-level
command that was written in dark ages, and the language used in the
documentation hasn't been updated to more modern terms.  Back then,
we said "revision" (and "rev" is a short for it) and the term was
invented to mean commit (see "$ git help glossary") but was used
loosely and more-or-less interchangeably with "object name" (in
other words, when the speaker who said "rev" did not necessarily
mean to limit the reference to commits, the word did not limit
itself to commit-ish but also covered trees and blobs).

Now, in the context of "git rev-parse",

    $ git rev-parse eacd13fab7e3

does make sense.  It is OK to give it a short version of a tree
object name (it is the tree of the commit pointed by the v2.25.0
release), so "git rev-parse <object-name>" (or "git rev-parse <rev>")
would be OK.

It is however a poor example to base our decision on how to explain
merge-base.  The command wants to _use_ two (or more) commits to
work on, so like many other commands, when it is fed a tag, it tries
to see if it points at a commit (and barfs if it does not) and use
that commit instead.  In other words, it takes commit-ish.

Saying that it takes <commit> is *not* so bad, but changing it to
<rev> is a move backwards, I'd have to say.

Thanks for working on it, but s/ref/rev/ is not a good change.

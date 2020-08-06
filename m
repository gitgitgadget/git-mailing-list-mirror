Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D3C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB5123136
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gf4mnJDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgHFRKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:10:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63960 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgHFRKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2763E6A4B;
        Thu,  6 Aug 2020 13:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3mfIBT4iQBas87lWw/yheLdzPM=; b=gf4mnJ
        DBkYVcS7tTsKQB36CTF/6kkEr+BNLxiSNcBiYMW7H4jgN3Fc8Ai+Be60gdkHvKi8
        AmwaS5sU6ghEF5R7rETCwgOaViwgqeEuk+1lQasMfMUBOmpG9W/Wmfm1WnNfm1z7
        0LZ16zNLNE6t3sJ7RFd/4ka4bKf47xvQX7eow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LALp99aam4aVHo8IO1rUVwQiG1R+e1YI
        vT/QaK4oPOVH9XZ6kSm9Q9h9ua0ZpqamA5Hu6aBk56kk2iaB+oh5AP09y6q2CYA2
        PNagfQnLin/aVUA+UsIbr3ScxV+WZyotOBcXVkx1voOAJGKZ9N2zj2wQMVGiPzQY
        Nj5LXJqjMTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6854E6A4A;
        Thu,  6 Aug 2020 13:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2820AE6A48;
        Thu,  6 Aug 2020 13:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com> <87ft90uq8w.fsf@osv.gnss.ru>
Date:   Thu, 06 Aug 2020 10:10:25 -0700
In-Reply-To: <87ft90uq8w.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        06 Aug 2020 11:34:39 +0300")
Message-ID: <xmqqmu37lmym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9343656-D807-11EA-BD0A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I asked because I thought you see some essential difference between two
> tests, as you didn't suggest to add similar permutation test to the
> original. I think this reply resolves my doubt.

Yeah, I didn't explain this very well.

The thing is that the way "--first-parent" interacts with other
options that countermand "--diff-merges" (i.e. "--no-diff-merges"
and "--diff-merges=off") needs to be highlighted with extra clarity,
simply because "--first-parent" is different from a simple
"combination" of "follow the first parent commit chain while
traversing" and "--diff-merges" [*1*]

It merely "implies" (or "defaults", which is the usual word we use)
"--diff-merges", so anything the user says explicitly on the command
line countermands it, i.e.

    git log --first-parent --no-diff-merges -p

does not trigger "--diff-merges" because the user explicitly says
that diffs for patches are unwanted after saying "--first-parent"
(i.e. without "--no-diff-merges" later, we would have done the
"diff-merges" implied by "--first-parent").

And

    git log --no-diff-merges --first-parent -p

does not trigger "--diff-merges" because the user explicitly said
that diffs for patches are unwanted by the time "--first-parent" is
seen (i.e. without "--no-diff-merges" upfront, "--first-parent"
would have weighed in to enable "--diff-merges" behavior, but
because the user already said "no", it wouldn't).

This is quite different from options that are orthogonal to each
other.  We do not need permutations of "log --root --cc" vs "log
--cc --root" tested.  We know from the code that they cannot
possibly interact with each other.  We could still test the
permutations, and it may give us more "complete" coverage, but it
may be of very low value.

As to permutations of additive options, we do want to make sure they
are truly additive (as opposed to being the "last one wins") and as
a side effect of ensuring the additive nature, we would end up
testing the effect of the order of options given, e.g. "git commit
-m paragraph1 -m paragraph2".

As to permutations of options that directly overrides or opposes
each other, we may want to ensure e.g. that "git log -p -U2 -U4"
uses four context lines and "git log -p -U4 -U2" uses two or that
"git format-patch --attach --no-attach" does not use attachment and
"git format-patch --no-attach --attach" does (i.e. "last one wins").

But again, especially for commands that use parse-options API
correctly to implement their command line options, it is hard to get
these two cases wrong (e.g. you need to deliberately write a
callback to make "log -p -U2 -U4" additive to use six context
lines), so it may be of lower value to throughly test permutations.
It would not be as low as testing permutations of unrelated options,
though.


[Footnote]

*1* It makes it worse that the "-m" option itself changes behavior
(whether it is given explicitly or implied) when used together with
"--first-parent".  Unlike "git log -m -p" without "--first-parent",
you cannot see the difference the mainline brought in to the side
branch when the "--first-parent" option is in use.

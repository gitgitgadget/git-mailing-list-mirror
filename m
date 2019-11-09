Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EA21F454
	for <e@80x24.org>; Sat,  9 Nov 2019 04:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfKIEzg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 23:55:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57287 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfKIEzg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 23:55:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13EEB25041;
        Fri,  8 Nov 2019 23:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M4MQ4i+nensSuV7VfuRTBcwtfzA=; b=lbwTFr
        2j+OP86v6a4RxEnVUipvT70uzCjyB82YkPeo7S7xOORWvBrlJ1qLAIzkaSVDg8ir
        JdeDeJj6Zo0JA9+e517p8Mk1BxBY36rFEPHbsibBI+mRhMah7yLh/r6CdqbwLKfs
        mjtzlPdC6sv28hfytEfwpC38+0aby1J4qyGGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=riMS97TKzgRUK+3ebd0irxBt6BGQaOE1
        Nl3BgrJFZ7WbcRtrZQoRcoI9bUUnsF6f3IX4uNaaK7R4qguHD7TkWs154Kt2kfBk
        tyM4p7vjHxmOZp2RhLoEHyjyqkjY6HwulXW5RIv66HUAGgOqgh6gqyr5iZyvwMWw
        MVNMH4Cy620=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C5BE25040;
        Fri,  8 Nov 2019 23:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76F702503F;
        Fri,  8 Nov 2019 23:55:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: Should we auto-close PRs on git/git?
References: <20191109020037.GB60198@google.com>
Date:   Sat, 09 Nov 2019 13:55:32 +0900
In-Reply-To: <20191109020037.GB60198@google.com> (Emily Shaffer's message of
        "Fri, 8 Nov 2019 18:00:37 -0800")
Message-ID: <xmqqtv7dlkcb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29613C66-02AD-11EA-8046-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It seems to me that the friendly template text we prefill when someone
> opens a pull request in github.com/git/git isn't being fully appreciated
> by many interested contributors. For some time now, Johannes has been
> slogging through the list to try to narrow it down to folks who are
> still interested in contributing, and yesterday on #git-devel said he
> was pretty happy with the progress so far.
>
> But to me, this seems like a sort of Sisyphean task ...

Yeah, I would not stop Dscho if he likes doing so, but it does sound
like a waste of talent.

> ... want to make contributions and not read the template text, and we will
> have more PRs being ignored forever, especially if Johannes decides he
> doesn't want to shepherd those changes anymore (I would have decided
> that long ago, in his shoes).
>
> To that end, I wonder if we should add an Action to automatically close
> PRs on that repo.
> It looks like https://github.com/dessant/repo-lockdown
> would do the trick.

Personally, I think that it would not help, it would be a waste of
our time to set up, and it would be a waste of our attention having
to worry about giving yet another external read/write access to PRs
to a third-party tool.

I've looked at those PRs, and noticed that the issues that the ones
with unedited prefilled template try to address are mostly those
that would cost more to give help polishing the patch into an
acceptable shape than some of us redo them outselves (more
clarifications below).

Quite honestly, "drive-by contribution" is overrated.  Surely it is
nice if those little typoes and forgotten free()s and off-by-ones
got fixed by somebody without taking too much of our attention, and
it would be nicer if we can help those who started from "drive-by"
status eventually grow to full fledged contributors.

But step back and think about these two a bit.

Those tiny typoes, missing calls to free(), etc. that are low
hanging fruits tend to be "bugs" that have only one obvious way to
"fix", without leaving much room to express the patch in any other
way.  It's not like that they now own the bug and the right to make
a patch to fix it because they found and sent a PR first.  If
somebody else makes the same fix with patch text that happens to be
identical, that is perfectly fine.  The _only_ real contribution to
us made by such a PR is to let us know where such a trivial problem
resides; once that is identified, anybody would fix it the same way.

It would be far more effective use of the time of the community to
make the same fix by any member who already knows how such a patch
should look like, while giving a proper credit for discovering the
issue.

I can already hear people saying that by investing to educate the
original drive-by contributors (instead of "stealing" their patch
and doing it outselves) would yield a larger value in the longer
term, as it could help grow the drive-by contributors into our
community.  I would agree with that argument in principle, but
I do not think that would apply to the drive-by stuff with unedited
prefilled template still intact.

The thing is, I do not think we can expect those who do not even
bother to read the prefilled template to grow to full fledged
contributors.  Certainly before they start paying attention to what
are told to them.

So, I would certainly not veto auto-closing, but I do not think it
would help.

Thanks.

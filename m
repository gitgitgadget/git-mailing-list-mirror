Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8947C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhLQAFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:05:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51767 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLQAFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:05:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D94D162C3B;
        Thu, 16 Dec 2021 19:05:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94fGrVyWqmK+d5h/g00X8gM+18uu+VVCxp0C+j
        hhYyk=; b=dKgLJztquYuDmhBCLs0+sLw3QRg1pKbIlKSnxzz10D9vrPxrbHK6pf
        yirkN+ZjbMkYvlCthC/rX43IFBKwIAIcz/cs+/mNwFWxysBo7xp6KTNQs7QGAzBN
        TGI9DfY+o3SRGJuhhr7KG6bv+bv1ccwhqaksUvZ6q/LnVuwSZHv2Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55D91162C3A;
        Thu, 16 Dec 2021 19:05:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B6AE162C38;
        Thu, 16 Dec 2021 19:05:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com
Subject: Re: Review process improvements
References: <YbvBvch8JcHED+A9@google.com>
Date:   Thu, 16 Dec 2021 16:05:09 -0800
In-Reply-To: <YbvBvch8JcHED+A9@google.com> (Emily Shaffer's message of "Thu,
        16 Dec 2021 14:46:21 -0800")
Message-ID: <xmqqbl1g6qq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0036BF7C-5ECD-11EC-80EE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> ... In the next few months, the Google
> Git team is planning to implement some of the following changes, and
> we'd appreciate your thoughts ahead of time as well as your review later
> on:

I was in some of the discussions that led to this message, and I
feel that some things need to be clarified.  The most important
thing is that it is not a declaration that Google's Git team is
somehow trying to take the project maintenance or the review process
over.  They are merely declaring what they will do to/on the list.

> In the first half of January, I'd like to have a review out to the list
> adding a kernel-style MAINTAINERS file with a few areas of interest. To
> that file, I'd like to add "R:" ("CC me!") lines to subsystem mailing
> lists and interested individuals. My hope is that that will make it easy
> for someone to either add themselves as an "R:" or to subscribe to the
> subsystem list, and then be able to filter their mail based on "stuff
> I'm CC'd to" or "stuff sent to git-partial-clone@linux.dev" - and then
> be able to review every patch in that list. I'd like to create lists on
> topics where it makes sense, too.

OK.  I expect that both the enumerations of "areas of interest" and
the parties who are interested in each area would be rather fluid,
though.  "config" might have somebody actively working on today, but
may not be in 3 months, and those who are interested in config today
may not be in 3 months.

Also, I'll mentally rephrase your "review" to "reviewable patch" in
my head from here on.

>   Submodules
>   submodule.[ch], git-submodule.sh, builtin/submodule.c,
>     Documentation/git-submodule.txt, anything else adding a feature involving
>     submodules
>   R: git-submodules@example.com
>   R: emilyshaffer@google.com

I am afraid not many people on this list knows about the convention.
They can probably guess "R:" is "CC me!" from the previous
paragraph, but they cannot guess (at least I can't) what it means to
have a mailing list there.  Does it mean a patch or a discussion
does not have to happen here as long as it is done on a "list"
elsewhere?

Also, the fluid-ness of the area might not work in favor of separate
mailing lists.  We'll see.

> 2. Draft a ReviewingPatches doc
> Another theme we discussed was the general ambiguity around the act of
> performing code review. How detailed should the review be? Who should be
> examining interoperability with the rest of the codebase? Is it OK to
> reply with only "I don't know what you're trying to do, rewrite your
> commit message please"?
>
> Sometime in January I'd like to have a review out with an outline with
> agreement on the content and organization for a ReviewingPatches doc.
> I'm hoping that it can give some structure to review by including:
>   - How to give different types of review (maintainer vs. individual vs.
>     drive-by nits)

It is unclear what "maintainer" and "individual" reviews are;
hopefully we see a clear definition in the January patch.

> 3. Google Git team will review cover letters and commit messages
>    internally before sending series to the list
> I often find that when I send a patch to the list, reviewers reply
> without understanding the point of what I was trying to achieve in the
> patch. It sounded like this happens to some other Google Gitters as
> well. Luckily, that's fixable by the patch author.
>
> To try and make sure we're sending patches that are easy to understand
> and decide whether to review, we're adding a step to our process ASAP to
> require commit messages, cover letters, and "---" notes to be reviewed
> and approved by at least one other Googler before a topic goes to the
> mailing list. Those reviews don't need to be formal, but do need to
> happen for every reroll of a series. We also will intentionally *not*
> review the diff of changes in this private setting - reviews for code
> correctness, etc. should continue to happen upstream, in public.
>
> I'm mentioning that takeaway in this email to say: if you find you don't
> understand the purpose of a patch from a Googler, please let us know! It
> would be really valuable for us to receive a review saying "I think you
> might be saying X but it's still confusing because you wrote Y"
> so that we can incorporate the source of your confusion as we continue
> to review each other's "accompanying context".

The reason behind this is because these Googler patch authors in the
discussion feel that an initial "why is this even needed?" response
highly discouraging.  They are trying to, by proofreading the cover
letters and log messages among themselves before they are sent, make
sure that the motivation is clearly expressed in their patches.

I think it is a good idea and would encourage everybody to follow,
if possible.  Find a good sounding board in your buddies and ask
them to see if your cover letter and proposed log messages clearly
convey what you want to achieve and why it is a good thing, even to
those who do not necessarily share as much background context.  For
a solo developer (which I've been on this project for quite some
time), well, just "sleeping on" your patches often helps, as a
renewed you tomorrow will give you a different perspective.

But don't spend too much time on it to waste your momentum.  Having
sounding board in your buddies is much better than not having any,
but your buddies may already share too much background context with
you to blind them from noticing why it is unclear to outsiders.

> 4. Documentation changes to encourage commit message quality
> ...
> But I'd like to make sure that whatever commits we use as an example are
> volunteered by the patch author, rather than chosen to be some example
> of an antipattern. So if anybody wants to volunteer an example of a
> particularly unclear commit that they wrote, that would be incredibly
> useful.

If we can do so by picking good and bad example by the same author,
that would make a good educational experience to the readers.  Knowing
that nobody is consistently great would make it less stressful than
always having to try to be perfect.


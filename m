Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338DA1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 16:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfGJQew (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 12:34:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59121 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfGJQew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 12:34:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D83A879109;
        Wed, 10 Jul 2019 12:34:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/o9TUdR2vPMW3hZ0Tuvm1dsqa6A=; b=SXz1II
        xL6Chp6vs1XJpU3PEA78WumPKKoeSPWfGNWnHnn2LCmuRFhZ+gbTAGqYw/Tn22ed
        M2RvvPoDBP6b4BqUDc6HWGA7yA/MwzBRRumYbVuqT/YTkvWucHnvlxU9BwBKP0U6
        Sb2IcOreibPhP8obimYUQWmNurN21VXnK9KjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BBNlD9ZGfCIMj25tFMnbBekH+5Wnz/Rn
        kH8fX7SaYPDZKdYR0dAi2oCDNxfYr+ptsEVCQn7wphjNxRxzA8WFnAVGoK9Zm+ee
        HAJ7u+cbAyNqDijUhTWuERmXCGEh+oDFSelwzYD47/LPf06bnUsILvdjyN8voZ4r
        XrwHh8rwOg4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D13DF79108;
        Wed, 10 Jul 2019 12:34:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F159B79107;
        Wed, 10 Jul 2019 12:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
Date:   Wed, 10 Jul 2019 09:34:39 -0700
In-Reply-To: <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        (Bryan Turner's message of "Tue, 9 Jul 2019 13:51:39 -0700")
Message-ID: <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E3C9238-A330-11E9-9E88-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> I think this is something I've seen come up on the list before[1]
> (Roland can correct me if I'm wrong). What I've seen asked for before
> is the ability to pass the combination "--ff-only --no-ff" and have
> that:
> * Ensure the branch to be merged is fast-forward from the current
> branch (i.e., to ensure no merge commit is actually necessary), but
> * Create a redundant merge commit anyway
>
> This retains the ancestry (as in, it shows where the branches were
> merged), but the merge is always effectively a no-op (no risk of
> unintended interactions, the sort of subtle breakages where the merge
> succeeds but the code on each "side" isn't entirely compatible,
> resulting in broken compilation and/or tests and/or runtime).

Hmph.  I know that the above was totally outside of expected use
pattern back when --ff/--no-ff and --ff-only were invented.  As I
still cannot tell if the use pattern makes sense, or even is
internally consistent, I am not ready to say if the omission was a
bad thing, though.  We did not omit it deliberately, but we might
have been lucky to omit it, which may have prevented a wrong
workflow from spreading.  If it is a wrong workflow, that is, and I
am yet not sure it is not.

The "--no-ff" part is a way to ensure that the series of commits are
still grouped together after they hit the mainline of the history,
so it expresses a wish (by the project using the use pattern) that
they care about topic branch workflow.  A group of commits belonging
to one single topic is about doing one single thing, not a random
collection.  "Make sure we always create a merge to record which
ones are from the side branch and which ones are the mainline" is a
reasonable way to ensure that.

The "the tip being merged into the mainline must always be
fast-forwardable", however, is not consistent with the topic branch
workflow, and I do not mean this in the sense that you should never
rebase just before submitting (which is a bad practice).  For an
initial merge of the topic to the mainline, the project can keep
rebasing to the then-current tip of the mainline, and as long as
they can afford the cycle to test the result, "record the range of
the topic branch by making a redundant merge" would work.  

But that is true only when you have one mainline.  You cannot reuse
the topic to maintain an older mainline (i.e. a maintenance track),
because of the "topic must contain the then-current tip of the
mainline" rule.  A topic forked from the tip of master cannot be
merged to maint without dragging all the other crap happened since
maint to master, and a topic forked from the tip of maint, which can
be merged to maint without problem, cannot be merged to master due
to this "must contain the tip of master" rule.

It gets worse when you need to make a fix-up to the topic.  Has any
of those who advocate this workflow considered a case where a topic
later needs fixups?  Do they always produce a 100% bug-free code so
that they do not need to?

If you have a topic with initially 1 commit, merged to the mainline,
with the "record a redundant merge of fast-forwardable side branch",
you would get this:


    ----O---1--- mainline
         \ /
          A      topic


where the topic only has commit A.  How would you apply a fix this
commit?  "A merged branch must have forked from the then-current tip"
would mean you would do this:

    ----O---1-----2--- mainline
         \ / \   /
          A   \ /  topic
               B   topic-fix

i.e. you cannot touch 'topic' branch, which has 'A', that is sealed
by the fact that it was already merged to the mainline and the rule
that you reject a merge of any side branch that does not fork from
the then-current tip.  You are forced to create B forked from the
mainline to fix A and merge it back to mainline, losing the valuable
"these commits, together, achieves this thing" grouping you wanted
to achieve with the topic-branch workflow, which is what "--no-ff"
is asking.  This is the reason why I doubt the workflow that wants
to say "record a merge with a side branch that contains the current
tip of the mainline" is not even internally consistent.

So, I dunno.



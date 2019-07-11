Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB281F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfGKRDX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:03:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51892 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRDX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:03:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1917E6AAB1;
        Thu, 11 Jul 2019 13:03:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lmzeVDsvPnyTYrADSUcxDLkONcg=; b=xIQ2Yo
        B0bb8MM7pBweil9zG84h8wyoFg91cJrQZ6EevRFUq7/zD6NTlDJERGpOBpehBBZ/
        1KmHuxDQaZ7TxXhI4opDVAXwew1r+ifErGvW3nR9VnVdqsbrUEhh/4Chf6ja8wtF
        YlI8cZCIKYpLuUil4XGuokA8+mMxuzlTGFhEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AhJsEx5SqYIfO7uPpgNHxB4DnwBNKosf
        e24fKSH0Lq+VxZpyDW3Y2Ll17feEk9RoP2m/xlrJ8PcevGm90/97tk1T/OtNOvH4
        Uj/nr8tSFWusRSctMa7U8Cw+pfZWo/FWssKxHhsHObTJ8OAFMCJkQdUZcgmc8wvL
        ojMuH5/6OfY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12B026AAB0;
        Thu, 11 Jul 2019 13:03:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 219476AAA9;
        Thu, 11 Jul 2019 13:03:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
        <87sgrdf91j.fsf@osv.gnss.ru>
Date:   Thu, 11 Jul 2019 10:03:11 -0700
In-Reply-To: <87sgrdf91j.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        11 Jul 2019 08:13:28 +0300")
Message-ID: <xmqqftncsdv4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C52BA50A-A3FD-11E9-84BF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
>> The "the tip being merged into the mainline must always be
>> fast-forwardable",
>
> It's rather "the tip being merged into the mainline must be fast-forwardable the
> first time it is merged".
>
>> however, is not consistent with the topic branch workflow, and I do
>> not mean this in the sense that you should never rebase just before
>> submitting (which is a bad practice). For an initial merge of the
>> topic to the mainline, the project can keep rebasing to the
>> then-current tip of the mainline, and as long as they can afford the
>> cycle to test the result, "record the range of the topic branch by
>> making a redundant merge" would work.
>
> Yes, that's exactly it, and, as the rule holds for the first topic merge
> only, the rest of workflow is as usual, no drastic changes.
>
> Overall, it only ensures the first merge of the topic is semantically
> simpler, nothing more.

But then you have to know to say or omit --ff-only if you are
mergint the topic for the first time.  The second and subsequent
merges, your merges won't be "semantically simple" at all.

And your first "semantically simple" merge is likely to be a merge
between the then-current tip, and a topic that has been prepared
over a few hours (or longer) and has sufficiently been tested, but
has gotten rebased immediately before being merged because of this
"must fast-forwardable to maintain semantic simplicity" policy to
catch up with the ever-moving-forward tip of the mainline.  The end
result of such a "semantically simpler" merge is as good as the
"freshly rebased, never had sufficient time to verify the result"
iteration of the topic branch.

How would such a state that was freshly rebased without chance of
enough validation be better than merging the "sufficiently been
tested in isolation" state without doing such a rebase?  If your
answer is "but the contributor would test after rebasing and before
doing the --ff-only-plus-no-ff merge", then perhaps the contributor
can also test the result of a (trial) merge before it actually gets
merged, no?

If we have a project like this:

        A               topic that is slightly stale
       /
  o---F---o---o---X     mainline

M, A', and N should end up with identical trees:


        A-----------M   topic that is slightly stale, merged into mainline
       /           /
  o---F---o---o---X---N mainline with A' merged
                   \ /
                    A'  mainline with A rebased on top as A'

And by forcing to rebase A to A' before merging into the mainline as
N, compared to advancing mainline from X to M, one major difference
the workflow is making is to _lose_ the information that the topic
was cooked in the context of an older mainline and did not take what
happened since F until X into account.  Rebasing it to A' without
giving the result sufficient vetting means you are forcing the
updated topic to pretend as if it also took F..X into account,
making it harder to diagnose subtle interactions with A and F..X
later that you did not spot when you made A'; merging to create M
does not have such a problem.  As A' and M would have the identical
trees, the same bug resulting from such a subtle interactions would
be there if A' has such an issue, but at least M is more honest and
lets us know that A itself predated what happened between F..X.

So...

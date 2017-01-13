Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE1D20756
	for <e@80x24.org>; Fri, 13 Jan 2017 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdAMTOu (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 14:14:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54591 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750805AbdAMTOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 14:14:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3364D5E574;
        Fri, 13 Jan 2017 14:14:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3VeSIWQhBocYbinByuliik6voI=; b=Ru/ANz
        8frEPPFgncAOa+HD+yXfveLrFrUWQ6o+zTdZafjRECkCek/Zy7YRwrl/BNIh/J0I
        1JCwQTC/V8wjYsouDGZOTylGhiy9JOKX2+xtMSa7Efm2fRm+xQIX8krzSHxAxjbd
        ulAAHz0QhO1/rGRtHXGyUl3k5GEJZFeE6he4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wV67hXDxjhkIjLupSfa0OYsJ+rlyKdHO
        NkE+FBS7f6uz2lx7oX8I6tloCYnncvz8s+j7hVR+TTuBSv2EmF1fhCNXhSm1InDI
        +uwFQc0+nkwSiZzyhXzl6gFmGpBIGhELlgUG7bn7YimZwUNSjTsVelCvlM5UocAb
        uQVwO2JbaDE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29C7C5E573;
        Fri, 13 Jan 2017 14:14:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72EE35E572;
        Fri, 13 Jan 2017 14:14:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Manuel Ullmann <ullman.alias@posteo.de>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation/bisect: improve on (bad|new) and (good|bad)
References: <20170113144405.3963-1-chriscool@tuxfamily.org>
Date:   Fri, 13 Jan 2017 11:14:04 -0800
In-Reply-To: <20170113144405.3963-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 13 Jan 2017 15:44:05 +0100")
Message-ID: <xmqqinpihiwz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 736F7422-D9C4-11E6-AC6F-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The following part of the description:
>
> git bisect (bad|new) [<rev>]
> git bisect (good|old) [<rev>...]
>
> may be a bit confusing, as a reader may wonder if instead it should be:
>
> git bisect (bad|good) [<rev>]
> git bisect (old|new) [<rev>...]
>
> Of course the difference between "[<rev>]" and "[<rev>...]" should hint
> that there is a good reason for the way it is.
>
> But we can further clarify and complete the description by adding
> "<term-new>" and "<term-old>" to the "bad|new" and "good|old"
> alternatives.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-bisect.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.  The patch looks good.

A related tangent.  

Last night, I was trying to think if there is a fundamental reason
why "bad/new/term-new" cannot take more than one <rev>s on the newer
side of the bisection, and couldn't quite think of any before
falling asleep.

Currently we keep track of a single bisect/bad, while marking all the
revs given as good previously as bisect/good-<SHA-1>.

Because the next "bad" is typically chosen from the region of the
commit DAG that is bounded by bad and good commits, i.e. "rev-list
bisect/bad --not bisect/good-*", the current bisect/bad will always
be an ancestor of all bad commits that used to be bisect/bad, and
keeping previous bisect/bad as bisect/bad-<SHA-1> won't change the
region of the commit DAG yet to be explored.

As a reason why we need to use only a single bisect/bad, the above
description is understandable.  But as a reason why we cannot have
more than one, it is tautological.  It merely says "if we start from
only one and dig history to find older culprit, we need only one
bad".

I fell asleep last night without thinking further than that.

I think the answer to the question "why do we think we need a single
bisect/bad?" is "because bisection is about assuming that there is
only one commit that flips the tree state from 'old' to 'new' and
finding that single commit".  That would mean that even if we had
bisect/bad-A and bisect/bad-B, e.g.

                          o---o---o---bad-A
                         /
    -----Good---o---o---o
                         \
                          o---o---o---bad-B


where 'o' are all commits whose goodness is not yet known, because
bisection is valid only when we are hunting for a single commit that
flips the state from good to bad, that commit MUST be at or before
the merge base of bad-A and bad-B.  So even if we allowed

	$ git bisect bad bad-A bad-B

on the command line, we won't have to set bisect/bad-A and
bisect/bad-B.  We only need a single bisect/bad that points at the
merge base of these two.

But what if bad-A and bad-B have more than one merge bases?  We
won't know which side the badness came from.

                          o---o---o---bad-A
                         /     \ / 
    -----Good---o---o---o       / 
                         \     / \
                          o---o---o---bad-B

Being able to bisect the region of DAG bound by "^Good bad-A bad-B"
may have value in such a case.  I dunno.


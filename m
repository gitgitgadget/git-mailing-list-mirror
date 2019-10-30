Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7801A1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJ3AVe (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 20:21:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61181 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJ3AVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 20:21:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 492D43C891;
        Tue, 29 Oct 2019 20:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9CU0EoAtTBp5c7lsojsIuW8khq8=; b=wBKTT0
        erHR/l1ys4FXbXuuYqDwi+lJJzIQ4POORrfxo8soiPyyjAtVlI54ZPuPTRL0EgAO
        k0WD5yrW/9T9CLpy0iCxL7Ucxd552s7wBSZQ3dztUYs/nzOUnAOuw5SLatFwW+Ie
        gv4IrRE2HWNkGjaqvDMUebenxnsQhhBu84/W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pt0tMkARMX7WOH6xJ9CTG/Wp1743U7YA
        yCytvvnxkHeuA8Xruwqxzn24A590t1SweHXLclIlo8/6g5yTM91vargIypn6frvn
        vB7OFWNJHdweh4DxQObVWVozZwpWOtv7wc3fkXssjbtSqgQUB9Y11CNZGHsLwGLJ
        RgBxK2fLAXc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D4D3C890;
        Tue, 29 Oct 2019 20:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71FA83C88D;
        Tue, 29 Oct 2019 20:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Utsav Shah <utsav@dropbox.com>
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
        <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
        <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
        <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
        <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
        <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
        <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
        <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com>
Date:   Wed, 30 Oct 2019 09:21:27 +0900
In-Reply-To: <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com>
        (Utsav Shah's message of "Tue, 29 Oct 2019 16:50:54 -0700")
Message-ID: <xmqqh83r5bi0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 374092C8-FAAB-11E9-BF15-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Utsav Shah <utsav@dropbox.com> writes:

> Thanks for testing it out. The unpack_trees bugfix is especially useful.
>
> There's tons of places where we're using ce_uptodate(ce) that could be
> optimized by checking CE_FSMONITOR_VALID. One example is in
> run_diff_files in diff-lib.c
>
> Should we add a check for CE_FSMONITOR_VALID in all of them? Should we
> do that in this patch? Or should we take the time to refactor and
> flesh out bugs in unifying it with CE_UPTODATE?

If we rephrase the first question slightly, i.e. "should these
places all be avoiding lstat() based check when fsmonitor says the
path is up to date?", I would imagine the answer is absolutely yes.

I would further imagine that the implementation of the interface to
external fsmonitor itself may have to distinguish "we know/have known
this path is clean" vs "we just got told by fsmonitor that this path
is clean", so losing FSMONITOR_VALID bit might not be an easy or
clean conversion, in which case my earlier "can we perhaps lose it
and have fsmonitor interfacing code to directly set UPTODATE bit?"
would lead us in a wrong direction.

But ce_uptodate(ce) being the primary way for the callers that care
about "is the path known to be up to date?", it is unsatisfying that
all of them have to ask

	if (!ce_uptodate(ce) && !(ce->ce_flags & CE_FSMONITOR_VALID))
		... process ce that is not up-to-date ...

So I would say that the longer term goal should be to let them ask
ce_uptodate(ce) and have that macro automatically take FSMONITOR bit
into account (in other words, those who want to know if ce is fresh
should not have to even know about what fsmonitor is).

Perhaps we can take a polished version of this "'reset --hard' can
and should notice paths known-to-be-uptodate via fsmonitor" as an
independent patch (to reduce the number of things we have to worry
by one) for now?  Taking this patch means we would now have one more
place that checks both ce_uptodate() and FSMONITOR_VALID bit, but if
we would be auditing all such places before we can decide what the
best way to reach the goal of allowing them to just say ce_uptodate()
without having to spell FSMONITOR_VALID, that probably is a cost
worth paying.

Thanks for working on this topic.




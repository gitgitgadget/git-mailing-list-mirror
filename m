Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29FC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F5E208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcTcgMii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgJMT1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:27:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53289 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMT1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:27:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92DDB734F2;
        Tue, 13 Oct 2020 15:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jESpxPRwAEqMfWCwX9qZ25jXWgY=; b=fcTcgM
        iiu08RHtcNoor2BYGUIhGFEBR9g739Igi4TmU+02F9BXlPYDrzJ3kk7UkwdWjO5H
        k6sucCf1EM57tHBc2uLKtDClcUacnMwoN3zUYsIM4Nqvl9XGB0NceMgcOy9tauYl
        SmLRnaRCl/7sWUVbwW7i5wPvecLXWQgoGhQuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WR57jvalj06ia6W1LHVvrvDbJS8AvE85
        Fa9VhLi6UELv46j3FN1rBo7Dpn6sgrZmwZtkRMnVKGIFTcaTtdgWRfmsWtstqDLL
        PuJ0hT0NcOhyOfH2ZAJt/X4IhtwtH7e1oylIfI63kpzsnG407Fb8LIXNHgMGJE94
        1u7uneShFYw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B3C4734F1;
        Tue, 13 Oct 2020 15:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20D28734F0;
        Tue, 13 Oct 2020 15:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] test-lib: reduce verbosity of skipped tests
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <bb2317972a8faf0358aaad1247fdfd2af2ea142d.1602545164.git.gitgitgadget@gmail.com>
        <20201013154439.GB1913367@nand.local>
        <CABPp-BFj0S1Z7rgNGsUuRurNgKFOqtD_Nm0Dr3fZt-RFMTwoDw@mail.gmail.com>
Date:   Tue, 13 Oct 2020 12:27:12 -0700
In-Reply-To: <CABPp-BFj0S1Z7rgNGsUuRurNgKFOqtD_Nm0Dr3fZt-RFMTwoDw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 13 Oct 2020 10:56:54 -0700")
Message-ID: <xmqqpn5mj59r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 186EA9F0-0D8A-11EB-A51B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>   skipping test: writing bitmaps via command-line can duplicate .keep objects
>>   ok 2 # skip (--run)
>>
>> or:
>>
>>   ok 2 # skip writing bitmaps via command-line can duplicate .keep objects (--run)
>>
>> I have a slight preference towards the latter, since it keeps more of
>> the information in the TAP line, and it cuts the total line count of
>> output from skipped tests in half.
>>
>> For what it's worth, I'd also be fine with the patch as-is.
>
> I was worried that shortening it as much as I did would run into
> objections for some obscure reason.  But if no one objects, I think
> I'd also prefer your latter suggestion for shortening it even more.
> It looks like the dual output for skipped tests comes from commit
> 04ece59399 ("GIT_SKIP_TESTS: allow users to omit tests that are known
> to break", 2006-12-28) by Junio, so it'd be nice to hear his opinion
> on how much we shorten it.

I am afraid that the surrounding code has changed so heavily that
expertise as the author of 04ece593 would not count that much in the
context of today's code.  Back in the late 2006 version of the code,
text_expect_success asked test_skip to see if a test should be
skipped, and when the latter says yes (which also gave "skipping
test" to the verbose output and "skip $test_count: $1" to normal
output), test_expect_success did not even call test_ok_ or
test_failure_.  So "ok 2 # skip ..." we see in the quoted part of
your exchange above is probably a much more recent invention.

As long as we can convince ourselves that writing similar things to
fd #1 (for tap in "ok $count # skip ($why)" format) and fd #3 is
redundant and not useful, I think removing the utterance to fd #3
in this codepath may be a reasonable thing to do.

    ... goes and scans for ">&3" in test-lib.sh and
    ... test-lib-functions.sh

OK, I think we can safely lose the one we send for the "verbose"
case here and that would turn our use of fd #3 more consistent with
how it is used by other parts of the test framework.

Thanks.



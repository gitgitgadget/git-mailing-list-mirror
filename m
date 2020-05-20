Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C545C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D779C204EF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrlWCOZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgETDQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 23:16:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60139 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETDQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 23:16:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE8206ED5F;
        Tue, 19 May 2020 23:16:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NRdAiLHJv/vZ2vGbYEyMMKiCeI4=; b=QrlWCO
        ZN6vy5XQDEyCYUGR2GfNYM+Dg9H5JhbhocirtOh6hPaokWZMJU+nc6Mq861t2Ctc
        sBXKPY0W2GZP5sPCCeCzf89/X6ULrHRS2RC6GPXjgdrUxPbSlDJ/0SsRC5ubc8N9
        cWXkxluX/he6dDuTZ8p8ePpt7M7u38OkoZNlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QRmnHmXymX/0RUCg9wUFB9y0+U0H7rKo
        SimQt59ccfaGcHrYqw/ccQ5rHNqMFcX7BKyLNT0gvK0UKdrQhZMKh0P+eGh450TI
        WiyZWQwn+X4l/ah7Sm+alTg+KArJ67HrdIPlYQhSyrqf7dHYwO0b05khAXVPxORL
        qfJgB/RdVt4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7F7C6ED5D;
        Tue, 19 May 2020 23:16:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1254F6ED5C;
        Tue, 19 May 2020 23:16:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2020, #06; Tue, 19)
References: <xmqqpnazxueg.fsf@gitster.c.googlers.com>
        <CABPp-BG_0S0pbcGgDELt535eUVYuuv8gtr4Qfgn79xzeL6m4Jg@mail.gmail.com>
Date:   Tue, 19 May 2020 20:16:03 -0700
In-Reply-To: <CABPp-BG_0S0pbcGgDELt535eUVYuuv8gtr4Qfgn79xzeL6m4Jg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 May 2020 19:52:08 -0700")
Message-ID: <xmqqlflnxpn0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D0E80C4-9A48-11EA-B47F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, May 19, 2020 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * pw/rebase-i-more-options (2020-04-29) 5 commits
>>  - rebase: add --reset-author-date
>>  - rebase -i: support --ignore-date
>>  - sequencer: rename amend_author to author_to_free
>>  - rebase -i: support --committer-date-is-author-date
>>  - rebase -i: add --ignore-whitespace flag
>>
>>  "git rebase -i" learns a bit more options.
>>
>>  Needs review.
>
> Had two, one from Alban and one from me.  Should this be updated to
> "Waiting for a reroll" (cf.
> <c3dad0e2-e381-499a-af02-ef3f49207c49@gmail.com>)?

Excellent; the fewer topics needing review, the better.

Thanks for a pointer.


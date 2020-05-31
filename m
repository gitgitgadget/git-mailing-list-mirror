Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0AC433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8164B206C3
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVh+ID6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEaQRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 12:17:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54082 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaQRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 12:17:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 011CA66227;
        Sun, 31 May 2020 12:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NaI/eri8m7EfWf8E8Qx17naPbKk=; b=cVh+ID
        6Q+V74mW3LJO5K6milj97RvrJk5ci818PiupUS6S4cFCvOPz1pUjgiicp8kE51yO
        0AjR28isHAbAQ0ysEHy4hXFq2hpdkdyCjMc3daQ9nK+DIL28Qu62jk4R0kujSM5h
        TyxOWwq1I/1763XNRznxBx1rDV2EWPnfxCQWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xwHPo9tMH3IKVzPaihMTFgWnvxj92uWy
        OI53ajQF1PgPqrd0zIY1wEUZIRvXQ0u1c9SZ3RYxEGFw3ADFNPMF9nl+qN4uDOFd
        kDtlil646MBKICh8qp+YfLP97ZuGIZAAfJ+Lm09I6dPyycc8/hEb7wSr8ECbxc6R
        UaBD0UqIcaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECBB166226;
        Sun, 31 May 2020 12:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A0C466225;
        Sun, 31 May 2020 12:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/8] Introduce CMake support for configuring Git
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
        <xmqqy2pay216.fsf@gitster.c.googlers.com>
        <CAKiG+9WWqHJNz_fEaQ+Rw3sRJSFOutCt772v1mbZeOS2rWpDOA@mail.gmail.com>
Date:   Sun, 31 May 2020 09:17:26 -0700
In-Reply-To: <CAKiG+9WWqHJNz_fEaQ+Rw3sRJSFOutCt772v1mbZeOS2rWpDOA@mail.gmail.com>
        (Sibi Siddharthan's message of "Sun, 31 May 2020 00:20:43 +0530")
Message-ID: <xmqqpnakw02x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 384CF370-A35A-11EA-BB46-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> On Sat, May 30, 2020 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Everything after the "Changes" line does not belong to the commit
>> log, as it is no use for those who read "git log" output and
>> encounter the "first" attempt to add CMake support there.  There is
>> no need to tell them that you did things differently from this
>> version in the past, as they simply do not know what you did in the
>> previous iterations, nor particularly care about them.
>>
>> These *do* help reviewers who saw previous iterations, and the space
>> after the three-dash line below is the right/recommended place for
>> them.
>>
>> The above applies to other patches in this series.
>
> Do you mean this line '---' below?

Yes.

> If so how do I place the changelog below them?
> I just do `/submit` at gigitgadet/git.

Sorry, I don't use GGG, so the question needs to be redirected to
those who do and enhance (Dscho cc'ed).

>> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>> > ---

Here is what I meant, but another place that is suitable to describe
differences from previous rounds is the cover letter.  If the split
of tasks between steps in a multi-patch series hasn't changed from
the previous round, it makes it easier to review if the changes
since the last round for each individual step is described in the
message itself, like you did.  It just needs to be done outside the
log message.

Thanks.

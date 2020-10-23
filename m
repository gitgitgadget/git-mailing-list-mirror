Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E2C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6321D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rtFJEbi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463274AbgJWPnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:43:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64430 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369960AbgJWPnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:43:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31E4DF7904;
        Fri, 23 Oct 2020 11:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V57HdDIsYILXEjzx7GT4dPlOgyc=; b=rtFJEb
        i26CSAJncEDJ+rRmH6uHllRvbJB9tb7b7AGAqnWblFoJ9JIKvGPxEoyB6RD2BIcq
        nc+BHERn/UjG5BWYZrmlekOD1Nq6i+sjYfpjyV01PKIT3bDG8aMs83xUMBgxmWkv
        qNu9qmak/aSQCrY6D+i4Bk7vCAs51A4la8Hck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZePo5RTnNkiGV0lZZLjbYKpFjV+ZwpD
        0CRebSBk1pnqxlH2McSlpgB7Na5KujL+Kr9l0zUJpCDGqp0WYLakU4qEuwd0FT8r
        QcDeQMINggVt9KO3SDUsK+HRxSZw+TQ7u8g0yOB65gVRha/JUHFIuD9Zfe85Sv6E
        CL5jKrztKxA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A0DBF7903;
        Fri, 23 Oct 2020 11:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D9A4F7902;
        Fri, 23 Oct 2020 11:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
        <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
        <20201021162044.GB111581@nand.local>
        <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
        <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com>
        <xmqq7drinqxv.fsf@gitster.c.googlers.com>
        <CAHjREB7+3QtPw6X33GEB8SiDjSfvNhb15+_rpy=McmqBdcMebQ@mail.gmail.com>
Date:   Fri, 23 Oct 2020 08:43:02 -0700
In-Reply-To: <CAHjREB7+3QtPw6X33GEB8SiDjSfvNhb15+_rpy=McmqBdcMebQ@mail.gmail.com>
        (Sangeeta NB's message of "Fri, 23 Oct 2020 16:29:52 +0530")
Message-ID: <xmqqeelphrsp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70860FB6-1546-11EB-B8A6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

> Yes, I agree. We need to make some changes in `git rebase` to make it
> work from the subdirectory, but that doesn't mean that we should
> completely restrict it from running in the subdirectory, and the same
> follows for `git bisect`.

You actually don't have to make "bisect" work from the subdirectory.

You instead can detect the case where your $cwd may be made to
disappear, and allow "git bisect" to continue if you are certain
that you are not in the funny situation.  You need to protect the
user from funny situation by refusing to run from a subdirectory
only when needed.

Besides, as Phillip mentioned, there is a big difference between two
commands, isn't it?

"git rebase" would ask for help to the end-user by returning the
control when anything goes wrong (e.g. it may not be able to replay
a commit while the user is sitting in a directory that has already
gone), but "git bisect run" would just interpret any failure, not
just the ones that are caused by genuine test failure but caused by
$cwd going away, as "we saw a bad revision".  It would cause a lot
of wasted cycles, instead of immediately stopping when there is
trouble.  So the first thing that has to happen if we want to allow
"bisect" to run from anywhere is to teach it to detect when the $cwd
went away, and stop to give control back to the user to deal with
the situation (it might be the matter of "cd /path/to/top" at that
point), instead of blindly continuing.  Only after that is in place,
we can safely allow it to start from a subdirectory.

Thanks.

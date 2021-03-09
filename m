Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0310C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A175D64FF4
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 23:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhCIX2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:28:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63784 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIX22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 18:28:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95CA811B9AE;
        Tue,  9 Mar 2021 18:28:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+X/8g2voGLYP1QvhQRAuI1KCC4=; b=rlhu6F
        TL+qunqQn7t2XDHjFGu/mslSlUoDy7W4fup3eLpHrcCMav4/vSpWP+rDSSCE7gsL
        X7L9qEfjps5vBqUEP4ttnpMyijmPCUuye/x9hvfpJyaSONLt2LNwoBIDoTWNPDGQ
        Gk9glgpWQpRXHwtfGyadc0tvhy/EkM5n2qMEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ecvfbhkSTWYBaXFeai92SZv7wn6AMJId
        nYwrJ0RgntuLlh4fCp9yCEYtoxKeLQLxPlTGimQVqXhiGEjU6GBmQJjmv5DIx/O6
        uVqxAz9H74X78BQCXUCFpb6PLs+n64kIiH5dECeEjNmIsBPb+LNRXga70mQqGidr
        Dfyd2z6FYeA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DF4B11B9AD;
        Tue,  9 Mar 2021 18:28:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4EFC11B9AC;
        Tue,  9 Mar 2021 18:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/12] Simple IPC Mechanism
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 15:28:24 -0800
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Tue, 09 Mar 2021 15:02:25
        +0000")
Message-ID: <xmqqk0qfzz3b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2594BB60-812F-11EB-B3A7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> .... I think the combined
> result is better long term than preserving them as two sequential series.

Yup, I think that is a sensible thing to do, too.  Just kick the one
in 'next' out by reverting them, and queue a cleaned-up series to be
merged to 'next' once the upcoming release is out.

Thanks.

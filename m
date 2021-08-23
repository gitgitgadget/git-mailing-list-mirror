Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA28C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3A6136A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhHWIGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:06:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhHWIGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 04:06:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB0F2EB99F;
        Mon, 23 Aug 2021 04:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RMqSDkWp/WV0nVmVXYNb1mVzYeKbyw0N19qLSf
        yYC9M=; b=sYtUaxpUsfZAISeKz9/j1qa3giaXbcas7YkhYCOh5j6t68LISgPLDb
        Q7erUblzZCVFwZngHRNd6qh3AeWgFrib9ATIEU7v0ihWo6YQEpIuV3oGJ4v3NWjw
        hROuFbpMeJa78IzA/8paJruVXrNJLEM0GRXvF3xM3Zv527MJhUsEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3EA9EB99E;
        Mon, 23 Aug 2021 04:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EB24EB99D;
        Mon, 23 Aug 2021 04:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
References: <20210820193504.37044-1-johannes@sipsolutions.net>
        <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
        <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
Date:   Mon, 23 Aug 2021 01:05:40 -0700
In-Reply-To: <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 23 Aug 2021 09:21:10 +0200")
Message-ID: <xmqqo89osi0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8A550C4-03E8-11EC-90E2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> I just needed to go outside the current test git directory, the tests
> are running in a way that the current working directory is already the
> git tree I'm operating in.
>
>> Even if you mean to use "cd",
>> please do so within a sub-shell.
>
> I thought about it, but clearly all the tests are run in a sub-shell, so
> it didn't seem necessary? But happy to change, I don't really care
> either way.

Please learn to care before you write your next test, then ;-)

These tests are not run in a sub-shell; they are eval'ed, so that
the assignment they make to variables can persist and affect the
next test piece.

Thanks.

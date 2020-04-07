Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7EC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1720719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc8OihRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGXET (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:04:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50608 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGXES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:04:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9DB547FA0;
        Tue,  7 Apr 2020 19:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w99grdE9TAB1kHe0lpzQ3lthTqM=; b=bc8Oih
        RWqWENel/MTR40BBYS77AccOhprSYeLDPQlQAyrj8GCoTegsVLKPrMpsiKUfewI3
        GxQd6/LYLrpMwDPzsASPoeZh6KD7TKcj47d64C+t+GJ2xuMh0DIQwlfiRpfQVCNK
        1/3KMPq2O1vGmEKZ8i6cm6pB43l4nufjxe2i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=USStuFv0ZbvlCjUivfpkzoUqfp5Ernxt
        2tiKkQRP9lvxwZ1FEVq8huauS5O5IyJYjwObgxiSnzT1m1QxS4ZNCzMW5U2a3dHL
        ZNM54a2QBD4bjmXia6fSKatjS/nuclpxMPadWfnjnOkgDnxUDV/52eiJDGo10FKM
        MPk0yujIXv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A029447F9F;
        Tue,  7 Apr 2020 19:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE21B47F9E;
        Tue,  7 Apr 2020 19:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/6] fixup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Date:   Tue, 07 Apr 2020 16:04:14 -0700
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Tue, 7 Apr 2020 15:11:19 +0100")
Message-ID: <xmqq1roysxsh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19FBD2E8-7924-11EA-80E4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The tests for ra/rebase-i-more-options were not as comprehensive as
> they could have been and some of the tests that we did have didn't do
> a good job of testing what they purported to. This series cleans up
> the tests and fixes a couple of bugs (thanks to Jonathan Nieder for
> reporting one of them). The bug fix reworks the code to try and make
> it clearer.

As t3433 is already taken, I've queued a SQUASH??? commit at the tip
of the topic to move it to t3436 while queuing (which is another
fallout that needs fixing while we resurrect an outdated series).

Thanks.

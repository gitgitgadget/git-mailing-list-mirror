Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC24C47258
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527B42064A
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWlXVVl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgEEW2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:28:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61519 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgEEW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 18:28:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA3F5813B;
        Tue,  5 May 2020 18:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6CZwf7qywTMhPy9uLBM3bjQldq8=; b=FWlXVV
        l2MPyK4WE8AviHPhz36nfK/Ehsjym4Xuw1x/bH8fZ9H1nfwLRZAp7tcLgtIPxFBY
        3mzPnQwYvNd/TcVWlcGoU7MkSf6Y22jeNlSGLlE35GOMroPhNQdCqTpCRuuROUpl
        xe9xcm4q9kHrENhyErBICUgvPKJDzm4saU1l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tAObAY7o5y+zdGMUdcUC6iiyDiBJt604
        gjS0+ARw2PydX9m40DoZky1hIaNAvKTu02AX832VMtN/MgvK1+2GYi/N5bAD29KL
        JIyxbkhss8G8AbMnHUcffexGarn7sTo8olMaACN3igs93WItgp8GM5ycVK6/m98z
        R+EjNtErwrs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 653A05813A;
        Tue,  5 May 2020 18:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E101058139;
        Tue,  5 May 2020 18:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <xmqqlfm69il6.fsf@gitster.c.googlers.com>
        <20200505215843.GA646020@coredump.intra.peff.net>
Date:   Tue, 05 May 2020 15:28:10 -0700
In-Reply-To: <20200505215843.GA646020@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 5 May 2020 17:58:43 -0400")
Message-ID: <xmqqd07i9fut.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3AC3CA0-8F1F-11EA-8B24-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > Or since we're running a shell in a VM, we really
>> > could just run "./allow-ref $refname" and let individual forks specify
>> > whatever shell code they like.
>> 
>> I presume that you are saying "checking out the tree of refs/ci/config
>> and there is a program allow-ref that can tell which one to run ci on"?
>
> Yes, exactly.

I guess a simple example implementation of allow-ref script, with a
bit of instruction to tell people how to initialize a separate and
otherwise empty repository with just a (possibly customized) copy of
the script in it, and push its 'master' branch to refs/ci/config of
their Git fork, would be a way to go, then?

Sounds simple enough.  Cycles to spin up a VM that adds 3 seconds
latency, only to know that a branch won't need to be built, does
sound like a bit unfortunate, though.

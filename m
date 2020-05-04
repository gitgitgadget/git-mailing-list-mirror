Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFBC47247
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B168620707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p041MgpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgEDWww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:52:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64029 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgEDWww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 18:52:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79F93BE079;
        Mon,  4 May 2020 18:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VY0D6AzDX/MZ56OPRxaxEYBRKKQ=; b=p041Mg
        pCnQUO3qWW5GWKmt/cyc//VAlMSrEwNLqdg7GYZZlJG3U2OiA9II0yYPUL3HOHat
        DIihl2oeOFqGRnpI3nNa2P8HxPzvLk3oAxOZ7D1Nvb71ODm6K+KNqgcr96NuUs0X
        eR6U6Fe9pKhRTaDJiWfLvZWgzyLUhp1ua3qng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lmjugwxCEeJa9NKRu/cA7AM6mgZiqINB
        UpiUiSS17rKXhr9I41wuMYGoeUh6wVrcDR8xCQARSDXq2NAQah5XFEhRPYoHUkaw
        ZyF1nReHI00CXyWa9YSvDlj5XfhiZzWbIruHeOXKYJ9SYAbq7zkekcfsyc0H3UoZ
        iDcKra7IrT8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72590BE078;
        Mon,  4 May 2020 18:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 921F0BE077;
        Mon,  4 May 2020 18:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
Date:   Mon, 04 May 2020 15:52:44 -0700
In-Reply-To: <20200504215824.GC45250@syl.local> (Taylor Blau's message of
        "Mon, 4 May 2020 15:58:24 -0600")
Message-ID: <xmqqzhane2ir.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8D4FA0E-8E59-11EA-8077-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Huh; I'm not sure that I'm sold on the idea of a 'for-ci' namespace
> here. In addition to running 'make test' on patches locally before I
> send them, I find it tremendously convenient for GitHub to run them for
> me when I push 'tb/' branches up to 'ttaylorr/git'.
>
> So, while the above is more-or-less what I'd expect the monitored list
> of branches to look like (at least, ignoring the missing 'for-ci/**'
> bits), I wish that I could also build every branch that I push up to my
> fork.
>
> Of course, I don't want to maintain a one-patch difference between
> ttaylorr/git@master and git/git@master, so I wonder if we could get a
> little more creative with these rules and actually run Actions on
> *every* branch, but introduce a new first step which stops the rest of
> the actions run (so that in practice we're not running CI on
> non-integration branches in Junio's tree).

Hmph, what are we trying to avoid by using the for-ci/ convention?

If this is only a reaction to what I said earlier (i.e. "building
everything in github.com/gitster/git/ has no value to me"), then I
suspect it may be an over-engineered solution to a problem that does
not exist, and harms people like you.  I could just go there and
turn off GitHub Actions for that repository instead.

Or are there more issues being addressed with the "testing branches
are opt-in, unless a pull request against git/git explicitly says it
is ready to be tested" approach?


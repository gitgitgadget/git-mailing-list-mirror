Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790BC2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7492240C
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AL78JeCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgKTWfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:35:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKTWfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 17:35:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9DCDF05D2;
        Fri, 20 Nov 2020 17:35:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B29tvfyvJIijf6+BmAmL31MJUlo=; b=AL78Je
        CT9hY+g1Tat+UPC+8yfqnW68nWbpPFUhyg7iiYJjXI66UcvJUh5bRR/dPW43wP8W
        MaXmH7CljSFsX/7TuXVl2lN2CRNC4MrnLYRIO7Rnaz7u6pp4HizxgV0DIckLLY4G
        tYPRL/oY7HTYYXssmqiQ2QMoKmMF+NRen3H+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JZAOL3D8sj3CiNxlDBblSYvU8NJ6cKVc
        yGVsHyw3yCkImux+F9/xU7y6xGdAqfmaErwe+6kEGjtqjF9smDH3X6aRWCZEgpqS
        4JDLXXmGLuy1DY1K03zwUPlfw0LOGVQQGIzLIGGpsyNpnGF+SqeGbFkbGGDZ7vkw
        CyNypWF/5Bk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1B9CF05D1;
        Fri, 20 Nov 2020 17:35:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DD78F05D0;
        Fri, 20 Nov 2020 17:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
        <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
        <20201120183903.GA320614@coredump.intra.peff.net>
Date:   Fri, 20 Nov 2020 14:35:40 -0800
In-Reply-To: <20201120183903.GA320614@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 20 Nov 2020 13:39:03 -0500")
Message-ID: <xmqq7dqfu05f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8D07BE4-2B80-11EB-9D7A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So that got a bit off-track, but I think:
>
>   - t1300 already is very much like this, so it's not a new thing
>
>   - but I would be happy not to see it go further in that direction,
>     even if it means inconsistency with the rest of the script

Yeah, I especially like the latter half ;-)

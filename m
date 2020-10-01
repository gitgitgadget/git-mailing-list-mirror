Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE09AC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D19920754
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pY1Pdbou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbgJAScZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 14:32:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56812 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgJAScY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 14:32:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B49BD8FEEB;
        Thu,  1 Oct 2020 14:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sC/W/nReV21zu8TKVhHucqv18gw=; b=pY1Pdb
        ou+HbIdAqBN8psnm6Z1bAfnhlakjcLgbs3N5jhUyxj4cLu91hh9MqzWzxJNAxwob
        1DDk1tdD62M2x6Ceq3QjdhoAIHp/XULR6mCWc9bFGkhA2HADbAFvZBSEx6EaDUFw
        Kk6vEgm4c+sjcUHjZDe75GXRYPCrOBfoCa/78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qIWSkazsdLUnZSjZweK/m7JdWzr8G0P9
        GlZeJPfiJuQkGDDpdgxsO6skImXFQtXZY9HTnACdkWuh3LJWcFFbZA8evjDmPRup
        S9cej1tO/qUtW8puXn4fJBpdWO8MovdwtaZxjHKT5FL/aXIMqWkJsm7+Th9sL80o
        OMjDKsI5lM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB75E8FEEA;
        Thu,  1 Oct 2020 14:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 385958FEE7;
        Thu,  1 Oct 2020 14:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
        <xmqq4knddg5v.fsf@gitster.c.googlers.com>
        <20201001175443.GA28444@mail.clickyotomy.dev>
Date:   Thu, 01 Oct 2020 11:32:21 -0700
In-Reply-To: <20201001175443.GA28444@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Thu, 1 Oct 2020 23:24:43 +0530")
Message-ID: <xmqqtuvdbxvu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71F2CBCA-0414-11EB-A511-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Ah, this will keep a record of the behavior in the tests; nice,
> will update in the next set.

I actually think this kind of "sweep the breakage under the rug"
belongs not in the code that uses the (suspected broken) API but
in the code that is suspected to be broken, i.e. somewhere in
commit.c that is involved in in_merge_bases_many() codepath.

So if you are going to reroll, I would rather see you drop this part
entirely, and add a similar "this code is broken so we won't run in
the real user's environment" to protect all code that call
in_merge_bases_many() from the breakage, not just your new one.

> One of the failing tests in t5533 was modified (for debugging), and
> the following shows the difference in behavior of
> "repo_in_merge_bases_many()". The test checks if the remote tip is
> reachable from the reflog entries of the local branch after
> "git pull --rebase" is run.
> ...
> It looks like G (b995a30) is reachable from J (7c16010), but
> "repo_in_merge_bases_many()" disagrees when "GIT_TEST_COMMIT_GRAPH"
> is enabled. I hope this information helps a little to understand
> why this happens and whether it is a bug or not.

Wonderful.  With this good start, perhaps we may not have to discuss
disabling the commit-graph code in your code or in commit.c for all
callers ;-)


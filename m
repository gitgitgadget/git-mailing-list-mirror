Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB2C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023E422277
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5DFSUgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbgJIQXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:23:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61733 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389518AbgJIQXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:23:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A963570AC2;
        Fri,  9 Oct 2020 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fGgP4WuHBa8NTGmVGsjJ5N4L8AY=; b=q5DFSU
        glomx7IEJy5l10G9QqeEOhlWbaQjMDkdklSyj0d50Y2Tsp+7fyZPjfWatOuGIkZM
        Poq/gvOmyjYC8EUiBsSxlkwznG0uKMB43reAVaPetALm5IVSoPGMmVB5grvnmqJ4
        2XBzByQxhE2oR9722RADHtPLo4TiKOYDGAJCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nMJ7Ku1zQysHOtXi9o7ZwqBmEof+qpRg
        46eWy442avTHojI5933nHJsucH7ynOSkskz7B8Vy2U3QE1ytQ3AzAuGwnQ8ZHCbM
        wADLBMMfWV5M9FSY+8ie2yV0kcx1O05ulRWAmzScw4bUGYymF2apcWDsH2hIUDZS
        8t1rZUOhg8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A169470ABF;
        Fri,  9 Oct 2020 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F8F770ABE;
        Fri,  9 Oct 2020 12:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Chris Webster <chris@webstech.net>, Jeff King <peff@peff.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
        <20200922170745.GA541915@coredump.intra.peff.net>
        <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
        <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
        <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
Date:   Fri, 09 Oct 2020 09:23:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 9 Oct 2020 15:20:35 +0200 (CEST)")
Message-ID: <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4005864-0A4B-11EB-B836-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Chris,
>
> On Thu, 8 Oct 2020, Chris Webster wrote:
>
>> Is this waiting for some action on my part?  I thought the question of
>> running on push vs pull had been resolved (in favour of pull).
>
> FWIW I agree that the current shape is the best we can do for now (and of
> course, full disclosure: I was the one suggesting to restrict this to Pull
> Requests because we know exactly the commit range to check in that case).

I think this is exactly the use case that

    After the list reached a consensus that it is a good idea to apply the
    patch, re-send it with "To:" set to the maintainer{current-maintainer}
    and "cc:" the list{git-ml} for inclusion.

in Documentation/SubmittingPatches was written to address.

I usually pay attention to majority of topics and have them on my
radar by getting involved in _some_ way in the discussion thread, so
I often know when the patch(es) matured enough to be picked up
without such a "this is the version after our discussion and it is
as close to perfect as we can possibly make" resend.

But for some topics, I have no strong opinion on the exact shape of
the final patch(es), and/or I have no expertise to offer to help the
discussion to reach the final product.  In such a case, I'd be just
waiting, without getting involved in the discussion, for trusted
others to bring the posted patch to a completed form.  I think this
is such a case.

Thanks.





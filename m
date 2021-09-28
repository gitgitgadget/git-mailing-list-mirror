Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ABEC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F2761352
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhI1RST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:18:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59486 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbhI1RSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:18:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85FE314951B;
        Tue, 28 Sep 2021 13:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E2pDtqNFiog0r02XZ6NRvEL0GtSn7itfexl3GQ
        6yJvM=; b=Hqs9UldigZW9GnUIeeuyWU6Nu8Sc+1hm7vXdP4hbA6uKIS1DI63cyi
        vxX5RnWdIi1dC0Cr2MKa0Y1j3Z/xIClOK/Lr6OZI4l5Tl/NT1hqcGSWExn1RL2qN
        P1+JwB52SeTy6sF7o55fduHt3Su6TG1P+hYXbEocMw9tNndwpi/mc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E4D014951A;
        Tue, 28 Sep 2021 13:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF3C5149519;
        Tue, 28 Sep 2021 13:16:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Date:   Tue, 28 Sep 2021 10:16:33 -0700
In-Reply-To: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 27 Sep 2021 23:46:40 -0700")
Message-ID: <xmqqo88clixa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D511F676-207F-11EC-9E3F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * js/scalar (2021-09-14) 15 commits
> ...
> However, since Johannes has been away for a couple weeks, maybe give
> him a chance to return and respond to myself and others (and perhaps
> push any updates that occurred to him while on vacation) before
> merging down?

Fair enough.

>> * en/remerge-diff (2021-08-31) 7 commits
>>  - doc/diff-options: explain the new --remerge-diff option
>>  - show, log: provide a --remerge-diff capability
>>  - tmp-objdir: new API for creating and removing primary object dirs
>>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>>  - merge-ort: add ability to record conflict messages in a file
>>  - merge-ort: mark a few more conflict messages as omittable
>>
>>  A new presentation for two-parent merge "--remerge-diff" can be
>>  used to show the difference between mechanical (and possibly
>>  conflicted) merge results and the recorded resolution.
>>
>>  Will merge to 'next'?
>
> It has been a month that it's been cooking with no issues brought up,
> and it's been in production for nearly a year...

Please do not read that much for being in "seen".  Until a topic
hits 'next', where some orgs package and ship to their internal
audience, I am not sure if it can be called "cooking".

But your using it on your folks in the production (how big is your
audience, I don't know) does count ;-)

> But just this morning I pinged peff and jrnieder if they might have
> time to respectively look at the tmp-objdir stuff (patch 5, plus its
> integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
> (patch 3).  I don't know if either will have time to do it, but
> perhaps wait half a week or so to see if they'll mention they have
> time?

Sure.

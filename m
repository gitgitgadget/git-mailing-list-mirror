Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B8C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC59A2084C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IF7uRxgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410534AbgJPQnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:43:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64635 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409218AbgJPQnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 12:43:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C57CFFC59A;
        Fri, 16 Oct 2020 12:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RwWhG0inatt66DUjP6NY8q4ORAk=; b=IF7uRx
        gX7CS3MLfHtFdgOCWA7lHaARmqQHs8ecKikRJBMFYui8r7Yx2z5F0MVGLos6KmZU
        WOtE/pNVSrirzyghKadvDjoQLksdrr7W2oSF/URv4XQK0dcKP7ETLww3IlxW1zgk
        YgmYPapaiaAEKJyXbli9pnFczKGXnVWVvJDms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dnpUPhcnsvP3KrzVFW9lDfKcxLeYTiR1
        A6TM+26LDSIAtCHj7R66Uqwci2XBGwhoDRVSoSut3ls5nKedY8ZrUMzqaFVi6zWD
        kA+UJlDWBqHuvOY+3aSyoObLw+sStoHknWtFnTqnybLnZWaMdBBZCKSuUBD6xHKg
        gRklRxRr154=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE51EFC599;
        Fri, 16 Oct 2020 12:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12E49FC596;
        Fri, 16 Oct 2020 12:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [Request] gitweb: tag feeds
References: <20201013221250.GA20483@kevinlocke.name>
Date:   Fri, 16 Oct 2020 09:43:06 -0700
In-Reply-To: <20201013221250.GA20483@kevinlocke.name> (Kevin Locke's message
        of "Tue, 13 Oct 2020 16:12:50 -0600")
Message-ID: <xmqqtuuuceat.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB8F9122-0FCE-11EB-9577-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Locke <kevin@kevinlocke.name> writes:

> I've found the support for Atom and RSS commit feeds in gitweb to be
> very useful.  I'd like to extend the support to include tag feeds as a
> simple means of announcing/tracking releases.  Might such a feature be
> acceptable in some form?
>
> Giuseppe Bilotta raised this idea and provided an implementation in
> 2012[1] and 2017[2] which did not receive any responses on-list that I
> could find.  Would these be a suitable starting point?

I suspect that these patches would have been OK back then.

The thing is, it appears nobody actively maintains gitweb anymore,
which cuts both ways.

 - We may not have made fundamental changes to the program in the
   last 3 years, so patches from 2017 may still be relevant.

 - Even if 2017 patch were to be resurrected, nobody would be able
   to review and vouch for the result.

So, if you still use gitweb and want to take over its maintenance,
or if we can revive interest in those who want to maintain it,
perhaps.

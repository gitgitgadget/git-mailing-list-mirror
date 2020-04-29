Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A388C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E0F2076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wZN4Ttej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2Wgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:36:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60243 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2Wga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:36:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE0F5CAC46;
        Wed, 29 Apr 2020 18:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hwEEghYGpxzUHnogHJLSUxFXspM=; b=wZN4Tt
        ejcTq/47DM9X6KbNYEcQrXV6z+qEl31brNBo3bkiKJWfvcsOukOfkxXQHc6U2IBG
        PRt3x+LOqdv79ISQ+w2MujCD0JWRD47iMHonTJ2D+eit05kg98gSAOyjJLMhTvjN
        1nW+0fXXEA18/dyTEj3tBhVvvFtGA8Q66AD/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h/f30Ob0pDsD/So28PK3l7PW3Su/uXZd
        dZ/cKOo/nrnIvQBZftp+SUtT2tWEb9luh7CiptZnO5HeMrtBELkk7WSd7a4Lo+hN
        12SeG9sf+7G53piU2FMgFve51sxEN2E59G/MylHGPnM3bCb34WKcgQ9ey5jsGSjh
        JQChmz6VJzI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6054CAC45;
        Wed, 29 Apr 2020 18:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C698CAC44;
        Wed, 29 Apr 2020 18:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
References: <cover.1588162842.git.liu.denton@gmail.com>
        <20200429195035.GB3920@syl.local>
        <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
        <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
        <20200429214906.GA12075@syl.local>
Date:   Wed, 29 Apr 2020 15:36:25 -0700
In-Reply-To: <20200429214906.GA12075@syl.local> (Taylor Blau's message of
        "Wed, 29 Apr 2020 15:49:06 -0600")
Message-ID: <xmqqsggludg6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD06D214-8A69-11EA-A1C9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. I say this as somebody who just re-rolled a series to add two
> 'test_might_fail umask 022' lines, so am a little disappointed to learn
> that this is not considered to be idiomatic.
> ...
> Junio: do you want another reroll of that series? :/

The one I saw and remember was two new umask calls protected in POSIXPERM
prerequisite but without test-might-fail involved.

Perhaps there is nothing to reroll?  Or perhaps I am not checking my
mailbox often enough?

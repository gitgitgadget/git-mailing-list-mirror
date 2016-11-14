Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37EB1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 17:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935199AbcKNRV1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 12:21:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932174AbcKNRVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 12:21:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF8D84DC18;
        Mon, 14 Nov 2016 12:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oiW2L5HyY+z389+3/ZcPMgw58AI=; b=H0r02M
        Z3EoLFCstvj95hJ9i8Tbe0FnZ8YoBEbIhfZWM3Bk61TixErbAfKL7ozNbqYvHVz1
        xlYppXthRK5DNdNYgB7+Ct4WD6YWtS0gnNXOg/yyc4UKrJyhwJuSvB/WIkBSBdcK
        gNe2FCWEol/LhtwbylB4Ib/YYnuSz6fZ1KwZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g7Lm6ZgFxkmjLIrKKBa3GZL391IEteRF
        YtWy3Zoh11HmCYOVhq/xYFVkkPjndjTCIuhvqfpq84CKLoY4vqir6ZnzfHYXuv7/
        yOYsWToUGt1KcVgg7VIkwdtpHFsz8Ppz4O/rxLu8KQINgY5uOKxPIvbNbG6KdTE0
        Gv/UJAk1rKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A70BE4DC17;
        Mon, 14 Nov 2016 12:21:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D11A4DC16;
        Mon, 14 Nov 2016 12:21:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variables
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
        <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
        <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
        <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
        <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611121237230.3746@virtualbox>
        <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
        <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
Date:   Mon, 14 Nov 2016 09:21:22 -0800
In-Reply-To: <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com> (Lars
        Schneider's message of "Mon, 14 Nov 2016 10:11:12 +0100")
Message-ID: <xmqqshqux9il.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C403CFA6-AA8E-11E6-B95F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 Nov 2016, at 02:13, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Earlier you said 'pu' did even not build, but do we know where this
>> "still times out" comes from?  As long as I don't merge anything
>> prematurely, which I need to be careful about, it shouldn't impact
>> the upcoming release, but we'd need to figure it out before moving
>> things forward post release.
>
> What is the goal for 'pu'?
>
> (1) Builds clean on all platforms + passes all tests
> (2) Builds clean on all platforms
> (3) Builds clean on Linux
> (4) Just makes new topics easily available to a broader audience
>
> My understanding was always (4) but the discussion above sounds 
> more like (1) or (2)?

The purpose of 'pu' is none of the above, but its intended effect
for people other than me is (4).  It is primarily meant as a way for
me to avoid having to go back to the mailing list archive to find
topics that I felt that were potentially interesting but not yet
ready and may want to get commented on later.  When queued on 'pu',
it is not unusual that I haven't really looked at the patches yet,
and it is not surprising if it does not build on any platform.

When queued to 'pu', the reason of the initial "not yet ready"
assessment may not have anything to do with the quality of the
patches but based on the phase of the development (e.g. during a
feature-freeze, it is less efficient use of our time to take new
topics to 'next'), so what was queued on 'pu' may get merged to
'next' without any update, after getting looked at by me or by
other people and deemed to be worth trying out.

Dscho's mention of 'still times out' may be an indiciation that
something unspecified on 'pu' is not ready to be merged to 'next',
but blocking all of 'pu' with a blanket statement is not useful,
and that was where my response comes from.  We need to know more
to say "this particular topic is not ready", so that we can unblock
other innocent topics.

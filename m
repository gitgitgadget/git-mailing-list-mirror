Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B96C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AAE61164
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEFAPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 20:15:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60263 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhEFAP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 20:15:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D42AD32AD;
        Wed,  5 May 2021 20:14:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mSkP6ACzXDxf6sdzKTBMLCC/pxljTFVni+1EPA
        fbxck=; b=G+K3UZyJUNKtXSFWl2oG3YxSOzM11jEnft1s63JaA/xFuo6UhQ6AG3
        v/UoJHBFY1wM0V9E7H77QpFJNLCe6q7KkShgm+eI9q3DRNV2vzbJUxk59+ybVII0
        cCr5Reh1oU2XMkt25mE5A53TlASwtC/TR3rDyCxWLwi795SnJqGVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 151FDD32AC;
        Wed,  5 May 2021 20:14:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C177D32AB;
        Wed,  5 May 2021 20:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] streaming.c: remove enum/function/vtbl indirection
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
        <patch-2.5-13061f01212-20210505T122816Z-avarab@gmail.com>
        <YJKgsfJXMsR47CkW@coredump.intra.peff.net>
Date:   Thu, 06 May 2021 09:14:29 +0900
In-Reply-To: <YJKgsfJXMsR47CkW@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 5 May 2021 09:42:09 -0400")
Message-ID: <xmqqmtt83ehm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 070E366E-AE00-11EB-921D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> We can thus remove the entire enum, and the "open_istream_tbl" virtual
>> table that (indirectly) referenced it.
>
> Yeah, I think this is simpler. The value of the vtable was that we might
> have added more functions to it, but we haven't done so over the course
> of the last 10 years. And I have trouble imagining for what purpose we
> would. So it seems like unnecessary complexity.

The code hasn't changed all that much since it was written, so
another equally plausible way forward is not to touch it at all ;-),
but I am fine with this simplification, too.


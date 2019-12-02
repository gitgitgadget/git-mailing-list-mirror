Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C97C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6B20848
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGMO6Qgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfLBRCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:02:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53040 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBRCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 12:02:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3C31AB69F;
        Mon,  2 Dec 2019 12:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PfVGsb1aRVGjk5aYWY+Wr+jw+ks=; b=tGMO6Q
        gbsECOnfo8u+ZSdyCMBJ8Ep7g8FIWz7M8tdtFtFzoKgKs0J1jglsSwK2craxaf72
        Blbu5uSp1GSfPDVcbe5mT2Q0S2fEaBsYpO0ynNNeneIhU0iW7WWQMnqjDDMRKj9b
        pgNKvwTV5nuyNKzWMoQ/kceqa7zGgEb26TPSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nzo3YUdCBqMeGPn8qdpE4+DXdiSH1Da2
        /te3RVWWqhAiCF8arwPA9vX702+t20of6JGZ9c3JXYR+02T4lhla23qXH7UjKQoU
        SZu3ySBwm7qltrpYKq3fJOU5rSibLjkGYWZS+mw50duMNmfF+G2G3t9LwmyeKnL9
        uTuOgcW6/64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC7DAAB69E;
        Mon,  2 Dec 2019 12:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C729AB69D;
        Mon,  2 Dec 2019 12:01:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ed Maste <emaste@freefall.freebsd.org>, git@vger.kernel.org,
        Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2] t4210: skip i18n tests that don't work on FreeBSD
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
        <20191127171507.56354-1-emaste@freefall.freebsd.org>
        <20191127172035.GB1123@sigill.intra.peff.net>
Date:   Mon, 02 Dec 2019 09:01:55 -0800
In-Reply-To: <20191127172035.GB1123@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 27 Nov 2019 12:20:35 -0500")
Message-ID: <xmqqd0d6y83g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73578C5A-1525-11EA-88CB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 27, 2019 at 05:15:07PM +0000, Ed Maste wrote:
>
>> Extend test-lib.sh to add a REGEX_ILLSEQ prereq, set it on FreeBSD, and
>> add !REGEX_ILLSEQ to the two affected tests.
>
> Thanks, this is much nicer.
>
>> +FreeBSD)
>> +	test_set_prereq REGEX_ILLSEQ
>> +	test_set_prereq POSIXPERM
>> +	test_set_prereq BSLASHPSPEC
>> +	test_set_prereq EXECKEEPSPID
>> +	;;
>
> I scratched my head at these for a minute, but I see you are just
> covering the bits set in the "*" case that we now no longer trigger.
>
> It would probably be cleaner to set them ahead of time and just unset
> them selectively in MINGW, etc. But we don't have any way to unset a
> prereq, so lets' go with this for now. :)

Thanks, both.  Queued.  Will merge to 'next' shortly.

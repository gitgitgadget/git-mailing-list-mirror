Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738AC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022DB23715
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbhALCDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:03:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58192 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhALCDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 21:03:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 673A0A469C;
        Mon, 11 Jan 2021 21:03:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KACYAmES+W72UUXfmN3dBXUIRhQ=; b=WX54QU
        2g0S/+3Q0PTnn3ELgtpyQugRxJfol9L/FrYfDzZiyl0Ju7VRh5CQ6ryzv4xDiYZU
        tkfTJrpJIzPeF8vmsCZA0ujgD1Y3Htu6PSYhG5e6CdeLtF9xBBUVESGWSwmxSOGy
        LRHNre5OLtwRH5to1TaxI4a4Tgp8wGw4mV1s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WBo/EvcZh1P+4CLQ5D7cPqwKp8HHMZiz
        wsLvRhts9ormH91KpEpqJGv4w6KmGsOqg/fc9XlA4OGiq/Jjs4ogP2YKUZzKeNVn
        ayTao3gIoLKt2L9w8BvwWcrcC5jEj7jjz9bHHB0jOdsf0zmsNP87nh1c3wSgoDHC
        oNv4FFSFvRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CD9EA469B;
        Mon, 11 Jan 2021 21:03:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D025BA469A;
        Mon, 11 Jan 2021 21:03:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Support for commits signed by multiple algorithms
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
        <20210111035840.2437737-1-sandals@crustytoothpaste.net>
        <xmqq5z436rwe.fsf@gitster.c.googlers.com>
        <X/zfdA8uUAdx0oEu@camp.crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 18:03:08 -0800
In-Reply-To: <X/zfdA8uUAdx0oEu@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 11 Jan 2021 23:29:56 +0000")
Message-ID: <xmqqft366her.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 511FD54E-547A-11EB-967D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I just noticed this because I'm now getting to the case where we write
> (and sign) both SHA-1 and SHA-256 versions of commits and I thought I'd
> better send in a patch sooner rather than later, since there's a lot
> more prep work (surprise) before we get to anything interesting.

Uncomfortably excited to hear this ;-)

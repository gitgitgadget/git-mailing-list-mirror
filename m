Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C0720756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdAQU5S (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:57:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdAQU5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C81F612D7;
        Tue, 17 Jan 2017 15:57:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6eVgEZb+XmQCZDRzzOnY7EwZL9s=; b=OoP29M
        Y41JyBM++R43Z2WCSMcQRXPKen3pUXQVzsHRfH6cvMj4Irpx+j0pW9RKq5fJQs3Z
        Htmz480M5Hk00iMWBsyTP9gbnfOYFeOHKihkcFvcG7GRtN7RywAmnIXOOjQpUy77
        N4YxTUtv4XyiE6gasLRj72NX7kMynWrH8g5kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jbfLTes8R61hoF4+W5Bmt+ZVKxuxXDlB
        FJZYF6CNmroZv3aujHVlFlWqrWUoYSQU1b4eN04f68yhCrkzBPdtx5O68HNKyW5O
        FJGEdS9ByvGITZswhHRYzBWevWUZcQFF862Drm0H6X/ZMNR6eXGsYfCDC6F2Xqjt
        d8Y36ksvQDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A698612D6;
        Tue, 17 Jan 2017 15:57:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B343612D4;
        Tue, 17 Jan 2017 15:57:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/6] fsck: report trees as dangling
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
        <20170116212535.cohvikwkju5zehr4@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 12:57:10 -0800
In-Reply-To: <20170116212535.cohvikwkju5zehr4@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:25:35 -0500")
Message-ID: <xmqqh94xe76h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 843FBE20-DCF7-11E6-AB1E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After checking connectivity, fsck looks through the list of
> any objects we've seen mentioned, and reports unreachable
> and un-"used" ones as dangling. However, it skips any object
> which is not marked as "parsed", as that is an object that
> we _don't_ have (but that somebody mentioned).
>
> Since 6e454b9a3 (clear parsed flag when we free tree
> buffers, 2013-06-05), that flag can't be relied on, and the
> correct method is to check the HAS_OBJ flag. The cleanup in
> that commit missed this callsite, though. As a result, we
> would generally fail to report dangling trees.
>
> We never noticed because there were no tests in this area
> (for trees or otherwise). Let's add some.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense, and the new test is very easy to read, too.

Queued; thanks.


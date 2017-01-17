Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6264E20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdAQVRn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:17:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55468 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdAQVRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:17:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2213061F7B;
        Tue, 17 Jan 2017 16:17:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XZiq3/636722/obGOpGPrL7EOBU=; b=uJu+KY
        APy8iTwjTSP7vl5dHX2PXJy7d4h/yyWAY7BY0XtivrunVPGxjj0TakYAOmJJXg39
        mVnWfQ80iIvbKl+H7Hvv4O4bFjEyQk/pI64K50QbWGI/taNz/PTR7OzrG4cDDMej
        TRa5o6BXiRrNhFwLzl1PVjkCbvszZQhthoUBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2k2jlSvhH9nCRVB4/5aRxS/lzBZif0d
        hLRftw5y/ks7jr1Osrnz7dDFj3WOLtU0uLkT6wlJ77TiwdhrbCiKOIZFGOZz2+ic
        0CVz9pTPETo3j0mJulWXXD/fjK5jbXiTuR6h2TSxVDeyOltn1ekmbAgSn2miLFE7
        Izyq4Eq1zjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A0AA61F7A;
        Tue, 17 Jan 2017 16:17:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A80161F78;
        Tue, 17 Jan 2017 16:17:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/6] fsck: tighten error-checks of "git fsck <head>"
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
        <20170116213329.jk26zvcp7erzfc6l@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 13:17:39 -0800
In-Reply-To: <20170116213329.jk26zvcp7erzfc6l@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:33:29 -0500")
Message-ID: <xmqq1sw1e68c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 614FB4F8-DCFA-11E6-9F4D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Instead of checking reachability from the refs, you can ask
> fsck to check from a particular set of heads. However, the
> error checking here is quite lax. In particular:
>
>   1. It claims lookup_object() will report an error, which
>      is not true. It only does a hash lookup, and the user
>      has no clue that their argument was skipped.
>
>   2. When either the name or sha1 cannot be resolved, we
>      continue to exit with a successful error code, even
>      though we didn't check what the user asked us to.
>
> This patch fixes both of these cases.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense, too.  Thanks.

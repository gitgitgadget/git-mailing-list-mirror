Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346FC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABFC206A1
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d6cFaY5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGHUza (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:55:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51243 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGHUza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 16:55:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0316078FEA;
        Wed,  8 Jul 2020 16:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pgDEVtlx1aloCdAhiDnfM7Lh87c=; b=d6cFaY
        5SQnYJFYmLO/EysGtsAQDdKpiadZ1jmobMqrjVernjCGHzm7y6CCJViYBbmrXUrx
        tf9UPobC1Ba4eZDWPedZEuPB5sozLCRsLOWwkVv5QdOgIwdOzV+0201ZjgVAAV6t
        4ptFi9x9EnHwZG1j4xAjZtpRMNlsa13K33rLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pmHD6qO6vH2TqCUkXfsqBMn2O8cm87+6
        UuO6bWGB9GfTvsTUtOF/mZHpAzDFyYb4WutKMSBoA+zZxmMTbgneN8gFUlRRjzks
        Vngjy0mlWVWTFvMzbB6mdNQcgd9SyCId7xJX1CfBlx+7iK0y945k3rqv7po3FOjo
        LTf7thLX/lM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA58E78FE9;
        Wed,  8 Jul 2020 16:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 642EF78FE8;
        Wed,  8 Jul 2020 16:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jayconrod@google.com,
        jonathantanmy@google.com
Subject: Re: [PATCH] commit.c: don't persist substituted parents when unshallowing
References: <82939831ad88f7750b1d024b2031f688ecdf6755.1594132839.git.me@ttaylorr.com>
        <20200708054112.GA118756@google.com>
Date:   Wed, 08 Jul 2020 13:55:28 -0700
In-Reply-To: <20200708054112.GA118756@google.com> (Jonathan Nieder's message
        of "Tue, 7 Jul 2020 22:41:12 -0700")
Message-ID: <xmqqk0zd20cf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B30F690-C15D-11EA-9998-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> A fairly straightforward test that demonstrates the bug being fixed and
> only relies on what was set up in the initial 'setup' test (4 commits).
> Thanks for tying that loose end.
>
> With or without commit message tweaks along the lines described above,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for your thoughtful work, as always.

Thanks for a nicely written review.  It would be very nice if we can
see a reroll before I have to tag -rc0.

Thanks.


Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0CC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85002072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2riUKRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQVYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:24:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:24:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 491BB394E6;
        Fri, 17 Jan 2020 16:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zt2/NqMS7Tl7HpEcB46dMX2vNwE=; b=J2riUK
        RTiWv+HhRF26QYQKSNaBsqw9rRk61Hc/reuXMaiK+bosNY0Ka1FtYXMThxTHzgDK
        Q7JTKvnQajZrqIM11dFkO/qBXDvsT4OHMyFLt0iKnJmLUr1aKQTEUoEbc7BfXmej
        IGWYjJA0x7hp32wM7RQZcmzD47PqFaqUdL5cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rU41Htjj6vakGzQojswfKsobgSF/F/2r
        dP3mv/MpjHM4GSfCnhtnXAnWFl5mjDu7UnLKnweOx4xJfcl97r92maUbXscq8kl+
        KiKo63jEiOEHe2ezGiLpdJzqs/nLfN4vTYUCvRvA98eS/Ynwy0B+2e4btGkC5vjW
        uIk1MR/XlbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 405D7394E1;
        Fri, 17 Jan 2020 16:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63D39394E0;
        Fri, 17 Jan 2020 16:24:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config values too
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
        <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
        <xmqqeevxex7a.fsf@gitster-ct.c.googlers.com>
        <CAKPyHN2RwpWhBkTUwERSns0B0Vg7r7CTmhe8p0mZRNeNw4Aagw@mail.gmail.com>
Date:   Fri, 17 Jan 2020 13:24:28 -0800
In-Reply-To: <CAKPyHN2RwpWhBkTUwERSns0B0Vg7r7CTmhe8p0mZRNeNw4Aagw@mail.gmail.com>
        (Bert Wesarg's message of "Fri, 17 Jan 2020 21:20:35 +0100")
Message-ID: <xmqqo8v1dbeb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BED91F40-396F-11EA-A1F5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> can you give me an heads up about your expected number of patches for
> this clean up. Rather detailed or just one?

That's up to the contributor X-<.

I would expect that some folks can write it up as a single patch and
still keep it easily understandable, and others might have trouble
explaining what they did well to the others and may need to split
them into a few pieces.


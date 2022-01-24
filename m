Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B330BC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiAXRMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:12:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62605 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbiAXRMC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:12:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97822174CFD;
        Mon, 24 Jan 2022 12:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O16ErtPz4UZ5goCnVNgPVHL+m+An+pQVxQ8nAS
        bpHFY=; b=tb5nczOVJ6X/9CzAZCX0Z1SS/C7B1Np0Ah3bLPcsRPZhXGKdg8kamD
        ejI5sOAZ1u7TWlJWSXOokMm85zuu/5jGmK0c+O9WouiAj6Pug5oGpuXdR1eR5UXE
        /kGP2PHnpsH3ALFeUHcyTGPHV8uHKtEq19GkZnN0QaxkWHuqDJccM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90619174CFC;
        Mon, 24 Jan 2022 12:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB1E6174CF6;
        Mon, 24 Jan 2022 12:11:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] mem-pool: Don't assume uintmax_t is aligned enough
 for all types
References: <20220123152458.72540-1-jrtc27@jrtc27.com>
        <20220123203347.74869-1-jrtc27@jrtc27.com>
Date:   Mon, 24 Jan 2022 09:11:58 -0800
In-Reply-To: <20220123203347.74869-1-jrtc27@jrtc27.com> (Jessica Clarke's
        message of "Sun, 23 Jan 2022 20:33:47 +0000")
Message-ID: <xmqq1r0x6otd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDEE24B8-7D38-11EC-A635-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +/*
> + * The inner union is an approximation for C11's max_align_t, and the
> + * struct + offsetof computes _Alignof. This can all just be replaced
> + * with _Alignof(max_align_t) if/when C11 is part of the baseline.
> + * Note that _Alignof(X) need not be the same as sizeof(X); it's only
> + * required to be a (possibly trivial) factor. They are the same for
> + * most architectures, but m68k for example has only 2-byte alignment
> + * for its 4-byte and 8-byte types, so using sizeof would waste space.
> + *
> + * Add more types to the union if the current set is insufficient.
> + */

That reads very clear.  Thanks.

Will queue.

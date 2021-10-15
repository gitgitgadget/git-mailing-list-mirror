Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C6AC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA9861164
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbhJOQC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:02:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57727 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbhJOQC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:02:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A151815E5C3;
        Fri, 15 Oct 2021 12:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zIW9rmYxBnmngCPywXSrws3rnoJeIyd7Bfi1id
        MuLF4=; b=KYO97L/CuEliRtW0+gVT65CpyRD4sQC3z6V0M8dSyjbr3l2sNJ7fs4
        vpIxx6v/OnqIIYgRQEZPyqJFaKbtOw90R2X2jeG8ca62n7Urh+bwFwxe7lgRYt1s
        tfxMK/3tK32k+lvVKd+Gd+R3GQls16/0GGN0UwkvJ/aUvf/0h4NNk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9950115E5C2;
        Fri, 15 Oct 2021 12:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F86015E5BC;
        Fri, 15 Oct 2021 12:00:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: To "const char *" and cast on free(), or "char *" and no cast...
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
        <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
        <87mtnbfk0g.fsf@evledraar.gmail.com> <xmqqlf2vbbl8.fsf@gitster.g>
        <5868076d-69cf-9b77-fa5c-5bb229333bd9@gmail.com>
Date:   Fri, 15 Oct 2021 09:00:16 -0700
In-Reply-To: <5868076d-69cf-9b77-fa5c-5bb229333bd9@gmail.com> (Phillip Wood's
        message of "Fri, 15 Oct 2021 11:03:24 +0100")
Message-ID: <xmqq5yty9t2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDCB8808-2DD0-11EC-8712-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> If it was just the destructor that was free()'ing the values I'd agree
> but the struct gets mutated in other places as well.

Oh, if the members are meant to be mutated by the users (as opposed
to the implementation) of the API around the type, I would agree
that we'd be much better off having them non-const.

Thanks.

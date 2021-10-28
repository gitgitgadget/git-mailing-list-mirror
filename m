Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C51C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05ED60E54
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1TEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:04:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60793 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1TEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:04:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 022B2F8AAF;
        Thu, 28 Oct 2021 15:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=foWsnI4Vfv6yXkt0CMA8NNsaQLBQK/8XAb9lOV
        R/Mgo=; b=GJ9mOFFBC030yEr6DykwX7GvbBvfhXMCvhN/5uIKe7j+CcuySfAKf5
        sVDtHLa4iOCtoFEiKyAtgVNb148iVk3XICJyIq3fvTxVoH/Egyu5tOn+9lgD+ukA
        LsGjyI3fePGYZLNPMaaMOXnxTbOpzxUTRO1QLQrjHQ8Mjk8EDiVoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED867F8AAE;
        Thu, 28 Oct 2021 15:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57F05F8AAD;
        Thu, 28 Oct 2021 15:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv() warning
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
        <YXk0hAgaSJbLUgeB@coredump.intra.peff.net>
        <xmqqmtmuwdh9.fsf@gitster.g>
        <YXreMYZrTCUkpHXz@coredump.intra.peff.net>
Date:   Thu, 28 Oct 2021 12:02:23 -0700
In-Reply-To: <YXreMYZrTCUkpHXz@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Oct 2021 13:30:25 -0400")
Message-ID: <xmqqzgqtq8g0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96075D54-3821-11EC-82B0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I am all for making it convenient to squelch, but it would be sad to
>> lose the convenient way to notice possible misencoding in recent
>> commits.  Or can we have a command line option and pass it through
>> the callchain, or would that be too involved?
>
> Do you mean a command-line option to squelch the warnings? I think it
> would not be too hard to do it as a config option (which is probably
> what you'd want anyway, since historical commits would come up over and
> over again).

Adding a "git -c please.be.verbose.on.encoding.errors=true" is
sufficient for those who want to diagnose, but that is not very
discoverable.  Swapping the polarity and making it verbose by
default, with a knob to squelch, may be more practical from that
point of view.



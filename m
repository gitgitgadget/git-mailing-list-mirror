Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFDBC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F320716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="raNWajHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgHQR1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:27:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52759 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbgHQRTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:19:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FF85DA405;
        Mon, 17 Aug 2020 13:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BnJc/BGExFO+68CXL/GVnzk0Lbo=; b=raNWaj
        HpFxRFGzzMJuavNwVipsHDbjKCsO3IQMflQMSPSmEVo1WbvJRLA6c2lSNm/bICyb
        H/YlCUbuCckJOBefnx88Xr7o5Ae9R6AvxRpDAnz4l88K+5jlTB0Qnw2cOyAzFJVW
        Q4aEnCWWKmASc/qz9LTcK4A0yXiMTIA78aLLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rJA42uASoOxwidnwzKAx6no0DCVWsrwJ
        mgwyp/2QXiYYNVsc1O5QSkP8QKvA4VDer9ax0O8A92UlgdaPJivy1vxTIpNODKrw
        1QVynKuhFboAzKTX0bdY9dY0KkkkQMNHFXVXSQaXWB7zTpcPjHL2y5fmaZKgPL4U
        5AF6tx276OA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87B30DA404;
        Mon, 17 Aug 2020 13:19:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D356DDA3FE;
        Mon, 17 Aug 2020 13:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
        <20200804185057.GA1400256@coredump.intra.peff.net>
        <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
        <20200804192053.GA1400936@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
        <20200812141958.GA32453@coredump.intra.peff.net>
        <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
        <20200812160653.GA42443@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet>
        <20200814124011.GA4104592@coredump.intra.peff.net>
Date:   Mon, 17 Aug 2020 10:19:10 -0700
In-Reply-To: <20200814124011.GA4104592@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Aug 2020 08:40:11 -0400")
Message-ID: <xmqqmu2t2nsh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C47E8882-E0AD-11EA-9832-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -    if: needs.ci-config.outputs.enabled == 'yes'
>> +    if: (github.repository == 'git/git' || github.repository == 'gitgitgadget/git') && needs.ci-config.outputs.enabled == 'yes'
>
> If we do go this route, I'd consider defaulting it to on and just
> letting people disable it through needs.ci-config.outputs.vsbuild or
> similar.

That sounds like a good idea.  Special casing based on repositories
do not scale.

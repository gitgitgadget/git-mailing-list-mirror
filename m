Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0385C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5ECF61AED
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhKSTbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:31:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56019 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhKSTbm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 14:31:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 277F210ABCA;
        Fri, 19 Nov 2021 14:28:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pKzZ8hPp3opBvek0nCU4Rlht8DSoPjcg2TRNHX
        if/ys=; b=ZxF3zWzUiIWHiR2MjvHxhMRSMIRWZvwhtMQTB83aop932nmHmjB5C5
        SZeSd+OBSChGsM/qvP1tVcPamHzmJmKl4xH9XA9gvKVtfh7ymAERjyRY1WiGYul/
        u9OeM2Ba9SvWsXWDaGLT4/pI2nu8i6O1Sb51dNqQXMg+MRhwxtfmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E9AC10ABC9;
        Fri, 19 Nov 2021 14:28:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8924410ABC8;
        Fri, 19 Nov 2021 14:28:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mergesort: avoid left shift overflow
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
        <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
        <nycvar.QRO.7.76.6.2111191750400.63@tvgsbejvaqbjf.bet>
        <05e6c0ab-7364-56d8-f0b2-e93c11b327e3@iee.email>
Date:   Fri, 19 Nov 2021 11:28:38 -0800
In-Reply-To: <05e6c0ab-7364-56d8-f0b2-e93c11b327e3@iee.email> (Philip Oakley's
        message of "Fri, 19 Nov 2021 17:27:23 +0000")
Message-ID: <xmqqlf1kosgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6026020-496E-11EC-8F90-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>> My patches are in https://github.com/PhilipOakley/git/tree/oneU_t
>> How about rebasing the remaining patches from
>> https://github.com/git-for-windows/git/compare/main...PhilipOakley:oneU_t
>> on top of `rs/mergesort` and then submitting them, to avoid duplicate
>> efforts?
>>
> I'm not finding a `rs/mergesort` at the moment. Any particular remote I
> should find it on, or maybe a different spelling?
> P.

At https://github.com/gitster/git/, I publish the "broken out"
branches.

But resurrecting the tips of the topics should be fairly easy.

$ git log --first-parent --oneline origin/master..origin/seen |
  grep rs/mergesort

The second parent of that merge is the tip of rs/mergesort topic
back when the 'seen' integration branch was created.


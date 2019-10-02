Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D6E1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 05:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfJBFnw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:43:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52950 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfJBFnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:43:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 884ED3380B;
        Wed,  2 Oct 2019 01:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ThinwuAFibTsm6wcNYHkSLqE16E=; b=gtxFwF
        XPp8kZ2GY2zcRCxzR9szOKj4vdyoQGPBKnOVerH4/jm13fgWsPib484YvDN5DNGw
        2S7LrptixvZum06EXaqCxQrCVz/jtiqjLwYaFuTppcxxSHKpg5gIwRgro3ZUSk9p
        9UIeuB54mA0axGgG8HObevPzT86Wr4aukM8k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=if0Kzh2ekv1lYsSiU6WDrDePR6R2N3lU
        VMP9+NVyh05gilb6kqDR/Fb0N9wZ0atjhMOQyDcEHLi+s/71taKZwDJaKjtWLs4A
        TtzneI6VwekAKQUwwTimZ8kudZnCmsNGTxzyUQPo1WEQRQviZVDfKBdB09fDVRw2
        DSTXOw5HYsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F9B93380A;
        Wed,  2 Oct 2019 01:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E198D33809;
        Wed,  2 Oct 2019 01:43:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <20190921121104.GA6787@szeder.dev>
        <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
        <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com>
Date:   Wed, 02 Oct 2019 14:43:48 +0900
In-Reply-To: <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com> (William Baker's
        message of "Mon, 30 Sep 2019 10:01:55 -0700")
Message-ID: <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C17B81E-E4D7-11E9-823B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> Although my debugger might not be the smartest, I haven't noticed any
> downsides to switching this to an enum.

Well, if you write

	enum { BIT_0 = 1, BIT_1 = 2, BIT_3 = 4 } var;

it's pretty much a promise that the normal value for the var is one
of these listed values to your readers.  But bit flags are meant to
be used combined (after all, they are cheaper alternative for 1-bit
wide bitfields in a structure), so it is misleading to use enum as
such.

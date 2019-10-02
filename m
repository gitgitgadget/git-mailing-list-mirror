Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8278D1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 05:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfJBFib (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:38:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55287 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJBFib (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:38:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6700E82680;
        Wed,  2 Oct 2019 01:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vl+yCOLCvwzAcrJsPRBCM3HdgiA=; b=BO48uS
        k/uqG9VPCHYocAHwhVJeEwWCTp4qeE9Xd75WSUeLOPUpla3kBg8Zm1qO96ZJoBTi
        trPCIN+B/rh2aTwREzvXDR2n/0hwaOqROYQHF96g+IJFLTQHrlD384VvCGhMbu7A
        j4lOtsta+YfUXd/8m9bxbk6YMMg26F4ZQA6og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oHYDBcPf4Y0M1UZo+2M939oBhaGuK9jl
        PqoDMH4hNQ/t12RETzNtNjLvzaESp5/kxvf5kA9YjBIOcq47LVEhqTW8bJbtwCwA
        vVNZ580CAK8hk4Aq/sxeDSXSeho5HxX21WQfE9O5FP8gF6lRv0tUXBJBXlgxRCdI
        8/ZUi/UWJ5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E7E38267F;
        Wed,  2 Oct 2019 01:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A0B08267E;
        Wed,  2 Oct 2019 01:38:26 -0400 (EDT)
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
Date:   Wed, 02 Oct 2019 14:38:24 +0900
In-Reply-To: <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com> (William Baker's
        message of "Mon, 30 Sep 2019 10:01:55 -0700")
Message-ID: <xmqqwodng10v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB5BB67A-E4D6-11E9-95D4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> I saw that the code base is currently a mix of #define and enums when it
> comes to flags  (e.g. dir_struct.flags and rebase_options.flags are both
> enums) and so using one here would not be something new stylistically.

Yes.  But it is a different matter to spread a bad practice to
parts of the code that haven't been contaminated by it.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE02C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1F022248
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbhAUDro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:47:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62437 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393348AbhAUCxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:53:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28658977DA;
        Wed, 20 Jan 2021 21:45:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nrcWmYqtjd2NDGIQunlMOrGBmrg=; b=lccm9W
        MpV1SsQfHGgVzs0gVzP2+hgW+d5rnmig7i0sF2+V2rEv8Obh701sz0OUAMvJG2fE
        Y3enKvMCz6ozMeN5E1+HKi7QupoP940EGD3Pt9UpOE7vaalwFTdqLX65/nDZU7XX
        CEeqt9/paUhg5+wPzlZ4wm4D0sQSQCqZmKhiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hlbCk4RvCF3PeF8TfBlA9PZ9Lvogtj1/
        3Hs/FNqpzlGMXuFVMqsKtL6M8UGatWhQHSgpjuy9wh8HDL/y8srI4GRmLWgpeSsM
        YQpJpHI360OWV78zDw8NDAmQllscjgDI3UteSVbV8UeqfAI6TDJBqTSflxbNt+8n
        QuEjVnH033o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19E98977D7;
        Wed, 20 Jan 2021 21:45:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C577977D6;
        Wed, 20 Jan 2021 21:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] Two cleanups around 'prefetch' refs
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
        <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
        <YAbrsO1uIuE/CTrP@nand.local>
Date:   Wed, 20 Jan 2021 18:45:45 -0800
In-Reply-To: <YAbrsO1uIuE/CTrP@nand.local> (Taylor Blau's message of "Tue, 19
        Jan 2021 09:24:48 -0500")
Message-ID: <xmqq8s8ndn3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C35D6FC6-5B92-11EB-B6D6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 19, 2021 at 12:52:02PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Update in v2: deleting refs more safely for alternate ref backends. (Thanks,
>> Taylor!)
>
> The range-diff looks good to me, thanks!
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks, both.

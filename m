Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB5F1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfGaSO5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:14:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61299 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGaSO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:14:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0896E16E099;
        Wed, 31 Jul 2019 14:14:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f7wJJWoNWOkEGzArja84qkjmRqo=; b=yKTXEo
        s3s5QfiX8k9xL+I4pwsvGXdaOXiNKu75VTHmzubxG1uT8+SugWlL3XtyxHc/1Jti
        DFpssJIiLcq6l5MLKwmjVIayHOs3uHOgRiC9lUJDY9599+q5RjcfcwszPOTqDLTz
        GMqZB+d7vla0hfniMHwLzCimFPX4k5S2MrVy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i+hAmgGqrW3T33uAQRiSpVA7R5iWSHEF
        shG+t+X61s5C0WYJ/uITwdSgHpuOTMtc/j8qzWN49DAi+sC7JR5YAQtsMEQnz8FD
        c+TDVPkztJ0cXRlEY86yxn8aLc/NbVnHXkVWXSQrCs2COAcEsbbAr63aDCscIKVd
        5pwThqculv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F376916E098;
        Wed, 31 Jul 2019 14:14:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50A8E16E097;
        Wed, 31 Jul 2019 14:14:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 06/11] built-in add -i: implement the main loop
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <175409aaae0f3127b92126dc201faa4b41da0870.1563289115.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 11:14:54 -0700
In-Reply-To: <175409aaae0f3127b92126dc201faa4b41da0870.1563289115.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:41 -0700 (PDT)")
Message-ID: <xmqqo91aoyu9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19252CFA-B3BF-11E9-B223-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The Perl script `git-add--interactive.perl` mixed the purposes of the
> "list" and the "and choose" part into the same function. In the C
> version, we will keep them separate instead, calling the `list()`
> function from the `list_and_choose()` function.

Makes sense.  After all, I recall writing "add -i" in a few
iterations of lunch-time hack.  If we are to rewrite it from
scratch, we should engineer it the right way ;-)

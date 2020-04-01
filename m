Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8CC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3DF2073B
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIJAFJEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgDAVGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:06:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59351 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:06:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 250E1C4488;
        Wed,  1 Apr 2020 17:06:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bSL2cQnNRlLn7xZ5gzuQkN7FFfg=; b=WIJAFJ
        ExYDRDI4svTEJDy1HCaRsqcIoSiHNVWYC7v4iI1vAhNoBAj0uTtXL7xeOYZgQn5e
        QMCSDQQgWxiqZPgo5+TpdodSkiAppDM1SZRkvi7rxlt4obXrP7q+q3l7BrIYNzmW
        xkOEVi9O79CHwAqXd/9c5DJXwN2/E7iHnxkOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CfEP5ZDEyzpWJ2i8t5tG1OoZRxSD0TdH
        0BrURZfozVwUrBA5jPGicnD241hkuBMR8S4K8zggXSKAoN6xEIPDhMgguYA3UI41
        aExzn5PTQrKD2egAeVRl6c+zAOJvrIn7UW49QkR57FoKVoguIk280LZ6zpAT11ve
        aVcL3BKcZ5o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CDDAC4487;
        Wed,  1 Apr 2020 17:06:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B1C5C4481;
        Wed,  1 Apr 2020 17:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/2] commit-graph: fix buggy --expire-time option
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 14:05:59 -0700
In-Reply-To: <pull.596.v2.git.1585774844.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 01 Apr 2020 21:00:42
        +0000")
Message-ID: <xmqqbloa6hmw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9730D6EA-745C-11EA-86A6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Added a file that should be kept on the other side of the expire time to
>    protect against off-by-one errors and future date errors.

Thanks for being extra careful.  It is always a pleasure to read
patches from you ;-)

Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F24C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5CF20737
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nKS4tU8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD1V5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:57:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59393 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1V5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:57:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22C98C1BD3;
        Tue, 28 Apr 2020 17:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O4CB5ANb7D6Yg5Te86IJlX3HnD8=; b=nKS4tU
        8FKZAKcApv7FYPas8vFZsbf2heOoQw6yS1iIdZAHZG69i8h1qQqadfnXH9O+nEe7
        w3mK3t5VIDSJBckDYXUlxk+zdn8GOSJ2IFL8PfqhyHazB78maCPshQ5SDM5h8FOQ
        a6FcfcT6mlMZuQDGgGi5lIYNq4ii7JudbkadE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpZL5vLIfYWVfF1ARibR1LGNctWvacep
        uDM8A6ON3GAPXBcHqO2LAU6Ro9NUrZd3UlXEc2ue2Aik0+fJWSUgK8PZwgt9QzKZ
        DSHYuPobo0zNfh/sSNvjhT5FQKwZodnzWFFsHQP/lFhG9M31suekqXXCTv0jtmEY
        PHsQuw/cC9s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AE7DC1BD1;
        Tue, 28 Apr 2020 17:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66C9FC1BCE;
        Tue, 28 Apr 2020 17:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ash Holland" <ash@sorrel.sh>
Cc:     "Emma Brooks" <me@pluvano.com>, <git@vger.kernel.org>,
        "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Subject: Re: [PATCH] userdiff: support Markdown
References: <C28ZA0MZKHK6.2CCZPZF15D32W@what>
Date:   Tue, 28 Apr 2020 14:57:11 -0700
In-Reply-To: <C28ZA0MZKHK6.2CCZPZF15D32W@what> (Ash Holland's message of "Fri,
        24 Apr 2020 00:32:46 +0100")
Message-ID: <xmqqv9ljz32g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 379FDCCC-899B-11EA-B03A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ash Holland" <ash@sorrel.sh> writes:

> On Tue Apr 21, 2020 at 2:22 AM, Emma Brooks wrote:
>> Since Markdown can have raw HTML tags in many variants, it may make
>> sense to extend the word pattern to "[^<>= \t]+" like HTML's pattern so
>> tags starting/ending will not be considered part of a word.
>
> Good point, I'll update the pattern to that, thanks!

I just marked the topic as "expecting a reroll" in the "What's
cooking" report I have been preparing, but has something happened
after this exchange?

No need to rush, but we'll be closing the acceptance of new features
in three weeks for this cycle, so we won't have infinite amount of
time, either.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A16BC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6F561365
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhDDFhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 01:37:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55805 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 01:37:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5B8713864F;
        Sun,  4 Apr 2021 01:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vYUZxIJyd8aA6r/ssT5NEcWbU1A=; b=HGOgpd
        GkzdZ8ed9FA3ZjBA2v293AZbIQlUGv8YRRtYXvms6nk9CH8CpqxItBEpWGgVw0U9
        OqmF54t2tIs0fnIbpQsICKLERpRVIu0cEKLbvpyEgpU8U9Z83YCXBqTrCrBHRdwL
        qShAZTSd14Y8cW5t2hNI0ebvraSku+vdUc68Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lqz03qXRzYNqBL1XKLaHURLny8TkW/8l
        TQAZOXoYSROYiNZyJPP137u52hz+6+JCM5AFmOK/R22C1+LGeoFQXluvG6Cva4Zi
        vQoBaorSGoRkjACIuY2E7Zd2dSOC4fcV5MNtJFsZf4UxMU1FEg6g+cKOg5jxS0du
        Aofax4wax+g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFB3A13864E;
        Sun,  4 Apr 2021 01:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD55013864C;
        Sun,  4 Apr 2021 01:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
        <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
        <xmqqpmzazund.fsf@gitster.g>
        <16da2d91-9eda-ddf4-dd87-e07fb2bfbbcb@gmail.com>
Date:   Sat, 03 Apr 2021 22:36:57 -0700
In-Reply-To: <16da2d91-9eda-ddf4-dd87-e07fb2bfbbcb@gmail.com> (Chinmoy
        Chakraborty's message of "Sun, 4 Apr 2021 10:41:35 +0530")
Message-ID: <xmqq5z12zk3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C64D05A8-9507-11EB-A208-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chinmoy Chakraborty <chinmoy12c@gmail.com> writes:

>> And if you are building somewhere other than the tip of 'master', it
>> is necessary to say where, in order to save confusion and wasted
>> effort for your readers.  E.g.  "This patch was made on top of
>> merging topic 'X' and 'Y' into 'master'".  Then you'd only have to
>> wait for 'X' and 'Y' to graduate to 'master' before the topic can
>> proceed.
>>
>> Thanks.
>
> Should this information also be added to the commit message
>
> or just the cover letter of the patch?

We often see people write it in the cover letter for multi-patch
series.  For a single patch topic, it is written under the
three-dash line.

Thanks.

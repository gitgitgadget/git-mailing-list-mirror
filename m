Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD0C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632F02072F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cww3EneJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDHTVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:21:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56097 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgDHTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:21:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B38CCB193A;
        Wed,  8 Apr 2020 15:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MuPFdz3ZJPgrzk/O2c5sX5mgwIU=; b=cww3En
        eJxNIOcqkcsFz1Ot/exByXw+R5J6QX23/dhkus08CL8PGaZj2j81xaHJSos7K2XI
        nXstj8FeehYMptXifSGiTNpBLHxQQb/wYQGqF9+7Mogk5wN7duiry2RLTztF3nxj
        sTdDvoZvMZn8zUcZYE3Vn/FMAHHm94WVNZVgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HVCsKp9F+cfmQeQPaG2L+yHACwc1VNn8
        D29ZqiTAjjOKbMq6nuvz8kUhJ+ByhCgsvTFCZ7FygDw1qtqWDvqCNloIdTAT/PAy
        6ThbnkVBlAHQq50RYu02ecZ2+S+npABbtp6mktWBHYtEMFcKZNHmFi3gCVFo3InB
        sjmEkEr5zig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAB39B1938;
        Wed,  8 Apr 2020 15:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1516B1936;
        Wed,  8 Apr 2020 15:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>
Subject: Re: [PATCH v4 00/15] Changed Paths Bloom Filters
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
        <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
Date:   Wed, 08 Apr 2020 12:21:31 -0700
In-Reply-To: <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Apr 2020 11:51:14 -0400")
Message-ID: <xmqq7dyppyv8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2807EE4E-79CE-11EA-B8AD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I noticed Jakub was not CC'd on this email. Jakub: do you plan to re-review
> the new version? Or are you satisfied with the resolutions to your comments?
> ...
> What do you think, Junio?

I was hoping that after Jakub's review, the new round was ready for
'next' to be extended further by building on top as needed.  Of
course the path-limited revision walk is one of the most important
part of the entire system, so I'd welcome reviews from others, too.

Thanks.

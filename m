Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBDC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29932072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cpKxq2TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgEUQmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:42:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51343 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgEUQmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:42:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7E04DB1DD;
        Thu, 21 May 2020 12:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BQgq/cKVxDC/+4stqUujLGPQ8kI=; b=cpKxq2
        TEer7gc1rottBz71e2qJTOozqu5pnKT79+cdB7QOcXtgyitVMcCY6fOUTtbpKgCI
        za2BX4D+QyDidmPfICT0lxBRiZ5IQAL4uYChY5+uah+GSA+jvtW1z/NcIjhTAwST
        JYZds6f91fahLfvGCoFwsUebkWMS2kfdVoOyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o2SBJt23Yp+fAUBeJfQxg04wC2cIp6WP
        zYy05pPLczxA2K2jOJQoxsDfDc0CBuH0yXbsXgxljIl622W0bEOJtD999eHlT/1U
        UN+aSP+/XL7/Gchtld8g/1MVE3+wiYVpiu3nUR+dd038mTOz26Au6queFB5+JQd/
        rPU9qDYMdgE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDAF4DB1DC;
        Thu, 21 May 2020 12:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F9E1DB1DB;
        Thu, 21 May 2020 12:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
        <20200520193156.GA4700@coredump.intra.peff.net>
        <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
        <20200520220023.GB3648@google.com>
        <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
        <20200521021533.GC3648@google.com>
        <1a3bf366-d888-74d3-5f81-78dfeb5eb79c@gmail.com>
Date:   Thu, 21 May 2020 09:42:02 -0700
In-Reply-To: <1a3bf366-d888-74d3-5f81-78dfeb5eb79c@gmail.com> (Derrick
        Stolee's message of "Thu, 21 May 2020 07:54:08 -0400")
Message-ID: <xmqqd06xtf39.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 004553E4-9B82-11EA-A884-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Git 2.26 used protocol v2 as its default protocol, but soon after
>> release, users noticed that the protocol v2 negotiation code was prone
>> to fail when fetching from some remotes that are far ahead of others
>> (such as linux-next.git versus Linus's linux.git).  That has been
>> fixed by 0b07eecf6ed (Merge branch 'jt/v2-fetch-nego-fix',
>> 2020-05-01),
>
> Should we really mention the merge here? Is it because the "fix" is
> spread across two commits? Why not say the tip of the topic?

Strictly speaking, the tip of the topic is sufficient.  You can use
a third-party script "git when-merged" to ask "which exact merge
gave us this commit in the mainline?" when given only the tip of the
topic, which is what I often end up doing.

Writing the merge result reduces the need for doing the same
"reverse" look-up.

On the other hand, going the other way to find the then-current tip
of the topic from the result of the merge is much easier; you can
ask the merge result what its second parent is.

The rest of your review I can entirely agree with.  Thanks, always,
for a prompt and well written review.


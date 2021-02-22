Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2BC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7F364DFD
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBVXcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:32:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54322 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhBVXck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:32:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F76D120DCA;
        Mon, 22 Feb 2021 18:31:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DlBw30jTAzz25qdQrsoj1x89rkk=; b=eBusLx
        ER1a8ec/m5r1DsXtmvTpZlZoODh2iG55CLVtl1l6INQgTZM0l1B4TNCyvYnBpo4j
        1YcExFKb8gd9v27giL6FqpjBMr7E03yAwSnK+1vVWlAmmuZFIu2U/q0qYxOdWa4a
        D59D7DbytZu92EIy1M0ZhFYBpSNukhrCBiWJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iP5ceIwF/O/h+5OQkhqpBWYFhvRQXKF1
        R3kFjvX0VNQxACKL8eiT6nhH1eC2v9S5ygyJ15nkpt8S2h/nVFSE2ptMdYrmFS7s
        apCvXKQbiZ1q5SUNi21kxRblgL4UegeYuo23/LPOpiNA0oLxUdN1PHeobeLUz+QG
        jgrLj0Z20RU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48CCA120DC9;
        Mon, 22 Feb 2021 18:31:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95AD2120DC8;
        Mon, 22 Feb 2021 18:31:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs/format-patch: mention handling of merges
References: <20210222211621.0C5D.409509F4@e16-tech.com>
        <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
        <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net>
Date:   Mon, 22 Feb 2021 15:31:53 -0800
In-Reply-To: <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Feb 2021 18:08:16 -0500")
Message-ID: <xmqqv9aj65na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 266610FE-7566-11EB-92D1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] docs/format-patch: mention handling of merges
>
> Format-patch doesn't have a way to format merges in a way that can be
> applied by git-am (or any other tool), and so it just omits them.
> However, this may be a surprising implication for users who are not well
> versed in how the tool works. Let's add a note to the documentation
> making this more clear.
> ...
> +CAVEATS
> +-------
> +
> +Note that `format-patch` cannot represent commits with more than one
> +parent (i.e., merges) and will silently omit them entirely from its
> +output, even if they are part of the requested range.


I think "cannot represent" is a little bit misleading, unless we
expect the readers already know what we are trying to say (in which
case there is no point in documenting this).  Perhaps something like
this might clarify a bit, though.

    Note that `format-patch` omits merge commits from the output,
    because it is impossible to turn a merge commit into a simple
    "patch" in such a way that allows receiving end to reproduce the
    same merge commit.


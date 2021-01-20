Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB05C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3ECA2313B
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhATGud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 01:50:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64755 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhATGsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 01:48:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EC5DAF229;
        Wed, 20 Jan 2021 01:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ShzranesDx/2hcVNrhLjuz7aE94=; b=OOM7q7
        55HDegVr6z8LOwbe/odqs0gpGszDdeZmmGgCWet85uicjYv4FCu3ZrKqNr6slwJ4
        3vLI8Gvsx3FA3WuzN5FZ+McpLMUPdSW/ofDcUtZL+BADTDGHOlViacPQd9NvX+ik
        uDokZQ3uz+grpQ2ZXpfSnpomVJpGp+gFlWZqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f3bn9v72NgDA2wBDl6IoC7UhvkzNMrDY
        KFRLWXYtjXgODSm+DCRAFGbUGX3tSYB1k6X3rf/ngZARtetOoJN42ahsWCyI+8+Z
        6KZXtjoY2+T5oyD9vMyxQIqSa5zP23yyWiu4fFbezEulfWtPlMPIff/uYv3aNlbl
        lCK9yKCb8NM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97010AF228;
        Wed, 20 Jan 2021 01:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26502AF227;
        Wed, 20 Jan 2021 01:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
        <xmqqr1mij88k.fsf@gitster.c.googlers.com>
        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
        <xmqq1reginnq.fsf@gitster.c.googlers.com>
        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>
Date:   Tue, 19 Jan 2021 22:47:42 -0800
In-Reply-To: <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us> (Kyle Marek's
        message of "Tue, 19 Jan 2021 22:25:48 -0500")
Message-ID: <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 658156BC-5AEB-11EB-B8D6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> When graphing C..Z, git produces output like:
>
> *   0fbb0dc (HEAD -> z) Z
> |\
> | * 11be529 (master) B
> | * 8dd1b85 A
> * 851a915 Y
> * 27d3ed0 (x) X
>
> We cannot tell from the above graph alone that X is a root and A is not.

I actually do not see that as a problem.  In the past several years,
I've never needed to see "log --graph" output that goes all the way
down to the roots, unless I was playing with a toy repository in
order to tweak and/or develop a feature in Git that draws the graph.

Besides, such root commtis in real life projects would not say "X",
but something along the lines of "my very initial commit", which
would be much more "/<search>" friendly to pagers than "#".

So, no, sorry, but I do not buy "root is more special" at all.

Thanks.


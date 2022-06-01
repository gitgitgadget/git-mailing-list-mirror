Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F47C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiFAUtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiFAUsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:48:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DB27B98E
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:45:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF46711DB83;
        Wed,  1 Jun 2022 16:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ai0cX6qv1DbV2Pj0V0sH6UDNbv9Pnhbq1fDEA+
        xs7UQ=; b=IPyTCiPPZ8Tx2jIUFa4As3GmDdBsd0TIWqjf8w/NtpfB49WlSEmPqN
        6d39LYrUUzCJLuNRk3twMPaw+ubbaXlbeOwWH6bL0XYfpQu7yfSIUXejwwoqSxD7
        zaMbhAv9QRyOW0egtQxv4/FVxco0IeL5LM9PyicE7yPPtTaQrvq5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3CDF11DB81;
        Wed,  1 Jun 2022 16:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EBC811DB80;
        Wed,  1 Jun 2022 16:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] git-prompt: make colourization consistent
References: <20220601134414.66825-1-joak-pet@online.no>
        <xmqq7d60tfyd.fsf@gitster.g>
        <47ba2296-10f3-4590-dbf5-38d92ed3e29e@online.no>
Date:   Wed, 01 Jun 2022 13:45:27 -0700
In-Reply-To: <47ba2296-10f3-4590-dbf5-38d92ed3e29e@online.no> (Joakim
        Petersen's message of "Wed, 1 Jun 2022 20:32:31 +0200")
Message-ID: <xmqqleugqfiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5A9BACE-E1EB-11EC-8A70-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> Your understanding is correct for the flow before the change I
> referenced (0ec7c23cdc6 (git-prompt: make upstream state
> indicator location consistent, 2022-02-27)), however, that commit
> changed the definition of $f and $gitstring to
>
> 	local f="$h$w$i$s$u$p"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
>
> This makes it so $p is no longer immediately preceded by $r, but rather
> $u, which, like all the preceding variables, except $h, will be
> colourized if enabled.

Ah, OK.  With the above explanation, the change does make sense.
The mention of that commit does need to be in the proposed log
message, not under the three-dash line, as it is essential to
understand why the patch is not a no-op change.

Thanks.

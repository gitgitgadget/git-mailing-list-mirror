Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61638C4332F
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiI3WRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiI3WRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:17:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537F816EA92
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:17:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAF4D15DE40;
        Fri, 30 Sep 2022 18:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jhg0b74uf+5isxUqj0E76KFq5Z+RqOl5Oct0ZK
        4jLiQ=; b=PlyFlUMtQR+Fqwj6WMrb6cp4lnD5bRbr1HST/7os+xIf5VehkU8XQ0
        9HG9kSla0KTna9Goz7Jgw8f5Dak90FfKzG8csDZICh2mfuHwumyBZbj0rM3skE7x
        TjTWBRSrA+PV06dRcgaMJlzoxHI0zC5MIJKeMNmD1qHcurr4QG4PY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1E4015DE3F;
        Fri, 30 Sep 2022 18:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D781E15DE3E;
        Fri, 30 Sep 2022 18:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fail early when partial clone prefetch fails
References: <20220930215000.2079107-1-jonathantanmy@google.com>
Date:   Fri, 30 Sep 2022 15:17:49 -0700
In-Reply-To: <20220930215000.2079107-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 30 Sep 2022 14:50:00 -0700")
Message-ID: <xmqqmtag7bhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8CA3532-410D-11ED-8E64-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> No changes to t/ directory?
>
> Hmm...any test you would like to see in particular? Here, we just fail
> with a specific error message when any sort of fetching from the
> promisor remote due to a lookup of a missing object.

I presume that we already have a test that interact with a promisor
remote that does not keep its promise?  If we don't then adding one
or two would help.  If we do, then how the command fails would
probably be different (observable via trace2) with your "early
break" change, no?

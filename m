Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941BAC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiGRR4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiGRR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:56:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D42D1FD
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:56:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94E8D14CD5B;
        Mon, 18 Jul 2022 13:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RspgGKIuFg/2RcmLLF8MG6D17ZmbfkCyFE4OK9
        n5WNI=; b=pGvDKQGZ5nmgSzQ69w+dWYVD3FDNIZAY7TVPTFx4ylr8NTCuap6c4g
        YjU9S67zkmeiQ+GKGKi8qV/HpI96k9TkNHrHuOZLgeln6fmHqPTnpXbU8G3PGDpm
        9hwy4L27b7UNIaLTUOlTrpOlVTfQP+pv5hmm7bUisQlGiKFCAcn7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C3BA14CD5A;
        Mon, 18 Jul 2022 13:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 033DC14CD58;
        Mon, 18 Jul 2022 13:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
In-Reply-To: <20220718161823.3363013-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 18 Jul 2022 09:18:23 -0700")
References: <20220718161823.3363013-1-jonathantanmy@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 18 Jul 2022 10:56:45 -0700
Message-ID: <xmqqa696qp7m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDD43A54-06C2-11ED-97CF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> ... that the user is not using, but fetch is I/O-intensive enough
> and having the empty message is useful enough (not only do we not need
> to know which versions have this feature, but we also can be sure that
> the message wasn't excluded because of some unexpected log filtering or
> something like that) that I think we should have the empty message. I'll
> put it in v2 but we can easily remove it if we decide that we don't want
> it.

As long as it is clearly documented that "none" is given explicitly
when no filtering is requested (Jeff's point of making it possible
to tell the reason why we are not requesting is still valid), I
think it would be OK.  If we are giving enough log entries for
"fetch" operation, another "empty" message would not hurt (if the
trace for "fetch" is otherwise very quiet, then an unused "empty"
may become distracting, but I somehow do not think it is the case).

Thanks.

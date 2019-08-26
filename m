Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B29B1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfHZQ2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:28:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58643 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfHZQ2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:28:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AA8F73033;
        Mon, 26 Aug 2019 12:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6G+QAZDQbxfWTBlrH/xuDjMtQY0=; b=VEloz2
        hF4om/BoL87DpY5sjDP5fMkdEs0V+t5jYWM0vlk1QEI6prRVx1ZzHgyq9+jUnwoV
        +sQPTIRykxTfN5xaqrwifK3/qFkRl66TNs9dsApSwPdOgikIUQ3hZvDvA+UORSzL
        qJk5Yeo4ug8vChNAm1+wovKj/YFzSWoqBGBgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J+XTyIGNfY2BZWOe7urWH2nNS8m182Oa
        pVG3ONXjIy9JENHlqqPKSMPjiP1mOXJCCiaBv767baOwcEa0UNEHwZYBDZ6K/NOo
        fpKCj4e4zJvo4VpzHrW19c7oICZaes3DmYrxE2ZnsJbrnmtiH06YR7cmzj26a41H
        jZ63/Pe0dlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 442CE73032;
        Mon, 26 Aug 2019 12:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 600087302F;
        Mon, 26 Aug 2019 12:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Masaya Suzuki <masayasuzuki@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] credential: add nocache option to the credentials API
References: <20190707055132.103736-1-masayasuzuki@google.com>
        <20190709125620.GA18175@sigill.intra.peff.net>
        <CAJB1erXRg4S-vzRZwA-Q5cXAPayRE0dAjFjjkNQ9CoKiXF=7EQ@mail.gmail.com>
        <20190722210037.GA31664@sigill.intra.peff.net>
Date:   Mon, 26 Aug 2019 09:27:56 -0700
In-Reply-To: <20190722210037.GA31664@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Jul 2019 17:00:38 -0400")
Message-ID: <xmqqsgpnj3hv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 771762E2-C81E-11E9-B60C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was thinking that Git itself could treat "ttl=0" specially, the same
> as your nocache, and avoid passing it along to any helpers during the
> approve stage. That would make it exactly equivalent to your patch
> (modulo the name change).
> ...
> And as you noted above, if we don't suppress the helper calls inside
> Git, then every matching storage helper needs to learn about "nocache"
> (or "ttl") before it will do any good.

I was waiting for this discussion to settle and then the discussion
seems to have petered out.  Any interest to following the "ttl with
special casing value 0 as 'nocache'" idea thru from either two of
you, or should I take the patch as is in the meantime?

Thanks.

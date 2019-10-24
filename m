Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8B91F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406688AbfJXD5J (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 23:57:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65210 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403951AbfJXD5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 23:57:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A18318415;
        Wed, 23 Oct 2019 23:57:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whzB43vtSUlPx+YwD1Joj1kY4FI=; b=VMc2rB
        KKx+wgTz+pEtTknRYl17rP/KvjAVRH9r70zbgR1OblonrgGwwFAYjMN4V8MhTTcd
        lJUR/jJ+b2F7IlNt0E5Z9DnPtg6QZ2wB0mGHkiBm1fy9Zx/Td3jJ2JGQV1Oud7T0
        omPn1NNE+9GRSknhjOTXRUB5iahTDqI3wGVWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jH+pcycwOPetZnbYz1EzMiVxMf3iSnYu
        kBZO3SZp7zoTSr7EvvXIW/lX1Ye/Zv/Sw1sAwk+XrdoMNCvwE0Tw9zl2bQZ4OhwK
        38Eq+vZr3jj3OQcQ2AWgKi8wlM1y61IilcL2x7EgK4+KNLtvDpYTLHJQwkm0EZ56
        tb9u01Dydt4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 916ED18414;
        Wed, 23 Oct 2019 23:57:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0123818413;
        Wed, 23 Oct 2019 23:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/23] fsck: stop checking commit->tree value
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018044820.GE17879@sigill.intra.peff.net>
Date:   Thu, 24 Oct 2019 12:57:06 +0900
In-Reply-To: <20191018044820.GE17879@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:48:20 -0400")
Message-ID: <xmqqsgnig5il.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59568874-F612-11E9-9C02-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We check in fsck_commit_buffer() that commit->tree isn't NULL, which in
> ...
> So this code isn't helping anything. And it makes the fsck code slightly
> more confusing and rigid (e.g., it requires that any commit structs have
> already been parsed). Let's drop it.

Thanks; I recall we discussed this during a review of a topic.

Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F17DC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B1F20719
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wthxc3pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgIVFpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:45:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60880 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgIVFpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:45:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1DB589CCD;
        Tue, 22 Sep 2020 01:45:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X0R+HTxIpYRjIWIwwaSRy4X5JPA=; b=wthxc3
        pdEdzMNK6Ob1OkNobfQcRyKiEMB/2ZglM0v+aH/efeWspJ4vyG8N0z0ABVXdSZNT
        VyrJzhpDvQ1+s20TaY+VCCVy/RZW4VmsOBrrOsBsy8btwkEgDSQmEnFZ7sQ5GNJ8
        KGe08hzWD5NPpeGqC3Ho3aEe1zTV5hUtfWQKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JoKrY37l/8a8tDQptbVQydjMt2tm8KP9
        8egwGRDrdn6bnFaXorFpquc1axjOg8sDY2hFTkmqz53V5o3GaSts2Bvgt5TE+5Sh
        w6WfaR9J/rFAZ9jziraVT4hUJD12ZBvUmrgoNYzs+xvoqTIikUe7SNhUJvcvWrPs
        4dIN3M/IkTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B776589CCB;
        Tue, 22 Sep 2020 01:45:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22AD789CCA;
        Tue, 22 Sep 2020 01:45:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 0/2] Fix overriding of partial clone filter when
 lazy-fetching
References: <cover.1600743698.git.jonathantanmy@google.com>
Date:   Mon, 21 Sep 2020 22:45:26 -0700
In-Reply-To: <cover.1600743698.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 21 Sep 2020 20:03:55 -0700")
Message-ID: <xmqq7dsmcqkp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D119ECC6-FC96-11EA-BBD9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This was noticed at $DAYJOB when in a partial clone with a filter other
> than blob:none. The 1st patch is a code cleanup (so that the 2nd patch
> does not need to take into account the unused variable), and the 2nd
> patch contains the bug fix.

What is "this" is not clear at all.  This is one of those cover
letters unfriendly to readers who do not know what the author did
before being told X-<.  We got a vague "we found some unspecified
bug and fixed it, and we need to read them through if we want to
find out what it is".

>
> Jonathan Tan (2):
>   promisor-remote: remove unused variable
>   fetch: do not override partial clone filter
>
>  builtin/fetch.c               |  2 +-
>  list-objects-filter-options.c | 10 +++++++++-
>  promisor-remote.c             |  5 -----
>  promisor-remote.h             |  2 +-
>  t/t5601-clone.sh              |  5 +++++
>  5 files changed, 16 insertions(+), 8 deletions(-)

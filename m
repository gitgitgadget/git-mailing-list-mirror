Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C84C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32235207DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SCrxqBWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHUVNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:13:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56568 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVNn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:13:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16A7FE4AD1;
        Fri, 21 Aug 2020 17:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UsCdR7YOMvq8T8XRGY0UzAQnE4Q=; b=SCrxqB
        WC+jnswuKPiPyT3VUUXz1lRLTUaBG/H+CE4BJZacd22VNCaqzzG/WTKZIY/SeNbc
        vzzR11ahJ5Y6+L7m8iIxW84fMSwcg1y6rha/LYvV2fphPR43zotSh7gf8/vPNwao
        PmfLaTOHoxdB9gPKeDvb4e+YZQc3rYedlxTOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HnTtn1Irf8PuPkCWuLKulgT8c1S6rM+w
        QZAJ2P4TtHz8x39yicWxsqFpclkmx7nyoirBHu8c8C2Q3Z6wrvQWvfr3HvOqasKD
        fZzd+mreJnvl20jn4vKI3EhzkXuN0W4e5qEeLaQFJro48ruZdK7kgtL8swalfUOZ
        uSrtn99iUYc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EBF1E4AD0;
        Fri, 21 Aug 2020 17:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51F57E4ACF;
        Fri, 21 Aug 2020 17:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Alvaro Aleman <aaleman@redhat.com>
Subject: Re: [PATCH] ident: say whose identity is missing when giving user.name hint
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
        <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
        <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
        <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com>
        <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
Date:   Fri, 21 Aug 2020 14:13:36 -0700
In-Reply-To: <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Aug 2020 16:52:33 -0400")
Message-ID: <xmqq1rjz8zy7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E6A6BA6-E3F3-11EA-BF2B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>     If `user.name` and `user.email` have not been configured and the
>     user invokes:
>
>         git commit --author=...
>
>     without without specifying `--committer=`, then Git errors out
>     with a message asking the user to configure `user.name` and
>     `user.email` but doesn't tell the user which attribution was
>     missing. This can be confusing for a user new to Git who isn't
>     aware of the distinction between user, author, and committer.
>     Give such users a bit more help by extending the error message to
>     also say which attribution is expected.

Much easier to read.  Will steal.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CADC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3C623382
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgLPRdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:33:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52250 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgLPRdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:33:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AE88FD5D2;
        Wed, 16 Dec 2020 12:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+jN3ExaOraI15HQx9Sggl7X20IA=; b=BFd6KA
        duBmg84NUEWydYmKCQrUbDjxsWBo4hBf7YjGzHu3KL2ZkwXrFrsWyaimojtxWCN5
        zYS1dUTNGQus+yauTdep25lDstZFER0PTwYLgUK+41vLFs8R7Vizp//d+EDUjNup
        7qTmdVYzjMDHzzcdg49lQNZ/26wI4I7reVLk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FFtPROz2ZtqgfeRGr2TcmHthFrNfCW7v
        3qGmSp/Ir8gjvQKdF2bqaToNBQCNzYirc1TJVITnYYdR3J0n2N94Q7W/suCqAwod
        tZBgyiPftomvK5hdpzu6JzgbVkcG1PquLuDwN0jZ03germjEctHx+BCFdqJ6ThJp
        CJw9jc5M6SA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44B92FD5D1;
        Wed, 16 Dec 2020 12:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8AC15FD5D0;
        Wed, 16 Dec 2020 12:32:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Daniel C . Klauer" <daniel.c.klauer@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] pack-redundant: fix crash when one packfile in repo
References: <CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com>
        <20201216100952.16890-1-worldhello.net@gmail.com>
Date:   Wed, 16 Dec 2020 09:32:30 -0800
In-Reply-To: <20201216100952.16890-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 16 Dec 2020 05:09:52 -0500")
Message-ID: <xmqqo8it4pxt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADBBDF3E-3FC4-11EB-AAD0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Junio will add additional option for pack-redundant for preparing
> its removal.  So replace `git pack-redundant` command with variable
> `$git_pack_redundant` in t5323.

Could you please revert the part about $git_pack_redundant,
pretending as if the other patch never existed, so that this fix can
be applied without having to wait until the discussion to deprecate
and remove comes to conclusion?

Thanks.

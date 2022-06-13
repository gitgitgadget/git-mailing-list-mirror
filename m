Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE256C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbiFMTRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiFMTQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:16:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7972229F
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 10:29:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 338A21A653E;
        Mon, 13 Jun 2022 13:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mRCelJo2PEQ8cCreqR2UdfXVEOSG1pMNXK6pqA
        nLOG0=; b=EpGk63BkKxeeY7aOZQCQ0S90oeLO4POPJl8nARjltzRYcS8RR4cV4M
        FYW8qVANGzGUg/XMddqbTTYPaJlpdMCgQi3QfvsPDi21ZB/Lc6k7Lnovuyr0kDqc
        1Df5ijpAheAzqG6a5ROENnPiYFsXrSw/WxRTQEkAF/CfQ4Ro0TyFE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D6E31A653D;
        Mon, 13 Jun 2022 13:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC36F1A653B;
        Mon, 13 Jun 2022 13:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Udoff, Marc" <Marc.Udoff@deshaw.com>,
        "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git filter bug
References: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
        <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org>
Date:   Mon, 13 Jun 2022 10:29:00 -0700
In-Reply-To: <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org> (Johannes Sixt's
        message of "Sat, 11 Jun 2022 09:43:12 +0200")
Message-ID: <xmqqsfo879r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50D82C60-EB3E-11EC-B68F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> git status does not compute differences; it only looks at the stat
> information, and that is by design for performance reasons. So, IMO,
> this is working as designed and not a bug.

Hmph, is that true?  I thought "git status" did an equivalent of
diff.autoRefreshIndex just like other commands like "git diff" at
the Porcelain level.

Is this more like the commonly seen "after you futzed the attributes
to affect normalization, "--renormalize" is needed to force the
index to match the cleaned version of working tree under the new
clean filter rules", I wonder?


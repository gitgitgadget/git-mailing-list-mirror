Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E2420899
	for <e@80x24.org>; Tue,  8 Aug 2017 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbdHHVVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 17:21:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59989 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752444AbdHHVVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 17:21:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63BFE9F8C9;
        Tue,  8 Aug 2017 17:21:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cB62DpGSZ2T3C1YieN9bwwQLKDA=; b=Jsz/qN
        hjkcdTpyeVg0QBRiOi44nxT4EgsJJbXjLsHk0GPw5MZuqEMLqnZLechfszXwQJgr
        /UIPU2/BSRjsXAbDv3xT94BTfZpAZCh/XsSXCA9mabQumrZj392U1nWSQgVxUa9w
        ybZZrLCqPizkX1OWlGh5K1lsilikECMJ4znkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UlK2OwVvPCPHPcz92+AeLWETGKhCu/LS
        jB/bIvtHhw/W7j3pJqoyumo9d8d0YVSma9sUoOpySJa5ej9FoqrDGXlIlMV9jIgS
        eoecK2rFb9is49hl4H34/LoyLr58cs8HQ4yfFYTpPONiaKnIZccW3wWnLVPWfXWn
        FXbX8Hp/jDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B03D9F8C6;
        Tue,  8 Aug 2017 17:21:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAFD19F8C4;
        Tue,  8 Aug 2017 17:21:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Convert size datatype to size_t
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
Date:   Tue, 08 Aug 2017 14:21:40 -0700
In-Reply-To: <1502222450-20815-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Tue, 8 Aug 2017 22:00:50 +0200")
Message-ID: <xmqqr2wlah7f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92739EEE-7C7F-11E7-939C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> It changes the signature of the core object access function
> including any other functions to assure a clean compile if
> sizeof(size_t) != sizeof(unsigned long).
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
> ...
>  66 files changed, 193 insertions(+), 191 deletions(-)

Wow, that's a lot of changes.  What version did you worked this
patch on?  The reason I ask is because...

> diff --git a/diff-delta.c b/diff-delta.c
> index cd238c8..3d5e1ef 100644

... I do not see any version of Git that had blob cd238c8 at that
path, so "git am -3" is having hard time applying this pach to allow
me reviewing it.

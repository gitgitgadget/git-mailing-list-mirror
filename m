Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF391F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 02:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeKSMYR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 07:24:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50666 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeKSMYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 07:24:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9EB7122190;
        Sun, 18 Nov 2018 21:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4Ww5Lc8267Xz7J6D6IFxnljSPU=; b=stokV9
        043SLKLHnkk1Rs6746B6BkCAAM80RMWwM4gnXZHkpMKrRi+/CNuEayNod3v3cYh3
        /BANb5dZcqnN8lBjbhecMPEY086KPU4CHV9Te03diTp1shZRNRfO1VrS68e2qigs
        ZusQC+Hwd7j3ve+PtZjMytkyvDLTgE0OWBdYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CiPelIQvIC4/5bahUM2uKqiJMttO9xjX
        8OcIVQGD9F7O/bSep9NUyXZKuZP/RU4D4iJvqonz/3c9c3ss63J87lwveuOuhZ6t
        vF3yzDs2TnVlmDblLEiZ/aYcmbsM4KmpcCqO4afsky4P9OeFLDsgXNM/l0Tz9qmE
        5AMqnzSytWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D235212218F;
        Sun, 18 Nov 2018 21:02:14 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 573B612218E;
        Sun, 18 Nov 2018 21:02:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
References: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
        <20181118215820.GA14514@sigill.intra.peff.net>
Date:   Mon, 19 Nov 2018 11:02:13 +0900
In-Reply-To: <20181118215820.GA14514@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 18 Nov 2018 16:58:20 -0500")
Message-ID: <xmqqk1l9esey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 225D9386-EB9F-11E8-9D93-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And it seems we worked around this in de2f95ebed (mailmap: work around
> implementations with pure inline strcasecmp, 2013-09-12). So I don't
> think there is any blocker there.
>
> (Though of course I have no idea on other portability questions around
> _stricmp(); I'll leave that for Windows folks).

Likewise.  As to the placement for the replacement #define, the
patch puts it where the inline version was, but I would think it
would work better if it were in the block of #defines, immediately
next to #define strncasecmp above.
.



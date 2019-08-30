Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8CFD1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3RfA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 13:35:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54758 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3RfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 13:35:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67A5D1776D4;
        Fri, 30 Aug 2019 13:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6T0MiWgJkDcgKL6A5SAQNsit8Uo=; b=dlVSlL
        ALfntBGdDi3kikJeT9/B2sBHPf4mFPMu/4DEar+MF/W1XQ/yx85aCuXCG2vr9vMy
        v1pcFnUB+HqNscXLivPjhVLo8HQVqRdwg5DMWjQcnE+mhX5Vw3yuDYBJAyB/peec
        wDy53eAMXBQXw2j/WbFh8xQB1cZBuuMJ2Qgd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TzW6M5jSxl6VfrEs9iXCjkwD9HA2tLMk
        UnJeaz660bGsFfEWyUZAAwua+7qLORZx2CkzW4SmQi8lWCk7GSJLnQMZV4nYSBPb
        28hXFiPZXe9Mzmjzc6ifX9mhLiVRqUXShpTK4SDnj/gZDd6cGs/zPNiqobwSTmk+
        UHwd7RErR5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D4351776D3;
        Fri, 30 Aug 2019 13:34:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C41681776D2;
        Fri, 30 Aug 2019 13:34:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clarify documentation for remote helpers
References: <20190829210301.18467-1-dturner@twosigma.com>
        <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
        <88d9063060644dd99122bf0933f23fa9@exmbdft7.ad.twosigma.com>
Date:   Fri, 30 Aug 2019 10:34:56 -0700
In-Reply-To: <88d9063060644dd99122bf0933f23fa9@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Fri, 30 Aug 2019 13:47:23 +0000")
Message-ID: <xmqqv9uey2tb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C7F4FFC-CB4C-11E9-B9BB-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> I was confused, because I read "a file under GIT_DIR/objects/pack"
> to mean "just the filename".  Some of the things that deal with
> packs take just the filename (e.g. --keep-pack for git repack).
> I'll fix the under under and add $, but I do want to clarify that
> it's the full path.

I think that the phrase wanted to say that the file named with the
option must live under that directory, without any implication that
the directory is used as the base when a relative path is used.  If
the helper MUST give a full pathname and a pathname relative to that
directory is not accepted, it is a good idea to spell it out (also
if it must end with ".keep", that also should be documented---is
there any other restrictions?).
